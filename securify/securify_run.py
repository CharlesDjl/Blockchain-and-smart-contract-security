import os
import subprocess
import time

def run_securify_on_files(input_directory, output_directory):
    # Get a list of all .sol files in the input directory
    sol_files = [f for f in os.listdir(input_directory) if f.endswith('.sol')]

    # Create the output directory if it doesn't exist
    os.makedirs(output_directory, exist_ok=True)

    # Iterate over the .sol files and run securify
    for sol_file in sol_files:
        input_file_path = os.path.join(input_directory, sol_file)
        output_file_path = os.path.join(output_directory, sol_file.replace('.sol', '.txt'))

        # Run securify and measure the execution time
        start_time = time.time()
        process = subprocess.run(['securify', input_file_path], capture_output=True, text=True)
        end_time = time.time()

        # Write the results and running time to the output file
        with open(output_file_path, 'w') as output_file:
            output_file.write(f"Running time: {end_time - start_time} seconds\n\n")
            output_file.write(process.stdout)

if __name__ == "__main__":
    input_directory = "/home/logan/comp5566/Blockchain-and-smart-contract-security/sol_file"
    output_directory = "/home/logan/comp5566/Blockchain-and-smart-contract-security/securify/results"
    run_securify_on_files(input_directory, output_directory)
