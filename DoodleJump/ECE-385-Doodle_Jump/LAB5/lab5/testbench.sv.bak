module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1

timeprecision 1ns;

// These signals are internal because the processor will be
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset, Run, ClearA_LoadB;
logic [7:0] S;
logic [7:0] Aval, Bval;
logic X;
logic [6:0] AhexL, AhexU, BhexL, BhexU;

// To store expected results
logic [7:0] ans_a, ans_b;

// A counter to count the instances where simulation results
// do not match with expected results
integer ErrorCnt = 0;

// Instantiating the DUT
lab5_toplevel lab5_toplevel0(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always #1 Clk = ~Clk;

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin
	Reset = 0;		// Toggle Reset
	Run = 1;
	ClearA_LoadB = 1;
	
   // Test 1: 7 * 59 = 413
	S = 8'b00000111; // 7

	#2 Reset = 1;

	#2 ClearA_LoadB = 0; 
	#2 ClearA_LoadB = 1;

	#10 S = 8'b00111011; // 59

	#2 Run = 0;

	#40 Run = 1;

	//answer = 413
	ans_a = 8'h01;
	ans_b = 8'h9d;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
		
	// Test 2: 7 * -59 = -413
	#10 S = 8'b00000111; // 7

	#2 ClearA_LoadB = 0; 
	#2 ClearA_LoadB = 1;

	#10 S = 8'b11000101; // -59

	#2 Run = 0;

	#40 Run = 1;

	//answer = -413
	ans_a = 8'hfe;
	ans_b = 8'h63;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
		
	// Test 3: -7 * 59 = -413
	#10 S = 8'b11111001; // -7

	#2 ClearA_LoadB = 0; 
	#2 ClearA_LoadB = 1;

	#10 S = 8'b00111011; // 59

	#2 Run = 0;

	#40 Run = 1;

	//answer = -413
	ans_a = 8'hfe;
	ans_b = 8'h63;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
	
	// Test 4: -7 * -59 = 413
	#10 S = 8'b11111001; // -7

	#2 ClearA_LoadB = 0; 
	#2 ClearA_LoadB = 1;

	#10 S = 8'b11000101; // -59

	#2 Run = 0;

	#40 Run = 1;

	//answer = 413
	ans_a = 8'h01;
	ans_b = 8'h9d;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
		
	// Test 5: -2*-2*-2*-2*-2 = -32
	#10 S = 8'b11111110; // -2

	#2 ClearA_LoadB = 0; 
	#2 ClearA_LoadB = 1;

	#10 S = 8'b11111110; // -2
	#2 Run = 0;
	#40 Run = 1;
	
	#10 S = 8'b11111110; // -2
	#2 Run = 0;
	#40 Run = 1;
	
	#10 S = 8'b11111110; // -2
	#2 Run = 0;
	#40 Run = 1;
	
	#10 S = 8'b11111110; // -2
	#2 Run = 0;
	#40 Run = 1;

	//answer = -32
	ans_a = 8'hff;
	ans_b = 8'he0;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
	
	
	if (ErrorCnt == 0)
		$display("Success!");
	else
		$display("Try again!");

end

endmodule
