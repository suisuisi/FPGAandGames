//-------------------------------------------------------------------------
//      memory_contents.sv                                               --
//      The memory contents in the test memory.                          --
//                                                                       --
//      Originally contained in test_memory.sv                           --
//      Revised 10-19-2017 by Anand Ramachandran and Po-Han Huang        --
//      Revised 02-01-2018 by Yikuan Chen
//                        spring 2018 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
// Requires SLC3_2.sv
import SLC3_2::*;

module memory_parser;

parameter size = 256;

task memory_contents(output logic[15:0] mem_array[0:size-1]);

////////// Test code begin
// Feel free to modify the first few instructions to test specific opcode you want to test.
// e.g. Replace mem_array[0] = opCLR(R0) with mem_array[0] = opADDi(R0, R0, 1) to 
//      test ADD instruction (R0 <- R0 + 1).
// See SLC3_2.sv for all the functions you can use to create instructions.
// Note that if you do this, remember to turn "init_external" in test_memory.sv to 1 for 
// any of your modifications to take effect.

   mem_array[   0 ] =    opCLR(R0)                ;       // Clear the register so it can be used as a base
   mem_array[   1 ] =    opLDR(R1, R0, inSW)      ;       // Load switches
   mem_array[   2 ] =    opJMP(R1)                ;       // Jump to the start of a program
   
                                                          // Basic I/O test 1
   mem_array[   3 ] =    opLDR(R1, R0, inSW)      ;       // Load switches
   mem_array[   4 ] =    opSTR(R1, R0, outHEX)    ;       // Output
   mem_array[   5 ] =    opBR(nzp, -3)            ;       // Repeat
                                      
                                                          // Basic I/O test 2
   mem_array[   6 ] =    opPSE(12'h801)           ;       // Checkpoint 1 - prepare to input
   mem_array[   7 ] =    opLDR(R1, R0, inSW)      ;       // Load switches
   mem_array[   8 ] =    opSTR(R1, R0, outHEX)    ;       // Output
   mem_array[   9 ] =    opPSE(12'hC02)           ;       // Checkpoint 2 - read output, prepare to input
   mem_array[  10 ] =    opBR(nzp, -4)            ;       // Repeat
                                          
                                                          // Basic I/O test 3 (Self-modifying code)
   mem_array[  11 ] =    opPSE(12'h801)           ;       // Checkpoint 1 - prepare to input
   mem_array[  12 ] =    opJSR(0)                 ;       // Get PC address
   mem_array[  13 ] =    opLDR(R2,R7,3)           ;       // Load pause instruction as data
   mem_array[  14 ] =    opLDR(R1, R0, inSW)      ;       // Load switches
   mem_array[  15 ] =    opSTR(R1, R0, outHEX)    ;       // Output
   mem_array[  16 ] =    opPSE(12'hC02)           ;       // Checkpoint 2 - read output, prepare to input
   mem_array[  17 ] =    opINC(R2)                ;       // Increment checkpoint number
   mem_array[  18 ] =    opSTR(R2,R7,3)           ;       // Store new checkpoint instruction (self-modifying code)
   mem_array[  19 ] =    opBR(nzp, -6)            ;       // Repeat
                                    
   mem_array[  20 ] =    opCLR(R0)                ;       // XOR test
   mem_array[  21 ] =    opPSE(12'h801)           ;       // Checkpoint 1 - prepare to input (A)
   mem_array[  22 ] =    opLDR(R1, R0, inSW)      ;       // Load switches
   mem_array[  23 ] =    opPSE(12'h802)           ;       // Checkpoint 2 - prepare to input (B)
   mem_array[  24 ] =    opLDR(R2, R0, inSW)      ;       // Load switches again
   mem_array[  25 ] =    opNOT(R3, R1)            ;       // R3: A'
   mem_array[  26 ] =    opAND(R3, R3, R2)        ;       // R3: A'B
   mem_array[  27 ] =    opNOT(R3, R3)            ;       // R3: (A'B)'
   mem_array[  28 ] =    opNOT(R4, R2)            ;       // R4: B'
   mem_array[  29 ] =    opAND(R4, R4, R1)        ;       // R4: B'A
   mem_array[  30 ] =    opNOT(R4, R4)            ;       // R4: (B'A)'
   mem_array[  31 ] =    opAND(R3, R3, R4)        ;       // R3: (A'B)'(B'A)'
   mem_array[  32 ] =    opNOT(R3, R3)            ;       // R3: ((A'B)'(B'A)')' XOR using only and-not 
   mem_array[  33 ] =    opSTR(R3, R0, outHEX)    ;       // Output
   mem_array[  34 ] =    opPSE(12'h405)           ;       // Checkpoint 5 - read output
   mem_array[  35 ] =    opBR(nzp, -15)           ;       // Repeat
   mem_array[  36 ] =    NO_OP		              ;       // Place Holder  
   mem_array[  37 ] =    NO_OP		              ;       // Place Holder  
   mem_array[  38 ] =    NO_OP		              ;       // Place Holder  
   mem_array[  39 ] =    NO_OP		              ;       // Place Holder  
   mem_array[  40 ] =    NO_OP		              ;       // Place Holder
   mem_array[  41 ] =    NO_OP		              ;       // Place Holder   
                                 
   mem_array[  42 ] =    opCLR(R0)                ;       // Run once test (also for JMP)
   mem_array[  43 ] =    opCLR(R1)                ;       // clear R1
   mem_array[  44 ] =    opJSR(0)                 ;       // get jumpback address
   mem_array[  45 ] =    opSTR(R1, R0, outHEX)    ;       // output R1; LOOP DEST
   mem_array[  46 ] =    opPSE(12'h401)           ;       // Checkpoint 1 - read output
   mem_array[  47 ] =    opINC(R1)                ;       // increment R1
   mem_array[  48 ] =    opRET()                   ;       // repeat
                                 
   mem_array[  49 ] =    opCLR(R0)                ;       // Multiplier Program
   mem_array[  50 ] =    opJSR(0)                 ;       // R7 <- PC (for loading bit test mask)
   mem_array[  51 ] =    opLDR(R3, R7, 22)        ;       // load mask;
   mem_array[  52 ] =    opCLR(R4)                ;       // clear R4 (iteration tracker),  ; START
   mem_array[  53 ] =    opCLR(R5)                ;       // R5 (running total)
   mem_array[  54 ] =    opPSE(12'h801)           ;       // Checkpoint 1 - prepare to input
   mem_array[  55 ] =    opLDR(R1, R0, inSW)      ;       // Input operand 1
   mem_array[  56 ] =    opPSE(12'h802)           ;       // Checkpoint 2 - prepare to input
   mem_array[  57 ] =    opLDR(R2, R0, inSW)      ;       // Input operand 2
   mem_array[  58 ] =    opADD(R5, R5, R5)        ;       // shift running total; LOOP DEST
   mem_array[  59 ] =    opAND(R7, R3, R1)        ;       // apply mask
   mem_array[  60 ] =    opBR(z, 1)               ;       // test bit and jump over...
   mem_array[  61 ] =    opADD(R5, R5, R2)        ;       // ... the addition
   mem_array[  62 ] =    opADDi(R4, R4, 0)        ;       // test iteration == 0 (first iteration)
   mem_array[  63 ] =    opBR(p,2)                ;       // if not first iteration, jump over negation
   mem_array[  64 ] =    opNOT(R5, R5)            ;       // 2's compliment negate R5
   mem_array[  65 ] =    opINC(R5)                ;       //   (part of above)
   mem_array[  66 ] =    opINC(R4)                ;       // increment iteration
   mem_array[  67 ] =    opADD(R1, R1, R1)        ;       // shift operand 1 for mask comparisons
   mem_array[  68 ] =    opADDi(R7, R4, -8)       ;       // test for last iteration
   mem_array[  69 ] =    opBR(n, -12)             ;       // branch back to LOOP DEST if iteration < 7
   mem_array[  70 ] =    opSTR(R5, R0, outHEX)    ;       // Output result
   mem_array[  71 ] =    opPSE(12'h403)           ;       // Checkpoint 3 - read output
   mem_array[  72 ] =    opBR(nzp, -21)           ;       // loop back to start
   mem_array[  73 ] =    16'h0080                 ;       // bit test mask
                                 
   mem_array[  74 ] =    16'h00ef                  ;       // Data for Bubble Sort
   mem_array[  75 ] =    16'h001b                  ;       
   mem_array[  76 ] =    16'h0001                  ;       
   mem_array[  77 ] =    16'h008c                  ;       
   mem_array[  78 ] =    16'h00db                  ;       
   mem_array[  79 ] =    16'h00fa                  ;       
   mem_array[  80 ] =    16'h0047                  ;       
   mem_array[  81 ] =    16'h0046                  ;       
   mem_array[  82 ] =    16'h001f                  ;       
   mem_array[  83 ] =    16'h000d                  ;       
   mem_array[  84 ] =    16'h00b8                  ;       
   mem_array[  85 ] =    16'h0003                  ;       
   mem_array[  86 ] =    16'h006b                  ;       
   mem_array[  87 ] =    16'h004e                  ;       
   mem_array[  88 ] =    16'h00f8                  ;       
   mem_array[  89 ] =    16'h0007                  ;       
   mem_array[  90 ] =    opCLR(R0)                ;       // Bubblesort Program start
   mem_array[  91 ] =    opJSR(0)                 ;       
   mem_array[  92 ] =    opADDi(R6, R7, -16)      ;       // Store data location in R6
   mem_array[  93 ] =    opADDi(R6, R6, -2)       ;       //   (data location is 18 above the address from JSR)
   mem_array[  94 ] =    opPSE(12'h3FF)           ;       // Checkpoint -1 - select function; LOOP DEST
   mem_array[  95 ] =    opLDR(R1, R0, inSW)      ;       
   mem_array[  96 ] =    opBR(z, -3)              ;       // If 0, retry
   mem_array[  97 ] =    opDEC(R1)                ;       
   mem_array[  98 ] =    opBR(np, 2)              ;       // if selection wasn't 1, jump over�
   mem_array[  99 ] =    opJSR(9)                 ;       //   ...call to entry function
   mem_array[ 100 ] =    opBR(nzp, -7)            ;       
   mem_array[ 101 ] =    opDEC(R1)                ;       
   mem_array[ 102 ] =    opBR(np, 2)              ;       // if selection wasn't 2, jump over�
   mem_array[ 103 ] =    opJSR(15)                ;       //   ...call to sort function
   mem_array[ 104 ] =    opBR(nzp, -11)           ;       
   mem_array[ 105 ] =    opDEC(R1)                ;       
   mem_array[ 106 ] =    opBR(np, -13)            ;       // if selection wasn't 3, retry
   mem_array[ 107 ] =    opJSR(29)                ;       //   call to display function
   mem_array[ 108 ] =    opBR(nzp, -15)           ;       // repeat menu
   mem_array[ 109 ] =    opCLR(R1)                ;       // ENTRY FUNCTION
   mem_array[ 110 ] =    opSTR(R1, R0, outHEX)    ;       // R5 is temporary index into data; R1 is counter; LOOP DEST
   mem_array[ 111 ] =    opPSE(12'hC01)           ;       // Checkpoint 1 - read data (index) and write new value
   mem_array[ 112 ] =    opLDR(R2, R0, inSW)      ;       
   mem_array[ 113 ] =    opADD(R5, R6, R1)        ;       // generate pointer to data
   mem_array[ 114 ] =    opSTR(R2, R5, 0)         ;       // store data
   mem_array[ 115 ] =    opINC(R1)                ;       // increment counter
   mem_array[ 116 ] =    opADDi(R3, R1, -16)      ;       // test for counter == 16
   mem_array[ 117 ] =    opBR(n, -8)              ;       // less than 16, repeat
   mem_array[ 118 ] =    opRET()                   ;       // ENTRY FUNCTION RETURN
   mem_array[ 119 ] =    opADDi(R1, R0, -16)      ;       // i = -16; SORT FUNCTION
   mem_array[ 120 ] =    opADDi(R2, R0, 1)        ;       // j = 1; OUTER LOOP DEST
   mem_array[ 121 ] =    opADD(R3, R6, R2)        ;       // generate pointer to data; INNER LOOP DEST
   mem_array[ 122 ] =    opLDR(R4, R3, -1)        ;       // R4 = data[j-1]
   mem_array[ 123 ] =    opLDR(R5, R3, 0)         ;       // R5 = data[j]
   mem_array[ 124 ] =    opNOT(R5, R5)            ;       
   mem_array[ 125 ] =    opADDi(R5, R5, 1)        ;       // R5 = -data[j]
   mem_array[ 126 ] =    opADD(R5, R4, R5)        ;       // R5 = data[j-1]-data[j]
   mem_array[ 127 ] =    opBR(nz, 3)              ;       // if data[j-1] > data[j]
   mem_array[ 128 ] =    opLDR(R5, R3, 0)         ;       // { R5 = data[j]
   mem_array[ 129 ] =    opSTR(R5, R3, -1)        ;       //   data[j-1] = data[j]
   mem_array[ 130 ] =    opSTR(R4, R3, 0)         ;       //   data[j] = R4 } // old data[j-1]
   mem_array[ 131 ] =    opINC(R2)                ;
   mem_array[ 132 ] =    opADD(R3, R1, R2)        ;       // Compare i and j
   mem_array[ 133 ] =    opBR(n, -13)             ;       // INNER LOOP BACK
   mem_array[ 134 ] =    opINC(R1)                ;       
   mem_array[ 135 ] =    opBR(n, -16)             ;       // OUTER LOOP BACK
   mem_array[ 136 ] =    opRET()                   ;       // SORT FUNCTION RETURN
   mem_array[ 137 ] =    opCLR(R1)                ;       // DISPLAY FUNCTION
   mem_array[ 138 ] =    opADD(R4, R7, R0)        ;       // JSR shuffle to get PC value in R5
   mem_array[ 139 ] =    opJSR(0)                 ;       
   mem_array[ 140 ] =    opADD(R5, R7, R0)        ;       
   mem_array[ 141 ] =    opADD(R7, R4, R0)        ;       // shuffle done
   mem_array[ 142 ] =    opLDR(R3, R5, 15)        ;       // R3 = opPSE(12'b802)
   mem_array[ 143 ] =    opADDi(R2, R0, 8)        ;       
   mem_array[ 144 ] =    opADD(R2, R2, R2)        ;       // R2 = 16
   mem_array[ 145 ] =    opADD(R4, R6, R1)        ;       // generate pointer to data; LOOP DEST
   mem_array[ 146 ] =    opLDR(R4, R4, 0)         ;       // load data
   mem_array[ 147 ] =    opSTR(R4, R0, outHEX)    ;       // display data
   mem_array[ 148 ] =    opPSE(12'h802)           ;       // Checkpoint 2 - read data (self-modified instruction)
   mem_array[ 149 ] =    opADD(R3, R3, R2)        ;       // modify register with code
   mem_array[ 150 ] =    opSTR(R3, R5, 8)         ;       // store modified code
   mem_array[ 151 ] =    opINC(R1)                ;       // increment counter
   mem_array[ 152 ] =    opADDi(R4, R1, -16)      ;       // test for counter == 16
   mem_array[ 153 ] =    opBR(n, -9)              ;       // less than 16, repeat
   mem_array[ 154 ] =    opRET()                  ;       // DISPLAY FUNCTION RETURN
   mem_array[ 155 ] =    opPSE(12'h802)           ;       //    instruction as data
   
   
   for (integer i = 156; i <= size - 1; i = i + 1)		// Assign the rest of the memory to 0
   begin
       mem_array[i] = 16'h0;
   end

///////////// Test code end

endtask

endmodule
