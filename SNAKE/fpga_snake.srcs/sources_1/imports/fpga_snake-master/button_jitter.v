`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    button_jitter 
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
module button_jitter(
    input clk,
    input rst_n,
    input button_in,
	output reg button_final
    );

	reg [31:0] cnt;
	reg cnt_en;
   reg button_out;
	parameter interval=1_000_000;
		
	always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n) button_out<=1'b0;
		else if (cnt==interval-1) button_out<=button_in;
	end
	
	always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n) button_final<=1'b0;
	   else if (cnt==interval-1 && button_in) button_final<=1'b1;
		else if (button_final) button_final<=1'b0;
	end
	
	always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n) cnt_en<=1'b0;
		else if (button_in != button_out) cnt_en<=1'b1;
		else cnt_en<=1'b0;
	end

	always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n) cnt<=32'b0;
		else if (cnt_en) cnt<=cnt+32'b1;
		else cnt<=32'b0;
	end
		
endmodule
