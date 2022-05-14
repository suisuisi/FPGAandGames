//-------------------------------------------------------------------------
//      SLC3_2.sv                                                        --
//      Stephen Kempf                                                    --
//      Created  Spring 2006                                             --
//      Revised  3-22-2007                                               --
//              10-22-2013                                               --
//              03-04-2014                                               --
//              04-25-2017 by Po-Han Huang for additional comments       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8 (Test_Memory)                         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
// TO USE: Include this file in your project, and paste the following 2 lines
//   (uncommented) into whatever file needs to reference the functions &
//   constants included in this file, just after the usual library references:
//`include "SLC3_2.sv"
//import SLC3_2::*;

`ifndef _SLC3_2__SV 
`define _SLC3_2__SV

package SLC3_2;
   
   // Useful constants
   parameter op_ADD = 4'b0001; // opcode aliases
   parameter op_AND = 4'b0101;
   parameter op_NOT = 4'b1001;
   parameter op_BR  = 4'b0000;
   parameter op_JMP = 4'b1100;
   parameter op_JSR = 4'b0100;
   parameter op_LDR = 4'b0110;
   parameter op_STR = 4'b0111;
   parameter op_PSE = 4'b1101;
   
   parameter NO_OP = 15'b0;   // "branch never" is a no op
  
   parameter R0 = 3'b000;      // register aliases
   parameter R1 = 3'b001;
   parameter R2 = 3'b010;
   parameter R3 = 3'b011;
   parameter R4 = 3'b100;
   parameter R5 = 3'b101;
   parameter R6 = 3'b110;
   parameter R7 = 3'b111;
  
   parameter p   = 3'b001;     // branch condition aliases
   parameter z   = 3'b010;
   parameter zp  = 3'b011;
   parameter n   = 3'b100;
   parameter np  = 3'b101;
   parameter nz  = 3'b110;
   parameter nzp = 3'b111;
 
   parameter outHEX = -1;
   parameter inSW = -1;
  
   // opCLR(DR): same as DR <- DR AND DR
   function [15:0] opCLR ( input [2:0] DR );
      opCLR[15:12] = op_AND;
      opCLR[11: 9] = DR;
      opCLR[ 8: 6] = DR;
      opCLR[ 5   ] = 1'b1;
      opCLR[ 4: 0] = 5'b0;
   endfunction
   
   // opAND(DR, SR1, SR2): DR <- SR1 AND SR2
   function [15:0] opAND ( input [2:0] DR, SR1, SR2 );
      opAND[15:12] = op_AND;
      opAND[11: 9] = DR;
      opAND[ 8: 6] = SR1;
      opAND[ 5: 3] = 3'b0;
      opAND[ 2: 0] = SR2;
   endfunction
   
   // opANDi(DR, SR1, imm5): DR <- SR1 AND SEXT(imm5)
   function [15:0] opANDi ( input [2:0] DR, SR, integer imm5 );
      opANDi[15:12] = op_AND;
      opANDi[11: 9] = DR;
      opANDi[ 8: 6] = SR;
      opANDi[ 5   ] = 1'b1;
      opANDi[ 4: 0] = imm5[4:0];
   endfunction
   
   // opADD(DR, SR1, SR2): DR <- SR1 + SR2
   function [15:0] opADD ( input [2:0] DR, SR1, SR2 );
      opADD[15:12] = op_ADD;
      opADD[11: 9] = DR;
      opADD[ 8: 6] = SR1;
      opADD[ 5: 3] = 3'b0;
      opADD[ 2: 0] = SR2;
   endfunction
   
   // opADDi(DR, SR1, imm5): DR <- SR1 + SEXT(imm5)
   function [15:0] opADDi ( input [2:0] DR, SR, integer imm5 );
      opADDi[15:12] = op_ADD;
      opADDi[11: 9] = DR;
      opADDi[ 8: 6] = SR;
      opADDi[ 5   ] = 1'b1;
      opADDi[ 4: 0] = imm5[4:0];
   endfunction
   
   // opINC(DR): same as DR <- DR + 1
   function [15:0] opINC ( input [2:0] DR );
      opINC[15:12] = op_ADD;
      opINC[11: 9] = DR;
      opINC[ 8: 6] = DR;
      opINC[ 5   ] = 1'b1;
      opINC[ 4: 0] = 1;
   endfunction
   
   // opINC(DR): same as DR <- DR - 1
   function [15:0] opDEC ( input [2:0] DR );
      opDEC[15:12] = op_ADD;
      opDEC[11: 9] = DR;
      opDEC[ 8: 6] = DR;
      opDEC[ 5   ] = 1'b1;
      opDEC[ 4: 0] = -1;
   endfunction
   
   // opNOT(DR, SR): DR <- NOT(SR)
   function [15:0] opNOT ( input [2:0] DR, SR );
      opNOT[15:12] = op_NOT;
      opNOT[11: 9] = DR;
      opNOT[ 8: 6] = SR;
      opNOT[ 5: 0] = 5'b1;
   endfunction
   
   // opBR(nzp, PCoffset9): if ((n AND N) OR (z AND Z) OR (p AND P)) then PC <- PC + SEXT(PCoffset9);
   function [15:0] opBR ( input [2:0] condition, integer PCoffset9 );
      opBR[15:12] = op_BR;
      opBR[11: 9] = condition;
      opBR[ 8: 0] = PCoffset9[8:0];
   endfunction
   
   // opJMP(BaseR): PC <- BaseR
   function [15:0] opJMP ( input [2:0] BaseR );
      opJMP[15:12] = op_JMP;
      opJMP[11: 9] = 3'b0;
      opJMP[ 8: 6] = BaseR;
      opJMP[ 5: 0] = 6'b0;
   endfunction
   
   // opRET(): same as PC <- R7
   function [15:0] opRET ( );
      opRET[15:12] = op_JMP;
      opRET[11: 9] = 3'b0;
      opRET[ 8: 6] = R7;
      opRET[ 5: 0] = 6'b0;
   endfunction
   
   // opJSR(PCoffset11): R7 <- PC; PC <- PC + SEXT(PCoffset11)
   function [15:0] opJSR ( input integer PCoffset11 );
      opJSR[15:12] = op_JSR;
      opJSR[11   ] = 1'b1;
      opJSR[10: 0] = PCoffset11[10:0];
   endfunction
   
   // opLDR(DR, BaseR, offset6): DR <- M[BaseR + SEXT(offset6)]
   function [15:0] opLDR ( input [2:0] DR, BaseR, integer offset6 );
      opLDR[15:12] = op_LDR;
      opLDR[11: 9] = DR;
      opLDR[ 8: 6] = BaseR;
      opLDR[ 5: 0] = offset6[5:0];
   endfunction
   
   // opSTR(SR, BaseR, offset6): M[BaseR + SEXT(offset6)] <- SR;
   function [15:0] opSTR ( input [2:0] SR, BaseR, integer offset6 );
      opSTR[15:12] = op_STR;
      opSTR[11: 9] = SR;
      opSTR[ 8: 6] = BaseR;
      opSTR[ 5: 0] = offset6[5:0];
   endfunction
   
   // opPSE(ledVect12): Go to pause state and set LEDs to ledVect12
   function [15:0] opPSE ( input [11:0] ledVect12 );
      opPSE[15:12] = op_PSE;
      opPSE[11: 0] = ledVect12;
   endfunction
   
   
endpackage

`endif 