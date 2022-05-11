`include "defs.vh"

module draw_tetris(

  input                                 clk_vga_i,

  input game_data_t                     game_data_i,
  
  // VGA interface
  output  logic                         vga_hs_o,
  output  logic                         vga_vs_o,
  output  logic                         vga_de_o,
  output  logic [7:0]                   vga_r_o,
  output  logic [7:0]                   vga_g_o,
  output  logic [7:0]                   vga_b_o

);
localparam PIX_WIDTH = 12;

logic [23:0]          strings_vga_data_w;
logic                 strings_vga_data_en_w;

logic [23:0]          field_vga_data_w;
logic                 field_vga_data_en_w;

logic                 pix_hs;
logic                 pix_vs;
logic                 pix_de;
logic [PIX_WIDTH-1:0] pix_x;
logic [PIX_WIDTH-1:0] pix_y;

logic [23:0]          vga_data;

draw_strings
#( 
  .PIX_WIDTH                              ( PIX_WIDTH             )
) draw_strings (
  .clk_i                                  ( clk_vga_i             ),

  .pix_x_i                                ( pix_x                 ),
  .pix_y_i                                ( pix_y                 ),
    
  .game_data_i                            ( game_data_i           ),

  .vga_data_o                             ( strings_vga_data_w    ),
  .vga_data_en_o                          ( strings_vga_data_en_w )
);

draw_field
#( 
  .PIX_WIDTH                              ( PIX_WIDTH           )
) draw_field (

  .clk_i                                  ( clk_vga_i           ),

  .pix_x_i                                ( pix_x               ),
  .pix_y_i                                ( pix_y               ),
  
  .game_data_i                            ( game_data_i         ),
    
  .vga_data_o                             ( field_vga_data_w    ),
  .vga_data_en_o                          ( field_vga_data_en_w )

);

always_comb
  begin
    vga_data = `COLOR_BACKGROUND;
    
    // strings got priority to draw "game over" over field
    if( strings_vga_data_en_w )
      vga_data = strings_vga_data_w;
    else 
      if( field_vga_data_en_w )
        vga_data = field_vga_data_w;
  end



// settings for VGA CORE

// for 640x480

/*
localparam H_DISP	         = 640;
localparam H_FPORCH	         = 16;
localparam H_SYNC	         = 96;
localparam H_BPORCH	         = 48;
localparam V_DISP	         = 480;
localparam V_FPORCH	         = 10;
localparam V_SYNC	         = 2;
localparam V_BPORCH	         = 33;
*/

// for 1280x1024
localparam H_DISP	         = 1280;
localparam H_FPORCH	         = 48;
localparam H_SYNC	         = 112;
localparam H_BPORCH	         = 248;
localparam V_DISP	         = 1024;
localparam V_FPORCH	         = 1;
localparam V_SYNC	         = 3;
localparam V_BPORCH	         = 38;

vga_time_generator vga_time_generator_instance(
  .clk                                  ( clk_vga_i                ),
  .reset_n                              ( 1'b1                     ), //FIXME(?)

  .h_disp                               ( H_DISP                   ),
  .h_fporch                             ( H_FPORCH                 ),
  .h_sync                               ( H_SYNC                   ), 
  .h_bporch                             ( H_BPORCH                 ),
                                               
  .v_disp                               ( V_DISP                   ),
  .v_fporch                             ( V_FPORCH                 ),
  .v_sync                               ( V_SYNC                   ),
  .v_bporch                             ( V_BPORCH                 ),
  .hs_polarity                          ( 1'b0                     ),
  .vs_polarity                          ( 1'b0                     ),
  .frame_interlaced                     ( 1'b0                     ),
                  
  .vga_hs                               ( pix_hs                   ),
  .vga_vs                               ( pix_vs                   ),
  .vga_de                               ( pix_de                   ),
  .pixel_x                              ( pix_x                    ),
  .pixel_y                              ( pix_y                    ),
  .pixel_i_odd_frame                    (                          ) 
);

logic                 pix_hs_d1;
logic                 pix_vs_d1;
logic                 pix_de_d1;

always_ff @( posedge clk_vga_i )
  begin
    { vga_r_o, vga_g_o, vga_b_o } <= vga_data;
    
    // delay because draw_strings/field got latency
    pix_hs_d1                     <= pix_hs;
    pix_vs_d1                     <= pix_vs;
    pix_de_d1                     <= pix_de;

    vga_hs_o                      <= pix_hs_d1;
    vga_vs_o                      <= pix_vs_d1;
    vga_de_o                      <= pix_de_d1;
  end

endmodule
