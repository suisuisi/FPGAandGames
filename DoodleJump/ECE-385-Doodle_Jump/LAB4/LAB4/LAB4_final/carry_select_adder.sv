module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
	logic c1,c2,c3;
	  
	adder4 FA0(.A(A[3:0]),.B(B[3:0]),.c_in(0),.S(Sum[3:0]),.c_out(c1)) ;
	  
	csa4 csa4_0(.A(A[7:4]),.B(B[7:4]),.c_in(c1),.S(Sum[7:4]),.c_out(c2)) ;
	csa4 csa4_1(.A(A[11:8]),.B(B[11:8]),.c_in(c2),.S(Sum[11:8]),.c_out(c3)) ;
	csa4 csa4_2(.A(A[15:12]),.B(B[15:12]),.c_in(c3),.S(Sum[15:12]),.c_out(CO)) ;
	  
endmodule


module MUX2
(
	input [1:0] in,
	input sel,
	output logic out
);
	always_comb
		begin
			case (sel)
				1'b0 : out = in[0];
				1'b1 : out = in[1];
				default : out = in[0];
			endcase
		end
endmodule
	
module MUX_4
(
		input [3:0] A,B,
		input sel,
		output logic [3:0]out
	);
		always_comb
			begin
				case (sel)
					1'b0 : out = A;
					1'b1 : out = B;
					default : out = 4'b0000;
				endcase
			end
	endmodule

module csa4
(
	input [3:0]A,B,
	input c_in,
	output [3:0]S,
	output logic c_out
);

	logic [3:0] mid_s0, mid_s1;
	logic c_out0, c_out1;
	logic [1:0] mid_test0,mid_test1,mid_test2,mid_test3;
	
	
	adder4 FA0(.A(A[3:0]),.B(B[3:0]),.c_in(0),.S(mid_s0[3:0]),.c_out(c_out0)) ;
	adder4 FA1(.A(A[3:0]),.B(B[3:0]),.c_in(1),.S(mid_s1[3:0]),.c_out(c_out1)) ;
	assign c_out = (c_in & c_out1) | c_out0;
	
//	assign mid_test0[0] = mid_s0[0];
//	assign mid_test0[1] = mid_s1[0];
	
//	assign mid_test1[0] = mid_s0[1];
//	assign mid_test1[1] = mid_s1[1];
	
//	assign mid_test2[0] = mid_s0[2];
//	assign mid_test2[1] = mid_s1[2];
	
//	assign mid_test3[0] = mid_s0[3];
//	assign mid_test3[1] = mid_s1[3];
	
//	MUX2 mu1(.in(mid_test0[1:0]),.sel(c_in),.out(S[0]));
//	MUX2 mu2(.in(mid_test1[1:0]),.sel(c_in),.out(S[1]));
//	MUX2 mu3(.in(mid_test2[1:0]),.sel(c_in),.out(S[2]));
//	MUX2 mu4(.in(mid_test3[1:0]),.sel(c_in),.out(S[3]));

	MUX_4 mu1(.A(mid_s0[3:0]),.B(mid_s1[3:0]),.sel(c_in),.out(S[3:0]));
	
	
endmodule
	
	