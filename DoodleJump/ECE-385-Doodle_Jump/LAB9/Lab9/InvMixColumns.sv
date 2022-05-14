/************************************************************************
Inverse Mix Columns

Po-Han Huang, Spring 2017
Joe Meng, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

// InvMixColumns 
// Input : 32-bit Word
// Output: Inverse MixColumns transformation of the Word
module InvMixColumns (
	input  logic [31:0] in,
	output logic [31:0] out
);

// Declaration of the individual Bytes in Word
logic [7:0] a0, a1, a2, a3;
// Declaration of the finite field multiplication results
logic [7:0] b00, b01, b02, b03,
			   b10, b11, b12, b13,
			   b20, b21, b22, b23,
			   b30, b31, b32, b33;

// Decompose the Word into 4 Bytes
assign {a0, a1, a2, a3} = in;

// Finite field multiplications with {09}
GF_Mul_9 gfmul9_0(a3, b03);
GF_Mul_9 gfmul9_1(a0, b10);
GF_Mul_9 gfmul9_2(a1, b21);
GF_Mul_9 gfmul9_3(a2, b32);

// Finite field multiplications with {0b}
GF_Mul_b gfmulb_0(a1, b01);
GF_Mul_b gfmulb_1(a2, b12);
GF_Mul_b gfmulb_2(a3, b23);
GF_Mul_b gfmulb_3(a0, b30);

// Finite field multiplications with {0d}
GF_Mul_d gfmuld_0(a2, b02);
GF_Mul_d gfmuld_1(a3, b13);
GF_Mul_d gfmuld_2(a0, b20);
GF_Mul_d gfmuld_3(a1, b31);

// Finite field multiplications with {0e}
GF_Mul_e gfmule_0(a0, b00);
GF_Mul_e gfmule_1(a1, b11);
GF_Mul_e gfmule_2(a2, b22);
GF_Mul_e gfmule_3(a3, b33);

// Assign output by XORing the above results
assign out[31:24] = b00^b01^b02^b03;
assign out[23:16] = b10^b11^b12^b13;
assign out[15: 8] = b20^b21^b22^b23;
assign out[ 7: 0] = b30^b31^b32^b33;

endmodule

// xtime 
// Input : input Byte
// Output: ({02}*a) in finite field
function [0:7] xtime (input logic [0:7] in);

	return {in[1:7],1'b0}^(8'h1b&{8{in[0]}});

endfunction

// GF_Mul_9 
// Input : input Byte
// Output: ({09}*a) in finite field
module GF_Mul_9 (
	input  logic [0:7] in,
	output logic [0:7] out
);

	logic [0:7] two, four, eight;

	assign two = xtime(in);
	assign four = xtime(two);
	assign eight = xtime(four);

	// Output = 8+1=9={9}
	assign out = eight^in;

endmodule

// GF_Mul_b 
// Input : input Byte
// Output: ({0b}*a) in finite field
module GF_Mul_b (
	input  logic [0:7] in,
	output logic [0:7] out
);

	logic [0:7] two, four, eight;

	assign two = xtime(in);
	assign four = xtime(two);
	assign eight = xtime(four);

	// Output = 8+2+1=11={b}
	assign out = eight^two^in;

endmodule

// GF_Mul_d 
// Input : input Byte
// Output: ({0d}*a) in finite field
module GF_Mul_d (
	input  logic [0:7] in,
	output logic [0:7] out
);

	logic [0:7] two, four, eight;

	assign two = xtime(in);
	assign four = xtime(two);
	assign eight = xtime(four);

	// Output = 8+4+1=13={d}
	assign out = eight^four^in;

endmodule

// GF_Mul_e 
// Input : input Byte
// Output: ({0e}*a) in finite field
module GF_Mul_e (
	input  logic [0:7] in,
	output logic [0:7] out
);

	logic [0:7] two, four, eight;

	assign two = xtime(in);
	assign four = xtime(two);
	assign eight = xtime(four);

	// Output = 8+4+2=14={e}
	assign out = eight^four^two;

endmodule
