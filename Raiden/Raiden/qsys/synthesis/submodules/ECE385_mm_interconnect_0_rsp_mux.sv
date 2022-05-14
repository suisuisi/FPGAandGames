// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/18.1std/ip/merlin/altera_merlin_multiplexer/altera_merlin_multiplexer.sv.terp#1 $
// $Revision: #1 $
// $Date: 2018/07/18 $
// $Author: psgswbuild $

// ------------------------------------------
// Merlin Multiplexer
// ------------------------------------------

`timescale 1 ns / 1 ns


// ------------------------------------------
// Generation parameters:
//   output_name:         ECE385_mm_interconnect_0_rsp_mux
//   NUM_INPUTS:          34
//   ARBITRATION_SHARES:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
//   ARBITRATION_SCHEME   "no-arb"
//   PIPELINE_ARB:        0
//   PKT_TRANS_LOCK:      72 (arbitration locking enabled)
//   ST_DATA_W:           114
//   ST_CHANNEL_W:        34
// ------------------------------------------

module ECE385_mm_interconnect_0_rsp_mux
(
    // ----------------------
    // Sinks
    // ----------------------
    input                       sink0_valid,
    input [114-1   : 0]  sink0_data,
    input [34-1: 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,
    output                      sink0_ready,

    input                       sink1_valid,
    input [114-1   : 0]  sink1_data,
    input [34-1: 0]  sink1_channel,
    input                       sink1_startofpacket,
    input                       sink1_endofpacket,
    output                      sink1_ready,

    input                       sink2_valid,
    input [114-1   : 0]  sink2_data,
    input [34-1: 0]  sink2_channel,
    input                       sink2_startofpacket,
    input                       sink2_endofpacket,
    output                      sink2_ready,

    input                       sink3_valid,
    input [114-1   : 0]  sink3_data,
    input [34-1: 0]  sink3_channel,
    input                       sink3_startofpacket,
    input                       sink3_endofpacket,
    output                      sink3_ready,

    input                       sink4_valid,
    input [114-1   : 0]  sink4_data,
    input [34-1: 0]  sink4_channel,
    input                       sink4_startofpacket,
    input                       sink4_endofpacket,
    output                      sink4_ready,

    input                       sink5_valid,
    input [114-1   : 0]  sink5_data,
    input [34-1: 0]  sink5_channel,
    input                       sink5_startofpacket,
    input                       sink5_endofpacket,
    output                      sink5_ready,

    input                       sink6_valid,
    input [114-1   : 0]  sink6_data,
    input [34-1: 0]  sink6_channel,
    input                       sink6_startofpacket,
    input                       sink6_endofpacket,
    output                      sink6_ready,

    input                       sink7_valid,
    input [114-1   : 0]  sink7_data,
    input [34-1: 0]  sink7_channel,
    input                       sink7_startofpacket,
    input                       sink7_endofpacket,
    output                      sink7_ready,

    input                       sink8_valid,
    input [114-1   : 0]  sink8_data,
    input [34-1: 0]  sink8_channel,
    input                       sink8_startofpacket,
    input                       sink8_endofpacket,
    output                      sink8_ready,

    input                       sink9_valid,
    input [114-1   : 0]  sink9_data,
    input [34-1: 0]  sink9_channel,
    input                       sink9_startofpacket,
    input                       sink9_endofpacket,
    output                      sink9_ready,

    input                       sink10_valid,
    input [114-1   : 0]  sink10_data,
    input [34-1: 0]  sink10_channel,
    input                       sink10_startofpacket,
    input                       sink10_endofpacket,
    output                      sink10_ready,

    input                       sink11_valid,
    input [114-1   : 0]  sink11_data,
    input [34-1: 0]  sink11_channel,
    input                       sink11_startofpacket,
    input                       sink11_endofpacket,
    output                      sink11_ready,

    input                       sink12_valid,
    input [114-1   : 0]  sink12_data,
    input [34-1: 0]  sink12_channel,
    input                       sink12_startofpacket,
    input                       sink12_endofpacket,
    output                      sink12_ready,

    input                       sink13_valid,
    input [114-1   : 0]  sink13_data,
    input [34-1: 0]  sink13_channel,
    input                       sink13_startofpacket,
    input                       sink13_endofpacket,
    output                      sink13_ready,

    input                       sink14_valid,
    input [114-1   : 0]  sink14_data,
    input [34-1: 0]  sink14_channel,
    input                       sink14_startofpacket,
    input                       sink14_endofpacket,
    output                      sink14_ready,

    input                       sink15_valid,
    input [114-1   : 0]  sink15_data,
    input [34-1: 0]  sink15_channel,
    input                       sink15_startofpacket,
    input                       sink15_endofpacket,
    output                      sink15_ready,

    input                       sink16_valid,
    input [114-1   : 0]  sink16_data,
    input [34-1: 0]  sink16_channel,
    input                       sink16_startofpacket,
    input                       sink16_endofpacket,
    output                      sink16_ready,

    input                       sink17_valid,
    input [114-1   : 0]  sink17_data,
    input [34-1: 0]  sink17_channel,
    input                       sink17_startofpacket,
    input                       sink17_endofpacket,
    output                      sink17_ready,

    input                       sink18_valid,
    input [114-1   : 0]  sink18_data,
    input [34-1: 0]  sink18_channel,
    input                       sink18_startofpacket,
    input                       sink18_endofpacket,
    output                      sink18_ready,

    input                       sink19_valid,
    input [114-1   : 0]  sink19_data,
    input [34-1: 0]  sink19_channel,
    input                       sink19_startofpacket,
    input                       sink19_endofpacket,
    output                      sink19_ready,

    input                       sink20_valid,
    input [114-1   : 0]  sink20_data,
    input [34-1: 0]  sink20_channel,
    input                       sink20_startofpacket,
    input                       sink20_endofpacket,
    output                      sink20_ready,

    input                       sink21_valid,
    input [114-1   : 0]  sink21_data,
    input [34-1: 0]  sink21_channel,
    input                       sink21_startofpacket,
    input                       sink21_endofpacket,
    output                      sink21_ready,

    input                       sink22_valid,
    input [114-1   : 0]  sink22_data,
    input [34-1: 0]  sink22_channel,
    input                       sink22_startofpacket,
    input                       sink22_endofpacket,
    output                      sink22_ready,

    input                       sink23_valid,
    input [114-1   : 0]  sink23_data,
    input [34-1: 0]  sink23_channel,
    input                       sink23_startofpacket,
    input                       sink23_endofpacket,
    output                      sink23_ready,

    input                       sink24_valid,
    input [114-1   : 0]  sink24_data,
    input [34-1: 0]  sink24_channel,
    input                       sink24_startofpacket,
    input                       sink24_endofpacket,
    output                      sink24_ready,

    input                       sink25_valid,
    input [114-1   : 0]  sink25_data,
    input [34-1: 0]  sink25_channel,
    input                       sink25_startofpacket,
    input                       sink25_endofpacket,
    output                      sink25_ready,

    input                       sink26_valid,
    input [114-1   : 0]  sink26_data,
    input [34-1: 0]  sink26_channel,
    input                       sink26_startofpacket,
    input                       sink26_endofpacket,
    output                      sink26_ready,

    input                       sink27_valid,
    input [114-1   : 0]  sink27_data,
    input [34-1: 0]  sink27_channel,
    input                       sink27_startofpacket,
    input                       sink27_endofpacket,
    output                      sink27_ready,

    input                       sink28_valid,
    input [114-1   : 0]  sink28_data,
    input [34-1: 0]  sink28_channel,
    input                       sink28_startofpacket,
    input                       sink28_endofpacket,
    output                      sink28_ready,

    input                       sink29_valid,
    input [114-1   : 0]  sink29_data,
    input [34-1: 0]  sink29_channel,
    input                       sink29_startofpacket,
    input                       sink29_endofpacket,
    output                      sink29_ready,

    input                       sink30_valid,
    input [114-1   : 0]  sink30_data,
    input [34-1: 0]  sink30_channel,
    input                       sink30_startofpacket,
    input                       sink30_endofpacket,
    output                      sink30_ready,

    input                       sink31_valid,
    input [114-1   : 0]  sink31_data,
    input [34-1: 0]  sink31_channel,
    input                       sink31_startofpacket,
    input                       sink31_endofpacket,
    output                      sink31_ready,

    input                       sink32_valid,
    input [114-1   : 0]  sink32_data,
    input [34-1: 0]  sink32_channel,
    input                       sink32_startofpacket,
    input                       sink32_endofpacket,
    output                      sink32_ready,

    input                       sink33_valid,
    input [114-1   : 0]  sink33_data,
    input [34-1: 0]  sink33_channel,
    input                       sink33_startofpacket,
    input                       sink33_endofpacket,
    output                      sink33_ready,


    // ----------------------
    // Source
    // ----------------------
    output                      src_valid,
    output [114-1    : 0] src_data,
    output [34-1 : 0] src_channel,
    output                      src_startofpacket,
    output                      src_endofpacket,
    input                       src_ready,

    // ----------------------
    // Clock & Reset
    // ----------------------
    input clk,
    input reset
);
    localparam PAYLOAD_W        = 114 + 34 + 2;
    localparam NUM_INPUTS       = 34;
    localparam SHARE_COUNTER_W  = 1;
    localparam PIPELINE_ARB     = 0;
    localparam ST_DATA_W        = 114;
    localparam ST_CHANNEL_W     = 34;
    localparam PKT_TRANS_LOCK   = 72;

    // ------------------------------------------
    // Signals
    // ------------------------------------------
    wire [NUM_INPUTS - 1 : 0]      request;
    wire [NUM_INPUTS - 1 : 0]      valid;
    wire [NUM_INPUTS - 1 : 0]      grant;
    wire [NUM_INPUTS - 1 : 0]      next_grant;
    reg [NUM_INPUTS - 1 : 0]       saved_grant;
    reg [PAYLOAD_W - 1 : 0]        src_payload;
    wire                           last_cycle;
    reg                            packet_in_progress;
    reg                            update_grant;

    wire [PAYLOAD_W - 1 : 0] sink0_payload;
    wire [PAYLOAD_W - 1 : 0] sink1_payload;
    wire [PAYLOAD_W - 1 : 0] sink2_payload;
    wire [PAYLOAD_W - 1 : 0] sink3_payload;
    wire [PAYLOAD_W - 1 : 0] sink4_payload;
    wire [PAYLOAD_W - 1 : 0] sink5_payload;
    wire [PAYLOAD_W - 1 : 0] sink6_payload;
    wire [PAYLOAD_W - 1 : 0] sink7_payload;
    wire [PAYLOAD_W - 1 : 0] sink8_payload;
    wire [PAYLOAD_W - 1 : 0] sink9_payload;
    wire [PAYLOAD_W - 1 : 0] sink10_payload;
    wire [PAYLOAD_W - 1 : 0] sink11_payload;
    wire [PAYLOAD_W - 1 : 0] sink12_payload;
    wire [PAYLOAD_W - 1 : 0] sink13_payload;
    wire [PAYLOAD_W - 1 : 0] sink14_payload;
    wire [PAYLOAD_W - 1 : 0] sink15_payload;
    wire [PAYLOAD_W - 1 : 0] sink16_payload;
    wire [PAYLOAD_W - 1 : 0] sink17_payload;
    wire [PAYLOAD_W - 1 : 0] sink18_payload;
    wire [PAYLOAD_W - 1 : 0] sink19_payload;
    wire [PAYLOAD_W - 1 : 0] sink20_payload;
    wire [PAYLOAD_W - 1 : 0] sink21_payload;
    wire [PAYLOAD_W - 1 : 0] sink22_payload;
    wire [PAYLOAD_W - 1 : 0] sink23_payload;
    wire [PAYLOAD_W - 1 : 0] sink24_payload;
    wire [PAYLOAD_W - 1 : 0] sink25_payload;
    wire [PAYLOAD_W - 1 : 0] sink26_payload;
    wire [PAYLOAD_W - 1 : 0] sink27_payload;
    wire [PAYLOAD_W - 1 : 0] sink28_payload;
    wire [PAYLOAD_W - 1 : 0] sink29_payload;
    wire [PAYLOAD_W - 1 : 0] sink30_payload;
    wire [PAYLOAD_W - 1 : 0] sink31_payload;
    wire [PAYLOAD_W - 1 : 0] sink32_payload;
    wire [PAYLOAD_W - 1 : 0] sink33_payload;

    assign valid[0] = sink0_valid;
    assign valid[1] = sink1_valid;
    assign valid[2] = sink2_valid;
    assign valid[3] = sink3_valid;
    assign valid[4] = sink4_valid;
    assign valid[5] = sink5_valid;
    assign valid[6] = sink6_valid;
    assign valid[7] = sink7_valid;
    assign valid[8] = sink8_valid;
    assign valid[9] = sink9_valid;
    assign valid[10] = sink10_valid;
    assign valid[11] = sink11_valid;
    assign valid[12] = sink12_valid;
    assign valid[13] = sink13_valid;
    assign valid[14] = sink14_valid;
    assign valid[15] = sink15_valid;
    assign valid[16] = sink16_valid;
    assign valid[17] = sink17_valid;
    assign valid[18] = sink18_valid;
    assign valid[19] = sink19_valid;
    assign valid[20] = sink20_valid;
    assign valid[21] = sink21_valid;
    assign valid[22] = sink22_valid;
    assign valid[23] = sink23_valid;
    assign valid[24] = sink24_valid;
    assign valid[25] = sink25_valid;
    assign valid[26] = sink26_valid;
    assign valid[27] = sink27_valid;
    assign valid[28] = sink28_valid;
    assign valid[29] = sink29_valid;
    assign valid[30] = sink30_valid;
    assign valid[31] = sink31_valid;
    assign valid[32] = sink32_valid;
    assign valid[33] = sink33_valid;


    // ------------------------------------------
    // ------------------------------------------
    // Grant Logic & Updates
    // ------------------------------------------
    // ------------------------------------------
    reg [NUM_INPUTS - 1 : 0] lock;
    always @* begin
      lock[0] = sink0_data[72];
      lock[1] = sink1_data[72];
      lock[2] = sink2_data[72];
      lock[3] = sink3_data[72];
      lock[4] = sink4_data[72];
      lock[5] = sink5_data[72];
      lock[6] = sink6_data[72];
      lock[7] = sink7_data[72];
      lock[8] = sink8_data[72];
      lock[9] = sink9_data[72];
      lock[10] = sink10_data[72];
      lock[11] = sink11_data[72];
      lock[12] = sink12_data[72];
      lock[13] = sink13_data[72];
      lock[14] = sink14_data[72];
      lock[15] = sink15_data[72];
      lock[16] = sink16_data[72];
      lock[17] = sink17_data[72];
      lock[18] = sink18_data[72];
      lock[19] = sink19_data[72];
      lock[20] = sink20_data[72];
      lock[21] = sink21_data[72];
      lock[22] = sink22_data[72];
      lock[23] = sink23_data[72];
      lock[24] = sink24_data[72];
      lock[25] = sink25_data[72];
      lock[26] = sink26_data[72];
      lock[27] = sink27_data[72];
      lock[28] = sink28_data[72];
      lock[29] = sink29_data[72];
      lock[30] = sink30_data[72];
      lock[31] = sink31_data[72];
      lock[32] = sink32_data[72];
      lock[33] = sink33_data[72];
    end

    assign last_cycle = src_valid & src_ready & src_endofpacket & ~(|(lock & grant));

    // ------------------------------------------
    // We're working on a packet at any time valid is high, except
    // when this is the endofpacket.
    // ------------------------------------------
    always @(posedge clk or posedge reset) begin
      if (reset) begin
        packet_in_progress <= 1'b0;
      end
      else begin
        if (last_cycle)
          packet_in_progress <= 1'b0; 
        else if (src_valid)
          packet_in_progress <= 1'b1;
      end
    end


    // ------------------------------------------
    // Shares
    //
    // Special case: all-equal shares _should_ be optimized into assigning a
    // constant to next_grant_share.
    // Special case: all-1's shares _should_ result in the share counter
    // being optimized away.
    // ------------------------------------------
    // Input  |  arb shares  |  counter load value
    // 0      |      1       |  0
    // 1      |      1       |  0
    // 2      |      1       |  0
    // 3      |      1       |  0
    // 4      |      1       |  0
    // 5      |      1       |  0
    // 6      |      1       |  0
    // 7      |      1       |  0
    // 8      |      1       |  0
    // 9      |      1       |  0
    // 10      |      1       |  0
    // 11      |      1       |  0
    // 12      |      1       |  0
    // 13      |      1       |  0
    // 14      |      1       |  0
    // 15      |      1       |  0
    // 16      |      1       |  0
    // 17      |      1       |  0
    // 18      |      1       |  0
    // 19      |      1       |  0
    // 20      |      1       |  0
    // 21      |      1       |  0
    // 22      |      1       |  0
    // 23      |      1       |  0
    // 24      |      1       |  0
    // 25      |      1       |  0
    // 26      |      1       |  0
    // 27      |      1       |  0
    // 28      |      1       |  0
    // 29      |      1       |  0
    // 30      |      1       |  0
    // 31      |      1       |  0
    // 32      |      1       |  0
    // 33      |      1       |  0
     wire [SHARE_COUNTER_W - 1 : 0] share_0 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_1 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_2 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_3 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_4 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_5 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_6 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_7 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_8 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_9 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_10 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_11 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_12 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_13 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_14 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_15 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_16 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_17 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_18 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_19 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_20 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_21 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_22 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_23 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_24 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_25 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_26 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_27 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_28 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_29 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_30 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_31 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_32 = 1'd0;
     wire [SHARE_COUNTER_W - 1 : 0] share_33 = 1'd0;

    // ------------------------------------------
    // Choose the share value corresponding to the grant.
    // ------------------------------------------
    reg [SHARE_COUNTER_W - 1 : 0] next_grant_share;
    always @* begin
      next_grant_share =
    share_0 & { SHARE_COUNTER_W {next_grant[0]} } |
    share_1 & { SHARE_COUNTER_W {next_grant[1]} } |
    share_2 & { SHARE_COUNTER_W {next_grant[2]} } |
    share_3 & { SHARE_COUNTER_W {next_grant[3]} } |
    share_4 & { SHARE_COUNTER_W {next_grant[4]} } |
    share_5 & { SHARE_COUNTER_W {next_grant[5]} } |
    share_6 & { SHARE_COUNTER_W {next_grant[6]} } |
    share_7 & { SHARE_COUNTER_W {next_grant[7]} } |
    share_8 & { SHARE_COUNTER_W {next_grant[8]} } |
    share_9 & { SHARE_COUNTER_W {next_grant[9]} } |
    share_10 & { SHARE_COUNTER_W {next_grant[10]} } |
    share_11 & { SHARE_COUNTER_W {next_grant[11]} } |
    share_12 & { SHARE_COUNTER_W {next_grant[12]} } |
    share_13 & { SHARE_COUNTER_W {next_grant[13]} } |
    share_14 & { SHARE_COUNTER_W {next_grant[14]} } |
    share_15 & { SHARE_COUNTER_W {next_grant[15]} } |
    share_16 & { SHARE_COUNTER_W {next_grant[16]} } |
    share_17 & { SHARE_COUNTER_W {next_grant[17]} } |
    share_18 & { SHARE_COUNTER_W {next_grant[18]} } |
    share_19 & { SHARE_COUNTER_W {next_grant[19]} } |
    share_20 & { SHARE_COUNTER_W {next_grant[20]} } |
    share_21 & { SHARE_COUNTER_W {next_grant[21]} } |
    share_22 & { SHARE_COUNTER_W {next_grant[22]} } |
    share_23 & { SHARE_COUNTER_W {next_grant[23]} } |
    share_24 & { SHARE_COUNTER_W {next_grant[24]} } |
    share_25 & { SHARE_COUNTER_W {next_grant[25]} } |
    share_26 & { SHARE_COUNTER_W {next_grant[26]} } |
    share_27 & { SHARE_COUNTER_W {next_grant[27]} } |
    share_28 & { SHARE_COUNTER_W {next_grant[28]} } |
    share_29 & { SHARE_COUNTER_W {next_grant[29]} } |
    share_30 & { SHARE_COUNTER_W {next_grant[30]} } |
    share_31 & { SHARE_COUNTER_W {next_grant[31]} } |
    share_32 & { SHARE_COUNTER_W {next_grant[32]} } |
    share_33 & { SHARE_COUNTER_W {next_grant[33]} };
    end

    // ------------------------------------------
    // Flag to indicate first packet of an arb sequence.
    // ------------------------------------------
    wire grant_changed = ~packet_in_progress && ~(|(saved_grant & valid));
    reg first_packet_r;
    wire first_packet = grant_changed | first_packet_r;
    always @(posedge clk or posedge reset) begin
      if (reset) begin
        first_packet_r <= 1'b0;
      end
      else begin 
        if (update_grant)
          first_packet_r <= 1'b1;
        else if (last_cycle)
          first_packet_r <= 1'b0;
        else if (grant_changed)
          first_packet_r <= 1'b1;
      end
    end

    // ------------------------------------------
    // Compute the next share-count value.
    // ------------------------------------------
    reg [SHARE_COUNTER_W - 1 : 0] p1_share_count;
    reg [SHARE_COUNTER_W - 1 : 0] share_count;
    reg share_count_zero_flag;

    always @* begin
      if (first_packet) begin
        p1_share_count = next_grant_share;
      end
      else begin
            // Update the counter, but don't decrement below 0.
        p1_share_count = share_count_zero_flag ? '0 : share_count - 1'b1;
      end
     end

    // ------------------------------------------
    // Update the share counter and share-counter=zero flag.
    // ------------------------------------------
    always @(posedge clk or posedge reset) begin
      if (reset) begin
        share_count <= '0;
        share_count_zero_flag <= 1'b1;
      end
      else begin
        if (last_cycle) begin
          share_count <= p1_share_count;
          share_count_zero_flag <= (p1_share_count == '0);
        end
      end
    end

    // ------------------------------------------
    // For each input, maintain a final_packet signal which goes active for the
    // last packet of a full-share packet sequence.  Example: if I have 4
    // shares and I'm continuously requesting, final_packet is active in the
    // 4th packet.
    // ------------------------------------------
    wire final_packet_0 = 1'b1;

    wire final_packet_1 = 1'b1;

    wire final_packet_2 = 1'b1;

    wire final_packet_3 = 1'b1;

    wire final_packet_4 = 1'b1;

    wire final_packet_5 = 1'b1;

    wire final_packet_6 = 1'b1;

    wire final_packet_7 = 1'b1;

    wire final_packet_8 = 1'b1;

    wire final_packet_9 = 1'b1;

    wire final_packet_10 = 1'b1;

    wire final_packet_11 = 1'b1;

    wire final_packet_12 = 1'b1;

    wire final_packet_13 = 1'b1;

    wire final_packet_14 = 1'b1;

    wire final_packet_15 = 1'b1;

    wire final_packet_16 = 1'b1;

    wire final_packet_17 = 1'b1;

    wire final_packet_18 = 1'b1;

    wire final_packet_19 = 1'b1;

    wire final_packet_20 = 1'b1;

    wire final_packet_21 = 1'b1;

    wire final_packet_22 = 1'b1;

    wire final_packet_23 = 1'b1;

    wire final_packet_24 = 1'b1;

    wire final_packet_25 = 1'b1;

    wire final_packet_26 = 1'b1;

    wire final_packet_27 = 1'b1;

    wire final_packet_28 = 1'b1;

    wire final_packet_29 = 1'b1;

    wire final_packet_30 = 1'b1;

    wire final_packet_31 = 1'b1;

    wire final_packet_32 = 1'b1;

    wire final_packet_33 = 1'b1;


    // ------------------------------------------
    // Concatenate all final_packet signals (wire or reg) into a handy vector.
    // ------------------------------------------
    wire [NUM_INPUTS - 1 : 0] final_packet = {
    final_packet_33,
    final_packet_32,
    final_packet_31,
    final_packet_30,
    final_packet_29,
    final_packet_28,
    final_packet_27,
    final_packet_26,
    final_packet_25,
    final_packet_24,
    final_packet_23,
    final_packet_22,
    final_packet_21,
    final_packet_20,
    final_packet_19,
    final_packet_18,
    final_packet_17,
    final_packet_16,
    final_packet_15,
    final_packet_14,
    final_packet_13,
    final_packet_12,
    final_packet_11,
    final_packet_10,
    final_packet_9,
    final_packet_8,
    final_packet_7,
    final_packet_6,
    final_packet_5,
    final_packet_4,
    final_packet_3,
    final_packet_2,
    final_packet_1,
    final_packet_0
    };

    // ------------------------------------------
    // ------------------------------------------
    wire p1_done = |(final_packet & grant);

    // ------------------------------------------
    // Flag for the first cycle of packets within an 
    // arb sequence
    // ------------------------------------------
    reg first_cycle;
    always @(posedge clk, posedge reset) begin
      if (reset)
        first_cycle <= 0;
      else
        first_cycle <= last_cycle && ~p1_done;
    end


    always @* begin
      update_grant = 0;

        // ------------------------------------------
        // No arbitration pipeline, update grant whenever
        // the current arb winner has consumed all shares,
        // or all requests are low
        // ------------------------------------------
  update_grant = (last_cycle && p1_done) || (first_cycle && ~(|valid));
  update_grant = last_cycle;
    end

    wire save_grant;
    assign save_grant = 1;
    assign grant = next_grant;

    always @(posedge clk, posedge reset) begin
      if (reset)
        saved_grant <= '0;
      else if (save_grant)
        saved_grant <= next_grant;
    end

    // ------------------------------------------
    // ------------------------------------------
    // Arbitrator
    // ------------------------------------------
    // ------------------------------------------

    // ------------------------------------------
    // Create a request vector that stays high during
    // the packet for unpipelined arbitration.
    //
    // The pipelined arbitration scheme does not require
    // request to be held high during the packet.
    // ------------------------------------------
    assign request = valid;

    wire [NUM_INPUTS - 1 : 0] next_grant_from_arb;
                               
    altera_merlin_arbitrator
    #(
    .NUM_REQUESTERS(NUM_INPUTS),
    .SCHEME ("no-arb"),
    .PIPELINE (0)
    ) arb (
    .clk (clk),
    .reset (reset),
    .request (request),
    .grant (next_grant_from_arb),
    .save_top_priority (src_valid),
    .increment_top_priority (update_grant)
    );

   assign next_grant = next_grant_from_arb;
                         
    // ------------------------------------------
    // ------------------------------------------
    // Mux
    //
    // Implemented as a sum of products.
    // ------------------------------------------
    // ------------------------------------------

    assign sink0_ready = src_ready && grant[0];
    assign sink1_ready = src_ready && grant[1];
    assign sink2_ready = src_ready && grant[2];
    assign sink3_ready = src_ready && grant[3];
    assign sink4_ready = src_ready && grant[4];
    assign sink5_ready = src_ready && grant[5];
    assign sink6_ready = src_ready && grant[6];
    assign sink7_ready = src_ready && grant[7];
    assign sink8_ready = src_ready && grant[8];
    assign sink9_ready = src_ready && grant[9];
    assign sink10_ready = src_ready && grant[10];
    assign sink11_ready = src_ready && grant[11];
    assign sink12_ready = src_ready && grant[12];
    assign sink13_ready = src_ready && grant[13];
    assign sink14_ready = src_ready && grant[14];
    assign sink15_ready = src_ready && grant[15];
    assign sink16_ready = src_ready && grant[16];
    assign sink17_ready = src_ready && grant[17];
    assign sink18_ready = src_ready && grant[18];
    assign sink19_ready = src_ready && grant[19];
    assign sink20_ready = src_ready && grant[20];
    assign sink21_ready = src_ready && grant[21];
    assign sink22_ready = src_ready && grant[22];
    assign sink23_ready = src_ready && grant[23];
    assign sink24_ready = src_ready && grant[24];
    assign sink25_ready = src_ready && grant[25];
    assign sink26_ready = src_ready && grant[26];
    assign sink27_ready = src_ready && grant[27];
    assign sink28_ready = src_ready && grant[28];
    assign sink29_ready = src_ready && grant[29];
    assign sink30_ready = src_ready && grant[30];
    assign sink31_ready = src_ready && grant[31];
    assign sink32_ready = src_ready && grant[32];
    assign sink33_ready = src_ready && grant[33];

    assign src_valid = |(grant & valid);

    always @* begin
      src_payload =
      sink0_payload & {PAYLOAD_W {grant[0]} } |
      sink1_payload & {PAYLOAD_W {grant[1]} } |
      sink2_payload & {PAYLOAD_W {grant[2]} } |
      sink3_payload & {PAYLOAD_W {grant[3]} } |
      sink4_payload & {PAYLOAD_W {grant[4]} } |
      sink5_payload & {PAYLOAD_W {grant[5]} } |
      sink6_payload & {PAYLOAD_W {grant[6]} } |
      sink7_payload & {PAYLOAD_W {grant[7]} } |
      sink8_payload & {PAYLOAD_W {grant[8]} } |
      sink9_payload & {PAYLOAD_W {grant[9]} } |
      sink10_payload & {PAYLOAD_W {grant[10]} } |
      sink11_payload & {PAYLOAD_W {grant[11]} } |
      sink12_payload & {PAYLOAD_W {grant[12]} } |
      sink13_payload & {PAYLOAD_W {grant[13]} } |
      sink14_payload & {PAYLOAD_W {grant[14]} } |
      sink15_payload & {PAYLOAD_W {grant[15]} } |
      sink16_payload & {PAYLOAD_W {grant[16]} } |
      sink17_payload & {PAYLOAD_W {grant[17]} } |
      sink18_payload & {PAYLOAD_W {grant[18]} } |
      sink19_payload & {PAYLOAD_W {grant[19]} } |
      sink20_payload & {PAYLOAD_W {grant[20]} } |
      sink21_payload & {PAYLOAD_W {grant[21]} } |
      sink22_payload & {PAYLOAD_W {grant[22]} } |
      sink23_payload & {PAYLOAD_W {grant[23]} } |
      sink24_payload & {PAYLOAD_W {grant[24]} } |
      sink25_payload & {PAYLOAD_W {grant[25]} } |
      sink26_payload & {PAYLOAD_W {grant[26]} } |
      sink27_payload & {PAYLOAD_W {grant[27]} } |
      sink28_payload & {PAYLOAD_W {grant[28]} } |
      sink29_payload & {PAYLOAD_W {grant[29]} } |
      sink30_payload & {PAYLOAD_W {grant[30]} } |
      sink31_payload & {PAYLOAD_W {grant[31]} } |
      sink32_payload & {PAYLOAD_W {grant[32]} } |
      sink33_payload & {PAYLOAD_W {grant[33]} };
    end

    // ------------------------------------------
    // Mux Payload Mapping
    // ------------------------------------------

    assign sink0_payload = {sink0_channel,sink0_data,
    sink0_startofpacket,sink0_endofpacket};
    assign sink1_payload = {sink1_channel,sink1_data,
    sink1_startofpacket,sink1_endofpacket};
    assign sink2_payload = {sink2_channel,sink2_data,
    sink2_startofpacket,sink2_endofpacket};
    assign sink3_payload = {sink3_channel,sink3_data,
    sink3_startofpacket,sink3_endofpacket};
    assign sink4_payload = {sink4_channel,sink4_data,
    sink4_startofpacket,sink4_endofpacket};
    assign sink5_payload = {sink5_channel,sink5_data,
    sink5_startofpacket,sink5_endofpacket};
    assign sink6_payload = {sink6_channel,sink6_data,
    sink6_startofpacket,sink6_endofpacket};
    assign sink7_payload = {sink7_channel,sink7_data,
    sink7_startofpacket,sink7_endofpacket};
    assign sink8_payload = {sink8_channel,sink8_data,
    sink8_startofpacket,sink8_endofpacket};
    assign sink9_payload = {sink9_channel,sink9_data,
    sink9_startofpacket,sink9_endofpacket};
    assign sink10_payload = {sink10_channel,sink10_data,
    sink10_startofpacket,sink10_endofpacket};
    assign sink11_payload = {sink11_channel,sink11_data,
    sink11_startofpacket,sink11_endofpacket};
    assign sink12_payload = {sink12_channel,sink12_data,
    sink12_startofpacket,sink12_endofpacket};
    assign sink13_payload = {sink13_channel,sink13_data,
    sink13_startofpacket,sink13_endofpacket};
    assign sink14_payload = {sink14_channel,sink14_data,
    sink14_startofpacket,sink14_endofpacket};
    assign sink15_payload = {sink15_channel,sink15_data,
    sink15_startofpacket,sink15_endofpacket};
    assign sink16_payload = {sink16_channel,sink16_data,
    sink16_startofpacket,sink16_endofpacket};
    assign sink17_payload = {sink17_channel,sink17_data,
    sink17_startofpacket,sink17_endofpacket};
    assign sink18_payload = {sink18_channel,sink18_data,
    sink18_startofpacket,sink18_endofpacket};
    assign sink19_payload = {sink19_channel,sink19_data,
    sink19_startofpacket,sink19_endofpacket};
    assign sink20_payload = {sink20_channel,sink20_data,
    sink20_startofpacket,sink20_endofpacket};
    assign sink21_payload = {sink21_channel,sink21_data,
    sink21_startofpacket,sink21_endofpacket};
    assign sink22_payload = {sink22_channel,sink22_data,
    sink22_startofpacket,sink22_endofpacket};
    assign sink23_payload = {sink23_channel,sink23_data,
    sink23_startofpacket,sink23_endofpacket};
    assign sink24_payload = {sink24_channel,sink24_data,
    sink24_startofpacket,sink24_endofpacket};
    assign sink25_payload = {sink25_channel,sink25_data,
    sink25_startofpacket,sink25_endofpacket};
    assign sink26_payload = {sink26_channel,sink26_data,
    sink26_startofpacket,sink26_endofpacket};
    assign sink27_payload = {sink27_channel,sink27_data,
    sink27_startofpacket,sink27_endofpacket};
    assign sink28_payload = {sink28_channel,sink28_data,
    sink28_startofpacket,sink28_endofpacket};
    assign sink29_payload = {sink29_channel,sink29_data,
    sink29_startofpacket,sink29_endofpacket};
    assign sink30_payload = {sink30_channel,sink30_data,
    sink30_startofpacket,sink30_endofpacket};
    assign sink31_payload = {sink31_channel,sink31_data,
    sink31_startofpacket,sink31_endofpacket};
    assign sink32_payload = {sink32_channel,sink32_data,
    sink32_startofpacket,sink32_endofpacket};
    assign sink33_payload = {sink33_channel,sink33_data,
    sink33_startofpacket,sink33_endofpacket};

    assign {src_channel,src_data,src_startofpacket,src_endofpacket} = src_payload;
endmodule


