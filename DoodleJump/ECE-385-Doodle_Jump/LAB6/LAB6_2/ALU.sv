module ALU
(
        input SEL,
        input [1:0] ALUK,
		input [15:0] SR1OUT,SR2OUT,IR40,
		output logic [15:0] ALUOUT
	);
		
    logic ALUMUXOUT;

    MUX2_1 ALUMUX(
        .A(SR2OUT),
        .B(IR40),
        .sel(SEL),
        .out(ALUMUXOUT)
        );

    always_comb
        begin
            unique case (ALUK)
                2'b00 : 
                        ALUOUT = ALUMUXOUT + SR1OUT;
                2'b01 :
                        ALUOUT = ALUMUXOUT & SR1OUT;
                2'b10 :
                        ALUOUT = SR1OUT;
                2'b11 :
                        ALUOUT = ~SR1OUT;
            endcase
        end

endmodule

