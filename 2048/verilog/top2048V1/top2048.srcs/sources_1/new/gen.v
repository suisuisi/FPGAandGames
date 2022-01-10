`timescale 1ns / 1ps

// Project F: gen clock
//gen模块在move模块产生的空行或空列里产生一个随机数2或4或8和3个空位，该随机数由random模块产生。
//生成4位，8位，16位的随机数。在按下按键对应的位置生成一列或一行随机数与三个空位。
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card
module gen(rst,clk,i3,i2,i1,i0,o3,o2,o1,o0);
    input rst,clk;
    input [3:0] i3,i2,i1,i0;
    output reg [3:0] o3,o2,o1,o0;
  
	wire f3,f2,f1,f0;
	assign f3=(i3!=4'h0);
	assign f2=(i2!=4'h0);
	assign f1=(i1!=4'h0);
	assign f0=(i0!=4'h0);
	
    wire [7:0] ran2;
    wire [11:0] ran3;
    wire [15:0] ran4;
  
	random ran(rst,clk,ran2,ran3,ran4);
  
    always @(i3 or i2 or i1 or i0 or f3 or f2 or f1 or f0) begin
		case({f3,f2,f1,f0})
			4'b0000 : {o3,o2,o1,o0} <= {ran4};
			4'b0001 : {o3,o2,o1,o0} <= {ran3,i0};
			4'b0010 : {o3,o2,o1,o0} <= {ran3[11:8],ran3[7:4],i1,ran3[3:0]};
			4'b0011 : {o3,o2,o1,o0} <= {ran2[7:4],ran2[3:0],i1,i0};
			4'b0100 : {o3,o2,o1,o0} <= {ran3[11:8],i2,ran3[7:4],ran3[3:0]};
			4'b0101 : {o3,o2,o1,o0} <= {ran2[7:4],i2,ran2[3:0],i0};
			4'b0110 : {o3,o2,o1,o0} <= {ran2[7:4],i2,i1,ran2[3:0]};
			4'b0111 : {o3,o2,o1,o0} <= {4'h1,i2,i1,i0};
			4'b1000 : {o3,o2,o1,o0} <= {i3,ran3};
			4'b1001 : {o3,o2,o1,o0} <= {i3,ran2[7:4],ran2[3:0],i0};
			4'b1010 : {o3,o2,o1,o0} <= {i3,ran2[7:4],i1,ran2[3:0]};
			4'b1011 : {o3,o2,o1,o0} <= {i3,4'h1,i1,i0};
			4'b1100 : {o3,o2,o1,o0} <= {i3,i2,ran2[7:4],ran2[3:0]};
			4'b1101 : {o3,o2,o1,o0} <= {i3,i2,4'h1,i0};
			4'b1110 : {o3,o2,o1,o0} <= {i3,i2,i1,4'h1};
			4'b1111 : {o3,o2,o1,o0} <= {i3,i2,i1,i0};
			default : {o3,o2,o1,o0} <= {i3,i2,i1,i0};
		endcase
	end
endmodule
