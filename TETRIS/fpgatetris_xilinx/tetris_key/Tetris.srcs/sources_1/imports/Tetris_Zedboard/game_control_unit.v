module game_control_unit (
    input clk,
    input rst_n,
    input rotate,
    input left,
    input right,
    input down,
    input start,
    output reg [3:0] opcode,
    output reg gen_random,
    output reg hold,
    output reg shift,
    output reg move_down,
    output reg remove_1,
    output reg remove_2,
    output reg stop,
    output reg move,
    output reg isdie,
    output reg auto_down,
    input shift_finish,
    input remove_2_finish,
    input down_comp,
    input move_comp,
    input die
    );
    
    reg left_reg;
    reg right_reg;
    reg up_reg;
    reg down_reg;
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            left_reg <= 0;
            right_reg <= 0;
            up_reg <= 0;
            down_reg <= 0;
        end
        else
        begin
            left_reg <= left;
            right_reg <= right;
            up_reg <= rotate;
            down_reg <=  down;
        end
    end
    
    reg auto_down_reg;
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            auto_down_reg <= 0;
        else if (time_cnt == time_val)
            auto_down_reg <= 1;
        else 
            auto_down_reg <= 0;
    end
    
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            auto_down <= 0;
        else
            auto_down <= auto_down_reg;
    end
    
    parameter time_val = 26'd25000001;
    reg [25:0] time_cnt;

    localparam  S_idle      = 4'd0,
                S_new       = 4'd1,
                S_hold      = 4'd2,
                S_move      = 4'd3,
                S_shift     = 4'd4,
                S_down      = 4'd5,
                S_remove_1  = 4'd6,
                S_remove_2  = 4'd7,
                S_isdie     = 4'd8,
                S_stop      = 4'd9;

    reg [3:0] state, next_state;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            state <= S_idle;
        else
            state <= next_state;
    end
    


    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            time_cnt <= 0;
        else if (hold == 0 && time_cnt < time_val)
            time_cnt <= time_cnt + 1;
        else if (move_down == 1)
            time_cnt <= 0;
        else begin
            time_cnt <= time_cnt;
        end
    end
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n) opcode<=0;
        else opcode<={right, left, down, rotate};
    end 
        

    always @ (*)
    begin
        next_state = S_idle;
        hold = 1;
        gen_random = 0;
        //opcode = 4'b0000;
        shift = 0;
        move_down = 0;
        remove_1 = 0;
        remove_2 = 0;
        stop = 0;
        move = 0;
        isdie = 0;
        case (state)
        S_idle:
        begin
            if (start)
                next_state = S_new;
            else
                next_state = S_idle;
        end
        S_new:
        begin
            gen_random = 1;
            next_state = S_hold;
        end
        S_hold:
        begin
            hold = 0;
            if (time_cnt == time_val)   // 0.5?
            begin
                next_state = S_down;
                //next_state = S_shift;
            end
            else if ((down_reg == 0) && (down == 1))
            begin
               next_state = S_down;
               // next_state = S_shift;
            end
            else if ((left_reg == 0 && left == 1)|| ( right_reg == 0 && right == 1)||(up_reg == 0 && rotate == 1))
            begin
                next_state = S_move;
                //next_state = S_shift;
            end
            else
                next_state = S_hold;
        end
        S_move:     //??????????
        begin
            move = 1;
            //opcode = {rotate, down, left, right};
            if (move_comp)
                next_state = S_shift;
            else
                next_state = S_hold;
        end
        S_shift:    //???????ид?????
        begin
            //opcode = {rotate, down, left, right};
            shift = 1;
            //if (shift_finish)
            next_state = S_hold;
            //else 
            //    next_state = S_shift;
        end
        S_down:
        begin
            move_down = 1;
            if (down_comp)
                next_state = S_shift;
            else
                next_state = S_remove_1;
                //next_state = S_hold;
                
        end
        S_remove_1:
        begin
            remove_1 = 1;
            next_state = S_remove_2;
        end
        S_remove_2:
        begin
            remove_2 = 1;
            if (remove_2_finish)
                next_state = S_isdie;
            else
                next_state = S_remove_2;
        end
        S_isdie:
        begin
            isdie = 1;
            if (die == 1)
                next_state = S_stop;
            else
                next_state = S_new;
        end
        S_stop:
        begin
            stop = 1;
            next_state = S_idle;
        end
        default next_state = S_idle;
        endcase
    end
    
endmodule
