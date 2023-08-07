# Blockchain-and-smart-contract-security
BLOCKCHAIN AND SMART CONTRACT SECURITY COMP5566_20222_A
## Results
![image](https://github.com/CharlesDjl/Blockchain-and-smart-contract-security/assets/51400996/24533774-077a-44d0-9073-f775ff19fa77)

As the results shown above, regarding the single tool correctness, Mythril has the highest accuracy. However, it also executes the longest time among the tools. That is because the procedure of Mythril’s dynamic symbolic detection simulates the solidity code execution, which will be time-consumed. With regard to the time performance, though Ethlint has the shortest running time, its accuracy performance is the lowest one. Generally, Slither keeps the best balance between accuracy and time since it can reach 80% of Mythril’s accuracy while only taking 3% of its time.
Even so, the best accuracy is also not satisfied, we tried to use combined tools in order to improve the accuracy further. We combined the best two tools and tested again, we discovered that the model used 3 more seconds to detect per file to provide 9% of accuracy, which is quite an acceptable improvement.
