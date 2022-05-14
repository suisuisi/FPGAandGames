// To test your adder one in a time. 
// Leave the adder you want to test uncomment in the top level


module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the adder will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset, LoadB, Run, CO;
logic [15:0] SW;
logic [15:0] Sum;
logic [6:0] Ahex0, Ahex1, Ahex2, Ahex3, Bhex0, Bhex1, Bhex2, Bhex3;

// To store expected results
logic [15:0] ans;
				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
lab4_adders_toplevel top(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
//test 1
Reset = 0;		// Toggle Reset

#2 Reset = 1;
   LoadB = 0;
   SW = 16'hfffe;

#2 LoadB = 1;

#2 SW = 16'h0001;
   ans = 16'hffff;
#2 Run = 0;	

#2 Run = 1;
// answer should be 0x0001+0xfffe = 0xffff
#22 if (Sum != ans) begin
	 ErrorCnt++;
	 $display("Test 1 failed");
	end

//test 2
Reset = 0;		// Toggle Reset

#2 Reset = 1;
   LoadB = 0;
   SW = 16'h0ece;

#2 LoadB = 1;

#2 SW = 16'h0385;
   ans = 16'h1253;
#2 Run = 0;	

#2 Run = 1;
// answer should be 0x0385+0x0ece = 0x1253
#22 if (Sum != ans) begin
	 ErrorCnt++;
	 $display("Test 2 failed");
	end

//test 3
Reset = 0;		// Toggle Reset

#2 Reset = 1;
   LoadB = 0;
   SW = 16'hffff;

#2 LoadB = 1;

#2 SW = 16'hffff;
   ans = 16'hfffe;
#2 Run = 0;	

#2 Run = 1;
// answer should be 0xffff+0xffff = 0xfffe
#22 if (Sum != ans) begin
	 ErrorCnt++;
	 $display("Test 3 failed");
	end

if (ErrorCnt == 0)
	$display("Success!");  // Command line output in ModelSim
else
	$display("%d error(s) detected. Try again!", ErrorCnt);
end
endmodule
