//-------------------------------------------------------------------------
//      collision.sv                                                     --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module is used to detect if a doodle touch a stair          --
//		  if doodle hit by monster 													 --
//      if monster shot by bullets 													 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module collision ( input     Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
						input [9:0]   Ball_X_Pos, Ball_Y_Pos, Ball_Size, Ball_Y_Step,       // Current ball's coordinates
						input [13:0][9:0]	  stair_x, stair_y, 
						input [9:0]  stair_size,
						output logic  collision            
					  );	
	 logic[13:0] check;
	 
	 always_comb 
	 begin
		 for(int j=0; j<14; j++)
			begin
				check[j] = (Ball_Y_Step < 10'd100) && 
							  (Ball_X_Pos + Ball_Size >= stair_x[j] + ~stair_size + 10'b1) && 
							  (Ball_X_Pos - Ball_Size <= stair_x[j] + stair_size) && 
							  (Ball_Y_Pos + Ball_Size + Ball_Y_Step >= stair_y[j] - 10'd8) && 
							  (Ball_Y_Pos + Ball_Size + Ball_Y_Step<= stair_y[j] + 10'd8) ;
			end
	 end	
	 
	always_ff @ (posedge Clk)
	begin
		if (Reset == 1'b1)
			collision <= 1'b0;
		else// if ((frame_clk_rising_edge == 1'b1))
			begin
				if (check[0] || check[1] || check[2] || check[3] || check[4] || check[5] || check[6] || check[7] || check[8] || check[9] || check[10] || check[11] || check[12] || check[13] )
					begin
						collision <= 1'b1;
					end
				else
					collision <= 1'b0;
			end
	end		
endmodule


// This module is used to detect if the doodler step on the monter or touch by monster
module doo_mons ( input     Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
						input [9:0]   Ball_X_Pos_out, Ball_Y_Pos_out, Ball_Size_out,Ball_Y_Step, 
						input [9:0]	  monster_x, monster_y, monster_size_x, monster_size_y,
						input		active,
						output logic  death,
						output logic  beat_mons       
					  );	
	 logic check;
	 logic beat;
	 
	 logic frame_clk_delayed, frame_clk_rising_edge;
	 always_ff @ (posedge Clk) begin
		  frame_clk_delayed <= frame_clk;
		  frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
	 end

	 always_comb 
	 begin
		 check = ( (Ball_X_Pos_out + Ball_Size_out > monster_x - monster_size_x) && (Ball_X_Pos_out - Ball_Size_out < monster_x + monster_size_x) && 
					  (Ball_Y_Pos_out + Ball_Size_out > monster_y - monster_size_y) && (Ball_Y_Pos_out - Ball_Size_out < monster_y + monster_size_y) && active);
		 beat = (check && (Ball_Y_Step < 10'd100));
	 end	
	 
	always_ff @ (posedge frame_clk_rising_edge)
	begin
		if (Reset == 1'b1)
			begin
				death <= 1'b0;
				beat_mons <= 1'b0;
			end
		else
			begin
				if (check && (~beat))
					death <= 1'b1;
				else if (beat)
					beat_mons <= 1'b1;
				else
					begin
					death <= 1'b0;
					beat_mons <= 1'b0;
					end
			end
	end		
endmodule


module bull_mons ( input     Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
						input [9:0]   bullet_x, bullet_y, bullet_size,
						input [9:0]	  monster_x, monster_y, monster_size_x, monster_size_y,
						input		  active, fly,
						output logic  hit            
					  );	
	 logic check;

	 always_comb 
	 begin
		 check = ( (bullet_x + bullet_size > monster_x - monster_size_x) && (bullet_x - bullet_size < monster_x + monster_size_x) && 
					  (bullet_y + bullet_size > monster_y - monster_size_y) && (bullet_y - bullet_size < monster_y + monster_size_y) && active && fly);
	 end	
	 
	always_ff @ (posedge Clk)
	begin
		if (Reset == 1'b1)
			hit <= 1'b0;
		else
			begin
				if (check)
					begin
						hit <= 1'b1;
					end
				else
					hit <= 1'b0;
			end
	end		
endmodule