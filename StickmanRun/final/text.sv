//-------------------------------------------------------------------------
//    stickman.sv Spring 2020											 --
//    Adapted from Ball.sv, lab8                                         --
//    Real time score keeper on VGA display					             --
//    Tell the ColorMapper whether this pixel is a part of the stickman  --
//-------------------------------------------------------------------------

module lose_text ( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				output logic is_lose_text           // Whether current pixel belongs to ball or background
			  );

    parameter [9:0] lose_Y_Pos = 10'd120;
	parameter [9:0] lose1_X_Pos = 10'd50; //"G"
	parameter [9:0] lose2_X_Pos = 10'd112; //"A"
    parameter [9:0] lose3_X_Pos = 10'd174; //"M"
	parameter [9:0] lose4_X_Pos = 10'd236; //"E"
    parameter [9:0] lose5_X_Pos = 10'd348; //"O"
	parameter [9:0] lose6_X_Pos = 10'd410; //"V"
    parameter [9:0] lose7_X_Pos = 10'd472; //"E"
	parameter [9:0] lose8_X_Pos = 10'd534; //"R"



	parameter [4:0] Text_Height = 5'd16;   // Height of the single score
	parameter [3:0] Text_Width = 4'd8;     // Width of the single score

	logic text_on;         //Tell whether the pixel belongs to score1 or score2 font


    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [9:0] sprite_adress;
	logic [0:7] sprite_data;

	always_comb begin
        //G
		if ( DrawX >=lose1_X_Pos && DrawX < lose1_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose1_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h7;
		end
        //A
		else if ( DrawX >=lose2_X_Pos && DrawX < lose2_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose2_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h1;
		end
        //M
        else if ( DrawX >=lose3_X_Pos && DrawX < lose3_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose3_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'hd;
		end
        //E
		else if ( DrawX >=lose4_X_Pos && DrawX < lose4_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose4_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h5;
		end
        //O
        else if ( DrawX >=lose5_X_Pos && DrawX < lose5_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose5_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'hf;
		end
        //V
        else if ( DrawX >=lose6_X_Pos && DrawX < lose6_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose6_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h16;
		end
        //E
		else if ( DrawX >=lose7_X_Pos && DrawX < lose7_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose7_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h5;
		end
        //R
		else if ( DrawX >=lose8_X_Pos && DrawX < lose8_X_Pos + Text_Width*7 &&
				DrawY >=lose_Y_Pos && DrawY < lose_Y_Pos + Text_Height*7) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-lose8_X_Pos)/7;
			Scaled_Y = (DrawY-lose_Y_Pos)/7;
			sprite_adress = Scaled_Y + Text_Height* 8'h12;
		end
        

			else begin
			text_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'b0;
		end

	end

	alphabet_rom game_lose(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (text_on==1'b1 && sprite_data[Scaled_X]== 1'b1)
			is_lose_text = 1'b1;
		else
			is_lose_text = 1'b0;
	end 

endmodule

module  win_text( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				output logic is_win_text           // Whether current pixel belongs to ball or background
			  );

    parameter [9:0] win_Y_Pos = 10'd40;
	parameter [9:0] win1_X_Pos = 10'd460; //"W"
	parameter [9:0] win2_X_Pos = 10'd505; //"I"
    parameter [9:0] win3_X_Pos = 10'd550; //"N"
	



	parameter [4:0] Text_Height = 5'd16;   // Height of the single score
	parameter [3:0] Text_Width = 4'd8;     // Width of the single score

	logic text_on;         //Tell whether the pixel belongs to score1 or score2 font


    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [9:0] sprite_adress;
	logic [0:7] sprite_data;

	always_comb begin
        //W
		if ( DrawX >=win1_X_Pos && DrawX < win1_X_Pos + Text_Width*5 &&
				DrawY >=win_Y_Pos && DrawY < win_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-win1_X_Pos)/5;
			Scaled_Y = (DrawY-win_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h17;
		end
        //I
        else if ( DrawX >=win2_X_Pos && DrawX < win2_X_Pos + Text_Width*5 &&
				DrawY >=win_Y_Pos && DrawY < win_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-win2_X_Pos)/5;
			Scaled_Y = (DrawY-win_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h9;
		end
        //N
        else if ( DrawX >=win3_X_Pos && DrawX < win3_X_Pos + Text_Width*5 &&
				DrawY >=win_Y_Pos && DrawY < win_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-win3_X_Pos)/5;
			Scaled_Y = (DrawY-win_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'he;
		end

        

		else begin
			text_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'b0;
		end

	end

	alphabet_rom game_win(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (text_on==1'b1 && sprite_data[Scaled_X]== 1'b1)
			is_win_text = 1'b1;
		else
			is_win_text = 1'b0;
	end 

endmodule



module  select_text( 	input		Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
				
				input [9:0] DrawX, DrawY,       // Current pixel coordinates
				output logic is_select_text           // Whether current pixel belongs to ball or background
			  );

    parameter [9:0] Line1_Y_Pos = 10'd30;
	parameter [9:0] Line2_Y_Pos = 10'd140;
	parameter [9:0] Line3_Y_Pos = 10'd210;

//line one "SELECT LEVEL"
	parameter [9:0] s11_X_Pos = 10'd60; //"S"
	parameter [9:0] s12_X_Pos = 10'd105; //"E"
    parameter [9:0] s13_X_Pos = 10'd150; //"L"
	parameter [9:0] s14_X_Pos = 10'd195; //"E"
	parameter [9:0] s15_X_Pos = 10'd240; //"C"
    parameter [9:0] s16_X_Pos = 10'd285; //"T"
	parameter [9:0] s17_X_Pos = 10'd385; //"L"
	parameter [9:0] s18_X_Pos = 10'd430; //"E"
    parameter [9:0] s19_X_Pos = 10'd475; //"V"
	parameter [9:0] s110_X_Pos = 10'd520; //"E"
	parameter [9:0] s111_X_Pos = 10'd565; //"L"
//line two "Press A -> Level 1" or "Press D -> Level 2"
    parameter [9:0] s21_X_Pos = 10'd30; //"P"
	parameter [9:0] s22_X_Pos = 10'd57; //"r"
    parameter [9:0] s23_X_Pos = 10'd84; //"e"
	parameter [9:0] s24_X_Pos = 10'd111; //"s"
	parameter [9:0] s25_X_Pos = 10'd138; //"s"
    parameter [9:0] s26_X_Pos = 10'd192; //"A" or "D"
	parameter [9:0] s27_X_Pos = 10'd246; //"->"
	parameter [9:0] s28_X_Pos = 10'd300; //"L"
    parameter [9:0] s29_X_Pos = 10'd327; //"e"
	parameter [9:0] s210_X_Pos = 10'd354; //"v"
	parameter [9:0] s211_X_Pos = 10'd381; //"e"
	parameter [9:0] s212_X_Pos = 10'd408; //"l"
	parameter [9:0] s213_X_Pos = 10'd435; //"1" or "2"



	parameter [4:0] Text_Height = 5'd16;   // Height of the single score
	parameter [3:0] Text_Width = 4'd8;     // Width of the single score

	logic text_on;         //Tell whether the pixel belongs to score1 or score2 font


    //Compute whether the pixel belongs to the score font.
    /* Since the dividers are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are divided. */

	int Scaled_X, Scaled_Y; //the scaled difference betweent th epixel and the origin of score
	
	logic [9:0] sprite_adress;
	logic [0:7] sprite_data;

	always_comb begin
        //S
		if ( DrawX >=s11_X_Pos && DrawX < s11_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s11_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h13;
		end
        //E
        else if ( DrawX >=s12_X_Pos && DrawX < s12_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s12_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h05;
		end
        //L
        else if ( DrawX >=s13_X_Pos && DrawX < s13_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s13_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h0c;
		end
		//E
        else if ( DrawX >=s14_X_Pos && DrawX < s14_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s14_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h05;
		end
        //C
        else if ( DrawX >=s15_X_Pos && DrawX < s15_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s15_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h03;
		end
		//T
        else if ( DrawX >=s16_X_Pos && DrawX < s16_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s16_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h14;
		end
        //L
        else if ( DrawX >=s17_X_Pos && DrawX < s17_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s17_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h0c;
		end
		//E
        else if ( DrawX >=s18_X_Pos && DrawX < s18_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s18_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h05;
		end
        //V
        else if ( DrawX >=s19_X_Pos && DrawX < s19_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s19_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h16;
		end
		//E
        else if ( DrawX >=s110_X_Pos && DrawX < s110_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s110_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h05;
		end
		//L
        else if ( DrawX >=s111_X_Pos && DrawX < s111_X_Pos + Text_Width*5 &&
				DrawY >=Line1_Y_Pos && DrawY < Line1_Y_Pos + Text_Height*5) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s111_X_Pos)/5;
			Scaled_Y = (DrawY-Line1_Y_Pos)/5;
			sprite_adress = Scaled_Y + Text_Height* 8'h0c;
		end
		//Line1 end Line 2 begin
		//P
		else if ( DrawX >=s21_X_Pos && DrawX < s21_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s21_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h10;
		end
		//r
		else if ( DrawX >=s22_X_Pos && DrawX < s22_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s22_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h21;
		end
		//e
		else if ( DrawX >=s23_X_Pos && DrawX < s23_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s23_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//s
		else if ( DrawX >=s24_X_Pos && DrawX < s24_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s24_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h22;
		end
		//s
		else if ( DrawX >=s25_X_Pos && DrawX < s25_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s25_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h22;
		end
		// A
		else if ( DrawX >=s26_X_Pos && DrawX < s26_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s26_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h01;
		end
		//->
		else if ( DrawX >=s27_X_Pos && DrawX < s27_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s27_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1b;
		end
		//L
		else if ( DrawX >=s28_X_Pos && DrawX < s28_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s28_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h0c;
		end
		//e
		else if ( DrawX >=s29_X_Pos && DrawX < s29_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s29_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//v
		else if ( DrawX >=s210_X_Pos && DrawX < s210_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s210_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h23;
		end
		//e
		else if ( DrawX >=s211_X_Pos && DrawX < s211_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s211_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//l
		else if ( DrawX >=s212_X_Pos && DrawX < s212_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s212_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1f;
		end
		//"1"
		else if ( DrawX >=s213_X_Pos && DrawX < s213_X_Pos + Text_Width*3 &&
				DrawY >=Line2_Y_Pos && DrawY < Line2_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s213_X_Pos)/3;
			Scaled_Y = (DrawY-Line2_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1c;
		end
		//Line2 end Line 3 begin
		//P
		else if ( DrawX >=s21_X_Pos && DrawX < s21_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s21_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h10;
		end
		//r
		else if ( DrawX >=s22_X_Pos && DrawX < s22_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s22_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h21;
		end
		//e
		else if ( DrawX >=s23_X_Pos && DrawX < s23_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s23_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//s
		else if ( DrawX >=s24_X_Pos && DrawX < s24_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s24_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h22;
		end
		//s
		else if ( DrawX >=s25_X_Pos && DrawX < s25_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s25_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h22;
		end
		// D
		else if ( DrawX >=s26_X_Pos && DrawX < s26_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s26_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h04;
		end
		//->
		else if ( DrawX >=s27_X_Pos && DrawX < s27_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s27_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1b;
		end
		//L
		else if ( DrawX >=s28_X_Pos && DrawX < s28_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s28_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h0c;
		end
		//e
		else if ( DrawX >=s29_X_Pos && DrawX < s29_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s29_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//v
		else if ( DrawX >=s210_X_Pos && DrawX < s210_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s210_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h23;
		end
		//e
		else if ( DrawX >=s211_X_Pos && DrawX < s211_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s211_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1e;
		end
		//l
		else if ( DrawX >=s212_X_Pos && DrawX < s212_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s212_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1f;
		end
		//"2"
		else if ( DrawX >=s213_X_Pos && DrawX < s213_X_Pos + Text_Width*3 &&
				DrawY >=Line3_Y_Pos && DrawY < Line3_Y_Pos + Text_Height*3) begin    
			text_on = 1'b1;
			Scaled_X = (DrawX-s213_X_Pos)/3;
			Scaled_Y = (DrawY-Line3_Y_Pos)/3;
			sprite_adress = Scaled_Y + Text_Height* 8'h1d;
		end

		else begin
			text_on = 1'b0;
			Scaled_X = 0;
			Scaled_Y = 0;
			sprite_adress = 10'b0;
		end

	end

	alphabet_rom game_select(.addr(sprite_adress), .data(sprite_data));

	always_comb begin
		if (text_on==1'b1 && sprite_data[Scaled_X]== 1'b1)
			is_select_text = 1'b1;
		else
			is_select_text = 1'b0;
	end 

endmodule