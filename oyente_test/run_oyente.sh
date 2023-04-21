#!/bin/bash

for file in ./Blockchain-and-smart-contract-security/sol_file/*.sol
do
	filename=$(basename "$file")
	python oyente.py -s "$file" > "./oyente_testResults/oyente_${filename%.*}.txt"
done
