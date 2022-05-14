module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */

		logic P0,G0,P1,G1,P2,G2,P3,G3,c1,c2,c3;
		
		unit_adder4 UA0(.A(A[3:0]),.B(B[3:0]),.c_in(0),.P(P0),.G(G0),.S(Sum[3:0])) ;
		
		assign c1 = (0 & P0)|G0;
		
		unit_adder4 UA1(.A(A[7:4]),.B(B[7:4]),.c_in(c1),.P(P1),.G(G1),.S(Sum[7:4])) ;
		
		assign c2 = (0 & P0 & P1) |(G0 & P1)| G1;
		
		unit_adder4 UA2(.A(A[11:8]),.B(B[11:8]),.c_in(c2),.P(P2),.G(G2),.S(Sum[11:8])) ;
		
		assign c3 = (0 & P0 & P1 & P2)|(G0 & P1 & P2)|(G1 & P2)|(G2);
		
		unit_adder4 UA3(.A(A[15:12]),.B(B[15:12]),.c_in(c3),.P(P3),.G(G3),.S(Sum[15:12])) ;
		
		assign CO = ( 0 & P0 & P1 & P2 & P3) | ( P1 & P2 & P3 & G0 ) | ( G1 & P2 & P3) | (G2 & P3)| G3;
	   //assign G = (G0 & P3 & P2 & P1) | (G1 & P2 & P3) | (G2 & P3) | G3 ;
		//assign P = P1 & P2 & P3 & P0 ;
     
endmodule



module unit_adder
(
	input	 A,B,
	input c_in,
	output logic P,G,
	output S
);

	assign P=A^B;
	assign G=A&B;
	assign S=A^B^c_in;
	

endmodule



module unit_adder4
(
	input [3:0]A,B,
	input c_in,
	output P,G,
	output [3:0]S
);

		logic P0,G0,P1,G1,P2,G2,P3,G3,c1,c2,c3;
		
		unit_adder UA0(.A(A[0]),.B(B[0]),.c_in(c_in),.P(P0),.G(G0),.S(S[0])) ;
		
		assign c1 = (c_in & P0)|G0;
		
		unit_adder UA1(.A(A[1]),.B(B[1]),.c_in(c1),.P(P1),.G(G1),.S(S[1])) ;
		
		assign c2 = (c_in & P0 & P1) |(G0 & P1)| G1;
		
		unit_adder UA2(.A(A[2]),.B(B[2]),.c_in(c2),.P(P2),.G(G2),.S(S[2])) ;
		
		assign c3 = (c_in & P0 & P1 & P2)|(G0 & P1 & P2)|(G1 & P2)|(G2);
		
		unit_adder UA3(.A(A[3]),.B(B[3]),.c_in(c3),.P(P3),.G(G3),.S(S[3])) ;
		
		//assign c_out = ( c_in & P0 & P1 & P2 ) | ( P1 & P2 & G0 ) | ( G1 & P2) | G2;
		assign P = P1 & P2 & P3 & P0 ;
		assign G = (G0 & P3 & P2 & P1) | (G1 & P2 & P3) | (G2 & P3) | G3 ;

		
endmodule	