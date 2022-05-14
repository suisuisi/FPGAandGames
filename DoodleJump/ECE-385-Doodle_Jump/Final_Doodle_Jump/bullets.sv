//-------------------------------------------------------------------------
//      bullets.sv                                                       --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module is used to shoot bullets                             --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module bullets ( input Clk, Reset,
					input frame_clk, 
					input shoot, hit, 
					input [2:0] direction,
					input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [19:0]  random_num,
					input [9:0]  distance,
					input [9:0]  Ball_X_Pos_out, Ball_Y_Pos_out, Ball_Size_out,
					output logic [9:0] bullet_x, bullet_y,
					output logic [9:0] bullet_size,   
					output logic fly,
					output logic is_bullet
					);	
					
    parameter [9:0] X_Min = 10'd160;       // Leftmost point on the X axis
    parameter [9:0] X_Max = 10'd479;     // Rightmost point on the X axis
	 
	 logic check;
	 assign bullet_size = 10'd2; // Stair size
	 logic[9:0] speedx,speedy;
	 
	 
    logic frame_clk_delayed, frame_clk_rising_edge;
	 logic shoot_delayed,shoot_rising_edge;
	 logic [4:0] slow_frame_clk;
	 
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
		  if (frame_clk_rising_edge)
				begin
					slow_frame_clk <= slow_frame_clk + 1'b1;
				end
		  shoot_delayed <= shoot;
		  shoot_rising_edge <= (shoot == 1'b1) && (shoot_delayed == 1'b0);
    end
	 
	 
	 // The movement of the bullet
    always_ff @ (posedge Clk) 
	 begin
		 if (shoot_rising_edge)
		 begin
			 if (direction == 3'd1)
			 begin
				 speedx <= ~10'd4 + 1'b1;
				 speedy <= ~10'd11 + 1'b1;
			 end
			 else if (direction == 3'd3)
			 begin
				 speedx <= 10'd4;
				 speedy <= ~10'd11 + 1'b1;
			 end
			 else
			 begin
				 speedx <= 1'b0;
				 speedy <= ~10'd11 + 1'b1;
			 end
		 end
	 end
	 
	 
    always_ff @ (posedge Clk) 
	 begin
		if(Reset)
			begin						
				fly <= 1'b0;
			end
		else if (shoot_rising_edge == 1'b1)				// generate a bullet on the doodle's head
			begin
				fly <= 1'b1;
				bullet_x <= Ball_X_Pos_out;		
				bullet_y <= Ball_Y_Pos_out - Ball_Size_out;
			end
		else
			begin
			if (fly)
				begin
					if (frame_clk_rising_edge)
					begin
						bullet_x <= bullet_x + speedx;
						bullet_y <= bullet_y + speedy;
					end
				end
			if (bullet_y > 10'd600)	
				begin
					fly <= 1'b0;
				end	
			if (hit)					// remove the bullet if it hit the monster
				begin
					bullet_y <= 10'd601;
				end
			end
    end
	 
	 
	 
	 // Is stair signal checks if the present pixel belongs to one of the stairs
	 always_comb 
	 begin
		  check = ( DrawX <= bullet_x +bullet_size && DrawX >= bullet_x + ~bullet_size + 10'b1 ) && ( (DrawY <= bullet_y + bullet_size) && (DrawY >= bullet_y + ~bullet_size + 10'b1));
		  if (check && fly)
				is_bullet = 1'b1;
		  else
				is_bullet = 1'b0;
	 end
	 
endmodule