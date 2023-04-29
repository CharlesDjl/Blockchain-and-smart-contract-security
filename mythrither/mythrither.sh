#!/bin/bash

# 创建一个用于存放结果的文件夹
mkdir -p results

# 记录开始时间
start_time=$(date +%s)

# 遍历sol_file文件夹中的所有.sol文件
for file in ../sol_file/*.sol; do
    filename=$(basename "$file" .sol)
    echo "正在分析：$filename.sol"

    # 获取sol文件的solidity版本号
    version=$(grep -oP "pragma solidity (\^|>=)\K\d+\.\d+\.\d+" "$file")

    # 使用solc-select切换到对应版本的编译器
    solc-select use "$version"

    # 使用slither检测sol文件并记录结果
    slither_output=$(slither "$file" 2>&1 | tee "results/$filename.txt")

    # 使用mythril检测sol文件并记录结果，将控制台输出结果与slither结果一起保存在同一个txt文件中
    file_start_time=$(date +%s.%N)
    timeout_output=$(timeout 180s myth analyze "$file" 2>&1)
    exit_status=$?

    # 计算文件分析耗时，并将其记录到结果文件的最后一行
    file_end_time=$(date +%s.%N)
    file_elapsed_time=$(echo "$file_end_time - $file_start_time" | bc)
    echo "分析时间：$file_elapsed_time s" >> "results/$filename.txt"

    if [ $exit_status -eq 124 ]; then
        echo "分析超时：$filename.sol" | tee -a "results/$filename.txt"
    else
        echo "$timeout_output" >> "results/$filename.txt"
        echo "分析结果已保存到：results/$filename.txt"
    fi
done

# 记录全局运行时间并保存在a_total_time.txt中
end_time=$(date +%s)
elapsed_time=$((end_time-start_time))
echo "全局运行时间：$elapsed_time秒" >> a_total_time.txt

