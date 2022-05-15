module draw_big_string
#( 
  parameter PIX_WIDTH = 12,

  parameter START_X   = 100,
  parameter START_Y   = 100,
  
  parameter MSG_X     = 200,
  parameter MSG_Y     = 200,

  parameter INIT_FILE = "some_file.mif" 
)
(
  input                 clk_i,

  input [PIX_WIDTH-1:0] pix_x_i, 
  input [PIX_WIDTH-1:0] pix_y_i, 
  
  output                draw_pix_o,
  output                draw_pix_en_o

);

localparam END_X = START_X + MSG_X - 1;
localparam END_Y = START_Y + MSG_Y - 1;

logic [$clog2(MSG_X)-1:0] msg_pix_x;
logic [$clog2(MSG_Y)-1:0] msg_pix_y;
logic [$clog2(MSG_Y)-1:0] msg_pix_y_d1;

assign msg_pix_x = pix_x_i - START_X;
assign msg_pix_y = pix_y_i - START_Y;

always_ff @( posedge clk_i )
  begin
    msg_pix_y_d1 <= msg_pix_y;
  end

logic in_msg;

always_ff @( posedge clk_i )
  in_msg <= ( pix_x_i >= START_X ) && ( pix_x_i <= END_X ) &&
            ( pix_y_i >= START_Y ) && ( pix_y_i <= END_Y );

logic [MSG_Y-1:0] rom_rd_data;

string_rom 
#( 
   .A_WIDTH                               ( $clog2( MSG_X ) ),
   .D_WIDTH                               ( MSG_Y           ),
   .INIT_FILE                             ( INIT_FILE       )
) string_rom
(
  .clock                                  ( clk_i           ),
  .address                                ( msg_pix_x       ),
  .q                                      ( rom_rd_data     )
);

assign draw_pix_o    = rom_rd_data[ msg_pix_y_d1 ];
assign draw_pix_en_o = in_msg;

endmodule
