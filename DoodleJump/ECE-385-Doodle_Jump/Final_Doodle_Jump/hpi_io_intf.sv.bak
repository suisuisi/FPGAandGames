// Interface between NIOS II and EZ-OTG chip
module hpi_io_intf( input        Clk, Reset,
                    input [1:0]  from_sw_address,
                    output[15:0] from_sw_data_in,
                    input [15:0] from_sw_data_out,
                    input        from_sw_r, from_sw_w, from_sw_cs, from_sw_reset, // Active low
                    inout [15:0] OTG_DATA,
                    output[1:0]  OTG_ADDR,
                    output       OTG_RD_N, OTG_WR_N, OTG_CS_N, OTG_RST_N // Active low
                   );

// Buffer (register) for from_sw_data_out because inout bus should be driven 
//   by a register, not combinational logic.
logic [15:0] from_sw_data_out_buffer;

// TODO: Fill in the blanks below. 
always_ff @ (posedge Clk)
begin
    if(Reset)
    begin
        from_sw_data_out_buffer <= 
        OTG_ADDR                <= 
        OTG_RD_N                <= 
        OTG_WR_N                <= 
        OTG_CS_N                <= 
        OTG_RST_N               <= 
        from_sw_data_in         <= 
    end
    else 
    begin
        from_sw_data_out_buffer <= 
        OTG_ADDR                <= 
        OTG_RD_N                <= 
        OTG_WR_N                <= 
        OTG_CS_N                <= 
        OTG_RST_N               <= 
        from_sw_data_in         <= 
    end
end

// OTG_DATA should be high Z (tristated) when NIOS is not writing to OTG_DATA inout bus.
// Look at tristate.sv in lab 6 for an example.
assign OTG_DATA = 

endmodule 