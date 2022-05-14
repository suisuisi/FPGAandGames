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


// $Id: //acds/rel/18.1std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2018/07/18 $
// $Author: psgswbuild $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module ECE385_mm_interconnect_0_router_002_default_decode
  #(
     parameter DEFAULT_CHANNEL = 12,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 21 
   )
  (output [100 - 95 : 0] default_destination_id,
   output [34-1 : 0] default_wr_channel,
   output [34-1 : 0] default_rd_channel,
   output [34-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[100 - 95 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 34'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 34'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 34'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module ECE385_mm_interconnect_0_router_002
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [114-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [114-1    : 0] src_data,
    output reg [34-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 67;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 100;
    localparam PKT_DEST_ID_L = 95;
    localparam PKT_PROTECTION_H = 104;
    localparam PKT_PROTECTION_L = 102;
    localparam ST_DATA_W = 114;
    localparam ST_CHANNEL_W = 34;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 70;
    localparam PKT_TRANS_READ  = 71;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h1000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h2000 - 64'h1000); 
    localparam PAD2 = log2ceil(64'h3000 - 64'h2000); 
    localparam PAD3 = log2ceil(64'h4000 - 64'h3000); 
    localparam PAD4 = log2ceil(64'h5000 - 64'h4000); 
    localparam PAD5 = log2ceil(64'h6000 - 64'h5000); 
    localparam PAD6 = log2ceil(64'h7000 - 64'h6000); 
    localparam PAD7 = log2ceil(64'h8000 - 64'h7000); 
    localparam PAD8 = log2ceil(64'h9000 - 64'h8800); 
    localparam PAD9 = log2ceil(64'h9400 - 64'h9000); 
    localparam PAD10 = log2ceil(64'h9800 - 64'h9400); 
    localparam PAD11 = log2ceil(64'h9880 - 64'h9800); 
    localparam PAD12 = log2ceil(64'h9900 - 64'h9880); 
    localparam PAD13 = log2ceil(64'h9980 - 64'h9940); 
    localparam PAD14 = log2ceil(64'h99c0 - 64'h9980); 
    localparam PAD15 = log2ceil(64'h9a00 - 64'h99c0); 
    localparam PAD16 = log2ceil(64'h9a40 - 64'h9a00); 
    localparam PAD17 = log2ceil(64'h9a80 - 64'h9a60); 
    localparam PAD18 = log2ceil(64'h9aa0 - 64'h9a80); 
    localparam PAD19 = log2ceil(64'h9ac0 - 64'h9aa0); 
    localparam PAD20 = log2ceil(64'h9ae0 - 64'h9ac0); 
    localparam PAD21 = log2ceil(64'h9b10 - 64'h9b00); 
    localparam PAD22 = log2ceil(64'h9b50 - 64'h9b40); 
    localparam PAD23 = log2ceil(64'h9b68 - 64'h9b60); 
    localparam PAD24 = log2ceil(64'h80000 - 64'h40000); 
    localparam PAD25 = log2ceil(64'h600000 - 64'h400000); 
    localparam PAD26 = log2ceil(64'h10000000 - 64'h8000000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h10000000;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [34-1 : 0] default_src_channel;






    ECE385_mm_interconnect_0_router_002_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x0 .. 0x1000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 28'h0   ) begin
            src_channel = 34'b001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x1000 .. 0x2000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h1000   ) begin
            src_channel = 34'b000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x2000 .. 0x3000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h2000   ) begin
            src_channel = 34'b000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x3000 .. 0x4000 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h3000   ) begin
            src_channel = 34'b000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x4000 .. 0x5000 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'h4000   ) begin
            src_channel = 34'b000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0x5000 .. 0x6000 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'h5000   ) begin
            src_channel = 34'b000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x6000 .. 0x7000 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'h6000   ) begin
            src_channel = 34'b000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x7000 .. 0x8000 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'h7000   ) begin
            src_channel = 34'b000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0x8800 .. 0x9000 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'h8800   ) begin
            src_channel = 34'b000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x9000 .. 0x9400 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'h9000   ) begin
            src_channel = 34'b100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x9400 .. 0x9800 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'h9400   ) begin
            src_channel = 34'b000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x9800 .. 0x9880 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'h9800   ) begin
            src_channel = 34'b000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x9880 .. 0x9900 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'h9880   ) begin
            src_channel = 34'b000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x9940 .. 0x9980 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 28'h9940   ) begin
            src_channel = 34'b000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x9980 .. 0x99c0 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 28'h9980   ) begin
            src_channel = 34'b000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x99c0 .. 0x9a00 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 28'h99c0   ) begin
            src_channel = 34'b000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x9a00 .. 0x9a40 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 28'h9a00   ) begin
            src_channel = 34'b000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x9a60 .. 0x9a80 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 28'h9a60   ) begin
            src_channel = 34'b000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x9a80 .. 0x9aa0 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 28'h9a80   ) begin
            src_channel = 34'b000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x9aa0 .. 0x9ac0 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 28'h9aa0   ) begin
            src_channel = 34'b000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x9ac0 .. 0x9ae0 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 28'h9ac0   ) begin
            src_channel = 34'b000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x9b00 .. 0x9b10 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 28'h9b00   ) begin
            src_channel = 34'b010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x9b40 .. 0x9b50 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 28'h9b40   ) begin
            src_channel = 34'b000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x9b60 .. 0x9b68 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 28'h9b60   ) begin
            src_channel = 34'b000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x40000 .. 0x80000 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 28'h40000   ) begin
            src_channel = 34'b000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x400000 .. 0x600000 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 28'h400000   ) begin
            src_channel = 34'b000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 28'h8000000   ) begin
            src_channel = 34'b000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


