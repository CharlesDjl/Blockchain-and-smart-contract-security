import os
import re

def is_version_exactly_050x(line):
    pattern = r'^\s*pragma solidity\s+([0-9]+\.[0-9]+\.[0-9]+)\s*;'
    match = re.search(pattern, line)
    if match:
        version = match.group(1)
        version_numbers = [int(x) for x in version.split('.')]
        return version_numbers[0] == 0 and version_numbers[1] == 5
    return False

def filter_sol_files(directory):
    filtered_files = []
    
    for filename in os.listdir(directory):
        if filename.endswith(".sol"):
            filepath = os.path.join(directory, filename)
            with open(filepath, "r") as file:
                for line in file:
                    if is_version_exactly_050x(line):
                        filtered_files.append(filepath)
                        break
    return filtered_files

if __name__ == "__main__":
    directory = "/home/logan/comp5566/Blockchain-and-smart-contract-security/sol_file"  # Replace with the path to your .sol files
    filtered_files = filter_sol_files(directory)
    print("Filtered .sol files with 'pragma solidity' version exactly 0.5.x:")
    for f in filtered_files:
        print(f)