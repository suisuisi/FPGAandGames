module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset, LoadA, LoadB, Execute;
logic [3:0] Din;
logic [2:0] F;
logic [1:0] R;
logic [3:0] LED;
logic [3:0] Aval,
		 Bval;
logic [6:0] AhexL,
		 AhexU,
		 BhexL,
		 BhexU; 

// To store expected results
logic [3:0] ans_1a, ans_2b;
				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
Processor processor0(.*);	

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
Reset = 0;		// Toggle Rest
LoadA = 1;
LoadB = 1;
Execute = 1;
Din = 4'hB;	// Specify Din, F, and R
F = 3'b010;
R = 2'b10;

#2 Reset = 1;

#2 LoadA = 0;	// Toggle LoadA
#2 LoadA = 1;

#2 LoadB = 0;	// Toggle LoadB
	Din = 4'h2;	// Change Din
#2 LoadB = 1;
	Din = 4'h0;	// Change Din again

#2 Execute = 0;	// Toggle Execute
   
#22 Execute = 1;
    ans_1a = (4'hB ^ 4'h2); // Expected result of 1st cycle
    // Aval is expected to be 4’hB XOR 4’h2
    // Bval is expected to be the original 4’h2
    if (Aval != ans_1a)
	 ErrorCnt++;
    if (Bval != 4'h2)
	 ErrorCnt++;
    F = 3'b110;	// Change F and R
    R = 2'b01;

#2 Execute = 0;	// Toggle Execute
#2 Execute = 1;

#22 Execute = 0;
    // Aval is expected to stay the same
    // Bval is expected to be the answer of 1st cycle XNOR 4’h2
    if (Aval != ans_1a)	
	 ErrorCnt++;
    ans_2b = ~(ans_1a ^ 4'h2); // Expected result of 2nd  cycle
    if (Bval != ans_2b)
	 ErrorCnt++;
    R = 2'b11;
#2 Execute = 1;

// Aval and Bval are expected to swap
#22 if (Aval != ans_2b)
	 ErrorCnt++;
    if (Bval != ans_1a)
	 ErrorCnt++;


if (ErrorCnt == 0)
	$display("Success!");  // Command line output in ModelSim
else
	$display("%d error(s) detected. Try again!", ErrorCnt);
end
endmodule
