module gen_sys_event(
  input  clk_i,
  input  srst_i,

  input  level_changed_i,
  
  output sys_event_o

);
// going from max to min value...
localparam SYS_EVENT_PERIOD_MAX  = 'd67_000_000; 
localparam SYS_EVENT_PERIOD_MIN  = 'd10_000_000;
localparam SYS_EVENT_PERIOD_STEP = 'd4_000_000; 

logic [31:0] sys_counter      = '0;
logic [31:0] sys_event_period = SYS_EVENT_PERIOD_MAX;
logic [31:0] next_sys_event_period;

logic        counter_eq_period;

always_comb
  begin
    if( ( sys_event_period - SYS_EVENT_PERIOD_STEP ) < SYS_EVENT_PERIOD_MIN )
      next_sys_event_period = SYS_EVENT_PERIOD_MIN;
    else
      next_sys_event_period = sys_event_period - SYS_EVENT_PERIOD_STEP;
  end

always_ff @( posedge clk_i )
  if( srst_i )
    sys_event_period <= SYS_EVENT_PERIOD_MAX;
  else
    if( level_changed_i )
      sys_event_period <= next_sys_event_period; 

always_ff @( posedge clk_i )
  if( srst_i || level_changed_i || counter_eq_period )
    sys_counter <= 'd0;
  else
    sys_counter <= sys_counter + 1'd1;
  
assign counter_eq_period = ( sys_counter == sys_event_period );

assign sys_event_o = counter_eq_period;

endmodule
