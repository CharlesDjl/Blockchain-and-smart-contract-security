# Mythril Test
This directory aim to do the mythril tool test on ../sol_files.
## Build the environment
Install Mythril Tool from https://github.com/ConsenSys/mythril
from Pypi (Python 3.6-3.9):

    $ pip3 install mythril

## Install solc-selcect
solc-select is a package to change solidity compiler version, which do good to the Tools with stringent environmental requirements

    $ pip3 install solc-select
   Install all versions
   
    $ solc-select install all

## Run the script 
Our scripts will analyze all the solidity files in the ../sol_file

With 180 seconds detection limited for each single file.
    $ .mythril_analyze_all.sh

## Check the results
The results can be reached in ./results
