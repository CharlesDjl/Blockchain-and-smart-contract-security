#!/bin/bash

input_directory="/home/logan/comp5566/Blockchain-and-smart-contract-security/sol_file"
output_directory="/home/logan/comp5566/Blockchain-and-smart-contract-security/securify/results"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Iterate over the .sol files and run securify
for input_file_path in "$input_directory"/*.sol; do
  sol_file="$(basename "$input_file_path")"
  output_file_path="$output_directory/${sol_file%.sol}.txt"

  # Run securify and measure the execution time
  start_time=$(date +%s.%N)
  output=$(securify "$input_file_path" 2>&1)
  exit_status=$?
  end_time=$(date +%s.%N)

  running_time=$(echo "$end_time - $start_time" | bc)

  # Write the results and running time to the output file
  echo "Running time: $running_time seconds" > "$output_file_path"
  echo -e "\n$output" >> "$output_file_path"

  # If there was an error, print a message
  if [ $exit_status -ne 0 ]; then
    echo "An error occurred while processing $input_file_path. Check the output file for details."
  fi
done