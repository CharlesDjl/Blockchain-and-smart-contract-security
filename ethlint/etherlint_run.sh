#!/bin/bash

# Define the directories for the .sol files and the results
sol_files_dir="/home/logan/comp5566/Blockchain-and-smart-contract-security/sol_file"
results_dir="/home/logan/comp5566/Blockchain-and-smart-contract-security/ethlint/results"

# Ensure the results directory exists
mkdir -p "$results_dir"

# Iterate through the .sol files in the sol_files_dir
for sol_file in "$sol_files_dir"/*.sol; do
  # Get the base file name without the extension
  base_file_name="$(basename "$sol_file" .sol)"

  # Run Solium on the current .sol file and save the result as a .txt file in the results directory
  (time solium -f "$sol_file") &> "$results_dir/$base_file_name.txt"
done
