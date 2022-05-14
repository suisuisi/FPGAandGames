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
 * RGMII PHY interface
 */
module rgmii_phy_if (
    input  wire        clk,
    input  wire        rst,

    /*
     * GMII interface to MAC
     */
    output wire        mac_gmii_rx_clk,
    output wire        mac_gmii_rx_rst,
    output wire [7:0]  mac_gmii_rxd,
    output wire        mac_gmii_rx_dv,
    output wire        mac_gmii_rx_er,
    output wire        mac_gmii_tx_clk,
    output wire        mac_gmii_tx_rst,
    output wire        mac_gmii_tx_clk_en,
    input  wire [7:0]  mac_gmii_txd,
    input  wire        mac_gmii_tx_en,
    input  wire        mac_gmii_tx_er,

    /*
     * RGMII interface to PHY
     */
    input  wire        phy_rgmii_rx_clk,
    input  wire [3:0]  phy_rgmii_rxd,
    input  wire        phy_rgmii_rx_ctl,
    output wire        phy_rgmii_tx_clk,
    output wire [3:0]  phy_rgmii_txd,
    output wire        phy_rgmii_tx_ctl,

    /*
     * Control
     */
    input  wire [1:0]  speed
);

// receive

wire rgmii_rx_ctl_1;
wire rgmii_rx_ctl_2;

iddr #
(
    .WIDTH(5)
)
rx_iddr_inst (
    .clk(phy_rgmii_rx_clk),
    .d({phy_rgmii_rxd, phy_rgmii_rx_ctl}),
    .q1({mac_gmii_rxd[3:0], rgmii_rx_ctl_1}),
    .q2({mac_gmii_rxd[7:4], rgmii_rx_ctl_2})
);

assign mac_gmii_rx_clk = phy_rgmii_rx_clk;
assign mac_gmii_rx_dv = rgmii_rx_ctl_1;
assign mac_gmii_rx_er = rgmii_rx_ctl_1 ^ rgmii_rx_ctl_2;

// transmit

reg rgmii_tx_clk_1 = 1'b1;
reg rgmii_tx_clk_2 = 1'b0;
reg rgmii_tx_clk_rise = 1'b1;
reg rgmii_tx_clk_fall = 1'b1;

reg [5:0] count_reg = 6'd0, count_next;

always @(posedge clk) begin
    if (rst) begin
        rgmii_tx_clk_1 <= 1'b1;
        rgmii_tx_clk_2 <= 1'b0;
        rgmii_tx_clk_rise <= 1'b1;
        rgmii_tx_clk_fall <= 1'b1;
        count_reg <= 0;
    end else begin
        rgmii_tx_clk_1 <= rgmii_tx_clk_2;

        if (speed == 2'b00) begin
            // 10M
            count_reg <= count_reg + 1;
            rgmii_tx_clk_rise <= 1'b0;
            rgmii_tx_clk_fall <= 1'b0;
            if (count_reg == 24) begin
                rgmii_tx_clk_1 <= 1'b1;
                rgmii_tx_clk_2 <= 1'b1;
                rgmii_tx_clk_rise <= 1'b1;
            end else if (count_reg >= 49) begin
                rgmii_tx_clk_1 <= 1'b0;
                rgmii_tx_clk_2 <= 1'b0;
                rgmii_tx_clk_fall <= 1'b1;
                count_reg <= 0;
            end
        end else if (speed == 2'b01) begin
            // 100M
            count_reg <= count_reg + 1;
            rgmii_tx_clk_rise <= 1'b0;
            rgmii_tx_clk_fall <= 1'b0;
            if (count_reg == 2) begin
                rgmii_tx_clk_1 <= 1'b1;
                rgmii_tx_clk_2 <= 1'b1;
                rgmii_tx_clk_rise <= 1'b1;
            end else if (count_reg >= 4) begin
                rgmii_tx_clk_2 <= 1'b0;
                rgmii_tx_clk_fall <= 1'b1;
                count_reg <= 0;
            end
        end else begin
            // 1000M
            rgmii_tx_clk_1 <= 1'b1;
            rgmii_tx_clk_2 <= 1'b0;
            rgmii_tx_clk_rise <= 1'b1;
            rgmii_tx_clk_fall <= 1'b1;
        end
    end
end

reg [3:0] rgmii_txd_1;
reg [3:0] rgmii_txd_2;
reg rgmii_tx_ctl_1;
reg rgmii_tx_ctl_2;

reg gmii_clk_en;

always @* begin
    if (speed == 2'b00) begin
        // 10M
        rgmii_txd_1 = mac_gmii_txd[3:0];
        rgmii_txd_2 = mac_gmii_txd[3:0];
        if (rgmii_tx_clk_2) begin
            rgmii_tx_ctl_1 = mac_gmii_tx_en;
            rgmii_tx_ctl_2 = mac_gmii_tx_en;
        end else begin
            rgmii_tx_ctl_1 = mac_gmii_tx_en ^ mac_gmii_tx_er;
            rgmii_tx_ctl_2 = mac_gmii_tx_en ^ mac_gmii_tx_er;
        end
        gmii_clk_en = rgmii_tx_clk_fall;
    end else if (speed == 2'b01) begin
        // 100M
        rgmii_txd_1 = mac_gmii_txd[3:0];
        rgmii_txd_2 = mac_gmii_txd[3:0];
        if (rgmii_tx_clk_2) begin
            rgmii_tx_ctl_1 = mac_gmii_tx_en;
            rgmii_tx_ctl_2 = mac_gmii_tx_en;
        end else begin
            rgmii_tx_ctl_1 = mac_gmii_tx_en ^ mac_gmii_tx_er;
            rgmii_tx_ctl_2 = mac_gmii_tx_en ^ mac_gmii_tx_er;
        end
        gmii_clk_en = rgmii_tx_clk_fall;
    end else begin
        // 1000M
        rgmii_txd_1 = mac_gmii_txd[3:0];
        rgmii_txd_2 = mac_gmii_txd[7:4];
        rgmii_tx_ctl_1 = mac_gmii_tx_en;
        rgmii_tx_ctl_2 = mac_gmii_tx_en ^ mac_gmii_tx_er;
        gmii_clk_en = 1;
    end
end

wire phy_rgmii_tx_clk_new;
wire [3:0] phy_rgmii_txd_new;
wire phy_rgmii_tx_ctl_new;

oddr #(
    .WIDTH(1)
)
clk_oddr_inst (
    .clk(clk),
    .d1(rgmii_tx_clk_1),
    .d2(rgmii_tx_clk_2),
    .q(phy_rgmii_tx_clk)
);

oddr #(
    .WIDTH(5)
)
data_oddr_inst (
    .clk(clk),
    .d1({rgmii_txd_1, rgmii_tx_ctl_1}),
    .d2({rgmii_txd_2, rgmii_tx_ctl_2}),
    .q({phy_rgmii_txd, phy_rgmii_tx_ctl})
);

assign mac_gmii_tx_clk = clk;

assign mac_gmii_tx_clk_en = gmii_clk_en;

// reset sync
reg [3:0] tx_rst_reg = 4'hf;
assign mac_gmii_tx_rst = tx_rst_reg[0];

always @(posedge mac_gmii_tx_clk or posedge rst) begin
    if (rst) begin
        tx_rst_reg <= 4'hf;
    end else begin
        tx_rst_reg <= {1'b0, tx_rst_reg[3:1]};
    end
end

reg [3:0] rx_rst_reg = 4'hf;
assign mac_gmii_rx_rst = rx_rst_reg[0];

always @(posedge mac_gmii_rx_clk or posedge rst) begin
    if (rst) begin
        rx_rst_reg <= 4'hf;
    end else begin
        rx_rst_reg <= {1'b0, rx_rst_reg[3:1]};
    end
end

endmodule
