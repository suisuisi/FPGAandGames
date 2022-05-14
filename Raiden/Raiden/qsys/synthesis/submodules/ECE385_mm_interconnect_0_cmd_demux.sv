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


// $Id: //acds/rel/18.1std/ip/merlin/altera_merlin_demultiplexer/altera_merlin_demultiplexer.sv.terp#1 $
// $Revision: #1 $
// $Date: 2018/07/18 $
// $Author: psgswbuild $

// -------------------------------------
// Merlin Demultiplexer
//
// Asserts valid on the appropriate output
// given a one-hot channel signal.
// -------------------------------------

`timescale 1 ns / 1 ns

// ------------------------------------------
// Generation parameters:
//   output_name:         ECE385_mm_interconnect_0_cmd_demux
//   ST_DATA_W:           114
//   ST_CHANNEL_W:        34
//   NUM_OUTPUTS:         34
//   VALID_WIDTH:         1
// ------------------------------------------

//------------------------------------------
// Message Supression Used
// QIS Warnings
// 15610 - Warning: Design contains x input pin(s) that do not drive logic
//------------------------------------------

module ECE385_mm_interconnect_0_cmd_demux
(
    // -------------------
    // Sink
    // -------------------
    input  [1-1      : 0]   sink_valid,
    input  [114-1    : 0]   sink_data, // ST_DATA_W=114
    input  [34-1 : 0]   sink_channel, // ST_CHANNEL_W=34
    input                         sink_startofpacket,
    input                         sink_endofpacket,
    output                        sink_ready,

    // -------------------
    // Sources 
    // -------------------
    output reg                      src0_valid,
    output reg [114-1    : 0] src0_data, // ST_DATA_W=114
    output reg [34-1 : 0] src0_channel, // ST_CHANNEL_W=34
    output reg                      src0_startofpacket,
    output reg                      src0_endofpacket,
    input                           src0_ready,

    output reg                      src1_valid,
    output reg [114-1    : 0] src1_data, // ST_DATA_W=114
    output reg [34-1 : 0] src1_channel, // ST_CHANNEL_W=34
    output reg                      src1_startofpacket,
    output reg                      src1_endofpacket,
    input                           src1_ready,

    output reg                      src2_valid,
    output reg [114-1    : 0] src2_data, // ST_DATA_W=114
    output reg [34-1 : 0] src2_channel, // ST_CHANNEL_W=34
    output reg                      src2_startofpacket,
    output reg                      src2_endofpacket,
    input                           src2_ready,

    output reg                      src3_valid,
    output reg [114-1    : 0] src3_data, // ST_DATA_W=114
    output reg [34-1 : 0] src3_channel, // ST_CHANNEL_W=34
    output reg                      src3_startofpacket,
    output reg                      src3_endofpacket,
    input                           src3_ready,

    output reg                      src4_valid,
    output reg [114-1    : 0] src4_data, // ST_DATA_W=114
    output reg [34-1 : 0] src4_channel, // ST_CHANNEL_W=34
    output reg                      src4_startofpacket,
    output reg                      src4_endofpacket,
    input                           src4_ready,

    output reg                      src5_valid,
    output reg [114-1    : 0] src5_data, // ST_DATA_W=114
    output reg [34-1 : 0] src5_channel, // ST_CHANNEL_W=34
    output reg                      src5_startofpacket,
    output reg                      src5_endofpacket,
    input                           src5_ready,

    output reg                      src6_valid,
    output reg [114-1    : 0] src6_data, // ST_DATA_W=114
    output reg [34-1 : 0] src6_channel, // ST_CHANNEL_W=34
    output reg                      src6_startofpacket,
    output reg                      src6_endofpacket,
    input                           src6_ready,

    output reg                      src7_valid,
    output reg [114-1    : 0] src7_data, // ST_DATA_W=114
    output reg [34-1 : 0] src7_channel, // ST_CHANNEL_W=34
    output reg                      src7_startofpacket,
    output reg                      src7_endofpacket,
    input                           src7_ready,

    output reg                      src8_valid,
    output reg [114-1    : 0] src8_data, // ST_DATA_W=114
    output reg [34-1 : 0] src8_channel, // ST_CHANNEL_W=34
    output reg                      src8_startofpacket,
    output reg                      src8_endofpacket,
    input                           src8_ready,

    output reg                      src9_valid,
    output reg [114-1    : 0] src9_data, // ST_DATA_W=114
    output reg [34-1 : 0] src9_channel, // ST_CHANNEL_W=34
    output reg                      src9_startofpacket,
    output reg                      src9_endofpacket,
    input                           src9_ready,

    output reg                      src10_valid,
    output reg [114-1    : 0] src10_data, // ST_DATA_W=114
    output reg [34-1 : 0] src10_channel, // ST_CHANNEL_W=34
    output reg                      src10_startofpacket,
    output reg                      src10_endofpacket,
    input                           src10_ready,

    output reg                      src11_valid,
    output reg [114-1    : 0] src11_data, // ST_DATA_W=114
    output reg [34-1 : 0] src11_channel, // ST_CHANNEL_W=34
    output reg                      src11_startofpacket,
    output reg                      src11_endofpacket,
    input                           src11_ready,

    output reg                      src12_valid,
    output reg [114-1    : 0] src12_data, // ST_DATA_W=114
    output reg [34-1 : 0] src12_channel, // ST_CHANNEL_W=34
    output reg                      src12_startofpacket,
    output reg                      src12_endofpacket,
    input                           src12_ready,

    output reg                      src13_valid,
    output reg [114-1    : 0] src13_data, // ST_DATA_W=114
    output reg [34-1 : 0] src13_channel, // ST_CHANNEL_W=34
    output reg                      src13_startofpacket,
    output reg                      src13_endofpacket,
    input                           src13_ready,

    output reg                      src14_valid,
    output reg [114-1    : 0] src14_data, // ST_DATA_W=114
    output reg [34-1 : 0] src14_channel, // ST_CHANNEL_W=34
    output reg                      src14_startofpacket,
    output reg                      src14_endofpacket,
    input                           src14_ready,

    output reg                      src15_valid,
    output reg [114-1    : 0] src15_data, // ST_DATA_W=114
    output reg [34-1 : 0] src15_channel, // ST_CHANNEL_W=34
    output reg                      src15_startofpacket,
    output reg                      src15_endofpacket,
    input                           src15_ready,

    output reg                      src16_valid,
    output reg [114-1    : 0] src16_data, // ST_DATA_W=114
    output reg [34-1 : 0] src16_channel, // ST_CHANNEL_W=34
    output reg                      src16_startofpacket,
    output reg                      src16_endofpacket,
    input                           src16_ready,

    output reg                      src17_valid,
    output reg [114-1    : 0] src17_data, // ST_DATA_W=114
    output reg [34-1 : 0] src17_channel, // ST_CHANNEL_W=34
    output reg                      src17_startofpacket,
    output reg                      src17_endofpacket,
    input                           src17_ready,

    output reg                      src18_valid,
    output reg [114-1    : 0] src18_data, // ST_DATA_W=114
    output reg [34-1 : 0] src18_channel, // ST_CHANNEL_W=34
    output reg                      src18_startofpacket,
    output reg                      src18_endofpacket,
    input                           src18_ready,

    output reg                      src19_valid,
    output reg [114-1    : 0] src19_data, // ST_DATA_W=114
    output reg [34-1 : 0] src19_channel, // ST_CHANNEL_W=34
    output reg                      src19_startofpacket,
    output reg                      src19_endofpacket,
    input                           src19_ready,

    output reg                      src20_valid,
    output reg [114-1    : 0] src20_data, // ST_DATA_W=114
    output reg [34-1 : 0] src20_channel, // ST_CHANNEL_W=34
    output reg                      src20_startofpacket,
    output reg                      src20_endofpacket,
    input                           src20_ready,

    output reg                      src21_valid,
    output reg [114-1    : 0] src21_data, // ST_DATA_W=114
    output reg [34-1 : 0] src21_channel, // ST_CHANNEL_W=34
    output reg                      src21_startofpacket,
    output reg                      src21_endofpacket,
    input                           src21_ready,

    output reg                      src22_valid,
    output reg [114-1    : 0] src22_data, // ST_DATA_W=114
    output reg [34-1 : 0] src22_channel, // ST_CHANNEL_W=34
    output reg                      src22_startofpacket,
    output reg                      src22_endofpacket,
    input                           src22_ready,

    output reg                      src23_valid,
    output reg [114-1    : 0] src23_data, // ST_DATA_W=114
    output reg [34-1 : 0] src23_channel, // ST_CHANNEL_W=34
    output reg                      src23_startofpacket,
    output reg                      src23_endofpacket,
    input                           src23_ready,

    output reg                      src24_valid,
    output reg [114-1    : 0] src24_data, // ST_DATA_W=114
    output reg [34-1 : 0] src24_channel, // ST_CHANNEL_W=34
    output reg                      src24_startofpacket,
    output reg                      src24_endofpacket,
    input                           src24_ready,

    output reg                      src25_valid,
    output reg [114-1    : 0] src25_data, // ST_DATA_W=114
    output reg [34-1 : 0] src25_channel, // ST_CHANNEL_W=34
    output reg                      src25_startofpacket,
    output reg                      src25_endofpacket,
    input                           src25_ready,

    output reg                      src26_valid,
    output reg [114-1    : 0] src26_data, // ST_DATA_W=114
    output reg [34-1 : 0] src26_channel, // ST_CHANNEL_W=34
    output reg                      src26_startofpacket,
    output reg                      src26_endofpacket,
    input                           src26_ready,

    output reg                      src27_valid,
    output reg [114-1    : 0] src27_data, // ST_DATA_W=114
    output reg [34-1 : 0] src27_channel, // ST_CHANNEL_W=34
    output reg                      src27_startofpacket,
    output reg                      src27_endofpacket,
    input                           src27_ready,

    output reg                      src28_valid,
    output reg [114-1    : 0] src28_data, // ST_DATA_W=114
    output reg [34-1 : 0] src28_channel, // ST_CHANNEL_W=34
    output reg                      src28_startofpacket,
    output reg                      src28_endofpacket,
    input                           src28_ready,

    output reg                      src29_valid,
    output reg [114-1    : 0] src29_data, // ST_DATA_W=114
    output reg [34-1 : 0] src29_channel, // ST_CHANNEL_W=34
    output reg                      src29_startofpacket,
    output reg                      src29_endofpacket,
    input                           src29_ready,

    output reg                      src30_valid,
    output reg [114-1    : 0] src30_data, // ST_DATA_W=114
    output reg [34-1 : 0] src30_channel, // ST_CHANNEL_W=34
    output reg                      src30_startofpacket,
    output reg                      src30_endofpacket,
    input                           src30_ready,

    output reg                      src31_valid,
    output reg [114-1    : 0] src31_data, // ST_DATA_W=114
    output reg [34-1 : 0] src31_channel, // ST_CHANNEL_W=34
    output reg                      src31_startofpacket,
    output reg                      src31_endofpacket,
    input                           src31_ready,

    output reg                      src32_valid,
    output reg [114-1    : 0] src32_data, // ST_DATA_W=114
    output reg [34-1 : 0] src32_channel, // ST_CHANNEL_W=34
    output reg                      src32_startofpacket,
    output reg                      src32_endofpacket,
    input                           src32_ready,

    output reg                      src33_valid,
    output reg [114-1    : 0] src33_data, // ST_DATA_W=114
    output reg [34-1 : 0] src33_channel, // ST_CHANNEL_W=34
    output reg                      src33_startofpacket,
    output reg                      src33_endofpacket,
    input                           src33_ready,


    // -------------------
    // Clock & Reset
    // -------------------
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) // setting message suppression on clk
    input clk,
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) // setting message suppression on reset
    input reset

);

    localparam NUM_OUTPUTS = 34;
    wire [NUM_OUTPUTS - 1 : 0] ready_vector;

    // -------------------
    // Demux
    // -------------------
    always @* begin
        src0_data          = sink_data;
        src0_startofpacket = sink_startofpacket;
        src0_endofpacket   = sink_endofpacket;
        src0_channel       = sink_channel >> NUM_OUTPUTS;

        src0_valid         = sink_channel[0] && sink_valid;

        src1_data          = sink_data;
        src1_startofpacket = sink_startofpacket;
        src1_endofpacket   = sink_endofpacket;
        src1_channel       = sink_channel >> NUM_OUTPUTS;

        src1_valid         = sink_channel[1] && sink_valid;

        src2_data          = sink_data;
        src2_startofpacket = sink_startofpacket;
        src2_endofpacket   = sink_endofpacket;
        src2_channel       = sink_channel >> NUM_OUTPUTS;

        src2_valid         = sink_channel[2] && sink_valid;

        src3_data          = sink_data;
        src3_startofpacket = sink_startofpacket;
        src3_endofpacket   = sink_endofpacket;
        src3_channel       = sink_channel >> NUM_OUTPUTS;

        src3_valid         = sink_channel[3] && sink_valid;

        src4_data          = sink_data;
        src4_startofpacket = sink_startofpacket;
        src4_endofpacket   = sink_endofpacket;
        src4_channel       = sink_channel >> NUM_OUTPUTS;

        src4_valid         = sink_channel[4] && sink_valid;

        src5_data          = sink_data;
        src5_startofpacket = sink_startofpacket;
        src5_endofpacket   = sink_endofpacket;
        src5_channel       = sink_channel >> NUM_OUTPUTS;

        src5_valid         = sink_channel[5] && sink_valid;

        src6_data          = sink_data;
        src6_startofpacket = sink_startofpacket;
        src6_endofpacket   = sink_endofpacket;
        src6_channel       = sink_channel >> NUM_OUTPUTS;

        src6_valid         = sink_channel[6] && sink_valid;

        src7_data          = sink_data;
        src7_startofpacket = sink_startofpacket;
        src7_endofpacket   = sink_endofpacket;
        src7_channel       = sink_channel >> NUM_OUTPUTS;

        src7_valid         = sink_channel[7] && sink_valid;

        src8_data          = sink_data;
        src8_startofpacket = sink_startofpacket;
        src8_endofpacket   = sink_endofpacket;
        src8_channel       = sink_channel >> NUM_OUTPUTS;

        src8_valid         = sink_channel[8] && sink_valid;

        src9_data          = sink_data;
        src9_startofpacket = sink_startofpacket;
        src9_endofpacket   = sink_endofpacket;
        src9_channel       = sink_channel >> NUM_OUTPUTS;

        src9_valid         = sink_channel[9] && sink_valid;

        src10_data          = sink_data;
        src10_startofpacket = sink_startofpacket;
        src10_endofpacket   = sink_endofpacket;
        src10_channel       = sink_channel >> NUM_OUTPUTS;

        src10_valid         = sink_channel[10] && sink_valid;

        src11_data          = sink_data;
        src11_startofpacket = sink_startofpacket;
        src11_endofpacket   = sink_endofpacket;
        src11_channel       = sink_channel >> NUM_OUTPUTS;

        src11_valid         = sink_channel[11] && sink_valid;

        src12_data          = sink_data;
        src12_startofpacket = sink_startofpacket;
        src12_endofpacket   = sink_endofpacket;
        src12_channel       = sink_channel >> NUM_OUTPUTS;

        src12_valid         = sink_channel[12] && sink_valid;

        src13_data          = sink_data;
        src13_startofpacket = sink_startofpacket;
        src13_endofpacket   = sink_endofpacket;
        src13_channel       = sink_channel >> NUM_OUTPUTS;

        src13_valid         = sink_channel[13] && sink_valid;

        src14_data          = sink_data;
        src14_startofpacket = sink_startofpacket;
        src14_endofpacket   = sink_endofpacket;
        src14_channel       = sink_channel >> NUM_OUTPUTS;

        src14_valid         = sink_channel[14] && sink_valid;

        src15_data          = sink_data;
        src15_startofpacket = sink_startofpacket;
        src15_endofpacket   = sink_endofpacket;
        src15_channel       = sink_channel >> NUM_OUTPUTS;

        src15_valid         = sink_channel[15] && sink_valid;

        src16_data          = sink_data;
        src16_startofpacket = sink_startofpacket;
        src16_endofpacket   = sink_endofpacket;
        src16_channel       = sink_channel >> NUM_OUTPUTS;

        src16_valid         = sink_channel[16] && sink_valid;

        src17_data          = sink_data;
        src17_startofpacket = sink_startofpacket;
        src17_endofpacket   = sink_endofpacket;
        src17_channel       = sink_channel >> NUM_OUTPUTS;

        src17_valid         = sink_channel[17] && sink_valid;

        src18_data          = sink_data;
        src18_startofpacket = sink_startofpacket;
        src18_endofpacket   = sink_endofpacket;
        src18_channel       = sink_channel >> NUM_OUTPUTS;

        src18_valid         = sink_channel[18] && sink_valid;

        src19_data          = sink_data;
        src19_startofpacket = sink_startofpacket;
        src19_endofpacket   = sink_endofpacket;
        src19_channel       = sink_channel >> NUM_OUTPUTS;

        src19_valid         = sink_channel[19] && sink_valid;

        src20_data          = sink_data;
        src20_startofpacket = sink_startofpacket;
        src20_endofpacket   = sink_endofpacket;
        src20_channel       = sink_channel >> NUM_OUTPUTS;

        src20_valid         = sink_channel[20] && sink_valid;

        src21_data          = sink_data;
        src21_startofpacket = sink_startofpacket;
        src21_endofpacket   = sink_endofpacket;
        src21_channel       = sink_channel >> NUM_OUTPUTS;

        src21_valid         = sink_channel[21] && sink_valid;

        src22_data          = sink_data;
        src22_startofpacket = sink_startofpacket;
        src22_endofpacket   = sink_endofpacket;
        src22_channel       = sink_channel >> NUM_OUTPUTS;

        src22_valid         = sink_channel[22] && sink_valid;

        src23_data          = sink_data;
        src23_startofpacket = sink_startofpacket;
        src23_endofpacket   = sink_endofpacket;
        src23_channel       = sink_channel >> NUM_OUTPUTS;

        src23_valid         = sink_channel[23] && sink_valid;

        src24_data          = sink_data;
        src24_startofpacket = sink_startofpacket;
        src24_endofpacket   = sink_endofpacket;
        src24_channel       = sink_channel >> NUM_OUTPUTS;

        src24_valid         = sink_channel[24] && sink_valid;

        src25_data          = sink_data;
        src25_startofpacket = sink_startofpacket;
        src25_endofpacket   = sink_endofpacket;
        src25_channel       = sink_channel >> NUM_OUTPUTS;

        src25_valid         = sink_channel[25] && sink_valid;

        src26_data          = sink_data;
        src26_startofpacket = sink_startofpacket;
        src26_endofpacket   = sink_endofpacket;
        src26_channel       = sink_channel >> NUM_OUTPUTS;

        src26_valid         = sink_channel[26] && sink_valid;

        src27_data          = sink_data;
        src27_startofpacket = sink_startofpacket;
        src27_endofpacket   = sink_endofpacket;
        src27_channel       = sink_channel >> NUM_OUTPUTS;

        src27_valid         = sink_channel[27] && sink_valid;

        src28_data          = sink_data;
        src28_startofpacket = sink_startofpacket;
        src28_endofpacket   = sink_endofpacket;
        src28_channel       = sink_channel >> NUM_OUTPUTS;

        src28_valid         = sink_channel[28] && sink_valid;

        src29_data          = sink_data;
        src29_startofpacket = sink_startofpacket;
        src29_endofpacket   = sink_endofpacket;
        src29_channel       = sink_channel >> NUM_OUTPUTS;

        src29_valid         = sink_channel[29] && sink_valid;

        src30_data          = sink_data;
        src30_startofpacket = sink_startofpacket;
        src30_endofpacket   = sink_endofpacket;
        src30_channel       = sink_channel >> NUM_OUTPUTS;

        src30_valid         = sink_channel[30] && sink_valid;

        src31_data          = sink_data;
        src31_startofpacket = sink_startofpacket;
        src31_endofpacket   = sink_endofpacket;
        src31_channel       = sink_channel >> NUM_OUTPUTS;

        src31_valid         = sink_channel[31] && sink_valid;

        src32_data          = sink_data;
        src32_startofpacket = sink_startofpacket;
        src32_endofpacket   = sink_endofpacket;
        src32_channel       = sink_channel >> NUM_OUTPUTS;

        src32_valid         = sink_channel[32] && sink_valid;

        src33_data          = sink_data;
        src33_startofpacket = sink_startofpacket;
        src33_endofpacket   = sink_endofpacket;
        src33_channel       = sink_channel >> NUM_OUTPUTS;

        src33_valid         = sink_channel[33] && sink_valid;

    end

    // -------------------
    // Backpressure
    // -------------------
    assign ready_vector[0] = src0_ready;
    assign ready_vector[1] = src1_ready;
    assign ready_vector[2] = src2_ready;
    assign ready_vector[3] = src3_ready;
    assign ready_vector[4] = src4_ready;
    assign ready_vector[5] = src5_ready;
    assign ready_vector[6] = src6_ready;
    assign ready_vector[7] = src7_ready;
    assign ready_vector[8] = src8_ready;
    assign ready_vector[9] = src9_ready;
    assign ready_vector[10] = src10_ready;
    assign ready_vector[11] = src11_ready;
    assign ready_vector[12] = src12_ready;
    assign ready_vector[13] = src13_ready;
    assign ready_vector[14] = src14_ready;
    assign ready_vector[15] = src15_ready;
    assign ready_vector[16] = src16_ready;
    assign ready_vector[17] = src17_ready;
    assign ready_vector[18] = src18_ready;
    assign ready_vector[19] = src19_ready;
    assign ready_vector[20] = src20_ready;
    assign ready_vector[21] = src21_ready;
    assign ready_vector[22] = src22_ready;
    assign ready_vector[23] = src23_ready;
    assign ready_vector[24] = src24_ready;
    assign ready_vector[25] = src25_ready;
    assign ready_vector[26] = src26_ready;
    assign ready_vector[27] = src27_ready;
    assign ready_vector[28] = src28_ready;
    assign ready_vector[29] = src29_ready;
    assign ready_vector[30] = src30_ready;
    assign ready_vector[31] = src31_ready;
    assign ready_vector[32] = src32_ready;
    assign ready_vector[33] = src33_ready;

    assign sink_ready = |(sink_channel & ready_vector);

endmodule

