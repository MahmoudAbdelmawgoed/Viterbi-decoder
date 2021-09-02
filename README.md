# Viterbi-decoder with coding rate = ½ and memory depth = 2
#### This decoder uses the Viterbi algorithm for decoding a bitstream that has been encoded using a convolutional code or trellis code. It does the maximum likelihood decoding.
## Inputs
### state     -> Initial state that you want the diagram to starts from it 
### rx_signal -> The encoded stream
## Output
### input sequence that will lead to the max cost path
##### This photo shows tha path that has the max cost, so we will get its sequence if the initial state is state 11 as described in the testbench
![img](https://user-images.githubusercontent.com/78317304/131787596-0ebc74b0-4ed0-4fb3-a545-f9a5460812b9.png)
