#!/bin/bash

for file in ./Blockchain-and-smart-contract-security/sol_file/*.sol
do
	filename=$(basename "$file")
	python -u osiris/osiris.py -s "$file" 2>&1 | tee "./osiris_testResults/osiris_${filename%.*}.txt" > /dev/null
done
