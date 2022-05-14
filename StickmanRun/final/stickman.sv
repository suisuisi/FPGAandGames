//-------------------------------------------------------------------------
//    stickman.sv Spring 2020											 --
//    Adapted from Ball.sv, lab8                                         --
//    Store the position, motion and shape of the stickman               --
//    Tell the ColorMapper whether this pixel is a part of the stickman  --
//-------------------------------------------------------------------------


module stickman (	input	Clk,				// 50 MHz clock
							Reset,				// Active-high reset signal
							frame_clk,			// The clock indicating a new frame (~60Hz)
					input   restart,			// Game status
					input [7:0] keycode,		// Accept the last received key 
					input [9:0] DrawX, DrawY,	// Current pixel coordinates
                    input [9:0] GroundY,		// The height of floor
					output[9:0] StickmanTop,	// The top height of the stickman
					output logic is_stickman	// Whether current pixel belongs to ball or background
				);

	parameter [9:0] X_TopLeft = 10'd100;     // TopLeft position on the X axis (640)
	parameter [9:0] Y_TopLeft = 10'd250;     // TopLeft position on the Y axis (480)

	parameter [9:0] Y_Min = 10'd10;         // Ceil
//	parameter [9:0] Y_Max = GroundY;        // Floor
	parameter [9:0] Y_Step = 10'd8;         // Jump size on the Y axis

	parameter [9:0] Height = 10'd80;        // Height of the stickman
	parameter [9:0] Width = 10'd56;         // Width of the stickman

	logic [9:0] X_Pos, X_Motion, Y_Pos, Y_Motion;
	logic [9:0] X_Pos_in, X_Motion_in, Y_Pos_in, Y_Motion_in;
	logic [7:0] page_cnt, page_cnt_in;      // Page 1-9, (0-8)

	assign StickmanTop = Y_Pos;

    // Detect rising edge of frame_clk
	logic frame_clk_delayed, frame_clk_rising_edge;
	always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	// Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset || restart)
        begin
            X_Pos <= X_TopLeft;
            Y_Pos <= Y_TopLeft;
            X_Motion <= 10'd0;
            Y_Motion <= 10'd0;
            page_cnt <= 8'd0;
        end
        else
        begin
            X_Pos <= X_Pos_in;
            Y_Pos <= Y_Pos_in;
            X_Motion <= X_Motion_in;
            Y_Motion <= Y_Motion_in;
            page_cnt <= page_cnt_in;
        end
    end

    
    always_comb
    begin
        // By default, keep motion and position unchanged
        X_Pos_in = X_Pos;
        Y_Pos_in = Y_Pos;
        X_Motion_in = X_Motion;
        Y_Motion_in = Y_Motion;
        page_cnt_in = page_cnt;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
            
            // X position does not change
            X_Motion_in = 10'd0;
            
            // press SPACE, jump
            if (keycode == 8'h2c)
            begin
                if (Y_Pos > Y_Min)
                    Y_Motion_in = (~(Y_Step) + 1'b1);  // 2's complement
                else
                    Y_Motion_in = 10'd0;
            end
            // fall to ground because of gravity
            else
            begin
				if (Y_Pos + Height + Y_Step <= GroundY)
                    Y_Motion_in = Y_Step;
                else if ( Y_Pos + Height <= GroundY )
                    Y_Motion_in = GroundY - (Y_Pos + Height);
                else
                    Y_Motion_in = 10'd0;
					
			// increment frame counter
            if (Y_Pos + Height >= GroundY)
            begin
                if (page_cnt == 8'd18)		// 9*2
                    page_cnt_in = 8'd0;
                else
                    page_cnt_in = page_cnt + 1'b1;
            end
				
				
			end

            // Update the ball's position with its motion
            X_Pos_in = X_Pos + X_Motion;
            Y_Pos_in = Y_Pos + Y_Motion;
		end

    end

    
    // Compute whether the pixel corresponds to the stickman or not
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int X_coor, Y_coor;
    assign X_coor = DrawX - X_Pos;
    assign Y_coor = DrawY - Y_Pos;
    
    logic [9:0] sprite_addr;
    logic [0:55] sprite_data;
    assign sprite_addr = Y_coor + Height * (page_cnt>>1);
    stickman_rom my_stickman_rom(.addr(sprite_addr), .data(sprite_data));

    always_comb begin
        if ( X_coor >= 0 && X_coor < Width && Y_coor >= 0 && Y_coor < Height && sprite_data[X_coor] == 1'b1 )
            is_stickman = 1'b1;
        else
            is_stickman = 1'b0;
    end
    
endmodule
