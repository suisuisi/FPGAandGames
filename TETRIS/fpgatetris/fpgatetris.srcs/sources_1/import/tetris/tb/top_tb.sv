`include "../rtl/defs.vh"

module top_tb;

logic clk;
logic rst;
initial
  begin
    clk = 1'b0;
    forever
      begin
        #10ns
        clk = !clk;
      end
  end

initial
  begin
    rst = 1'b0;
    #1ns;
    rst <= 1'b1;
    @( negedge clk );
    rst <= 1'b0;
  end
user_event_t           user_event;
logic                  user_event_ready;
logic                  user_event_rd_req;

task make_event( input user_event_t _event );
  @( posedge clk );
  user_event       <= _event;
  user_event_ready <= 1'b1;
  wait( user_event_rd_req );
  @( posedge clk );
  user_event_ready <= 1'b0;
endtask

user_event_t event_queue[$];

localparam USER_EVENT_PERIOD_TICKS = 20;

initial
  begin
    user_event       = EV_DOWN;
    user_event_ready = 1'b0;

    event_queue.push_back( EV_ENTER );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_LEFT  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    event_queue.push_back( EV_ROTATE  );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_RIGHT );
    //event_queue.push_back( EV_DOWN );
    
    forever
      begin
        repeat( USER_EVENT_PERIOD_TICKS ) @( posedge clk );
        
        if( event_queue.size() > 0 )
          begin
            make_event( event_queue[0] );
            event_queue.pop_front( );
          end

      end
  end


main_game_logic ml (
  .clk_i                                  ( clk               ),
  .rst_i                                  ( rst               ),
  
  .user_event_i                           ( user_event        ),
  .user_event_ready_i                     ( user_event_ready  ),
  .user_event_rd_req_o                    ( user_event_rd_req )

);

endmodule
