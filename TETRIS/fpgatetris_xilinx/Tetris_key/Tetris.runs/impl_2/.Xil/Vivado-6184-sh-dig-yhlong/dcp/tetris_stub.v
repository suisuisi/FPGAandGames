// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module tetris(clk, rst, UP_KEY, LEFT_KEY, RIGHT_KEY, DOWN_KEY, start, vsync_r, hsync_r, OutRed, OutGreen, OutBlue);
  input clk;
  input rst;
  input UP_KEY;
  input LEFT_KEY;
  input RIGHT_KEY;
  input DOWN_KEY;
  input start;
  output vsync_r;
  output hsync_r;
  output [3:0]OutRed;
  output [3:0]OutGreen;
  output [3:0]OutBlue;
endmodule
