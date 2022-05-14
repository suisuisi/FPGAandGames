module register #(
	parameter WIDTH = 8
) (
	input logic Clk, Reset, Load,
	input logic [WIDTH-1:0] Din,
	output logic [WIDTH-1:0] Dout
);

always_ff @ (posedge Clk) begin
	if(Reset) begin
		Dout <= {WIDTH{1'b0}};
	end else if(Load) begin
		Dout <= Din;
	end
end

endmodule
