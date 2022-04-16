`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:     
// Design Name: 
// Module Name:    clk_divide 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_divide(
	input clk,
	input rst_n,
	input hard,
	output reg clk_slow
	);

	wire [31:0] target;
	assign target = (hard) ? 32'd5_999_999 : 32'd9_999_999;
	reg [31:0] cnt_div;
	initial
		cnt_div <= 32'h0;

	always @(posedge clk or negedge rst_n)
	 begin
	  if (~rst_n) cnt_div<=32'h0;
	  else if (cnt_div == target) cnt_div<=32'h0;
	  else cnt_div<=cnt_div+32'h1;
	 end

	always @(posedge clk or negedge rst_n)
	 begin
	 	if (~rst_n) clk_slow<=1'b0;
	 	else if (cnt_div == target) clk_slow<=1'b1;
	 	else clk_slow<=1'b0;
	 end

endmodule