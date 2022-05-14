//-------------------------------------------------------------------------
//      doodle_state.sv                                                  --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module is used control whether to used different picture to draw the doodle 
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module doodlestate(
    input logic Clk,frame_clk,Reset,
    input  [15:0] keycode,
    output [1:0]state

);

logic frame_clk_delayed, frame_clk_rising_edge;
logic [6:0] delay,next_delay;
always_ff @ (posedge Clk) begin
    frame_clk_delayed <= frame_clk;
    frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
end



enum logic [1:0]{
				right,
                left,
                up
} current_state, next_state;


assign state = current_state;

always_ff @ (posedge frame_clk_rising_edge)
	begin
		if (Reset) 
			begin
				current_state <= right;
                delay <= 7'd0;
			end			
		else 
			begin
			current_state <= next_state;
            delay <= next_delay;
			end
	end
always_comb 
begin 
    next_delay = 7'd0;
    next_state = current_state;
    case(current_state)
        right:
            if  ( (keycode[7:0] == 8'h04) || (keycode[15:8] == 8'h04))
                next_state = left;
            else if  (( (keycode[7:0] == 8'd82) || (keycode[15:8] == 8'd82)) || ( (keycode[7:0] == 8'd80) || (keycode[15:8] == 8'd80)) || ( (keycode[7:0] == 8'd79) || (keycode[15:8] == 8'd79)))
                next_state = up;
            else
                next_state = right;
        left:
            if  ( (keycode[7:0] == 8'h07) || (keycode[15:8] == 8'h07))
                next_state = right;
            else if (( (keycode[7:0] == 8'd82) || (keycode[15:8] == 8'd82)) || ( (keycode[7:0] == 8'd80) || (keycode[15:8] == 8'd80)) || ( (keycode[7:0] == 8'd79) || (keycode[15:8] == 8'd79)))
                next_state = up;
            else
                next_state = left;
        up:
        begin
            next_delay = delay + 1;
            if (delay == 7'd20)
            begin
                next_state = right;
                next_delay = 7'd0;               
            end
            else
                next_state = up;           
        end
        default: next_state = right;
    endcase
    
end


endmodule