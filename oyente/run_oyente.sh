#!/bin/bash

for file in ./Blockchain-and-smart-contract-security/sol_file/*.sol
do
        file_count=$((file_count + 1))
        filename=$(basename "$file")
        start_time=$(date +%s%3N)
	python -u oyente.py -s "$file" 2>&1 | tee "./results/oyente_${filename%.*}.txt" > /dev/null
	end_time=$((end_time - start_time))
        total_time=$((total_time + elapsed_time))
        echo "Execution time: ${elapsed_time} ms" >> "./results/oyente_${filename%.*}.txt"

done

average_time=$((total_time / file_count))
echo "Average execution time: %{average_time} ms"

