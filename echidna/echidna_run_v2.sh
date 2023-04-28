#!/bin/bash

# Function to extract the solc version from the .sol file
extract_solc_version() {
  solc_version=$(grep -oP '(?<=pragma solidity )[^\s;]+' "$1")
  echo "$solc_version"
}

# Function to switch the solc version using solc-select
switch_solc_version() {
  solc_version="$1"
  solc-select use "$solc_version"
}

input_directory="/home/logan/comp5566/Blockchain-and-smart-contract-security/sol_file"
output_directory="/home/logan/comp5566/Blockchain-and-smart-contract-security/echidna/results_v2"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Iterate over the .sol files and run echidna
for input_file_path in "$input_directory"/*.sol; do
  sol_file="$(basename "$input_file_path")"
  output_file_path="$output_directory/${sol_file%.sol}.txt"

  # Extract the solc version and switch to that version
  solc_version=$(extract_solc_version "$input_file_path")
  switch_solc_version "$solc_version"

  # Run echidna and measure the execution time
  start_time=$(date +%s.%N)
  echidna "$input_file_path"
  exit_status=$?
  end_time=$(date +%s.%N)

  running_time=$(echo "$end_time - $start_time" | bc)

  # Read the generated data from the JSON file
  json_file="crytic-export/combined_solc.json"
  if [ -f "$json_file" ]; then
    json_data=$(cat "$json_file")
  else
    json_data="Error: JSON file not found."
  fi

  # Write the results and running time to the output file
  echo "Running time: $running_time seconds" > "$output_file_path"
  echo -e "\n$json_data" >> "$output_file_path"

  # If there was an error, print a message
  if [ $exit_status -ne 0 ]; then
    echo "An error occurred while processing $input_file_path. Check the output file for details."
  fi

  # Remove the crytic-export directory to avoid mixing results
  rm -rf "crytic-export"
done
