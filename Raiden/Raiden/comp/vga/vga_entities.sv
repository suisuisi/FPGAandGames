module VGA_entities #(
	parameter REGISTERS = 256
) (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic [7:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [REGISTERS-1:0][31:0] EXPORT_DATA		// Exported Conduit Signal
);

genvar i;
generate
	for(i = 0; i < REGISTERS; i++) begin: generate_vga_entity_registers
		register #(32) entity_register (
			.Clk(CLK), .Reset(RESET),
			.Load((AVL_ADDR == i) && AVL_WRITE),
			.Din(AVL_WRITEDATA),
			.Dout(EXPORT_DATA[i])
		);
	end
endgenerate

assign AVL_READDATA = EXPORT_DATA[AVL_ADDR];

endmodule
