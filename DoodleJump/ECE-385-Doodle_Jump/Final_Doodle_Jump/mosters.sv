//-------------------------------------------------------------------------
//      monsters.sv                                                      --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module is used to generate monsters                         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module monsters ( input Clk, Reset,
					input frame_clk, 
					input gene, hit, beat_mons,
					input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [19:0]  random_num,
					input [9:0]  distance,
					output logic [9:0] monster_x, monster_y,
					output logic [9:0] monster_size_x,monster_size_y,   
					output logic active,
					output logic  is_monster
					);	
					
    parameter [9:0] X_Min = 10'd160;       // Leftmost point on the X axis
    parameter [9:0] X_Max = 10'd479;     // Rightmost point on the X axis
	 
	 logic check;
	 assign monster_size_x = 10'd20; // monster size x
	 assign monster_size_y = 10'd11; 
	 logic[9:0] speedx,speedy;
	 
	 
    logic frame_clk_delayed, frame_clk_rising_edge;
	 logic gene_delayed,gene_rising_edge;
	 logic [4:0] slow_frame_clk;
	 logic [2:0] counter;
	 
	 assign counter = slow_frame_clk[4:2];
	 
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
		  if (frame_clk_rising_edge)
				begin
					slow_frame_clk <= slow_frame_clk + 1'b1;
				end
		  gene_delayed <= gene;
		  gene_rising_edge <= (gene == 1'b1) && (gene_delayed == 1'b0);
    end
	 
	 
	 // The movement of the monster
    always_ff @ (posedge Clk) 
	 begin
		 if (Reset)
			 speedx <= -1;
		 else if (monster_x + monster_size_x >= X_Max)
			 begin
				 speedx <= -1;
			 end
		 else if(monster_x - monster_size_x <= X_Min)
			 begin
				 speedx <= 1;
			 end
		 else
			 speedx <= speedx;
	 end
	 

    always_comb  begin
        unique case (counter)
            3'd0 : speedy = 10'd2;
            3'd1 : speedy = 10'd1;
            3'd2 : speedy = 10'd0;
	         3'd3 : speedy = ~10'd1+1'b1;
	         3'd4 : speedy = ~10'd2+1'b1;
            3'd5 : speedy = ~10'd1+1'b1;
            3'd6 : speedy = 10'd0;
            3'd7 : speedy = 10'd1;
        endcase
    end
	 
	 
    always_ff @ (posedge Clk) 
	 begin
		if(Reset)
			begin						
				active <= 1'b0;
			end
		else if (gene_rising_edge == 1'b1)
			begin
				active <= 1'b1;
				monster_x <= 10'd200;		
				monster_y <= 10'b0;
			end
		else
			begin
			if (active)
				begin
					if (frame_clk_rising_edge)
					begin
						monster_x <= monster_x + speedx;
						monster_y <= monster_y + speedy - distance;
					end
				end
			if (monster_y > 10'd479 && monster_y < 10'd600)	  // remove the monster when it goes out of the screen
				begin
					active <= 1'b0;
				end	
			if (hit | beat_mons)								// remove the monster when it is hit by a bullet
				begin
					active <= 1'b0;										
				end
			end
    end
	 
	 
	 
	 

	 // Is stair signal checks if the present pixel belongs to one of the stairs
	 always_comb 
	 begin
		  check = ( DrawX <= monster_x +monster_size_x && DrawX >= monster_x + ~monster_size_x + 10'b1 ) && ( (DrawY <= monster_y + monster_size_y) && (DrawY >= monster_y + ~monster_size_y + 10'b1));
		  if (check && active)
				is_monster = 1'b1;
		  else
				is_monster = 1'b0;
	 end
	 
endmodule