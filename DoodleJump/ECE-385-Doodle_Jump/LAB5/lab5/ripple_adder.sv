module ADD_SUB9
(
    input   logic[7:0]     A,
    input   logic[7:0]     B,
	 input						fn,
	 input						M,
    output  logic[8:0]     Sum,
    output  logic           CO
);


	  logic c1,c2;
	  logic A8,BB8;
	  logic [7:0] BB;
	  
	  always_comb
	  begin
			case(M)
				1'b0:	BB = 8'b0;
				1'b1: BB = (B ^ {8{fn}});
				default: BB = 8'b0;
			endcase
	  end
	  
		assign BB8 = BB[7];
		assign A8 = A[7];
		
		adder4 FA0(.A(A[3:0]),.B(BB[3:0]),.c_in(fn),.S(Sum[3:0]),.c_out(c1)) ;
		adder4 FA1(.A(A[7:4]),.B(BB[7:4]),.c_in(c1),.S(Sum[7:4]),.c_out(c2)) ;
		full_adder FA3(.x(A8),.y(BB8),.z(c2),.S(Sum[8]),.c());
endmodule


module full_adder
(
	input	 x,y,z,
	output logic S,c
);

	assign S=x^y^z;
	assign c=(x&y)|(y&z)|(x&z);
	

endmodule


module adder4
(
	input [3:0]A,B,
	input c_in,
	output [3:0]S,
	output logic c_out
);

		logic c1,c2,c3;

		full_adder FA0(.x(A[0]),.y(B[0]),.z(c_in),.S(S[0]),.c(c1)) ;
		full_adder FA1(.x(A[1]),.y(B[1]),.z(c1),.S(S[1]),.c(c2)) ;
		full_adder FA2(.x(A[2]),.y(B[2]),.z(c2),.S(S[2]),.c(c3)) ;
		full_adder FA3(.x(A[3]),.y(B[3]),.z(c3),.S(S[3]),.c(c_out)) ;

endmodule	
		
		
		
		
		
		
		
		
		
		
		
		
		