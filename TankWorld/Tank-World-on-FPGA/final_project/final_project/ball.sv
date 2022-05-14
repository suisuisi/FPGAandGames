//-------------------------------------------------------------------------

module  tanks ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					input [7:0]   keycode,
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					output [19:0] DistX_out, DistY_out,
               output logic  is_tank,             // Whether current pixel belongs to ball or background
					output [1:0] is_tank_out
              );
    
    parameter [9:0] Ball_X_Start = 10'd2;  // Center position on the X axis
    parameter [9:0] Ball_Y_Start = 10'd458;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min = 10'd2;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd638;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd2;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd478;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step = 10'd2;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step = 10'd2;      // Step size on the Y axis
    parameter [9:0] Ball_Size = 10'd19;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
	 logic [1:0] is_tank_dir, is_tank_in;
	 assign is_tank_out = is_tank_dir;
    logic new_instance;
	 enum logic [1:0] {FIRST, FIRST_WAIT, OTHER} State, Next_State;
	 
	 always_ff @ (posedge Clk) 
	 begin
		if (Reset)	
			State <= FIRST;
		else 
			State <= Next_State;
	 end
	 
	 always_comb 
	 begin
	 new_instance = 1'b1;
	 unique case (State)
		FIRST: 
			Next_State = FIRST_WAIT;
		FIRST_WAIT:
			if (keycode == 8'h00)
				Next_State = OTHER;
			else 
				Next_State = FIRST_WAIT;
		OTHER:
			Next_State = OTHER;
		endcase
		
	 case (State)
		FIRST: 
			new_instance = 1'b1;
		FIRST_WAIT:
			new_instance = 1'b1;
		OTHER: 
			new_instance = 1'b0;
	 endcase
	 end
	 
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
        if (Reset || new_instance)
        begin
            Ball_X_Pos <= Ball_X_Start;
            Ball_Y_Pos <= Ball_Y_Start;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Ball_Y_Step;
				is_tank_dir <= 2'b00; //00 Right, 01 up, 10 left, 11 down
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
				is_tank_dir <= is_tank_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
        is_tank_in = is_tank_dir;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
				if (keycode == 8'h00)
				begin
							Ball_Y_Motion_in = 10'b0;  // 2's complement.  
							Ball_X_Motion_in = 10'b0;
						
				end
				else if( keycode == 8'h1A || keycode == 8'h52)  // W (Up) Code 2'b01
				begin
					is_tank_in = 2'b01;
					if (Ball_Y_Pos > Ball_Y_Min)
					begin
						Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						Ball_X_Motion_in = 10'b0;
					end
					else
					begin
						Ball_Y_Motion_in = 10'b0;  // 2's complement.  
						Ball_X_Motion_in = 10'b0;
					end
				end
            else if ( keycode == 8'h16 || keycode == 8'h51)
				begin 														// S (Down) Code 2'b11
					is_tank_in = 2'b11;
					if (Ball_Y_Pos + Ball_Size < Ball_Y_Max)
					begin
						Ball_Y_Motion_in = Ball_Y_Step;
						Ball_X_Motion_in = 10'b0;
					end 
					else 
					begin
						Ball_Y_Motion_in = 10'b0;  // 2's complement.  
						Ball_X_Motion_in = 10'b0;
					end
				end
				else if( keycode == 8'h04 || keycode == 8'h50)  // A (Left) Code 2'b10
				begin
					is_tank_in = 2'b10;
					if (Ball_X_Pos > Ball_X_Min)
					begin
						Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.
						Ball_Y_Motion_in = 10'b0;
					end
					else 
					begin
						Ball_Y_Motion_in = 10'b0;  // 2's complement.  
						Ball_X_Motion_in = 10'b0;
					end
				end
            else if ( keycode == 8'h07 || keycode == 8'h4f)  // D (Right) Code 2'b00;
				begin
					is_tank_in = 2'b00;
					if (Ball_X_Pos + Ball_Size < Ball_X_Max)
						begin
							Ball_X_Motion_in = Ball_X_Step;
							Ball_Y_Motion_in = 10'b0;
						end
					else
						begin
							Ball_Y_Motion_in = 10'b0;  // 2's complement.  
							Ball_X_Motion_in = 10'b0;
						end
				end
	
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
			

            // Update the ball's position with its motion
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
            Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
        end
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
              Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
//	 logic [19:0] DistX_out, DistY_out;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
	 assign DistX_out = DistX;
	 assign DistY_out = DistY;
    assign Size = Ball_Size;
    always_comb begin
        if ( DistX >= 0 && DistX < Size && DistY >= 0 && DistY < Size) 
            is_tank = 1'b1;
        else
            is_tank = 1'b0;
    end
    
endmodule
