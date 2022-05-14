//-------------------------------------------------------------------------
//      controller.sv                                                    --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module controls the state of the game                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------




module controller(
    input logic Reset,Clk,frame_clk,
    input logic[15:0] keycode,
    input logic death,drop,
    output logic[2:0] show,
    output logic restart
);



logic frame_clk_delayed, frame_clk_rising_edge;
logic [6:0] delay,next_delay;
always_ff @ (posedge Clk) begin
    frame_clk_delayed <= frame_clk;
    frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
end



enum logic [3:0]{
				start,
                play,
                // pause,
                dead,
                drop_state,
                halt
} state, next_state;



always_ff @ (posedge Clk)
	begin
		if (Reset) 
			begin
				state <= start;
                // delay <= 7'd0;
			end			
		else 
			begin
			state <= next_state;
            // delay <= next_delay;
			end
	end


always_ff @ (posedge frame_clk_rising_edge)
	begin
		if (Reset) 
			begin
                delay <= 7'd0;
			end			
		else 
			begin
            delay <= next_delay;
			end
	end
always_comb 
begin 
    show = 3'd0;
    restart = 1'b0;
    next_delay = 7'd0;
    next_state = state;
    case(state)
        start:
        begin
            restart = 1'b1;
            show = 3'd1;
            if ((keycode & 16'hff) == 16'd40) //press enter then start
                next_state = play;  
        end          
        play:
        begin
            show = 3'd0;
            // if ((keycode & 16'hff) == 16'd44)//press space then pause
            //     next_state = pause;
            if(death)  
                next_state = dead;
            else if(drop)
                next_state = drop_state;
            else
                next_state = play;
        end
        
        // pause:
        // begin
        //     show = 3'd2;
        //     if ((keycode & 16'hff) == 16'd40)
        //     next_state = play;           
        // end
                   
        dead:
        begin
            show = 3'd3;
            if ((keycode & 16'hff) == 16'd40)
            next_state = halt;            
        end

        drop_state:
        begin
            next_delay = delay + 1;
            show = 3'd0;
            if (delay == 7'd50)
            begin
                next_state = dead;
                next_delay = 0;
            end  
            else
                next_state = drop_state;                         
        end

        halt:
        begin
            show = 3'd1;
            if ((keycode & 16'hff) == 16'd0)
            next_state = start; 
        end


               
        default: next_state = start;
    endcase
    
end

endmodule