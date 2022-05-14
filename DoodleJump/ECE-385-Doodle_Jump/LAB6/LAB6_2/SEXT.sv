module SEXT4 (
    input logic [4:0] IR,
    output logic [15:0] OUT
);

	always_comb
    if (IR[4] == 1'b1)
		begin
        OUT = {11'b11111111111,IR};
		 end
    else
		begin
        OUT = {11'b0,IR};
		 end
		  
endmodule

module SEXT5 (
    input logic [5:0] IR,
    output logic [15:0] OUT
);

	always_comb
    if (IR[5] == 1'b1)
		begin
        OUT = {10'b1111111111,IR};
		 end
    else
		begin
        OUT = {10'b0,IR};
		 end
		  
endmodule

module SEXT8 (
    input logic [8:0] IR,
    output logic [15:0] OUT
);

	always_comb
    if (IR[8] == 1'b1)
		begin
        OUT = {7'b1111111,IR};
		 end
    else
		begin
        OUT = {7'b0,IR};
		 end
	
endmodule

module SEXT10 (
    input logic [10:0] IR,
    output logic [15:0] OUT
);

	always_comb
    if (IR[10] == 1'b1)
		begin
        OUT = {5'b11111,IR};
		 end
    else
		begin
        OUT = {5'b0,IR};
		 end
		  
endmodule