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


//  -----------------------------------------------------------------------------------
// | Lookahead Multiport Memory
//  -----------------------------------------------------------------------------------
// | Module Name     : ECE385_eth0_tx_dma_buffer_data_format_adapter_0_data_ram
// | Author          : kjo, dmunday
// | Created On      : 2013 Nov 21
// | Description     :
// |   Standard multi-port memory, where a read on cycle n responds with data on 
// |   cycle n+2.  The lookahead protection means that if you write data on cycle n or 
// |   cycle n+1, the data returned on cycle n+2 is the written data.
//  -----------------------------------------------------------------------------------

`timescale 1ns / 100ps
// ------------------------------------------
// Generation parameters:
//   memName:          ECE385_eth0_tx_dma_buffer_data_format_adapter_0_data_ram
//   dataWidth:        8
//   addrWidth:        1
//   numReadPorts:     1
//   depth:            1
//   clrOnRST:         0 

module ECE385_eth0_tx_dma_buffer_data_format_adapter_0_data_ram (
  // Interface: clock
  input                clk,
  input                reset_n,
  // Interface: read0 
  input                rd0_address,
  output reg [8 -1: 0] rd0_readdata,
  // Interface: write
  input                wr_address,
  input      [8 -1: 0] wr_writedata,
  input                wr_write,
  output reg           wr_waitrequest                                                               
);

   // ---------------------------------------------------------------------
   //| Internal Parameters
   // ---------------------------------------------------------------------
   localparam  DEPTH           = 1;   
   localparam  DATA_WIDTH      = 8;   
   localparam  ADDRESS_WIDTH   = 1;   
   localparam  CLEAR_ON_RESET  = 0;   

   // ---------------------------------------------------------------------
   //| Signals
   // ---------------------------------------------------------------------
   reg [DATA_WIDTH-1:0]        wr_writedata1;
   reg [ADDRESS_WIDTH-1:0]     reset_count;
   reg [DATA_WIDTH-1:0]        mem_wr_writedata;
   reg [ADDRESS_WIDTH-1:0]     mem_wr_address;
   reg                         mem_wr_write;
   reg [DATA_WIDTH-1:0]        mem [DEPTH-1:0];  
   reg                         rd0_bypass;
   reg [DATA_WIDTH-1:0]        rd0_mem_readdata;
   
   // ---------------------------------------------------------------------
   // Synchronous Stuff
   // ---------------------------------------------------------------------
   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin
         wr_writedata1  <= 0;
         wr_waitrequest <= 1;
         if (CLEAR_ON_RESET) begin
            reset_count    <= DEPTH-1'b1;
         end else begin
            reset_count    <= 0;
         end
         rd0_bypass     <= 0;

      end else begin
         rd0_bypass   <= (rd0_address == wr_address) && wr_write;
         wr_writedata1  <= wr_writedata;  
  // Memory reset state machine
         if (reset_count > 0) begin
            reset_count <= reset_count - 1'b1;
         end else begin
            wr_waitrequest <= 0;
         end
      end
   end
   
   // ---------------------------------------------------------------------
   // Combinatorial Memory Control
   // --------------------------------------------------------------------- 
   always @* begin
      rd0_readdata     = rd0_mem_readdata;
      mem_wr_write     = wr_write;
      mem_wr_address   = wr_address;
      mem_wr_writedata = wr_writedata;
      
      // Lookahead
      if (rd0_bypass) begin
         rd0_readdata   = wr_writedata1;
      end
      // Memory Reset
      if (CLEAR_ON_RESET) begin
         if ( wr_waitrequest ) begin
            mem_wr_write  = 1;
            mem_wr_address = reset_count;
            mem_wr_writedata    = 0;
         end
      end
   end
   
   // --------------------------------------------------------------------- 
   // Infer Memory
   // --------------------------------------------------------------------- 
   always @(posedge clk) begin
      if (mem_wr_write)
         mem[mem_wr_address] <= mem_wr_writedata;
      rd0_mem_readdata       <= mem[rd0_address];
   end
   
endmodule

// synthesis translate_off

//  --------------------------------------------------------------------------------
// | test bench
//  --------------------------------------------------------------------------------
`ifdef RUN_INTERNAL_TEST
module test_ECE385_eth0_tx_dma_buffer_data_format_adapter_0_data_ram;

   // ---------------------------------------------------------------------
   //| Internal Parameters
   // ---------------------------------------------------------------------
   localparam  DEPTH                   = 1
   localparam  DATA_WIDTH              = 8
   localparam  ADDRESS_WIDTH           = 1
   localparam  CLEAR_ON_RESET          = 0
   localparam  CLOCK_HALF_PERIOD       = 10;
   localparam  CLOCK_PERIOD            = 2*CLOCK_HALF_PERIOD;
   localparam  RESET_TIME              = 25;
   
   // ---------------------------------------------------------------------
   //| Signals
   // ---------------------------------------------------------------------
   reg                       clk            = 0;
   reg                       reset_n        = 0;
   reg                       test_success   = 1;
   reg                       success        = 1;
   reg [ADDRESS_WIDTH-1:0]   wr_address;
   reg [DATA_WIDTH-1:0]      wr_writedata;
   reg                       wr_write;
   wire                      wr_waitrequest;
   reg [ADDRESS_WIDTH-1:0]   rd0_address;
   wire [DATA_WIDTH-1:0]     rd0_readdata;
   reg [DATA_WIDTH-1:0]      mem_mirror [DEPTH-1:0];
    
   // ---------------------------------------------------------------------
   //| DUT
   // ---------------------------------------------------------------------
   ECE385_eth0_tx_dma_buffer_data_format_adapter_0_data_ram dut ( 
    .clk              (clk),
    .reset_n          (reset_n),
    .rd0_address      (rd0_address),
    .rd0_readdata     (rd0_readdata),
    .wr_address       (wr_address),
    .wr_writedata     (wr_writedata),
    .wr_write         (wr_write),
    .wr_waitrequest   (wr_waitrequest)          
   );

   // ---------------------------------------------------------------------
   //| Clock & Reset
   // ---------------------------------------------------------------------
   initial begin
      reset_n = 0;
      #RESET_TIME;
      reset_n = 1;
   end
   
   always begin
      #CLOCK_HALF_PERIOD;
      clk <= ~clk;
   end

   // ---------------------------------------------------------------------
   //| Main Test
   // ---------------------------------------------------------------------
   initial begin
      test_reset();
      test_random();
      test_single_channel();
      
      $finish;
   end
   
   // ---------------------------------------------------------------------
   //| Test reset
   // ---------------------------------------------------------------------
   task test_reset;
      integer i;
      begin
       test_success = 1;

        if (CLEAR_ON_RESET) begin
            @(posedge clk);
                test_assert ("Memory's wr_waitrequest should be test_asserted while held in reset.", wr_waitrequest);

                    wait (reset_n == 1);
                        test_assert ("Memory should still be in reset immediately after clearing the in_reset signal.", wr_waitrequest);

                            wait (wr_waitrequest == 0);
                                

    for (i=0; i<DEPTH; i=i+1) begin
       rd0_address <= i;
       @(posedge clk);
       test_assert ("Memory location should be 0.", rd0_readdata==0);
    end
 end else begin
        @(posedge clk);
        test_assert ("Memory's in_reset should be asserted while held in reset.", wr_waitrequest);
        wait (reset_n == 1);
        @(posedge clk);
        #1 test_assert ("Memory should have in_reset=0 immediately after reset!!.", wr_waitrequest==0);
     end // else: !if(CLEAR_ON_RESET)
  endtest("test_reset");
endtest 
endtask

   // ---------------------------------------------------------------------
   //| Test random in & out data
   // ---------------------------------------------------------------------
   task test_random;
      integer i;
      begin


       // Initialize mem_mirror
        for (i=0; i<DEPTH; i=i+1) begin
           if (CLEAR_ON_RESET) begin
              mem_mirror[i] = 0;
           end else begin
              mem_mirror[i] = 256'bX;
           end
        end
         
         wait (reset_n == 1);
         wait (wr_waitrequest == 0);
         
         fork
            begin
               repeat (20*DEPTH) begin // do 20x Depth writes.
                  #1;
                  wr_write = $random % 2;
                  wr_address = ($random & 31'hFFFFFFFF) % DEPTH;
                  wr_writedata = $random;
                  #1;
                  if (wr_write)
                    mem_mirror[wr_address] = wr_writedata;
                  @(posedge clk);
               end
            end
            
            begin
               repeat (80*DEPTH) begin // do 80x Depth reads.
                  rd0_address = ($random & 31'hFFFFFFFF) % DEPTH;
                  @(posedge clk);
                  #1;
                  test_assert("Data Mismatch (port 0)", mem_mirror[rd0_address] == rd0_readdata);
               end
            end
         join
         endtest("test_random");
      end
   endtask // test_random

   // ---------------------------------------------------------------------
   //| Test a single port
   // ---------------------------------------------------------------------
   task test_single_channel;
      integer i;
      begin

         reset_n <= 0;
         @(posedge clk);
         reset_n <= 1;
          
          // Initialize mem_mirror
         for (i=0; i<DEPTH; i=i+1) begin
            if (CLEAR_ON_RESET) begin
               mem_mirror[i] = 0;
            end else begin
               mem_mirror[i] = 256'bX;
            end
         end
         
         wait (reset_n == 1);
         wait (wr_waitrequest == 0);
         
         wr_write  = 0;
         wr_address = ($random & 31'hFFFFFFFF) % DEPTH;
         rd0_address  = wr_address;
         
         repeat (200) begin // do 200 times
            wr_write  = ($random & 1'b1);
            wr_writedata    = $dist_uniform(23,0,256);
            #1;
            mem_mirror[wr_address] = wr_writedata;
            @(posedge clk);
            #1;
            test_assert("Data Mismatch", mem_mirror[rd0_address] == rd0_readdata);
         end
         endtest("test_single_channel");
      end
   endtask // test_random
   
   
   // ---------------------------------------------------------------------
   //| Test_assert
   // ---------------------------------------------------------------------
   task test_assert;
      input [256:0] message;
      input         condition;
      begin
       if (! condition) begin
          $display("%t: %s ",$time, message);
          success = 0;
          test_success = 0;
       end
      end
   endtask

   // ---------------------------------------------------------------------
   //| End Test
   // ---------------------------------------------------------------------
   task endtest;
      input [256:0] message;
      begin
         if (test_success) begin
            $display("(sim)%t: %-40s: Pass",$time, message);
         end else begin
            $display("(sim)%t: %-40s: Fail",$time, message);
         end
         success = success & test_success;
      end
   endtask

endmodule
`endif
// synthesis translate_on



