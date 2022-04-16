`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    random_gen 
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
module random_gen(
	input clk,
	output reg [9:0] rand_x,
	output reg [9:0] rand_y
	);

	reg [5:0] point_x = 10, point_y = 10;

	always @(posedge clk)
		point_x <= point_x + 3;

	always @(posedge clk)
		point_y <= point_y + 1;

	always @(posedge clk)
	begin	
		if (point_x > 62)
			rand_x <= 620;
		else if (point_x < 2)
			rand_x <= 20;
		else
			rand_x <= (point_x * 10);
	end
	
	always @(posedge clk)
	begin	
		if(point_y>46)
			rand_y <= 460;
		else if (point_y<2)
			rand_y <= 20;
		else
			rand_y <= (point_y * 10);
	end
endmodule