


//-------------------------------------------------------------------------
//    Star.sv Spring 2020											 --
//    Adapted from Ball.sv, lab8                                         --
//    Real time score keeper on VGA display					             --
//    Indicate how many coins are collected when the player wins.        --
//-------------------------------------------------------------------------

module star ( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				input [2:0] CoinStatus, 	   // Accept from gamelogic
				output logic is_star           // Whether current pixel belongs to star 
 
			  );

	parameter [9:0] Star1_X_Pos = 10'd80; //the rightmost star position
	parameter [9:0] Star1_Y_Pos = 10'd140;  //the leftmost star position

	parameter [9:0] Star2_X_Pos = 10'd250; //the middle star position
	parameter [9:0] Star2_Y_Pos = 10'd90; //the middle star position

	parameter [9:0] Star3_X_Pos = 10'd420;  //the leftmost star position
	parameter [9:0] Star3_Y_Pos = 10'd140;  //the leftmost star position


	parameter [9:0] Star_Height = 10'd130;   // Height of the single score
	parameter [9:0] Star_Width = 10'd130;     // Width of the single score

	logic star_on;         //Tell whether the pixel belongs to star1 or star2 or star3
	
	
	logic [2:0] Collected_Number;           //the number of collected coin

    always_comb begin
		Collected_Number = 3'd0;
		for  (int i=0; i<3; i++) begin
        if ( CoinStatus[i] == 1'b0)
            Collected_Number = Collected_Number + 3'd1;
        else
            Collected_Number = Collected_Number;
		end
    end
	

    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [9:0] sprite_adress;
	logic [0:129] sprite_data;

	always_comb begin

		if ( DrawX >=Star1_X_Pos && DrawX < Star1_X_Pos + Star_Width &&
				DrawY >=Star1_Y_Pos && DrawY < Star1_Y_Pos + Star_Height) begin    
			star_on = 1'b1;
			Scaled_X = (DrawX-Star1_X_Pos);
			Scaled_Y = (DrawY-Star1_Y_Pos);
            if (Collected_Number!=3'd0)
			    sprite_adress = Scaled_Y + Star_Height* 8'h1;
            else
                sprite_adress = Scaled_Y + Star_Height* 8'h0;
		end

		else if ( DrawX >=Star2_X_Pos && DrawX < Star2_X_Pos + Star_Width &&
				DrawY >=Star2_Y_Pos && DrawY < Star2_Y_Pos + Star_Height) begin    
            star_on = 1'b1;
			Scaled_X = (DrawX-Star2_X_Pos);
			Scaled_Y = (DrawY-Star2_Y_Pos);
            if (Collected_Number==3'd2 || Collected_Number==3'd3)
			    sprite_adress = Scaled_Y + Star_Height* 8'h1;
            else
                sprite_adress = Scaled_Y + Star_Height* 8'h0;
		end
		else if ( DrawX >=Star3_X_Pos && DrawX < Star3_X_Pos + Star_Width &&
				DrawY >=Star3_Y_Pos && DrawY < Star3_Y_Pos + Star_Height) begin    
            star_on = 1'b1;
			Scaled_X = (DrawX-Star3_X_Pos);
			Scaled_Y = (DrawY-Star3_Y_Pos);
            if (Collected_Number==3'd3)
			    sprite_adress = Scaled_Y + Star_Height* 8'h1;
            else
                sprite_adress = Scaled_Y + Star_Height* 8'h0;
		end
		else begin
			star_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'h0;
		end
		

	end

	star_rom my_star(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (star_on==1'b1 && sprite_data[Scaled_X]== 1'b1) begin
			is_star = 1'b1;
        end
        else begin
            is_star = 1'b0;
        end
    end

endmodule



module human ( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				output logic is_human          // Whether current pixel belongs to human
 
			  );

	parameter [9:0] human_X_Pos = 10'd60; //the rightmost star position
	parameter [9:0] human_Y_Pos = 10'd320;  //the leftmost star position


	parameter [9:0] human_Height = 10'd101;   // Height of the single score
	parameter [9:0] human_Width = 10'd81;     // Width of the single score

	logic human_on;         //Tell whether the pixel belongs to star1 or star2 or star3

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [9:0] sprite_adress;
	logic [0:80] sprite_data;

	always_comb begin

		if ( DrawX >=human_X_Pos && DrawX < human_X_Pos + human_Width &&
				DrawY >=human_Y_Pos && DrawY < human_Y_Pos + human_Height) begin    
			human_on = 1'b1;
			Scaled_X = (DrawX-human_X_Pos);
			Scaled_Y = (DrawY-human_Y_Pos);
		    sprite_adress = Scaled_Y + human_Height* 8'h0;
		end

		else begin
			human_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'h0;
		end
		

	end

	human_rom my_human_rom(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (human_on==1'b1 && sprite_data[Scaled_X]== 1'b1) begin
			is_human = 1'b1;
        end
        else begin
            is_human = 1'b0;
        end
    end

endmodule



