//`include "./tetris/rtl/defs.vh"
`include "defs.vh"
module top(
  

  input              GCLK,          //100MHz

  input       [7:0]  SW,
  

  ///////// PS2 /////////
  inout              PS2_CLK,
  inout              PS2_DAT,

  ///////// VGA /////////
  output      [7:0]  VGA_B,
  output             VGA_BLANK_N,
  output             VGA_CLK,
  output      [7:0]  VGA_G,
  output             VGA_HS,
  output      [7:0]  VGA_R,
  output             VGA_SYNC_N, // not used (?)
  output             VGA_VS

);

logic vga_clk;
logic  CLOCK_50;
//pll pll(
//  .refclk                                 ( CLOCK_50          ),
//  .rst                                    ( 1'b0              ),
//  .outclk_0                               (                   ),
//  .outclk_1                               ( vga_clk           )
//);

clk_wiz clk_wiz_inst
   (
    // Clock out ports

    .clk_out1(       ),     // output clk_out1  25.175
    .clk_out2(vga_clk),     // output clk_out2  108M
    .clk_out3(CLOCK_50),
    // Status and control signals
    .reset(1'b0), // input reset
   // Clock in ports
    .clk_in1(GCLK));      // input clk_in1

assign VGA_CLK = vga_clk;

logic main_reset;

logic sw_0_d1;
logic sw_0_d2;
logic sw_0_d3;

always_ff @( posedge CLOCK_50 )
  begin
    sw_0_d1 <= SW[0]; 
    sw_0_d2 <= sw_0_d1;
    sw_0_d3 <= sw_0_d2; 
  end

assign main_reset = sw_0_d3;

logic [7:0] ps2_received_data_w;    
logic       ps2_received_data_en_w; 

PS2_Controller ps2( 
  .CLOCK_50                               ( CLOCK_50                ),
  .reset                                  ( main_reset              ),

  // Bidirectionals
  .PS2_CLK                                ( PS2_CLK                 ),
  .PS2_DAT                                ( PS2_DAT                 ),

  .received_data                          ( ps2_received_data_w     ),
  .received_data_en                       ( ps2_received_data_en_w  )
);

logic        user_event_rd_req_w;
user_event_t user_event_w;
logic        user_event_ready_w;

user_input user_input(
  .rst_i                                  ( main_reset              ),

  .ps2_clk_i                              ( CLOCK_50                ),
    
  .ps2_key_data_i                         ( ps2_received_data_w     ),
  .ps2_key_data_en_i                      ( ps2_received_data_en_w  ),

  .main_logic_clk_i                       ( vga_clk                 ),

  .user_event_rd_req_i                    ( user_event_rd_req_w     ),
  .user_event_o                           ( user_event_w            ),
  .user_event_ready_o                     ( user_event_ready_w      )

);

game_data_t game_data_w;

main_game_logic main_logic(

  .clk_i                                  ( vga_clk             ),
  .rst_i                                  ( main_reset          ),

  .user_event_i                           ( user_event_w        ),
  .user_event_ready_i                     ( user_event_ready_w  ),
  .user_event_rd_req_o                    ( user_event_rd_req_w ),

  .game_data_o                            ( game_data_w         )

);

draw_tetris draw_tetris(
  .clk_vga_i                              ( vga_clk           ),

  .game_data_i                            ( game_data_w       ),
    
    // VGA interface
  .vga_hs_o                               ( VGA_HS            ),
  .vga_vs_o                               ( VGA_VS            ),
  .vga_de_o                               ( VGA_BLANK_N       ),
  .vga_r_o                                ( VGA_R             ),
  .vga_g_o                                ( VGA_G             ),
  .vga_b_o                                ( VGA_B             )

);

endmodule
