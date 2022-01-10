`timescale 1ns / 1ps

// Project F: 数字以log形式保存，即0~2048记为0~11，该模块将数字转换为决定颜色的288位数组。
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card
module seg(din,dout);
    input [3:0] din;
    output reg [0:287] dout;
    
    always @(din) begin
        case(din)
        4'h0 : dout <= 288'h00_00_00_00_00_00_00_00_03_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_20_e0_00_00_00_00_00_00_00;//0
        4'h1 : dout <= 288'h00_00_00_00_00_00_00_00_02_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_a0_a0_00_00_00_00_00_00_00;//2
        4'h2 : dout <= 288'h00_00_00_00_00_00_00_00_03_00_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_80_80_e0_00_00_00_00_00_00_00;//4
        4'h3 : dout <= 288'h00_00_00_00_00_00_00_00_03_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_a0_e0_00_00_00_00_00_00_00;//8
        4'h4 : dout <= 288'h00_00_00_00_00_00_00_03_00_00_03_02_02_00_00_00_00_00_00_00_00_00_00_00_00_e0_00_00_e0_a0_e0_00_00_00_00_00;//16
        4'h5 : dout <= 288'h00_00_00_00_00_00_02_02_03_00_02_02_03_00_00_00_00_00_00_00_00_00_00_00_a0_a0_e0_00_e0_a0_a0_00_00_00_00_00;//32
        4'h6 : dout <= 288'h00_00_00_00_00_00_03_02_02_00_03_00_03_00_00_00_00_00_00_00_00_00_00_00_e0_a0_e0_00_80_80_e0_00_00_00_00_00;//64
        4'h7 : dout <= 288'h00_00_00_00_00_03_00_00_02_02_03_00_03_02_03_00_00_00_00_00_00_00_00_e0_00_00_e0_a0_a0_00_e0_a0_e0_00_00_00;//128
        4'h8 : dout <= 288'h00_00_00_00_02_02_03_00_03_02_02_00_03_02_02_00_00_00_00_00_00_00_e0_a0_a0_00_a0_a0_e0_00_e0_a0_e0_00_00_00;//256
        4'h9 : dout <= 288'h00_00_00_00_03_02_02_00_00_03_00_00_02_02_03_00_00_00_00_00_00_00_a0_a0_e0_00_00_e0_00_00_e0_a0_a0_00_00_00;//512
        4'ha : dout <= 288'h00_00_00_03_00_00_03_02_03_00_02_02_03_00_03_00_03_00_00_00_00_e0_00_00_e0_20_e0_00_e0_a0_a0_00_80_80_e0_00;//1024
        4'hb : dout <= 288'h00_00_02_02_03_00_03_02_03_00_03_00_03_00_03_02_03_00_00_00_e0_a0_a0_00_e0_20_e0_00_80_80_e0_00_e0_a0_e0_00;//2048
        4'hc : dout <= 288'h00_00_03_00_03_00_03_02_03_00_03_02_03_00_03_02_02_00_00_00_80_80_e0_00_e0_20_e0_00_a0_a0_e0_00_e0_a0_e0_00;//4096
        4'hd : dout <= 288'h00_00_03_02_03_00_00_03_00_00_03_02_03_00_02_02_03_00_00_00_e0_a0_e0_00_00_e0_00_00_a0_a0_e0_00_e0_a0_a0_00;//8192
        default: dout<=288'hff_80_80_80_80_80_80_80_80_80_80_80_80_80_80_80_80_80_ff_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;//none
        endcase
    end
endmodule
