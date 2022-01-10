`timescale 1ns / 1ps

// Project F: move
//根据按键移动与合并16个数字。
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card
module move(i3,i2,i1,i0,o3,o2,o1,o0);
	input [3:0] i3,i2,i1,i0;
	output reg [3:0] o3,o2,o1,o0;
	
	wire f3,f2,f1,f0;
	assign f3 = (i3!=4'h0);
	assign f2 = (i2!=4'h0);
	assign f1 = (i1!=4'h0);
	assign f0 = (i0!=4'h0);
	
	always @(i3 or i2 or i1 or i0 or f3 or f2 or f1 or f0) begin
		case({f3,f2,f1,f0})
			4'b0000 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,4'h0};
			4'b0001 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0};
			4'b0010 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1};
			4'b0011 : if(i1!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i1,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+4'h1};
			4'b0100 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i2};
			4'b0101 : if(i2!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+4'h1};
			4'b0110 : if(i2!=i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1+4'h1};
			4'b0111 : if(i2!=i1 && i1!=i0) {o3,o2,o1,o0} <= {4'h0,i2,i1,i0};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i0+4'h1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i1+4'h1,i0};
			4'b1000 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i3};
			4'b1001 : if(i3!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+4'h1};
			4'b1010 : if(i3!=i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1+4'h1};
			4'b1011 : if(i3!=i1 && i1!=i0) {o3,o2,o1,o0} <= {4'h0,i3,i1,i0};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0+4'h1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i1+4'h1,i0};
			4'b1100 : if(i3!=i2) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i2};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i2+4'h1};
			4'b1101 : if(i3!=i2 && i2!=i0) {o3,o2,o1,o0} <= {4'h0,i3,i2,i0};
			          else if(i2==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0+4'h1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i2+4'h1,i0};
			4'b1110 : if(i3!=i2 && i2!=i1) {o3,o2,o1,o0} <= {4'h0,i3,i2,i1};
			          else if(i2==i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i1+4'h1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i2+4'h1,i1};
			4'b1111 : if(i3!=i2 && i2!=i1 && i1!=i0) {o3,o2,o1,o0} <= {i3,i2,i1,i0};
			          else if(i3==i2 && i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2+4'h1,i0+4'h1};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,i3,i2,i0+4'h1};
			          else if(i2==i1) {o3,o2,o1,o0} <= {4'h0,i3,i1+4'h1,i0};
			          else {o3,o2,o1,o0} <= {4'h0,i2+4'h1,i1,i0};
			default : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,4'h0};
		endcase
	end
endmodule
