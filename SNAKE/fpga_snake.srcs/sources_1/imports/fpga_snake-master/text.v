`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    text 
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
module text(
	input clk,
	input video_on,
	input [3:0] score1,
	input [3:0] score0,
	input [3:0] high1,
	input [3:0] high0,
	input g_over,
	input [9:0] pix_x, pix_y,
	output wire text_on,
	output reg [7:0] text_rgb
    );
	 
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_s, char_addr_o;
   reg [3:0] row_addr; 
   wire [3:0] row_addr_s, row_addr_o;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_s, bit_addr_o;
   wire [7:0] font_word;
   wire font_bit, score_on, over_on;
   wire [7:0] rule_rom_addr;
	
   font_romv1 font_unit
      (.clka(clk), .addra(rom_addr), .douta(font_word));
		
	assign score_on = (pix_y[9:4]==0) && (pix_x[9:3]<16);
   assign row_addr_s = pix_y[3:0];
   assign bit_addr_s = pix_x[2:0];
   always @(*)
      case (pix_x[6:3])
         4'h0: char_addr_s = 7'h53; // S
         4'h1: char_addr_s = 7'h63; // c
         4'h2: char_addr_s = 7'h6f; // o
         4'h3: char_addr_s = 7'h72; // r
         4'h4: char_addr_s = 7'h65; // e
         4'h5: char_addr_s = 7'h3a; // :
         4'h6: char_addr_s = {3'b011, score1}; // digit 10
         4'h7: char_addr_s = {3'b011, score0}; // digit 1
			4'h8: char_addr_s = 7'h00;
			4'h9: char_addr_s = 7'h48; // H
			4'hA: char_addr_s = 7'h69; // i
			4'hB: char_addr_s = 7'h67; // g
			4'hC: char_addr_s = 7'h68; // h
         4'hD: char_addr_s = 7'h3a; // :
			4'hE: char_addr_s = {3'b011, high1}; // digit 10 
			4'hF: char_addr_s = {3'b011, high0}; // digit 1
			default: char_addr_s = 7'h00; 
      endcase
	
	
	assign over_on = (pix_y[9:6]==3) &&
                    (5 <= pix_x[9:5]) && (pix_x[9:5] <= 13) && g_over;
   assign row_addr_o = pix_y[5:2];
   assign bit_addr_o = pix_x[4:2];
   always @*
      case(pix_x[8:5])
         4'h5: char_addr_o = 7'h4f; // O     //7'h47; // G
         4'h6: char_addr_o = 7'h70; // p     //7'h61; // a
         4'h7: char_addr_o = 7'h65; // e     //7'h6d; // m
         4'h8: char_addr_o = 7'h6e; // n     //7'h65; // e
         4'h9: char_addr_o = 7'h00; //       //7'h00; //
         4'ha: char_addr_o = 7'h46; // F     //7'h4f; // O
         4'hb: char_addr_o = 7'h50; // P     //7'h76; // v
         4'hc: char_addr_o = 7'h47; // G     //7'h65; // e
         default: char_addr_o = 7'h41; // A  //7'h72; // r
      endcase
		
		
	always @(*)
	begin
	   text_rgb = 8'b00000000;
	   if (over_on)
       begin
         char_addr = char_addr_o;
         row_addr = row_addr_o;
         bit_addr = bit_addr_o;
         if (font_bit) text_rgb = 8'b11111111;
			else text_rgb = 8'b11100000;
        end
		else if (~g_over && score_on)
       begin
         char_addr = char_addr_s;
         row_addr = row_addr_s;
         bit_addr = bit_addr_s;
         if (font_bit) text_rgb = 8'b11111111;
      end
   end
  
   assign text_on = (g_over) ? over_on : score_on;
	
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule
