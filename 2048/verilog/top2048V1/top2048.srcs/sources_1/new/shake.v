`timescale 1ns / 1ps

// Project F:  滤波
//使用一个32位fifo数组来按键去抖。
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card

module shake(rst,clk,din,dout);
	input rst,clk,din;
	output reg dout;
	reg [31:0] fifo;
	
	always @(posedge rst or posedge clk) begin
		if(rst) fifo <= 0;
		else fifo[31:0] <= {fifo[30:0],din};
	end
	
	always @(fifo) begin
		if(fifo == 32'h00000000) dout <= 0;
		else if(fifo == 32'hffffffff) dout <= 1;
		else dout <= dout;
	end
endmodule