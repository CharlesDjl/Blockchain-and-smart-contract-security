# Slither Test
This directory aim to do the Slither tool test on ../sol_files.
## Build the environment
Install Mythril Tool from https://github.com/crytic/slither
from Pypi (Python 3.6-3.9):

    $ pip3 install slither-analyzer

## Install solc-selcect
solc-select is a package to change solidity compiler version, which do good to the Tools with stringent environmental requirements

    $ pip3 install solc-select
   Install all versions
   
    $ solc-select install all

## Run the script 
Our scripts will analyze all the solidity files in the ../sol_file

    $ .slither_analyze_all.sh

The script will automatically check the version of the .sol file and change the compile version to the corresponding one.

## Check the results
The results can be reached in ./results
