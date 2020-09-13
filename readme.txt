All 3 programs worked.
Simply run test bench and you will see the result.
The modifications we've done to the test bench:
1. We updated top level name in test bench. And top_level port names does not match test bench port names, so we extended (.*).
2. In orginal test benvh, pattern in dm1[160] was in lower 5 bits. We changed it to upper 5 bits to match lab 1 instruction.

Program 1 (forward error correction block coder/transmitter): Given a series of fifteen 11-bit message blocks in data mem[0:29], generate the corresponding 15-bit (essentially 2-byte) encoded versions and store these in data mem[30:59]. Input and output formats are as follows:     
input MSW = 0   0   0   0   0   b11 b10 b9               
LSW =  b8 b7 b6 b5 b4 b3   b2   b1, where bx denotes a data bitoutput 
MSW =  b11 b10 b9 b8 b7 b6 b5 p8                 
LSW =  b4   b3  b2   p4 b1 p2 p1 p16, where px denotes a parity bit      
ModelSim ignores _, so I use them to parse the vectors for clarity.
Example, to clarify “endianness”:  binary data value = 10101010101              
mem[1] = 00000101   -- 5 bits zero pad followed by b11:b9 = 00000_101              
mem[0] = 01010101   -- lower 8 data bits b8:b1           

You would generate and store:              
mem[31] = 10101010 -- b11:b5, p8 = 1010101_0               
mem[30] = 01011010-- b4:b2, p4, b1, p2, p1, p16 = 010_1_1_01_0               

p8 = ^(b11:b5) = 0;               
p4 = ^(b11:b8,b4,b3,b2) = 1;               
p2 = ^(b11,b10,b7,b6,b4,b3,b1) = 0;                
p1 = ^(b11,b9,b7,b5,b4,b2,b1) = 1;                      
p16 = ^(b11:1,p8,p4,p2,p1)

Program 2 (forward error correction block decoder/receiver): Given a series of 15 two-byte encrypted data values, possibly corrupted in data mem[64:93], recover the original message and write into data mem[94:123].        
This is just (sort of :) ) the inverse problem. However, in Program 1 there was only 1 unique output for each unique input. Now there are several (how many?) possible inputs for each of the 2**11 possible outputs. This code can correct any single-bit error and detect any two-bit errorr. The test bench will generate parity bits for various random data sequences, occasionally flip one, occasionally two, of the parity or data bits, and then ask you to figure out the original message. 

Program 3 (pattern search): Given a continuous message string in data mem[128:159], enter the total number of occurrences of a given 5-bit pattern in any byte into data mem[192]. (Do not cross byte boundaries.) You will find the 5-bit pattern itself in bits [7:3] of data mem[160].    

Write the number of bytes within which the pattern occurs into data mem[193] and the total number of times it occurs anywhere in the string into data mem[194]. In the latter case, consider the 32 bytes to comprise one continuous 256-bit message, so that the 4-bit pattern could span adjacent portions of two consecutive bytes.         

Note the order ("Endian-ness") of the sequence:                              

data mem [128] = first byte in message string; bit [7] is the first bit in the entire string;                              
data mem [129] = second byte; bit [7] of [129] comes right after bit [0] of [128]         

Example:             
Pattern = 4'b00000    String is all zeroes, as well            
data_mem[192] = 4*32 =128 because the string can show up in any of 4 different locations in each byte            
data_mem[193] = 32 because every byte contains at least one copy of the pattern            
data_mem[194] = 252, because the pattern can start at bit 0, 1, 2, ..., 251  [1]
