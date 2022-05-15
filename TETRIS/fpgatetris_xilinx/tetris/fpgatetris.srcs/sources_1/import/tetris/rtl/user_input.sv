`include "defs.vh"

module user_input(
  input               rst_i,

  input               ps2_clk_i,
  
  input         [7:0] ps2_key_data_i,
  input               ps2_key_data_en_i,

  input               main_logic_clk_i,

  input               user_event_rd_req_i,
  output user_event_t user_event_o,
  output              user_event_ready_o

);

logic [1:0][7:0] ps2_key_data_sr;
logic            ps2_key_data_en_d1;

always_ff @( posedge ps2_clk_i or posedge rst_i )
  if( rst_i )
    begin
      ps2_key_data_sr <= '0;
    end
  else
    if( ps2_key_data_en_i )
      begin
        ps2_key_data_sr <= { ps2_key_data_sr[0], ps2_key_data_i };
      end

always_ff @( posedge ps2_clk_i or posedge rst_i )
  if( rst_i )
    ps2_key_data_en_d1 <= '0;
  else
    ps2_key_data_en_d1 <= ps2_key_data_en_i;

user_event_t wr_event;
logic        wr_event_val;
logic        break_event;

assign break_event = ( ps2_key_data_sr[1] == 8'hF0 );

always_comb
  begin
    wr_event_val = 1'b1;

    casex( ps2_key_data_sr )
      { 8'hxx, `SCAN_CODE_N }:
        begin
          wr_event     = EV_NEW_GAME;
          wr_event_val = !break_event;
        end
      `SCAN_CODE_ARROW_UP:
        begin
          wr_event     = EV_ROTATE; 
        end
      `SCAN_CODE_ARROW_LEFT:
        begin
          wr_event     = EV_LEFT; 
        end
      `SCAN_CODE_ARROW_RIGHT:
        begin
          wr_event     = EV_RIGHT;
        end
      `SCAN_CODE_ARROW_DOWN:
        begin
          wr_event     = EV_DOWN;
        end
      default:
        begin
          // на само? деле не та? принципиальн?...
          wr_event     = EV_DOWN; 
          wr_event_val = 1'b0;
        end
    endcase
  end

logic fifo_wr_req;
logic fifo_empty;
logic fifo_full;

assign fifo_wr_req = wr_event_val && ps2_key_data_en_d1 && ( !fifo_full ); 

//user_input_fifo 
//#( 
//  .DWIDTH                                 ( $bits( wr_event )   )
//) user_input_fifo (
//  .aclr                                   ( rst_i               ),
  
//  .wrclk                                  ( ps2_clk_i           ),
//  .wrreq                                  ( fifo_wr_req         ),
//  .data                                   ( wr_event            ),

//  .rdclk                                  ( main_logic_clk_i    ),
//  .rdreq                                  ( user_event_rd_req_i ),
//  .q                                      ( user_event_o        ),

//  .rdempty                                ( fifo_empty          ),
//  .wrfull                                 ( fifo_full           )
//);

async_fifo
    #(
    .DSIZE (8),
    .ASIZE (16)
    )
    async_fifo_user_input(
    .wclk           (ps2_clk_i    ),
    .wrst_n         (1'b1    ),
    .winc           (fifo_wr_req    ),
    .wdata          (wr_event    ),
    .wfull          (fifo_full    ),
    .awfull         (    ),
    .rclk           ( main_logic_clk_i   ),
    .rrst_n         (1'b1    ),
    .rinc           (user_event_rd_req_i    ),
    .rdata          (user_event_o     ),
    .rempty         (fifo_empty    ),
    .arempty        (    )
);



//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
//user_input_fifo user_input_fifo_inst (
//  .rst(rst_i),        // input wire rst
//  .wr_clk(ps2_clk_i),  // input wire wr_clk
//  .rd_clk(main_logic_clk_i),  // input wire rd_clk
//  .din(wr_event ),        // input wire [7 : 0] din
//  .wr_en(fifo_wr_req),    // input wire wr_en
//  .rd_en(user_event_rd_req_i),    // input wire rd_en
//  .dout(user_event_o),      // output wire [7 : 0] dout
//  .full(fifo_full),      // output wire full
//  .empty(fifo_empty)    // output wire empty
//);

ila_0 user_input_fifo (
	.clk(main_logic_clk_i), // input wire clk


	.probe0(fifo_wr_req), // input wire [0:0]  probe0  
	.probe1(wr_event), // input wire [7:0]  probe1 
	.probe2(user_event_rd_req_i), // input wire [0:0]  probe2 
	.probe3(user_event_o) // input wire [7:0]  probe3
);

assign user_event_ready_o = !fifo_empty;

endmodule
