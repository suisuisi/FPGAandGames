`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    directon_gen 
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
module direction_gen(
	input clk,
	input rst_n,
	input [3:0] btn,
	output reg [3:0] direction
	);

	wire [3:0] btn_new;
	wire [3:0] btn_old;
	
	assign btn_old = direction;
	
	button_jitter jitter3(clk, rst_n, btn[3], btn_new[3]);
	button_jitter jitter2(clk, rst_n, btn[2], btn_new[2]);
	button_jitter jitter1(clk, rst_n, btn[1], btn_new[1]);
	button_jitter jitter0(clk, rst_n, btn[0], btn_new[0]);	

	always @(posedge clk or negedge rst_n)
	begin
		if (~rst_n) direction<=4'b0100;
		else if (btn_old == 4'b1000 && btn_new == 4'b0100) direction <= btn_old;
		else if (btn_old == 4'b0100 && btn_new == 4'b1000) direction <= btn_old;
		else if (btn_old == 4'b0010 && btn_new == 4'b0001) direction <= btn_old;
		else if (btn_old == 4'b0001 && btn_new == 4'b0010) direction <= btn_old;
		else if (btn_new != 4'b0000) begin
			direction <= btn_new;
		end
	end
endmodule