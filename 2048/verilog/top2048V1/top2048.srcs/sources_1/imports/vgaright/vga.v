`timescale 1ns / 1ps

// Project F: Display Controller VGA Demo
//决定输出的颜色。vga模块能够输出屏幕的颜色变量，控制水平和垂直扫描信号来控制屏幕的显示，
//并且其将当前扫描的位置参数通过x，y变量输出到game模块。
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card
module vga(rst,dclk,db,r,g,b,hs,vs,x,y);
	input dclk,rst;
	input [2:0] db;
	output r;
	output g;
	output b;
	output reg hs,vs;
	output reg [9:0] x,y;
	reg [18:0] addr;
	reg [10:0] count_v,count_h;
	reg flag;
	
	assign {r,g,b} = (flag == 1 ? db : 0);
	always@(posedge dclk) begin
		if(rst)
			begin count_h <= 0;count_v <= 0;hs <= 0;vs <= 1;x <= 0;y <= 0;end
		else begin
			if (count_h == 800) count_h <= 0;
			else count_h <= count_h + 1;
			
			if (count_v == 525) count_v <= 0;
			else if (count_h == 800) count_v <= count_v + 1;
			
			if (count_h == 0) hs <= 0;
			if (count_v == 2) vs <= 1;
			if (count_h == 96) hs <= 1;
			if (count_v == 0) vs <= 0;
			
			if (count_v > 2+33 && count_v < 525-10+1) begin
				if ((count_h > 96+48) && (count_h < 800-16+1)) begin
					flag <= 1;
					addr <= addr + 1;
					x <= x + 1;
				end
				else begin
					flag <= 0;
					x <= 0;
					if(flag) y <= y + 1;
				end
			end
			else begin
				addr <= 0;
				y <= 0;
			end
		end
	end
endmodule
