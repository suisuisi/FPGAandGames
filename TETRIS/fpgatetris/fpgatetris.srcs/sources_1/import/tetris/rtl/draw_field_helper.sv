module draw_field_helper
#( 
  parameter PIX_WIDTH = 12,

  parameter BRICK_X   = 20,
  parameter BRICK_Y   = 25,

  parameter BRICK_X_CNT = 10,
  parameter BRICK_Y_CNT = 20,

  parameter BORDER_X    = 2,
  parameter BORDER_Y    = 2
)
(
  input                                  clk_i,

  input  [PIX_WIDTH-1:0]                 start_x_i,
  input  [PIX_WIDTH-1:0]                 start_y_i,

  output [PIX_WIDTH-1:0]                 end_x_o,
  output [PIX_WIDTH-1:0]                 end_y_o,

  // current pix value
  input  [PIX_WIDTH-1:0]                 pix_x_i,
  input  [PIX_WIDTH-1:0]                 pix_y_i,

  output logic                           in_field_o,
  output logic                           in_brick_o,

  output logic [$clog2(BRICK_X_CNT)-1:0] brick_col_num_o,
  output logic [$clog2(BRICK_Y_CNT)-1:0] brick_row_num_o

);

assign end_x_o = start_x_i + BORDER_X * ( BRICK_X_CNT + 1 ) + BRICK_X * BRICK_X_CNT - 1;
assign end_y_o = start_y_i + BORDER_Y * ( BRICK_Y_CNT + 1 ) + BRICK_Y * BRICK_Y_CNT - 1;

// значения границ, включая для col по X
logic [BRICK_X_CNT-1:0][PIX_WIDTH-1:0] col_pix_start;
logic [BRICK_X_CNT-1:0][PIX_WIDTH-1:0] col_pix_end;

logic [BRICK_Y_CNT-1:0][PIX_WIDTH-1:0] row_pix_start;
logic [BRICK_Y_CNT-1:0][PIX_WIDTH-1:0] row_pix_end;

genvar g;
generate
  for( g = 0; g < BRICK_X_CNT; g++ )
    begin : g_col_pix
      assign col_pix_start[g] = ( g + 1 ) * BORDER_X + g * BRICK_X;
      assign col_pix_end[g]   = col_pix_start[g] + BRICK_X - 1'd1;
    end
endgenerate

generate
  for( g = 0 ; g < BRICK_Y_CNT; g++ )
    begin : g_row_pix
      assign row_pix_start[g] = ( g + 1 ) * BORDER_Y + g * BRICK_Y;
      assign row_pix_end[g]   = row_pix_start[g] + BRICK_Y - 1'd1;
    end
endgenerate

// текущие значения
logic [$clog2( BRICK_X_CNT )-1:0] brick_col_num;
logic [$clog2( BRICK_Y_CNT )-1:0] brick_row_num;

logic                             in_brick_col;
logic                             in_brick_row;

// просто смещенные значения 
logic [PIX_WIDTH-1:0] in_field_pix_x;
logic [PIX_WIDTH-1:0] in_field_pix_y;

assign in_field_pix_x = pix_x_i - start_x_i;
assign in_field_pix_y = pix_y_i - start_y_i;


// высчитываем текущий блок для отображения
// сделано не очень оптимально - можно подумать...
always_comb
  begin
    brick_col_num = '0;
    in_brick_col  = 1'b0;

    for( int i = 0; i < BRICK_X_CNT; i++ )
      begin
        if( ( in_field_pix_x >= col_pix_start[i] ) && 
            ( in_field_pix_x <= col_pix_end[i]   ) )
          begin
            brick_col_num = i;
            in_brick_col  = 1'b1;
          end
      end
  end

always_comb
  begin
    brick_row_num = '0;
    in_brick_row  = 1'b0;

    for( int i = 0; i < BRICK_Y_CNT; i++ )
      begin
        if( ( in_field_pix_y >= row_pix_start[i] ) && 
            ( in_field_pix_y <= row_pix_end[i] ) )
          begin
            brick_row_num = i;
            in_brick_row  = 1'b1;
          end
      end
  end

always_ff @( posedge clk_i )
  begin
    in_field_o  <= ( pix_x_i >= start_x_i ) && ( pix_x_i <= end_x_o ) &&
                  ( pix_y_i >= start_y_i ) && ( pix_y_i <= end_y_o );

    in_brick_o  <=  in_brick_col && in_brick_row;


    brick_col_num_o <= brick_col_num;
    brick_row_num_o <= brick_row_num;
  end

endmodule
