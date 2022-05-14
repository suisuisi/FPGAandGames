//-------------------------------------------------------------------------
//      testbench_week1.sv                                               --
//                                                                       --
//      Created 3-23-2020 by Heyuan Li                                   --
//                        Spring 2020 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      ZJUI Institute                                                   --
//-------------------------------------------------------------------------
module testbench_week1();

// Half clock cycle at 50 MHz
// This is the amount of time represented by #1
timeunit 10ns;
timeprecision 1ns;

   // Internal variables
	logic [15:0] S, PC, MAR, MDR, IR;
	logic Clk, Reset, Run, Continue;
	logic [11:0] LED;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	logic CE, UB, LB, OE, WE;
	logic [19:0] ADDR;
	wire [15:0] Data;
	
	// initialize the toplevel entity
	lab6_toplevel test(.*);
	
	//	connect variables to signals
	//
	// In order to make this testbench work correctly, 
	//     make sure those names match what appear in your own design.
   // Feel free to use your own naming for the above variables or modules,
	//     as long as the four signals are correctly linked to those in your design.
   // Just do not change the variable names (PC, MAR, MDR and IR) because
   //     those are for the convenience of grading.	
	//
	// Note that my_slc is the instantiation name of the slc3 module in the toplevel
	// d0 is the instantiation name of the datapath module in the slc3 module
	// MAR_reg is the instantiation name of the MAR in the datapath module
   // MDR_reg is the instantiation name of the MDR in the datapath module
	// IR_reg is the instantiation name of the IR in the datapath module
   // data_out is the the variable name of output for each register instantiation	
	always begin
	#1
	PC = test.my_slc.d0.PC;
	MAR = test.my_slc.d0.MAR_reg.data_out;
	MDR = test.my_slc.d0.MDR_reg.data_out;
	IR = test.my_slc.d0.IR_reg.data_out;	
	end
	
	// set clock rule
   always begin : CLOCK_GENERATION 
		#1 Clk = ~Clk;
   end

	// initialize clock signal 
	initial begin: CLOCK_INITIALIZATION 
		Clk = 0;
   end
	
	// begin testing
	initial begin: TEST_VECTORS
	// give a dummy number for switch (3 here) and run
		Reset = 0;
		Continue = 1;
		Run = 0;
	   S = 16'd0074;
	#2 Reset = 1;
	#2 Run = 1;
	
	// run again to see if fetch automatically halts
	#10 Continue = 0;
	#5 Continue = 1;
	   S = 16'd0075;
	#5 Continue = 0;
	

	end
	 
endmodule
