`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    graph 
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
module graph(
	input clk,
	input rst_n,
	input reset_high,
	input hard,
	input [3:0] direction,
	input video_on,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [7:0] rgb,
	output [3:0] score1,
	output [3:0] score0,
	output [3:0] high1,
	output [3:0] high0,
	output g_over
	);

	parameter apple_rgb = 8'b11100000;
	parameter death_rgb = 8'b11100000;
	parameter snake_rgb = 8'b00011100;
	parameter border_rgb = 8'b00000011;
	parameter blank_rgb = 8'b00000000;

	wire [9:0] rand_x;
	wire [9:0] rand_y;
	reg [6:0] snake_x [0:31];
	reg [6:0] snake_y [0:31];
	reg [9:0] apple_x, apple_y;
	integer loop1, loop2, loop3;
	wire border_on;
	wire apple_on;
	reg snake_on;
	wire clk_update;
	reg snake_body;
	reg snake_head;
	reg game_over;
	reg apple_eaten;
	wire r;
	wire g;
	wire b;
	reg death;
	integer size;
	integer high;
	
	initial
	 high = 0;
	
	clk_divide new_clk(clk, rst_n, hard, clk_update);
	random_gen random_apple(clk_update, rand_x, rand_y);

	assign border_on = (hard) ?
	(((pix_x >= 0) && (pix_x < 10) && (pix_y >= 20)) || ((pix_x >= 630) && (pix_x < 640) && (pix_y >= 20)) || ((pix_y >= 20) && (pix_y < 30)) || ((pix_y >= 470) && (pix_y < 480)) 
	|| (pix_x >= 60 && pix_x < 110 && pix_y >= 50 && pix_y < 80))
	:
	(((pix_x >=0) && (pix_x < 10) && (pix_y >= 20)) || ((pix_x >= 630) & (pix_x < 640) && (pix_y >= 20)) || ((pix_y >= 20) && (pix_y < 30)) || ((pix_y >= 470) && (pix_y < 480)));

	always @(posedge clk_update or negedge rst_n)
	begin
		if (~rst_n)
	 	begin
			apple_x = 100;
	 	 	apple_y = 100;
	 	end
	 	else 
		 begin
			if (apple_eaten)
	 	 	begin
	 	 	 	if (((~hard) && ((rand_x < 10) || (rand_x > 630) || (rand_y < 30) || (rand_y > 470))) 
				|| 
				(hard && ((rand_x < 10) || (rand_x > 630) || (rand_y < 30) || (rand_y > 470) || (rand_x >= 60 && rand_x < 110 && rand_y >=50 && rand_y < 80))))
				begin
					apple_x = 100;
					apple_y = 100;
				end
				else
				begin
					apple_x = rand_x;
					apple_y = rand_y;
				end
	 	 	end
		end
	end

	assign apple_on = ((pix_x >= apple_x) && (pix_x < (apple_x + 10))) && ((pix_y >= apple_y) && (pix_y < (apple_y + 10)));

	always @(posedge clk_update or negedge rst_n)
	begin
		if (~rst_n)
		begin
			for (loop1 = 1; loop1 < 32; loop1 = loop1 + 1)
			begin
				snake_x[loop1] <= 70;
				snake_y[loop1] <= 50;
			end
			if (~hard)
			 begin
				snake_x[0] <= 30;
				snake_y[0] <= 25;
			end
			else 
			 begin
				snake_x[0] <= 2;
				snake_y[0] <= 12;
			end
		end
		else begin
			for (loop2 = 31; loop2 > 0; loop2 = loop2 - 1)
			begin
				if (loop2 < size)
				begin
					snake_x[loop2] <= snake_x[loop2 - 1];
					snake_y[loop2] <= snake_y[loop2 - 1];
				end
			end
			case (direction)
				4'b1000: snake_x[0] <= (snake_x[0] - 1);
				4'b0100: snake_x[0] <= (snake_x[0] + 1);
				4'b0010: snake_y[0] <= (snake_y[0] - 1);
				4'b0001: snake_y[0] <= (snake_y[0] + 1);
			endcase
		end
	end

	always @(posedge clk)
	begin
		snake_body = 1'b0;
		for (loop3 = 1; loop3 < 32; loop3 = loop3 + 1)
		begin
			if (~snake_body && loop3 < size)
			begin
				snake_body = ((pix_x >= snake_x[loop3] * 10) && (pix_x < (snake_x[loop3] * 10 + 10))) && ((pix_y >= snake_y[loop3] * 10) && (pix_y < (snake_y[loop3] * 10 + 10)));
			end
		end
	end
	
	always @(posedge clk)
		snake_head <= ((pix_x >= snake_x[0] * 10) && (pix_x < (snake_x[0] * 10 + 10))) && ((pix_y >= snake_y[0] * 10) && (pix_y < (snake_y[0] * 10 + 10)));
	
	always @(posedge clk)
		snake_on <= (snake_body || snake_head);

	always @(posedge clk_update or negedge rst_n)
	begin
		if (~rst_n) begin
     		apple_eaten <= 1'b0; 
			size <= 1;
		end
		else if ((snake_x[0] * 10 == apple_x) && (snake_y[0] * 10 == apple_y))
    	 begin
			 apple_eaten <= 1'b1;
			 size <= size + 1;
		end
		else apple_eaten <= 1'b0;
	end
	
	always @(posedge clk or negedge reset_high)
	if (~reset_high) high <= 0;
	else if (size - 1 > high) high <= size - 1;	
		
	always @(posedge clk)
	  death <= ((border_on || snake_body) && snake_head);
	
	always @(posedge clk or negedge rst_n)
	 begin
		if (~rst_n) game_over <= 1'b0;
		else if (death) game_over <= 1'b1;
	end
	
	assign score1 = (size-1) / 10;
	assign score0 = (size-1) % 10;
	assign high1 = high / 10;
	assign high0 = high % 10;
	assign g_over = game_over;
	
	always @(*)
	begin
		if (~video_on) rgb = blank_rgb;
		else begin
			if (game_over) rgb = death_rgb;
			else if (border_on) rgb = border_rgb;
			else if (apple_on) rgb = apple_rgb;
			else if (snake_on) rgb = snake_rgb;
			else rgb = blank_rgb;
		end
	end

endmodule
