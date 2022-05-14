//------------------------------------------------------------------------
//    game_logic.sv Spring 2020                                         --
//    decide the game status                                            --
//    connect all parts of the game                                     --
//------------------------------------------------------------------------


module game_logic ( input   Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
                    input [7:0] keycode,        // Accept the last received key
                    input [9:0] StickmanTop, GroundY, // The bottom of the stickman and current ground height
                    input [11:0] frame_counter, // Frame counter, to game_logic
                    input [12:0] CoinFrameX[3], // Frame X location of the 3 coins, from background.sv
                    input [9:0] CoinY[3],       // Frame Y location of the 3 coins, from background.sv
                    output [2:0] CoinStatus,    // From game_logic, to background.sv
                    output logic [1:0] level_status, //judge which level the player choose
                    output logic [4:0] status,  // Game status {selecting, waiting, playing, win, lose}
                    output logic coin_collide
                );

    // check stickman lose
    logic stickman_crash, stickman_fall;
    assign stickman_crash = StickmanTop + 10'd50 > GroundY ;
    assign stickman_fall = StickmanTop + 10'd50 >= 10'd470;

    // check coin collection
    logic [11:0] stickman_left_frame;
    assign stickman_left_frame	= 12'd100 + frame_counter;
    logic coin_collected[3];
    logic [2:0] CoinStatus_in;
    logic [1:0] level_status_in;
    always_comb
    begin
        for (int i=0; i<3; i++) begin
            coin_collected[i] = (CoinFrameX[i] > stickman_left_frame + 12'd10) && (CoinFrameX[i] < stickman_left_frame + 12'd46)
                                    && (CoinY[i] > StickmanTop + 12'd10) && (CoinY[i] < StickmanTop + 12'd74);
        end
        if ( coin_collected[0] == 1'b1 || coin_collected[1] == 1'b1 || coin_collected[2] == 1'b1 )
            coin_collide = 1'b1;
        else
            coin_collide = 1'b0;
    end

    // FSM
    enum logic [4:0] { SELECT, WAIT, PLAY, WIN, LOSE, PREWAIT } curr_state, next_state;   // Internal state logic

    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            curr_state <= WAIT;
            CoinStatus <= 3'b111;
            level_status <= 2'b01;  //defaut is level one
        end
        else 
        begin
            curr_state <= next_state;
            CoinStatus <= CoinStatus_in;
            level_status <= level_status_in;
        end
    end

    always_comb
    begin
        // Default, nothing happens
        next_state = curr_state;
        CoinStatus_in = CoinStatus;
        level_status_in = level_status;
        
        // Assign next state
        unique case (curr_state)
        
            WAIT:
                if (keycode == 8'h2c)
                    next_state = SELECT;
            SELECT:
                if (keycode == 8'h04)
                begin
                    next_state = PLAY;
                    level_status_in = 2'b01;
                end
                else if (keycode == 8'h07)
                begin
                    next_state = PLAY;
                    level_status_in = 2'b10;
                end
            PLAY:
            begin
                if (stickman_fall || stickman_crash)
                    next_state = LOSE;
                else if (frame_counter >= 13'd3000)
                    next_state = WIN;
            end

            WIN:
                if (keycode == 8'h2c)
                    next_state = PREWAIT;
            LOSE:
                if (keycode == 8'h2c)
                    next_state = PREWAIT;
            PREWAIT:
                if (keycode != 8'h2c)
                    next_state = WAIT;
            default : ;
        
        endcase
        

        // Assign status
        unique case (curr_state)
            WAIT, PREWAIT:
            begin
                status = 5'b01000; 
                CoinStatus_in = 3'b111;
            end
            SELECT:
            begin
                status = 5'b10000; 

            end
            WIN:
            status = 5'b00010;
            LOSE:
                status = 5'b00001;
            PLAY:
            begin
                status = 5'b00100;
                for (int i=0; i<3; i++) begin
                    CoinStatus_in[i] = CoinStatus[i] && (!coin_collected[i]);
                end
            end
            default: 
                status = 5'b00000;   // will never happen
        endcase

    end

    
endmodule
