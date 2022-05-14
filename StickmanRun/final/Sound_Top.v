//**********************************************//
//  Author: Ahmad Alastal                       //
//  Completion date: 25/7/2019 11.00PM          //
//  Title: WM8731 Audio CODEC demo              //
//  Main function: Audio demonstration          //
//                                              //
//  Modified by Xinyi Lai                       //
//  ECE385 2020SP, Final Project, Stickman run  //
//**********************************************//

module Sound_Top (
    input clk, reset,
    input [2:0] SoundSelect,	// {coin, win, gameover}
    inout SDIN,
    output SCLK, USB_clk, BCLK,
    output reg DAC_LR_CLK,
    output DAC_DATA,
    output [2:0] ACK_LEDR
);

reg [3:0] counter; //selecting register address and its corresponding data
reg counting_state,ignition,read_enable; 	
reg [15:0] MUX_input;
reg [3:0] ROM_output_mux_counter;
reg [4:0] DAC_LR_CLK_counter;
wire finish_flag;

reg DAC_DATA_out;
assign DAC_DATA = DAC_DATA_out;

reg [17:0] read_counter_coin, read_counter_win, read_counter_gameover;
wire [15:0] ROM_out_coin, ROM_out_win, ROM_out_gameover;
reg playing_coin, playing_win, playing_gameover;

wire select_coin, select_win, select_gameover;
assign {select_coin, select_win, select_gameover} = SoundSelect;


//============================================
//Instantiation section
I2C_Protocol I2C( .clk(clk), .reset(reset), .ignition(ignition), .MUX_input(MUX_input),
                    .ACK(ACK), .SDIN(SDIN), .finish_flag(finish_flag), .SCLK(SCLK) ); 

USB_Clock_PLL	USB_Clock_PLL_inst ( .inclk0(clk), .c0(USB_clk), .c1(BCLK) );

SoundROM_coin       SoundROM_coin_inst      ( .clock(clk), .address(read_counter_coin), .rden(playing_coin), .q(ROM_out_coin) );
SoundROM_win        SoundROM_win_inst       ( .clock(clk), .address(read_counter_win), .rden(playing_win), .q(ROM_out_win) );
SoundROM_gameover   SoundROM_gameover_inst  ( .clock(clk), .address(read_counter_gameover), .rden(playing_gameover), .q(ROM_out_gameover) );


//============================================
// choose databus
always
begin
    case({playing_coin, playing_win, playing_gameover})
    
    3'b100:     // coin
        DAC_DATA_out = ROM_out_coin[15-ROM_output_mux_counter];
    3'b010:     // win
        DAC_DATA_out = ROM_out_win[15-ROM_output_mux_counter];
    3'b001:     // gameover
        DAC_DATA_out = ROM_out_gameover[15-ROM_output_mux_counter];
    default:
        DAC_DATA_out = 0;

    endcase
end

//============================================
// select audio
always @(posedge clk)
begin
    if (reset) begin
        playing_coin = 1'b0;
        playing_win = 1'b0;
        playing_gameover = 1'b0;
    end

    // coin collected signal is shorter than coin sound, we need to play a complete coin sound
    // so playing_coin is turned on by select_coin, but turned off by read_counter_max
    if (select_coin)
        playing_coin <= 1'b1;
    else begin
        if (read_counter_coin >= 18'd10094)
            playing_coin <= 1'b0;
    end

    // win and gameover signal can be shorter or longer, should only play once and need to stop immediately
    // so playing_win and playing_gameover is turned on and off by select_win and select_gameover
    playing_win <= select_win;
    playing_gameover <= select_gameover;
        
end


//============================================
// address for ROM
always @(posedge DAC_LR_CLK)
begin
    if( read_enable ) 
    begin

        // coin will be played completely
        if (playing_coin) begin
            if (read_counter_coin < 18'd10094)
                read_counter_coin <= read_counter_coin + 1;
            else
                read_counter_coin <= 18'd10094;
        end
        else
            read_counter_coin <= 18'd0;

        // win and gameover is played only once, and can be stopped immediately by playing_

        if (playing_win) begin
            if (read_counter_win < 18'd50795)
                read_counter_win <= read_counter_win + 1;
            else
                read_counter_win <= 18'd50795;
        end
        else
            read_counter_win <= 18'd0;
        
        if (playing_gameover) begin
            if (read_counter_gameover < 18'd17196)
                read_counter_gameover <= read_counter_gameover + 1;
            else
                read_counter_gameover <= 18'd17196;
        end
        else
            read_counter_gameover <= 18'd0;

    end
end

//============================================
// ROM output mux
always @(posedge BCLK) 
    begin
        if(read_enable)
        begin
            ROM_output_mux_counter <= ROM_output_mux_counter + 1;
            if (DAC_LR_CLK_counter == 31) 
            begin
                DAC_LR_CLK <= 1;
                DAC_LR_CLK_counter <= 0;
            end
            else
            begin
                DAC_LR_CLK <= 0;
                DAC_LR_CLK_counter <= DAC_LR_CLK_counter + 1;
            end
        end
    end

//============================================
// generate 6 configuration pulses 
always @(posedge clk)
    begin
    if(!reset) 
        begin
        counting_state <= 0;
        read_enable <= 0;
        end
    else
        begin
        case(counting_state)
        0:
            begin
            ignition <= 1;
            read_enable <= 0;
            if(counter == 8) counting_state <= 1; //was 8
            end
        1:
            begin
            read_enable <= 1;
            ignition <= 0;
            end
        endcase
        end
    end

//============================================
// this counter is used to switch between registers
always @(posedge SCLK)
    begin
        case(counter) //MUX_input[15:9] register address, MUX_input[8:0] register data
        0: MUX_input <= 16'h1201; // activate interface
        1: MUX_input <= 16'h0460; // left headphone out
        2: MUX_input <= 16'h0C00; // power down control
        3: MUX_input <= 16'h0812; // analog audio path control
        4: MUX_input <= 16'h0A00; // digital audio path control
        5: MUX_input <= 16'h102F; // sampling control
        6: MUX_input <= 16'h0E23; // digital audio interface format
        7: MUX_input <= 16'h0660; // right headphone out
        8: MUX_input <= 16'h1E00; // reset device
        endcase
    end
always @(posedge finish_flag)
    begin
    counter <= counter + 1;
    end

endmodule 