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
//    Modified by Yuhao Ge & Haina Lou                                   --
//    This is the module to control the motion of the doodle             --
//-------------------------------------------------------------------------

module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [15:0]	  keycode,
					input 		  collision, gain, beat_mons,
					input [31:0]  tot_distance,
               input  logic[1:0] doodle_state,
					output logic  drop,					 // means falling
               output logic  is_ball,             // Whether current pixel belongs to ball or background
               output logic is_doodle,
					output logic [9:0]  Ball_X_Pos_out, Ball_Y_Pos_out, Ball_Size_out, Ball_Y_Step_out,
					output logic [9:0] distance
              );
    
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min = 10'd160;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd479;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] doodle_size = 10'd35;
    parameter [9:0] updoodle_size = 10'd49;
	 
	 
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    logic [9:0] Ball_X_Step;      // Step size on the X axis
    logic [9:0] Ball_Y_Step;      // Step size on the Y axis	
//	 int  temp_Y_Step;
	 logic [9:0] counter;
	 logic [20:0] temp_dis;
	 
	 //output 
	 assign Ball_X_Pos_out = Ball_X_Pos;
	 assign Ball_Y_Pos_out = Ball_Y_Pos;
	 assign Ball_Size_out = doodle_size/2;
	 assign Ball_Y_Step_out = Ball_Y_Step;
	 
	 
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Step <= 10'd0;
				Ball_Y_Step <= 10'd0;
            Ball_X_Motion <= Ball_X_Step;
            Ball_Y_Motion <= Ball_Y_Step;
				temp_dis <= 0;
				drop <= 0;
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				if (frame_clk_rising_edge)
				begin
					if (gain)
						 Ball_Y_Step <= ~10'd15+1;
					else if ((Ball_Y_Pos + Ball_Size_out >= Ball_Y_Max) && (tot_distance > 15'd10))
						begin
							drop <= 1;
							Ball_Y_Step <= 0;
						end
					else if( Ball_Y_Pos + Ball_Size_out >= Ball_Y_Max )   // Doodle is at the bottom edge, BOUNCE!
						 Ball_Y_Step <= ~10'd8+1;
					else if( Ball_X_Pos >= Ball_X_Max)  			// Doodle is at the right edge, CROSS!
						begin 
							Ball_X_Pos <= Ball_X_Pos_in + ~Ball_X_Max + 1'b1 + Ball_X_Min;
						end
					else if ( Ball_X_Pos <= Ball_X_Min)  			// Doodle is at the left edge, CROSS!
						begin
							Ball_X_Pos <= Ball_X_Pos_in + ~Ball_X_Min + 1'b1 + Ball_X_Max;
						end
					else if (collision | beat_mons)
						begin
							Ball_Y_Step <= ~10'd9+1;
						end
					else
						begin
							if ( ((keycode & 16'hff) == 8'h04) || ((keycode & 16'hff00 >> 8)== 8'h04) )
								Ball_X_Step <= ~10'd2+1;
							else if ( ((keycode & 16'hff) == 8'h07) || ((keycode & 16'hff00 >> 8)== 8'h07) )
								Ball_X_Step <= 10'd2;
						   else
								Ball_X_Step <= 10'b0;
						end
						
						counter <= counter + 1'b1;
						if (counter>3)
						begin
							Ball_Y_Step <= Ball_Y_Step + 1'b1;
							counter <= 1'b0;
						end
				end
				
        end
    end
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
        distance = 1'b0;
		  
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
				Ball_X_Motion_in = Ball_X_Step;
				Ball_Y_Motion_in = Ball_Y_Step;
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
				
				// if it reaches the upper half of the screan, and keeps go up, make the doodle still and move the stairs
				if ( Ball_Y_Pos <= 10'd239 && Ball_Y_Motion > 10'd30)    
					begin
						Ball_Y_Pos_in = Ball_Y_Pos;
						distance = Ball_Y_Motion;
					end
				else if (drop)
					begin
						Ball_Y_Pos_in = Ball_Y_Pos;
						distance = 10'd9;
					end
				else
					begin
						Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
						distance = 1'b0;
					end
        end
   
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX1, DistY1, DistX2, DistY2, Size;
    assign DistX1 = DrawX - Ball_X_Pos;
    assign DistY1 = DrawY - Ball_Y_Pos;
    assign DistX2 = DrawX - Ball_X_Pos + Ball_X_Max;
    assign DistY2 = DrawY - Ball_Y_Pos;
    always_comb 
	 begin
        if (((DistX1*DistX1 + DistY1*DistY1) <= (Size*Size)) || ((DistX2*DistX2 + DistY2*DistY2) <= (Size*Size)))
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 
    int hfsize;
	 int uphfsize;
    int Distdx, Distdy;
    assign Distdx = DrawX - Ball_X_Pos;
    assign Distdy = DrawY - Ball_Y_Pos;
    // assign DistX2 = DrawX - Ball_X_Pos + Ball_X_Max;
    // assign DistY2 = DrawY - Ball_Y_Pos;
    assign hfsize = (doodle_size-1)/2;
    assign uphfsize = (updoodle_size-1)/2;
    always_comb 
	 begin
		case(doodle_state)
			2'b00:
				 if ((Distdx >= -hfsize && Distdx <= hfsize) && (Distdy >= -hfsize && Distdy <= hfsize))
				 is_doodle = 1'b1;
				 else
				 is_doodle = 1'b0;
			2'b01:
				 if ((Distdx >= -hfsize && Distdx <= hfsize) && (Distdy >= -hfsize && Distdy <= hfsize))
				 is_doodle = 1'b1;
				 else
				 is_doodle = 1'b0;
			2'b10:
				 if ((Distdx >= -uphfsize && Distdx <= uphfsize) && (Distdy >= -uphfsize && Distdy <= uphfsize))
					  is_doodle = 1'b1;
				 else
					  is_doodle = 1'b0;
			2'b11:
				 if ((Distdx >= -uphfsize && Distdx <= uphfsize) && (Distdy >= -uphfsize && Distdy <= uphfsize))
					  is_doodle = 1'b1;
				 else
					  is_doodle = 1'b0;
			default: is_doodle = 1'b0;
		endcase
     end 
	 
    
endmodule
