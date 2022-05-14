//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module bullet (input logic [10:0]  BulletX, BulletY, BulletRadius,
			   input logic [15:0]  BulletColor,
               input logic [9:0]   DrawX, DrawY,
			   output logic VGA_isObject,
               output logic [15:0] VGA_Pixel
              );
			  
	assign VGA_Pixel = BulletColor;
    
    int DistX, DistY, Size;
    assign DistX = DrawX - BulletX;
    assign DistY = DrawY - BulletY;
	assign Size = BulletRadius;
	
	always_comb begin
		if((DistX*DistX + DistY*DistY) <= (Size*Size)) begin
			VGA_isObject = 1'b1;
		end else begin
			VGA_isObject = 1'b0;
		end
	end

endmodule
