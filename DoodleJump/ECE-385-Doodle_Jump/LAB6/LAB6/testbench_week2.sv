//-------------------------------------------------------------------------
//      testbench_week2.sv                                               --
//                                                                       --
//      Created 3-23-2020 by Heyuan Li                                   --
//      Modified 4-3-2020 by Heyuan Li                                   --
//               changed control signals to active low, changed some     --
//               variable names to accomodate to ZJUI requirements       --
//                        Spring 2020 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      ZJUI Institute                                                   --
//-------------------------------------------------------------------------
// IMPORTANT:
// 1. This testbench for week 2 requires about 280 us(microsecond) to run,
// so please set the simulation period to be AT LEAST 280 us.
//
// 2. The function of each test is sensitive to the delay time of each operation.
// During debugging, it is okay to add operations, but please DO NOT change the 
// delay time of those existing operations. Otherwise, TAs may have trouble finding
// the desired results, as well as giving you credits on that.
//
// 3. It is encouraged to run tests following their orders, rather than running all
// at once,  for the sake of debugging. For example, you can start from running the
// first test. Then, uncomment the second test to run the first and the second test
// together, etc.
// Or, you may choose to run one of them by commenting the others, since the results
// of each test are independent of the other tests. Though, as the lab manual suggests,
// it is only your slc3 runs earlier tests correctly that it can run the later tests
// correctly.
//
// In case you do not know how to set the simulation period, here are the steps
// step 1: in [Assignments] tab choose [Settings...]
// step 2: under [EDA Tool Settings] tab choose [Simulation]
// step 3: find the [Test Benches...] button and click it
// step 4: in the pop up window, choose "testbench_week2.sv" and click [Edit...]
//         if you cannot find this testbench, please add this first
// step 5: in the pop up window, choose the [End Simulation at:] circle box and 
//         enter the desired simulation time
//
//
// 

module testbench_week2();

// half clock cycle at 50 MHz
// this is the amount of time represented by #1 delay
timeunit 10ns;
timeprecision 1ns;

   // internal variables
	logic [15:0] S, PC, MAR, MDR, IR;
	logic Clk, Reset, Run, Continue;
	logic [11:0] LED;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	logic CE, UB, LB, OE, WE;
	logic [19:0] ADDR;
	wire [15:0] Data;
	
	// initialize the toplevel entity
	lab6_toplevel test(.*);
	
	// set clock rule
   always begin : CLOCK_GENERATION 
		#1 Clk = ~Clk;
   end

	
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
		MAR = test.my_slc.d0.MAR_reg.Dout;
	   MDR = test.my_slc.d0.MDR_reg.Dout;
	   IR = test.my_slc.d0.IR_reg.Dout;	
	end
	
	// initialize clock signal 
	initial begin: CLOCK_INITIALIZATION 
		Clk = 0;
   end
	
	// begin testing
	initial begin: TEST_VECTORS
	   Reset = 0;
		Continue = 0;
		Run = 1;
		
	
//	// Basic I/O Test 1		
//	#2 Reset = 1;
//	#2 Run = 0;
//	   S = 16'h0003;
//	// change switch values to see if hex display is correct
//	#100 S = 16'hFFFF;
//   #100 S = 16'h0000;	
//	// reset program
//	#100 Reset = 0;
//	   Run = 1;
	
	
	
//	// Basic I/O Test 2
//	#10 Reset = 1;
//   #10 Continue = 0;
//		Run = 0;
//	   S = 16'h0006;
//	// see if the hex displays values after continue is hit
//   #100 Continue = 1;
//	// hit continue
//   #10 Continue = 0;
//	#10 Continue = 1;
//	// reset program
// 	#100	Reset = 0;
//	   Run = 1;
//
//		
//
//	// Self-Modifying Code Test
//	#10 Reset = 1;
//	#10 Continue = 1;
//		Run = 0;
//		S = 16'h000B;
//	// see if the hex display increment by 1 each time continue is hit
//	#100 Continue = 0;
//	#10 Continue = 1;
//	#100 Continue = 0;
//	#10 Continue = 1;
//	#100 Continue = 0;
//	#10 Continue = 1;
//	// reset program
//	#100 Reset = 0;
//	   Run = 1;
//
//		
//	
//	
//	// XOR Test
//	#10 Reset = 1;
//   #10 Continue = 1;
//		Run = 0;
//		S = 16'h0014;
//	// XOR xEEEE and x1111, and the result should be xFFFF
//	// enter xEEEE
//	#100 S = 16'hEEEE;
//	   Continue = 0;
//	#10 Continue = 1;
//	// enter x1111
//	#100 S = 16'h1111;
//	   Continue = 0;
//	#10 Continue = 1;
//	// reset program
//	#200 Reset = 0;
//	   Run = 1;
//	
//	
//	
//	// Multiplication Test
//	#10 Reset = 1;
//	#10 Continue = 1;
//		Run = 0;
//		S = 16'h0031;
//	// x2020 multiplies x0005, and the result should be xA0A0
//	// enter x0005
//	#200 S = 16'h0005;
//	   Continue = 0;
//	#10 Continue = 1;
//	// enter x2020
//	#150 S = 16'h2020;
//	   Continue = 0;
//	#10 Continue = 1;
//	// reset program
//	#1000 Reset = 0;
//	   Run = 1;
//		
//		
//		
	// Sort Test
	#10 Reset = 1;
	#10 Continue = 1;
		S = 16'h005A;
		Run = 0;
	// choose "sort" command
	#100 S = 16'h0002;
	   Continue = 0;
	#10 Continue = 1;
	#21000 S = 16'h0003;
	   Continue = 0;
	// after sort, index 0 should be x0001
	#10 Continue = 1;
	// index 1 should be x0003
	#300 Continue = 0;
	#10 Continue = 1;
	// index 2 should be x0007
	#200 Continue = 0;
	#10 Continue = 1;
	// index 3 should be x000D
	#200 Continue = 0;
	#10 Continue = 1;
	// index 4 should be x001B
	#200 Continue = 0;
	#10 Continue = 1;
	// index 5 should be x001F
	#200 Continue = 0;
	#10 Continue = 1;
	// index 6 should be x0046
	#200 Continue = 0;
	#10 Continue = 1;
	// index 7 should be x0047
	#200 Continue = 0;
	#10 Continue = 1;
	// index 8 should be x004E
	#200 Continue = 0;
	#10 Continue = 1;
	// index 9 should be x006B
	#200 Continue = 0;
	#10 Continue = 1;
	// index 10 should be x008C
	#200 Continue = 0;
	#10 Continue = 1;
	// index 11 should be x00B8
	#200 Continue = 0;
	#10 Continue = 1;
	// index 12 should be x00DB
	#200 Continue = 0;
	#10 Continue = 1;
	// index 13 should be x00EF
	#200 Continue = 0;
	#10 Continue = 1;
	// index 14 should be x00F8
	#200 Continue = 0;
	#10 Continue = 1;
	// index 15 should be x00FA
	#200 Continue = 0;
	#10 Continue = 1;
	// reset program
	#250 Reset = 0;
	   Run = 1;
//		
//		
//		
	// "Act Once" Test
	#10 Reset = 1;
	#10 Continue = 1;
		S = 16'h002A;
		Run = 0;
	// Hex should count up by 1 each time, starting from 0
	#150 Continue = 0;
	#10 Continue = 1;
	#100 Continue = 0;
	#10 Continue = 1;
	#100 Continue = 0;
	#10 Continue = 1;
	// reset program
	#100 Reset = 0;
	   Run = 1;

	end
	 
endmodule
