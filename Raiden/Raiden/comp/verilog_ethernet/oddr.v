/*

Copyright (c) 2016-2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * Generic ODDR module
 */
module oddr #
(
    // Width of register in bits
    parameter WIDTH = 1
)
(
    input  wire             clk,

    input  wire [WIDTH-1:0] d1,
    input  wire [WIDTH-1:0] d2,

    output wire [WIDTH-1:0] q
);

/*

Provides a consistent output DDR flip flop across multiple FPGA families
              _____       _____       _____       _____
    clk  ____/     \_____/     \_____/     \_____/     \_____
         _ ___________ ___________ ___________ ___________ __
    d1   _X____D0_____X____D2_____X____D4_____X____D6_____X__
         _ ___________ ___________ ___________ ___________ __
    d2   _X____D1_____X____D3_____X____D5_____X____D7_____X__
         _____ _____ _____ _____ _____ _____ _____ _____ ____
    d    _____X_D0__X_D1__X_D2__X_D3__X_D4__X_D5__X_D6__X_D7_

*/


    altddio_out #(
        .WIDTH(WIDTH),
        .POWER_UP_HIGH("OFF"),
        .OE_REG("UNUSED")
    )
    altddio_out_inst (
        .aset(1'b0),
        .datain_h(d1),
        .datain_l(d2),
        .outclocken(1'b1),
        .outclock(clk),
        .aclr(1'b0),
        .dataout(q)
    );

endmodule
