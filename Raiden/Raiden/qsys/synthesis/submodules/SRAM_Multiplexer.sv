module SRAM_Multiplexer(
	// Avalon Clock Input
	input logic CLK, CLK2,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic [19:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [15:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [15:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// VGA Controller Instructions
	input logic [9:0] VGA_DrawX, VGA_DrawY,
	output logic [15:0] VGA_VAL,
	
	// SRAM Signals
	output logic    [19:0]		SRAM_ADDR,
	output logic          		SRAM_CE_N,
	inout logic     [15:0]		SRAM_DQ,
	output logic          		SRAM_LB_N,
	output logic          		SRAM_OE_N,
	output logic          		SRAM_UB_N,
	output logic          		SRAM_WE_N
);

assign SRAM_CE_N = 1'b0;
assign SRAM_LB_N = 1'b0;
assign SRAM_UB_N = 1'b0;

logic [19:0] VGA_ADDR;
assign VGA_ADDR = VGA_DrawY * 640 + VGA_DrawX;

logic CYCLE_EVEN;

always_ff @ (posedge CLK2) begin
	if(RESET) begin
		CYCLE_EVEN <= 1'b1;
	end else begin
		CYCLE_EVEN <= ~CYCLE_EVEN;
	end
end

logic[19:0] SRAM_ADDR_CANDIDATE;
logic SRAM_WE_N_CANDIDATE, SRAM_OE_N_CANDIDATE;
logic[15:0] SRAM_DQ_CANDIDATE;
always_comb begin
	SRAM_ADDR_CANDIDATE = CYCLE_EVEN ? AVL_ADDR : VGA_ADDR;
	SRAM_WE_N_CANDIDATE = CYCLE_EVEN ? ~AVL_WRITE : 1'b1;
	SRAM_OE_N_CANDIDATE = CYCLE_EVEN ? ~AVL_READ : 1'b0;
end
always_ff @ (posedge CLK2) begin
	SRAM_ADDR <= SRAM_ADDR_CANDIDATE;
	SRAM_WE_N <= SRAM_WE_N_CANDIDATE;
	SRAM_OE_N <= SRAM_OE_N_CANDIDATE;
end

always_ff @ (posedge CLK2) begin
	if(CYCLE_EVEN) begin
		AVL_READDATA <= SRAM_DQ;
	end else begin
		VGA_VAL <= SRAM_DQ;
	end
end

assign SRAM_DQ = SRAM_WE_N ? 1'bZ : AVL_WRITEDATA;
			
endmodule
