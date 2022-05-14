module avalon_mm_passthrough #(
	parameter ADDR_WIDTH = 8
) (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic [ADDR_WIDTH-1:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Avalon Clock Input
	output logic PASS_CLK,
	
	// Avalon Reset Input
	output logic PASS_RESET,
	
	// Avalon-MM Slave Signals
	output logic PASS_READ,					// Avalon-MM Read
	output logic PASS_WRITE,					// Avalon-MM Write
	output logic [ADDR_WIDTH-1:0] PASS_ADDR,			// Avalon-MM Address
	output logic [31:0] PASS_WRITEDATA,	// Avalon-MM Write Data
	input  logic [31:0] PASS_READDATA	// Avalon-MM Read Data
);

assign PASS_CLK = CLK;
assign PASS_RESET = RESET;

assign PASS_READ = AVL_READ;
assign PASS_WRITE = AVL_WRITE;
assign PASS_ADDR = AVL_ADDR;
assign PASS_WRITEDATA = AVL_WRITEDATA;
assign AVL_READDATA = PASS_READDATA;

endmodule
