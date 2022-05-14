module router (input  logic [1:0]  R,
               input  logic A_In, B_In, F_A_B,
               output logic A_Out, B_Out);
	
	always_comb
	begin
		unique case (R)
	 	   2'b00   : A_Out = A_In;
		   2'b01   : A_Out = A_In;
		   2'b10   : A_Out = F_A_B;
			2'b11   : A_Out = B_In;
	  	 endcase
	end
	
	always_comb
	begin
		unique case (R)
	 	   2'b00   : B_Out = B_In;
		   2'b01   : B_Out = F_A_B;
		   2'b10   : B_Out = B_In;
			2'b11   : B_Out = A_In;
	  	 endcase
	end
	
endmodule
