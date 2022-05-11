`include "../rtl/defs.vh"

module gen_next_block(
  input                   clk_i,
  input                   en_i,
  
  output block_info_t     next_block_o
);

localparam BLOCK_I = 0;
localparam BLOCK_J = 1;
localparam BLOCK_L = 2;
localparam BLOCK_O = 3;
localparam BLOCK_S = 4;
localparam BLOCK_T = 5;
localparam BLOCK_Z = 6;
localparam BLOCKS_CNT = 7;

logic [BLOCKS_CNT-1:0][3:0][0:3][0:3] blocks_table;

/* **** */
assign blocks_table[ BLOCK_I ] = { 4'b0000,
                                   4'b1111,
                                   4'b0000,
                                   4'b0000,

                                   4'b0100,
                                   4'b0100,
                                   4'b0100,
                                   4'b0100,

                                   4'b0000,
                                   4'b1111,
                                   4'b0000,
                                   4'b0000,

                                   4'b0100,
                                   4'b0100,
                                   4'b0100,
                                   4'b0100 };

assign blocks_table[ BLOCK_J ] = { 4'b0000,
                                   4'b1110,
                                   4'b0010,
                                   4'b0000,

                                   4'b0110,
                                   4'b0100,
                                   4'b0100,
                                   4'b0000,

                                   4'b1000,
                                   4'b1110,
                                   4'b0000,
                                   4'b0000,

                                   4'b0100,
                                   4'b0100,
                                   4'b1100,
                                   4'b0000 };
/* *** */
/* *   */
assign blocks_table[ BLOCK_L ] = { 4'b0000,
                                   4'b1110,
                                   4'b1000,
                                   4'b0000,

                                   4'b0100,
                                   4'b0100,
                                   4'b0110,
                                   4'b0000,

                                   4'b0010,
                                   4'b1110,
                                   4'b0000,
                                   4'b0000,

                                   4'b1100,
                                   4'b0100,
                                   4'b0100,
                                   4'b0000 };

/* ** */
/* ** */
assign blocks_table[ BLOCK_O ] = { 4'b0000,
                                   4'b0110,
                                   4'b0110,
                                   4'b0000,

                                   4'b0000,
                                   4'b0110,
                                   4'b0110,
                                   4'b0000,

                                   4'b0000,
                                   4'b0110,
                                   4'b0110,
                                   4'b0000,

                                   4'b0000,
                                   4'b0110,
                                   4'b0110,
                                   4'b0000 };

/*  ** */
/* **  */
assign blocks_table[ BLOCK_S ] = { 4'b0000,
                                   4'b0110,
                                   4'b1100,
                                   4'b0000,

                                   4'b0100,
                                   4'b0110,
                                   4'b0010,
                                   4'b0000,

                                   4'b0110,
                                   4'b1100,
                                   4'b0000,
                                   4'b0000,

                                   4'b1000,
                                   4'b1100,
                                   4'b0100,
                                   4'b0000 };

/* *** */
/*  *  */
assign blocks_table[ BLOCK_T ] = { 4'b0000,
                                   4'b1110,
                                   4'b0100,
                                   4'b0000,

                                   4'b0100,
                                   4'b0110,
                                   4'b0100,
                                   4'b0000,

                                   4'b0100,
                                   4'b1110,
                                   4'b0000,
                                   4'b0000,

                                   4'b0100,
                                   4'b1100,
                                   4'b0100,
                                   4'b0000 };

/* **  */
/*  ** */
assign blocks_table[ BLOCK_Z ] = { 4'b0000,
                                   4'b1100,
                                   4'b0110,
                                   4'b0000,

                                   4'b0010,
                                   4'b0110,
                                   4'b0100,
                                   4'b0000,

                                   4'b1100,
                                   4'b0110,
                                   4'b0000,
                                   4'b0000,

                                   4'b0100,
                                   4'b1100,
                                   4'b1000,
                                   4'b0000 };

logic [14:0]                   prbs_15 = 'd1;
logic [$clog2(BLOCKS_CNT)-1:0] random_block_num = 'd0;
logic [1:0]                    random_rotation  = 'd0;

always_ff @( posedge clk_i )
  if( en_i )
    prbs_15 <= { prbs_15[13:0], prbs_15[14] ^ prbs_15[13] };

always_ff @( posedge clk_i )
  begin
    random_block_num <= prbs_15[7:0] % BLOCKS_CNT;
    random_rotation  <= prbs_15[9:8]; // why not(?)
  end

always_ff @( posedge clk_i )
  begin
    next_block_o.data     <= blocks_table[ random_block_num ];
    
    // zero color for background, so adding one
    next_block_o.color    <= random_block_num + 1'd1;
    next_block_o.rotation <= random_rotation;
    next_block_o.x        <= 'd4; 
    next_block_o.y        <= 'd0;
  end


endmodule
