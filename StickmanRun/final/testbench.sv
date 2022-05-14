module testbench();

	timeunit 10ns;	// Half clock cycle at 50 MHz
						// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
	logic frame_clk = 0;
	
	// Toggle the clock
	// #1 means wait for a delay of 1 timeunit
	always begin : CLOCK_GENERATION
		#1 frame_clk = ~frame_clk;
	end

	initial begin: CLOCK_INITIALIZATION
		 frame_clk = 0;
	end 


	// Testing begins here
	// The initial block is not synthesizable
	// Everything happens sequentially inside an initial block
	// as in a software program
	
	
//	module stickman (   
// input Clk,                // 50 MHz clock
//			Reset,              // Active-high reset signal
//			frame_clk,          // The clock indicating a new frame (~60Hz)
//	input [7:0]   keycode, 		// Accept the last received key 
//	input [9:0]   DrawX, DrawY, // Current pixel coordinates
//	input [9:0]   GroundY,      // The height of floor
//	output logic  is_stickman   // Whether current pixel belongs to ball or background
//	);


	logic Clk, Reset, is_stickman;
//	logic [7:0] keycode;
//	logic [9:0]	DrawX, DrawY, GroundY, StickmanBottom;
//	stickman mystickman(.*);
//	
//	logic [7:0] page_cnt;
//	assign page_cnt = mystickman.curr_data;
	
		
	initial begin: TEST_VECTORS
	Reset = 1;
	#2 Reset = 0;
	
	end


endmodule
