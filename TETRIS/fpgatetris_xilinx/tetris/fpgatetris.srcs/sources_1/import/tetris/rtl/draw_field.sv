/*
  Модуль занимается тем, что "отрисовывает" поле игры.

*/

`include "../rtl/defs.vh"

module draw_field
#( 
  parameter PIX_WIDTH     = 12
)
(
  input                                 clk_i,

  input  [PIX_WIDTH-1:0]                pix_x_i,
  input  [PIX_WIDTH-1:0]                pix_y_i,
  
  input  game_data_t                    game_data_i,

  // выходные данные RGB
  output [23:0]                         vga_data_o,
  output                                vga_data_en_o

);

// значения X и Y для одного блока в значениях реальных пикселей 
localparam BRICK_X = 30;
localparam BRICK_Y = 30;

// значения для границ в реальных пикселях
localparam BORDER_X = 2;
localparam BORDER_Y = 2;

// значение координат ( в реальных пикселях ) когда начинается игровое поле
localparam START_MAIN_FIELD_X = 300;
localparam START_MAIN_FIELD_Y = 200;

logic [$clog2(`FIELD_COL_CNT)-1:0] main_field_col_num;
logic [$clog2(`FIELD_ROW_CNT)-1:0] main_field_row_num;
logic                              main_field_in_field;
logic                              main_field_in_brick;
logic [PIX_WIDTH-1:0]              main_field_end_x;
logic [PIX_WIDTH-1:0]              main_field_end_y;


draw_field_helper
#( 
  .PIX_WIDTH                              ( PIX_WIDTH         ), 

  .BRICK_X                                ( BRICK_X           ),
  .BRICK_Y                                ( BRICK_Y           ),

  .BRICK_X_CNT                            ( `FIELD_COL_CNT    ),
  .BRICK_Y_CNT                            ( `FIELD_ROW_CNT    ),

  .BORDER_X                               ( BORDER_X          ),
  .BORDER_Y                               ( BORDER_Y          )
) main_field (
  .clk_i                                  ( clk_i             ),

  .start_x_i                              ( START_MAIN_FIELD_X ),
  .start_y_i                              ( START_MAIN_FIELD_Y ),

  .end_x_o                                ( main_field_end_x  ),
  .end_y_o                                ( main_field_end_y  ),

    // current pix value
  .pix_x_i                                ( pix_x_i           ),
  .pix_y_i                                ( pix_y_i           ),

  .in_field_o                             ( main_field_in_field ),
  .in_brick_o                             ( main_field_in_brick ),

  .brick_col_num_o                        ( main_field_col_num  ),
  .brick_row_num_o                        ( main_field_row_num  )

);

// ******* Next Block Preview (nbp) *******
localparam NBP_BRICK_CNT = 6;

logic [PIX_WIDTH-1:0] nbp_field_start_x;
logic [PIX_WIDTH-1:0] nbp_field_start_y;

assign nbp_field_start_x = 'd670;
assign nbp_field_start_y = START_MAIN_FIELD_Y;

logic [$clog2(NBP_BRICK_CNT)-1:0]  nbp_field_col_num;
logic [$clog2(NBP_BRICK_CNT)-1:0]  nbp_field_row_num;
logic                              nbp_field_in_field;
logic                              nbp_field_in_brick;

draw_field_helper
#( 
  .PIX_WIDTH                              ( PIX_WIDTH         ), 

  .BRICK_X                                ( BRICK_X           ),
  .BRICK_Y                                ( BRICK_Y           ),

  
  .BRICK_X_CNT                            ( NBP_BRICK_CNT     ),
  .BRICK_Y_CNT                            ( NBP_BRICK_CNT     ),

  .BORDER_X                               ( BORDER_X          ),
  .BORDER_Y                               ( BORDER_Y          )
) draw_nbp_field (
  .clk_i                                  ( clk_i             ),

  .start_x_i                              ( nbp_field_start_x ),
  .start_y_i                              ( nbp_field_start_y ),

  .end_x_o                                (                   ),
  .end_y_o                                (                   ),

    // current pix value
  .pix_x_i                                ( pix_x_i           ),
  .pix_y_i                                ( pix_y_i           ),

  .in_field_o                             ( nbp_field_in_field ),
  .in_brick_o                             ( nbp_field_in_brick ),

  .brick_col_num_o                        ( nbp_field_col_num  ),
  .brick_row_num_o                        ( nbp_field_row_num  )

);

logic [NBP_BRICK_CNT-1:0][NBP_BRICK_CNT-1:0][`TETRIS_COLORS_CNT-1:0] nbp_field;

logic [0:3][0:3] nbp_block_data;

assign nbp_block_data = game_data_i.next_block.data[ game_data_i.next_block.rotation ];

always_comb
  begin
    for( int i = 0; i < NBP_BRICK_CNT; i++ )
      begin
        for( int j = 0; j < NBP_BRICK_CNT; j++ )
          begin
            if( ( i == 0 ) || ( j == 0 ) ||
                ( i == ( NBP_BRICK_CNT - 1 ) ) || ( j == ( NBP_BRICK_CNT - 1 ) ) )
              begin
                nbp_field[i][j] = 'd0;
              end
            else
              begin
                if( nbp_block_data[i-1][j-1] && game_data_i.next_block_draw_en ) 
                  nbp_field[i][j] = game_data_i.next_block.color;  
                else
                  nbp_field[i][j] = 'd0;
              end
          end
      end
  end

logic [23:0] vga_data;

logic [`TETRIS_COLORS_CNT-1:0][23:0] vga_colors_pos;

assign vga_colors_pos[0] = `COLOR_BRICKS_0;
assign vga_colors_pos[1] = `COLOR_BRICKS_1;
assign vga_colors_pos[2] = `COLOR_BRICKS_2;
assign vga_colors_pos[3] = `COLOR_BRICKS_3;
assign vga_colors_pos[4] = `COLOR_BRICKS_4;
assign vga_colors_pos[5] = `COLOR_BRICKS_5;
assign vga_colors_pos[6] = `COLOR_BRICKS_6;
assign vga_colors_pos[7] = `COLOR_BRICKS_7;

always_comb
  begin
    vga_data = `COLOR_BORDERS;
    
    if( main_field_in_field )
      begin
        if( main_field_in_brick )
          begin
            vga_data = vga_colors_pos[ game_data_i.field[ main_field_row_num ][ main_field_col_num ] ]; 
          end
      end
    else
      if( nbp_field_in_field )
        begin
          if( nbp_field_in_brick )
            begin
              vga_data = vga_colors_pos[ nbp_field[ nbp_field_row_num ][ nbp_field_col_num ] ]; 
            end
        end
  end

assign vga_data_o    = vga_data;
assign vga_data_en_o = main_field_in_field || nbp_field_in_field;

endmodule
