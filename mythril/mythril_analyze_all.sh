#!/bin/bash

# 创建一个用于存放结果的文件夹
mkdir -p results

# 分析sol_file文件夹中的所有.sol文件
for file in *../sol_file/.sol; do
    filename=$(basename "$file" .sol)
    echo "正在分析：$filename.sol"
    
    # 使用timeout设置运行时间限制，并捕获异常
    timeout_output=$(timeout 120s myth analyze "$file" 2>&1)
    exit_status=$?
    
    if [ $exit_status -eq 124 ]; then
        echo "分析超时：$filename.sol" | tee "results/$filename.txt"
    else
        echo "$timeout_output" > "results/$filename.txt"
        echo "分析结果已保存到：results/$filename.txt"
    fi
done

