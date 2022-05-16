`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/11/17 11:13:29
// Design Name: 
// Module Name: sim
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


module sim();
    reg clk;
    reg rst;
    reg start;
    reg up;
    reg left;
    reg right;
    reg down;
    
    wire vsync_r;
    wire hsync_r;
    
    
    wire [3:0] OutRed, OutGreen, OutBlue;
    
    tetris u(
        .clk(clk),
        .rst(rst),
        .start(start),
        .UP_KEY(up),
        .LEFT_KEY(left),
        .RIGHT_KEY(right),
        .DOWN_KEY(down),
        .vsync_r(vsync_r),
        .hsync_r(hsync_r),
        .OutRed(OutRed),
        .OutGreen(OutGreen),
        .OutBlue(OutBlue)
    );
    
    initial
    begin
        #0 clk = 0;
        #0 rst = 0;
        #25 rst = 1;
        #10 rst = 0;
        #3 start = 1;
        #100 up = 1;
        #25 up =0;
    end
    
    always #5 clk = ~clk;
    
endmodule
