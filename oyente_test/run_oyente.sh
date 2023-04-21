#!/bin/bash

for file in ./Blockchain-and-smart-contract-security/sol_file/*.sol
do
	filename=$(basename "$file")
	python -u oyente.py -s "$file" 2>&1 | tee "./oyente_testResults/oyente_${filename%.*}.txt" > /dev/null
done
