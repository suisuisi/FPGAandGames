//-------------------------------------------------------------------------
//      doodle_state.sv                                                  --
//      Created by Lai Xinyi & Yuqi Yu.                                  --
//      Modified by Yuhao Ge & Haina Lou                                 --
//      Fall 2021                                                        --
//                                                                       --
//      Recode the total distance of the doodle, and make it show on the screen.    
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module score ( 	input		Clk,                // 50 MHz clock
							Reset, 
					input logic [2:0] show,             // Active-high reset signal
				
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				input [10:0] score_num, 	// Accept from background
				output logic is_score           // Whether current pixel belongs to ball or background
			  );

	int Score1_X_Pos = 10'd180; //the most significant digit number (leftupmost position)
	int Score1_X_Pos_drop = 10'd360;
	int Score1_Y_Pos = 10'd20;
	int Score1_Y_Pos_drop = 10'd200;
	int Score2_X_Pos = 10'd200; //the least significant digit number (leftupmost position)
	int Score2_X_Pos_drop = 10'd370;
	int Score2_Y_Pos = 10'd20;
	int Score2_Y_Pos_drop = 10'd200;
	int Score1_X_Pos_use;
	int Score2_X_Pos_use;
	int Score1_Y_Pos_use;
	int Score2_Y_Pos_use;

	int Text_Height = 5'd16;   // Height of the single score
	int Text_Width = 4'd8;     // Width of the single score

	logic score_on; 
	//Tell whfther the pixel belongs to score1 or score2 font
//	logic check;
//	always_ff @( posedge Clk)
//	begin 
//		if (Reset)
//			check <= 0;
//		else if (death|drop)
//			check <= 1;
//		else 
//			check <= check;
//	
//	end
	
	
	
	always_comb
	begin 
	if (show==3'd3)
	begin
		Score1_X_Pos_use = Score1_X_Pos_drop;
		Score2_X_Pos_use= Score2_X_Pos_drop;
		Score1_Y_Pos_use= Score1_Y_Pos_drop;
		Score2_Y_Pos_use= Score2_Y_Pos_drop;
	end
	else
	begin
		Score1_X_Pos_use = Score1_X_Pos;
		Score2_X_Pos_use= Score2_X_Pos;
		Score1_Y_Pos_use= Score1_Y_Pos;
		Score2_Y_Pos_use= Score2_Y_Pos;
	end
	
	
	end
	
	
	
	// parameter [7:0] unit_distance = 8'd30; // Score = frame_counter/unit_distance
	// logic [7:0] Score;           //the score (survice distance)


	// assign Score = frame_counter/unit_distance;

	int digit1, digit2;		// decimal, score = digit1*10 + digit2
	always_comb
	begin
	digit1 = score_num/10;
	digit2 = score_num%10;
	end
    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [10:0] sprite_adress;
	logic [7:0] sprite_data;

	always_comb begin

		if ( DrawX >=Score1_X_Pos_use && DrawX < Score1_X_Pos_use + Text_Width &&
				DrawY >=Score1_Y_Pos_use && DrawY < Score1_Y_Pos_use + Text_Height) begin    
			score_on = 1'b1;
			Scaled_X = (DrawX-Score1_X_Pos_use);
			Scaled_Y = (DrawY-Score1_Y_Pos_use);
			sprite_adress = Scaled_Y + Text_Height* digit1;
		end

		 else if ( DrawX >=Score2_X_Pos_use && DrawX < Score2_X_Pos_use + Text_Width &&
		 		DrawY >=Score2_Y_Pos_use && DrawY < Score2_Y_Pos_use + Text_Height) begin
		 	score_on = 1'b1;
		 	Scaled_X = (DrawX-Score2_X_Pos_use);
		 	Scaled_Y = (DrawY-Score2_Y_Pos_use);
		 	sprite_adress = Scaled_Y + Text_Height* digit2;
		 end

		else begin
			score_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 11'b0;
		end

	end

	digit_font my_digits(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (score_on==1'b1 && sprite_data[8-Scaled_X]== 1'b1)
			is_score = 1'b1;
		else
			is_score = 1'b0;
	end 

endmodule