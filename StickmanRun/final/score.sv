//-------------------------------------------------------------------------
//    stickman.sv Spring 2020											 --
//    Adapted from Ball.sv, lab8                                         --
//    Real time score keeper on VGA display					             --
//    Tell the ColorMapper whether this pixel is a part of the stickman  --
//-------------------------------------------------------------------------

module score ( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				input [11:0] frame_counter, 	// Accept from background
				output logic is_score           // Whether current pixel belongs to ball or background
			  );

	parameter [9:0] Score1_X_Pos = 10'd570; //the most significant digit number (leftupmost position)
	parameter [9:0] Score1_Y_Pos = 10'd10;
	parameter [9:0] Score2_X_Pos = 10'd600; //the least significant digit number (leftupmost position)
	parameter [9:0] Score2_Y_Pos = 10'd10;

	parameter [4:0] Text_Height = 5'd16;   // Height of the single score
	parameter [3:0] Text_Width = 4'd8;     // Width of the single score

	logic score_on;         //Tell whether the pixel belongs to score1 or score2 font
	
	parameter [7:0] unit_distance = 8'd30; // Score = frame_counter/unit_distance
	logic [7:0] Score;           //the score (survice distance)


	assign Score = frame_counter/unit_distance;

	int digit1, digit2;		// decimal, score = digit1*10 + digit2
	assign  digit1 = Score/10;
	assign  digit2 = Score%10;

    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [7:0] sprite_adress;
	logic [0:7] sprite_data;

	always_comb begin

		if ( DrawX >=Score1_X_Pos && DrawX < Score1_X_Pos + Text_Width*3 &&
				DrawY >=Score1_Y_Pos && DrawY < Score1_Y_Pos + Text_Height*3) begin    
			score_on = 1'b1;
			Scaled_X = (DrawX-Score1_X_Pos)/3;
			Scaled_Y = (DrawY-Score1_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* digit1;
		end

		else if ( DrawX >=Score2_X_Pos && DrawX < Score2_X_Pos + Text_Width*3 &&
				DrawY >=Score2_Y_Pos && DrawY < Score2_Y_Pos + Text_Height*3) begin
			score_on = 1'b1;
			Scaled_X = (DrawX-Score2_X_Pos)/3;
			Scaled_Y = (DrawY-Score2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* digit2;
		end

		else begin
			score_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'b0;
		end

	end

	digits_rom my_digits(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (score_on==1'b1 && sprite_data[Scaled_X]== 1'b1)
			is_score = 1'b1;
		else
			is_score = 1'b0;
	end 

endmodule