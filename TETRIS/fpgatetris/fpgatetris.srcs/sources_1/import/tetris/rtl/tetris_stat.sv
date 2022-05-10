module tetris_stat(
  input                   clk_i,
  
  // sync reset - when starts new game
  input                   srst_i,
  
  input        [2:0]      disappear_lines_cnt_i,
  input                   update_stat_en_i,
  
  output logic [5:0][3:0] score_o,
  output logic [5:0][3:0] lines_o,
  output logic [5:0][3:0] level_o,

  output logic            level_changed_o

);

// ******* SCORE *******

logic [4:0][3:0] add_score_pos;

assign add_score_pos[0] = 4'd0;
assign add_score_pos[1] = 4'd1;
assign add_score_pos[2] = 4'd3;
assign add_score_pos[3] = 4'd7;
assign add_score_pos[4] = 4'd15;

localparam SCORE_DIGITS           = 4;
localparam MAX_SCORE_IN_HUNDRED   = 10**SCORE_DIGITS - 1;
localparam SCORE_IN_HUNDRED_WIDTH = $clog2( MAX_SCORE_IN_HUNDRED );

logic [SCORE_IN_HUNDRED_WIDTH-1:0] score_hundred;
logic [SCORE_IN_HUNDRED_WIDTH:0]   next_score_hundred;
logic [SCORE_DIGITS-1:0][3:0]      score_hundred_bcd;

always_comb
  begin
    next_score_hundred = score_hundred + add_score_pos[ disappear_lines_cnt_i ];

    if( next_score_hundred > MAX_SCORE_IN_HUNDRED )
      next_score_hundred = MAX_SCORE_IN_HUNDRED;
  end

always_ff @( posedge clk_i )
  if( srst_i )
    score_hundred <= 'd0;
  else
    if( update_stat_en_i )
      score_hundred <= next_score_hundred[SCORE_IN_HUNDRED_WIDTH-1:0]; 

bin_2_bcd
#( 
  .BIN_WIDTH                              ( SCORE_IN_HUNDRED_WIDTH ),
  .BCD_WIDTH                              ( SCORE_DIGITS           )
) bcd_score (
  .bin_i                                  ( score_hundred          ),
  .bcd_o                                  ( score_hundred_bcd      )
);

always_ff @( posedge clk_i )
  score_o <= { score_hundred_bcd, 4'h0, 4'h0 };


// ******* LINES *******
localparam LINES_DIGITS  = 3;
localparam MAX_LINES_CNT = 10**LINES_DIGITS - 1;
localparam LINES_WIDTH   = $clog2( MAX_LINES_CNT );

logic [LINES_WIDTH-1:0]         lines_cnt;
logic [LINES_WIDTH:0]           next_lines_cnt;
logic [LINES_DIGITS-1:0][3:0]   lines_cnt_bcd; 

always_comb
  begin
    next_lines_cnt = lines_cnt + disappear_lines_cnt_i;

    if( next_lines_cnt > MAX_LINES_CNT )
      next_lines_cnt = MAX_LINES_CNT;
  end
 
always_ff @( posedge clk_i )
  if( srst_i )
    lines_cnt <= '0;
  else
    if( update_stat_en_i )
      lines_cnt <= next_lines_cnt[LINES_WIDTH-1:0];

bin_2_bcd
#( 
  .BIN_WIDTH                              ( LINES_WIDTH            ),
  .BCD_WIDTH                              ( LINES_DIGITS           )
) bcd_lines (
  .bin_i                                  ( lines_cnt              ),
  .bcd_o                                  ( lines_cnt_bcd          )
);

always_ff @( posedge clk_i )
  lines_o <= { 4'h0, 4'h0, 4'h0, lines_cnt_bcd };

// ******* LEVEL *******

logic [1:0][3:0] level_num;

always_comb
  begin
    level_num = lines_cnt_bcd[2:1];

    level_num[0] = level_num[0] + 4'd1;

    if( level_num[0] == 4'd10 )
      begin
        level_num[0] = 4'd0;
        level_num[1] = level_num[1] + 4'd1;
      end
    
    // max level is 99
    if( level_num[1] == 4'd10 && level_num[0] == 4'd0 )
      begin
        level_num[1] = 4'd9;
        level_num[0] = 4'd9;
      end
  end

always_ff @( posedge clk_i ) 
  level_o <= { 4'h0, 4'h0, 4'h0, 4'h0, level_num };

logic [3:0] level_num_0_d1;

always_ff @( posedge clk_i )
  if( srst_i )
    level_num_0_d1 <= 'd0;
  else
    level_num_0_d1 <= level_num[0];

assign level_changed_o = ( level_num_0_d1 != level_num[0] );

endmodule
