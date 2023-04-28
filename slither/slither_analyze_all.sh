#!/bin/bash

# 定义一个函数来提取pragma solidity版本
function extract_version() {
    local SOL_FILE=$1
    local PRAGMA_VERSION=$(grep -oP "pragma solidity (\^|>=)\K\d+\.\d+\.\d+" "$SOL_FILE")
    echo "$PRAGMA_VERSION"
}

# 创建输出目录
RESULTS_DIR="./results"
mkdir -p "$RESULTS_DIR"

# 遍历sol_file文件夹中的所有.sol文件
for SOL_FILE in ../sol_file/*.sol; do
    echo "Processing $SOL_FILE..."

    # 提取.sol文件的编译器版本
    PRAGMA_VERSION=$(extract_version "$SOL_FILE")

    # 如果未找到版本，则跳过该文件
    if [ -z "$PRAGMA_VERSION" ]; then
        echo "No compiler version found in $SOL_FILE. Skipping..."
        continue
    fi

    # 使用solc-select切换到提取的版本
    solc-select use "$PRAGMA_VERSION"

    # 运行Slither分析并将输出重定向到结果文件
    slither "$SOL_FILE" > "$RESULTS_DIR/$(basename "$SOL_FILE" .sol)_results.txt" 2>&1
done

