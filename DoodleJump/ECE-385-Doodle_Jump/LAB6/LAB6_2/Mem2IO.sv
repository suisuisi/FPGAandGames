//-------------------------------------------------------------------------
//      Mem2IO.vhd                                                       --
//      Stephen Kempf                                                    --
//                                                                       --
//      Revised 03-15-2006                                               --
//              03-22-2007                                               --
//              07-26-2013                                               --
//              03-04-2014                                               --
//              02-13-2017                                               --
//                                                                       --
//      For use with ECE 385 Experiment 6                                --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  Mem2IO ( 	input logic Clk, Reset,
					input logic [19:0]  ADDR, 
					input logic CE, UB, LB, OE, WE,
					input logic [15:0]  Switches,
					input logic [15:0] Data_from_CPU, Data_from_SRAM,
					output logic [15:0] Data_to_CPU, Data_to_SRAM,
					output logic [3:0]  HEX0, HEX1, HEX2, HEX3 );

	logic [15:0] hex_data;
   
	// Load data from switches when address is xFFFF, and from SRAM otherwise.
	always_comb
    begin 
        Data_to_CPU = 16'd0;
        if (WE && ~OE) 
			if (ADDR[15:0] == 16'hFFFF) 
				Data_to_CPU = Switches;
			else 
				Data_to_CPU = Data_from_SRAM;
    end

    // Pass data from CPU to SRAM
	assign Data_to_SRAM = Data_from_CPU;

	// Write to LEDs when WE is active and address is xFFFF.
	always_ff @ (posedge Clk) begin 
		if (Reset) 
			hex_data <= 16'd0;
		else if ( ~WE & (ADDR[15:0] == 16'hFFFF) ) 
			hex_data <= Data_from_CPU;
    end
       
	assign HEX0 = hex_data[3:0];
	assign HEX1 = hex_data[7:4];
	assign HEX2 = hex_data[11:8];
	assign HEX3 = hex_data[15:12];

endmodule
