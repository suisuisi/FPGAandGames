//4-bit logic processor top level module
//for use with ECE 385 Fall 2016
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                Reset,   // Push button 0
                                Run,   // Push button 1
                                ClearA_LoadB,   // Push button 2
//                                Execute, // Push button 3
                  input  logic [7:0]  S,     // input data
//                  input  logic [2:0]  F,       // Function select
//                  input  logic [1:0]  R,       // Routing select
//                  output logic [3:0]  LED,     // DEBUG
                  output logic [7:0]  	Aval,    // DEBUG
													Bval,    // DEBUG
						output logic			X,
						output logic 			m,
                  output logic [6:0]   AhexL,
													AhexU,
													BhexL,
													BhexU);

	 //local logic variables go here
	 logic Reset_SH, ClearA_LoadB_SH, Run_SH;
//	 logic [2:0] F_S;
//	 logic [1:0] R_S;
	 logic	calb, shift, add, sub;
	 logic [7:0] S_S, A_out,B_out;
	 logic [8:0] adder_out;
	 logic X_out;
	 logic A2B;
	 logic cleara, cleara_remainb;
	 
	 assign cleara = Reset_SH | ClearA_LoadB_SH |cleara_remainb;
	 assign m = B_out[0];
	 assign fn_in = sub & m;
	 
	 assign Aval = A_out;
	 assign Bval = B_out;
	 assign X = X_out;
	 
	 
	 //We can use the "assign" statement to do simple combinational logic
//	 assign Aval = A;
//	 assign Bval = B;
//	 assign LED = {Execute_SH,LoadA_SH,LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL
	 
	 //Instantiation of modules here
	 Dreg			X_unit  (
								.Clk(Clk),
								.Load(add),
								.Reset(cleara),
								.D(adder_out[8]),
								.Q(X_out)
									);
									
	ADD_SUB9		adder_unit (
								.A(A_out),
								.B(S_S),
								.fn(fn_in),
								.M(m),
								.Sum(adder_out),
								.CO()								
								);							
																		
									
	 reg_8     reg_unitA (
                        .Clk(Clk),
                        .Reset(cleara),
                        .Shift_In(X_out), //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Load(add),
                        .Shift_En(shift),
                        .D(adder_out[7:0]),
                        .Shift_Out(A2B),
                        .Data_Out(A_out)
								);
	reg_8     reg_unitB (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .Shift_In(A2B), //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Load(ClearA_LoadB_SH),
                        .Shift_En(shift),
                        .D(S_S),
                        .Shift_Out(),
                        .Data_Out(B_out)
								);
							
								
	 control          control_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .Run(Run_SH),
                        .Shift(shift),
                        .Add(add),
                        .Sub(sub),
								.cleara_remainb(cleara_remainb));
								
	 HexDriver        HexAL (
                        .In0(A_out[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B_out[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(A_out[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B_out[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH, Run_SH});
	  sync Din_sync[7:0] (Clk, S, S_S);
//	  sync F_sync[2:0] (Clk, F, F_S);
//	  sync R_sync[1:0] (Clk, R, R_S);
	  
endmodule
