//-------------------------------------------------------------------------
//    Color_Mapper.sv Spring 2020										 --
//    Adapted from Color_Mapper.sv, lab8                                 --
//    Map the pixel with a color                                         --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input is_stickman, is_ground, is_coin, is_score,    // Whether current pixel belongs to the stickman or ground or coin
                       input is_star,is_human,
                       input is_lose_text, is_win_text,is_select_text,
                       input [4:0] status,              // Game status {selecting, waiting, playing, win, lose}
                       input [9:0] DrawX, DrawY,        // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

    // Find Cover Color
    logic cover_is_black;
    logic [0:639]cover_row;
    cover_rom my_cover(.addr(DrawY), .data(cover_row));
    assign cover_is_black = cover_row[DrawX];

       // Find End background Color
    logic end_is_win;
    logic end_is_lose;
    logic is_white;

    logic [0:639]end_row;
    end_rom my_end_lose(.addr(DrawY), .data(end_row));
    assign end_is_lose = end_row[DrawX];
	// assign CoverGray = 8'h40;
    assign end_is_win = ~end_is_lose;
    // Assign color
    always_comb
    begin
        if (DrawY < 70)
            is_white = 1'b1;
        else
            is_white = 1'b0;
    end

    always_comb
    begin

        // status = {selecting waiting, playing, win, lose}
        unique case (status)

            // selecting
            5'b10000:
            begin
                if (is_select_text) begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else if (is_white) begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
                else if (end_is_win) begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
            end
            // waiting & prewaiting
            5'b01000:
            begin
                if (cover_is_black) begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
            end

            // win
            5'b00010:
            begin

                if (is_win_text) begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else if (is_star)begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else if (is_human)begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else if (end_is_win) begin //black
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
                
                
            end

            // lose
            4'b00001:
            begin
                if (is_lose_text)begin  //
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
                else if (is_human)begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
                else if (end_is_lose) begin //black
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else begin          
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'hff;
                end
            end

            // playing
            4'b00100:
            begin
                if (is_stickman == 1'b1) begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
                end
                else if (is_coin == 1'b1) begin
                    Red = 8'hff;
                    Green = 8'hff;
                    Blue = 8'h00;
                end
                else if (is_ground == 1'b1) begin
                    Red = 8'h40;
                    Green = 8'h40;
                    Blue = 8'h40;
                end
                else if (is_score == 1'b1) begin
                    Red = 8'h10;
                    Green = 8'h10; 
                    Blue = 8'h10;
                end
                else begin
                    Red = 8'h4f; 
                    Green = 8'h4f;
                    Blue = 8'h7f - {1'b0, DrawX[9:3]};
                end
            end

            default: 
				begin
					Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;
				end

        endcase

    end 
    
endmodule
