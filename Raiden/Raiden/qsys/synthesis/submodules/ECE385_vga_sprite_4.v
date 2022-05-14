//Legal Notice: (C)2019 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ECE385_vga_sprite_4 (
                             // inputs:
                              address,
                              address2,
                              byteenable,
                              byteenable2,
                              chipselect,
                              chipselect2,
                              clk,
                              clk2,
                              clken,
                              clken2,
                              freeze,
                              reset,
                              reset2,
                              reset_req,
                              reset_req2,
                              write,
                              write2,
                              writedata,
                              writedata2,

                             // outputs:
                              readdata,
                              readdata2
                           )
;

  parameter INIT_FILE = "ECE385_vga_sprite_4.hex";


  output  [ 31: 0] readdata;
  output  [ 15: 0] readdata2;
  input   [  9: 0] address;
  input   [ 10: 0] address2;
  input   [  3: 0] byteenable;
  input   [  1: 0] byteenable2;
  input            chipselect;
  input            chipselect2;
  input            clk;
  input            clk2;
  input            clken;
  input            clken2;
  input            freeze;
  input            reset;
  input            reset2;
  input            reset_req;
  input            reset_req2;
  input            write;
  input            write2;
  input   [ 31: 0] writedata;
  input   [ 15: 0] writedata2;


wire             clocken0;
wire             clocken1;
wire    [ 31: 0] readdata;
wire    [ 15: 0] readdata2;
wire             wren;
wire             wren2;
  assign wren = chipselect & write;
  assign clocken0 = clken & ~reset_req;
  assign clocken1 = clken2 & ~reset_req2;
  assign wren2 = chipselect2 & write2;
  altsyncram the_altsyncram
    (
      .address_a (address),
      .address_b (address2),
      .byteena_a (byteenable),
      .byteena_b (byteenable2),
      .clock0 (clk),
      .clock1 (clk2),
      .clocken0 (clocken0),
      .clocken1 (clocken1),
      .data_a (writedata),
      .data_b (writedata2),
      .q_a (readdata),
      .q_b (readdata2),
      .wren_a (wren),
      .wren_b (wren2)
    );

  defparam the_altsyncram.address_reg_b = "CLOCK1",
           the_altsyncram.byte_size = 8,
           the_altsyncram.byteena_reg_b = "CLOCK1",
           the_altsyncram.indata_reg_b = "CLOCK1",
           the_altsyncram.init_file = INIT_FILE,
           the_altsyncram.lpm_type = "altsyncram",
           the_altsyncram.maximum_depth = 1024,
           the_altsyncram.numwords_a = 1024,
           the_altsyncram.numwords_b = 2048,
           the_altsyncram.operation_mode = "BIDIR_DUAL_PORT",
           the_altsyncram.outdata_reg_a = "UNREGISTERED",
           the_altsyncram.outdata_reg_b = "UNREGISTERED",
           the_altsyncram.ram_block_type = "AUTO",
           the_altsyncram.read_during_write_mode_mixed_ports = "DONT_CARE",
           the_altsyncram.width_a = 32,
           the_altsyncram.width_b = 16,
           the_altsyncram.width_byteena_a = 4,
           the_altsyncram.width_byteena_b = 2,
           the_altsyncram.widthad_a = 10,
           the_altsyncram.widthad_b = 11,
           the_altsyncram.wrcontrol_wraddress_reg_b = "CLOCK1";

  //s1, which is an e_avalon_slave
  //s2, which is an e_avalon_slave

endmodule

