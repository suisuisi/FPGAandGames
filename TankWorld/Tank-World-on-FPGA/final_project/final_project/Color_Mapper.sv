//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input                                  // Whether current pixel belongs to ball 
																				  //   or background (computed in ball.sv)
														is_one_tank,        // Single_Player_Marker             
														are_two_tanks,      // Multiplayer Marker
														is_tank,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input 			[11:0] code,               // Current color code at DrawX, DrawY			
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  input        [1:0] mode
                     );
    
	 
    logic [7:0] Red, Green, Blue;
	 logic [7:0] tRed, tGreen, tBlue;
	 logic [11:0] tcode;
    palette p(.RGB_12(code), .R(Red), .G(Green), .B(Blue), .DrawX);
	 palette tp(.RGB_12(tcode), .R(tRed), .G(tGreen), .B(tBlue), .DrawX);
    // Output colors to VGA
	 always_comb 
	 begin
		if (mode == 2'b10 && is_tank == 1'b0)
			begin
				tcode = 12'h000;
				VGA_R = tRed;
				VGA_G = tGreen;
				VGA_B = tBlue;
			end
//		else if (mode == 2'b10 && is_tank == 1'b1)
//			begin 
//				tcode = 12'hf00;
//				VGA_R = Red; 
//				VGA_G = Green;
//				VGA_B = Blue;
//			end
		else
			begin 
				tcode = 12'h000;
				VGA_R = Red;
				VGA_G = Green;
				VGA_B = Blue;
			end
	end

    
endmodule
