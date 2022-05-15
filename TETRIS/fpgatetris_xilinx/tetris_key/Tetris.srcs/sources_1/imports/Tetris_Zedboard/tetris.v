`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/11/15 19:38:52
// Design Name: 
// Module Name: tetris
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tetris #(
    parameter ROW = 20,
    parameter COL = 10
    )(
    input clk,
    input rst,
    input UP_KEY,
    input LEFT_KEY,
    input RIGHT_KEY,
    input DOWN_KEY,
    input start,
    output vsync_r,
    output hsync_r,
    output [3:0]OutRed, OutGreen,
    output [3:0]OutBlue
    );
    
    wire [3:0] opcode;
    wire gen_random;
    wire hold;
    wire shift;
    wire move_down;
    wire remove_1;
    wire remove_2;
    wire stop;
    wire move;
    wire isdie;
    wire shift_finish;
    wire down_comp;
    wire move_comp;
    wire die;
    wire [ROW*COL-1:0] data_out;
    
    wire [6:0] BLOCK;
    wire [3:0] m;
    wire [4:0] n;
    wire [(ROW+4)*COL-1:0] M_OUT;
    
    wire rotate;
    wire left;
    wire right;
    wire down;
    wire auto_down;
    wire rst_n;
    assign rst_n = ~rst;
    
    key u_key (
        .clk(clk),
        .rst_n(rst_n),
        .UP_KEY(UP_KEY),
        .LEFT_KEY(LEFT_KEY),
        .RIGHT_KEY(RIGHT_KEY),
        .DOWN_KEY(DOWN_KEY),
        .rotate(rotate),
        .left(left),
        .right(right),
        .down(down)
    );
    
    game_control_unit u_Controller (
        .clk(clk),
        .rst_n(rst_n),
        .rotate(rotate),
        .left(left),
        .right(right),
        .down(down),
        .start(start),
        .opcode(opcode),
        .gen_random(gen_random),
        .hold(hold),
        .shift(shift),
        .move_down(move_down),
        .remove_1(remove_1),
        .remove_2(remove_2),
        .stop(stop),
        .move(move),
        .isdie(isdie),
        .shift_finish(shift_finish),
        .down_comp(down_comp),
        .move_comp(move_comp),
        .die(die),
        .auto_down(auto_down),
        .remove_2_finish(remove_2_finish)
        );
        
    Datapath_Unit u_Datapath (
        .clk(clk),
        .rst_n(rst_n),
        .NEW(gen_random),
        .MOVE(move),
        .DOWN(move_down),
        .DIE(isdie),
        .SHIFT(shift),
        .REMOVE_1(remove_1),
        .REMOVE_2(remove_2),
        .KEYBOARD(opcode),
        .MOVE_ABLE(move_comp),
        .SHIFT_FINISH(shift_finish),
        .DOWN_ABLE(down_comp),
        .DIE_TRUE(die),
        .M_OUT(M_OUT),
        .n(n),
        .m(m),
        .BLOCK(BLOCK),
        .REMOVE_2_FINISH(remove_2_finish),
        .STOP(stop),
        .AUTODOWN(auto_down)
        );
        
    merge u_merge (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(M_OUT),
        .shape(BLOCK),
        .x_pos(m),
        .y_pos(n),
        .data_out(data_out)
        
        );
	 
    top u_VGA (
        .clk(clk),
        .rst(rst),
        .number(data_out),
        .hsync_r(hsync_r),
        .vsync_r(vsync_r),
        .OutRed(OutRed),
        .OutGreen(OutGreen),
        .OutBlue(OutBlue)        
	);
    
    
endmodule
