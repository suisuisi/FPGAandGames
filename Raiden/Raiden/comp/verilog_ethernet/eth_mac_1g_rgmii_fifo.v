/*

Copyright (c) 2015-2018 Alex Forencich

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
 * 1G Ethernet MAC with RGMII interface and TX and RX FIFOs
 */
module eth_mac_1g_rgmii_fifo #
(
    parameter ENABLE_PADDING = 1,
    parameter MIN_FRAME_LENGTH = 64
)
(
    input  wire        gtx_clk,
    input  wire        gtx_rst,
    input  wire        logic_clk,
    input  wire        logic_rst,

    /*
     * AXI input
     */
    input  wire [7:0]  tx_axis_tdata,
    input  wire        tx_axis_tvalid,
    output wire        tx_axis_tready,
    input  wire        tx_axis_tlast,
    input  wire        tx_axis_tuser,

    /*
     * AXI output
     */
    output wire [7:0]  rx_axis_tdata,
    output wire        rx_axis_tvalid,
    input  wire        rx_axis_tready,
    output wire        rx_axis_tlast,
    output wire        rx_axis_tuser,
	output wire        rx_axis_startofpacket,

    /*
     * RGMII interface
     */
    input  wire        rgmii_rx_clk,
    input  wire [3:0]  rgmii_rxd,
    input  wire        rgmii_rx_ctl,
    output wire        rgmii_tx_clk,
    output wire [3:0]  rgmii_txd,
    output wire        rgmii_tx_ctl,

    /*
     * Status
     */
    output wire        tx_error_underflow,
    output wire        rx_error_bad_frame,
    output wire        rx_error_bad_fcs,
    output wire [1:0]  speed,

    /*
     * Configuration
     */
    input  wire [7:0]  ifg_delay
);

wire tx_clk;
wire rx_clk;
wire tx_rst;
wire rx_rst;

// synchronize MAC status signals into logic clock domain
wire tx_error_underflow_int;

reg [0:0] tx_sync_reg_1 = 1'b0;
reg [0:0] tx_sync_reg_2 = 1'b0;
reg [0:0] tx_sync_reg_3 = 1'b0;
reg [0:0] tx_sync_reg_4 = 1'b0;

assign tx_error_underflow = tx_sync_reg_3[0] ^ tx_sync_reg_4[0];

always @(posedge tx_clk or posedge tx_rst) begin
    if (tx_rst) begin
        tx_sync_reg_1 <= 1'b0;
    end else begin
        tx_sync_reg_1 <= tx_sync_reg_1 ^ {tx_error_underflow_int};
    end
end

always @(posedge logic_clk or posedge logic_rst) begin
    if (logic_rst) begin
        tx_sync_reg_2 <= 1'b0;
        tx_sync_reg_3 <= 1'b0;
        tx_sync_reg_4 <= 1'b0;
    end else begin
        tx_sync_reg_2 <= tx_sync_reg_1;
        tx_sync_reg_3 <= tx_sync_reg_2;
        tx_sync_reg_4 <= tx_sync_reg_3;
    end
end

wire rx_error_bad_frame_int;
wire rx_error_bad_fcs_int;

reg [1:0] rx_sync_reg_1 = 2'd0;
reg [1:0] rx_sync_reg_2 = 2'd0;
reg [1:0] rx_sync_reg_3 = 2'd0;
reg [1:0] rx_sync_reg_4 = 2'd0;

assign rx_error_bad_frame = rx_sync_reg_3[0] ^ rx_sync_reg_4[0];
assign rx_error_bad_fcs = rx_sync_reg_3[1] ^ rx_sync_reg_4[1];

always @(posedge rx_clk or posedge rx_rst) begin
    if (rx_rst) begin
        rx_sync_reg_1 <= 2'd0;
    end else begin
        rx_sync_reg_1 <= rx_sync_reg_1 ^ {rx_error_bad_frame_int, rx_error_bad_frame_int};
    end
end

always @(posedge logic_clk or posedge logic_rst) begin
    if (logic_rst) begin
        rx_sync_reg_2 <= 2'd0;
        rx_sync_reg_3 <= 2'd0;
        rx_sync_reg_4 <= 2'd0;
    end else begin
        rx_sync_reg_2 <= rx_sync_reg_1;
        rx_sync_reg_3 <= rx_sync_reg_2;
        rx_sync_reg_4 <= rx_sync_reg_3;
    end
end

wire [1:0] speed_int;

reg [1:0] speed_sync_reg_1 = 2'b10;
reg [1:0] speed_sync_reg_2 = 2'b10;

assign speed = speed_sync_reg_2;

always @(posedge logic_clk) begin
    speed_sync_reg_1 <= speed_int;
    speed_sync_reg_2 <= speed_sync_reg_1;
end

eth_mac_1g_rgmii #(
    .ENABLE_PADDING(ENABLE_PADDING),
    .MIN_FRAME_LENGTH(MIN_FRAME_LENGTH)
)
eth_mac_1g_rgmii_inst (
    .gtx_clk(gtx_clk),
    .gtx_rst(gtx_rst),
    .tx_clk(tx_clk),
    .tx_rst(tx_rst),
    .rx_clk(rx_clk),
    .rx_rst(rx_rst),
    .tx_axis_tdata(tx_axis_tdata),
    .tx_axis_tvalid(tx_axis_tvalid),
    .tx_axis_tready(tx_axis_tready),
    .tx_axis_tlast(tx_axis_tlast),
    .tx_axis_tuser(tx_axis_tuser),
    .rx_axis_tdata(rx_axis_tdata),
    .rx_axis_tvalid(rx_axis_tvalid),
    .rx_axis_tlast(rx_axis_tlast),
    .rx_axis_tuser(rx_axis_tuser),
	.rx_start_packet(rx_axis_startofpacket),
    .rgmii_rx_clk(rgmii_rx_clk),
    .rgmii_rxd(rgmii_rxd),
    .rgmii_rx_ctl(rgmii_rx_ctl),
    .rgmii_tx_clk(rgmii_tx_clk),
    .rgmii_txd(rgmii_txd),
    .rgmii_tx_ctl(rgmii_tx_ctl),
    .tx_error_underflow(tx_error_underflow_int),
    .rx_error_bad_frame(rx_error_bad_frame_int),
    .rx_error_bad_fcs(rx_error_bad_fcs_int),
    .speed(speed_int),
    .ifg_delay(ifg_delay)
);

endmodule
