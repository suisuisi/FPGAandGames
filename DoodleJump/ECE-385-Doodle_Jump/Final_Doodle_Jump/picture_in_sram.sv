module read_SRAM (
    input logic Clk,
    input [19:0]SRAM_ADDR,
    output [5:0]Data_out,
    inout wire[15:0]SRAM_DQ
);

    logic [15:0] Data_from_SRAM;
    // The tri-state buffer serves as the interface between Mem2IO and SRAM
    tristate #(.N(16)) tr0(.Clk(Clk), .Data_read(Data_from_SRAM), .Data(SRAM_DQ));

    always_ff @( posedge Clk ) 
    begin 
        Data_out <= Data_from_SRAM[5:0];        
    end

endmodule