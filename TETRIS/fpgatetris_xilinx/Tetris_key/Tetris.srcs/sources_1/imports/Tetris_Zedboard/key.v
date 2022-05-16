`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:56:39 11/15/2015 
// Design Name: 
// Module Name:    key 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module key(
    input clk,
    input rst_n,
    input UP_KEY,
    input LEFT_KEY,
    input RIGHT_KEY,
    input DOWN_KEY,
    output reg rotate,
    output reg left,
    output reg right,
    output reg down
    );
    
    reg [3:0] shift_up;
    reg [3:0] shift_left;
    reg [3:0] shift_right;
    reg [3:0] shift_down;
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            shift_up <= 0;
        else
            shift_up <= {shift_up[2:0], UP_KEY};
    end
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            shift_right <= 0;
        else
            shift_right <= {shift_right[2:0], RIGHT_KEY};
    end 
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            shift_left <= 0;
        else
            shift_left <= {shift_left[2:0], LEFT_KEY};
    end
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            shift_down <= 0;
        else
            shift_down <= {shift_down[2:0], DOWN_KEY};
    end
    
//    always @(posedge clk or negedge rst_n)
//    begin
//        if (!rst_n)
//            rotate <= 0;
//        else if (shift_up[3] == 0 && shift_up[2] == 1)
//            rotate <= 1;
//        else if (shift_up[3] == 1 && shift_up[2] == 0)
//            rotate <= 0;
//        else
//            rotate <= rotate;
//    end
    
//    always @(posedge clk or negedge rst_n)
//    begin
//        if (!rst_n)
//            left <= 0;
//        else if (shift_left[3] == 0 && shift_left[2] == 1)
//            left <= 1;
//        else if (shift_right[3] == 1 && shift_right[3] == 0)
//            left <= 0;
//        else
//            left <= left;
//    end
    
//    always @(posedge clk or negedge rst_n)
//    begin
//        if (!rst_n)
//            right <= 0;
//        else if (shift_right[3] == 0 && shift_right[2] == 1)
//            right <= 1;
//        else if (shift_right[3] == 1 && shift_right[2] == 0)
//            right <= 0;
//        else
//            right <= right;
//    end
    
//    always @(posedge clk or negedge rst_n)
//    begin
//        if (!rst_n)
//            down <= 0;
//        else if (shift_down[3] == 0 && shift_down[2] == 1)
//            down <= 1;
//        else if (shift_down[3] == 1 && shift_down[2] == 0)
//            down <= 0;
//        else
//            down <= down;
//    end

reg clk_div;
reg [7:0] clk_cnt;
always @ (posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        clk_cnt <= 0;
        clk_div <= 0;
    end
    else if (clk_cnt <= 8'd49)
    begin
        clk_cnt <= clk_cnt + 1;
        clk_div <= clk_div;
    end
    else
    begin
        clk_cnt <= 0;
        clk_div <= ~clk_div;
    end
end

always @(posedge clk_div or negedge rst_n)
begin
    if (!rst_n)
    begin
        rotate <= 0;
        left <= 0;
        right <= 0;
        down <= 0;
    end
    else
    begin
        rotate <= shift_up[3];
        left <= shift_left[3];
        right <= shift_right[3];
        down <= shift_down[3];
    end
end

endmodule
