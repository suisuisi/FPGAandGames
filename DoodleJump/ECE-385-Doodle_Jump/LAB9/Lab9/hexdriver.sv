
module hexdriver (
	input  logic [3:0] In,
	output logic [6:0] Out
);
	
always_comb begin
	unique case (In)
		4'b0000   : Out = 7'b1000000; // '0'
		4'b0001   : Out = 7'b1111001; // '1'
		4'b0010   : Out = 7'b0100100; // '2'
		4'b0011   : Out = 7'b0110000; // '3'
		4'b0100   : Out = 7'b0011001; // '4'
		4'b0101   : Out = 7'b0010010; // '5'
		4'b0110   : Out = 7'b0000010; // '6'
		4'b0111   : Out = 7'b1111000; // '7'
		4'b1000   : Out = 7'b0000000; // '8'
		4'b1001   : Out = 7'b0010000; // '9'
		4'b1010   : Out = 7'b0001000; // 'A'
		4'b1011   : Out = 7'b0000011; // 'b'
		4'b1100   : Out = 7'b1000110; // 'C'
		4'b1101   : Out = 7'b0100001; // 'd'
		4'b1110   : Out = 7'b0000110; // 'E'
		4'b1111   : Out = 7'b0001110; // 'F'
		default   : Out = 7'bX;
	endcase
end

endmodule
