module  Mem2IO ( 	input logic Clk, Reset,
					input logic [19:0]  ADDR, 
					input logic CE, UB, LB, OE, WE,
					input logic [15:0] Data_from_SRAM,
					output logic [15:0] Data_to_CPU
					);

//	logic [15:0] hex_data;
   
	// Load data from switches when address is xFFFF, and from SRAM otherwise.
	always_comb
    begin 
        Data_to_CPU = 16'd0;
        if (WE && ~OE) 
//			if (ADDR[15:0] == 16'hFFFF) 
//				Data_to_CPU = Switches;
//			else 
		  Data_to_CPU = Data_from_SRAM;
    end

    // Pass data from CPU to SRAM
//	assign Data_to_SRAM = Data_from_CPU;

	// Write to LEDs when WE is active and address is xFFFF.
//	always_ff @ (posedge Clk) begin 
//		if (Reset) 
//			hex_data <= 16'd0;
//		else if ( ~WE & (ADDR[15:0] == 16'hFFFF) ) 
//			hex_data <= Data_from_CPU;
//    end
       

endmodule