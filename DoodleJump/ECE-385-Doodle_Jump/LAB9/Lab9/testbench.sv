
module testbench();

	// Half clock cycle at 50 MHz
	// This is the amount of time represented by #1
	timeunit 10ns;
	timeprecision 1ns;

	// Internal variables
	logic CLK;
	logic RESET;
	logic AES_START;
	logic AES_DONE;
	logic [127:0] AES_KEY;
	logic [127:0] AES_MSG_ENC;
	logic [127:0] AES_MSG_DEC;
	logic [4:0]curr_state, next_state;
	logic start,done;
	
	// initialize the toplevel entity
	AES MYAES(.*);
	
	//	connect variables to signals
	always begin
//	#1	curr_state = MYAES.state;
//		next_state = MYAES.next_state;
   #1 start = MYAES.AES_START;
		done = MYAES.AES_DONE;
      

	
	end
	
	// set clock rule
   always begin : CLOCK_GENERATION 
	#1 CLK = ~CLK;
   end

	// initialize clock signal 
	initial begin: CLOCK_INITIALIZATION 
		CLK = 0;
   end
	
	// begin testing
	initial begin: TEST_VECTORS
		RESET = 1;
		AES_START = 0;
		AES_KEY = 128'h000102030405060708090a0b0c0d0e0f;
		AES_MSG_ENC = 128'hdaec3055df058e1c39e814ea76f6747e;
		
	#2 RESET = 0;
		AES_START = 1;
	end
	

endmodule