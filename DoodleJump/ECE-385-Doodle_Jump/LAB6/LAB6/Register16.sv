module reg_16 
(
    input logic Clk, Reset, Load,
    input logic [15:0] Din,
//        output logic Shift_Out,
    output logic [15:0] Dout
);
always_ff @ (posedge Clk) begin
    if (~Reset) // Asynchronous Reset
        Dout <= 16'h0;
    else if (Load)
        Dout <= Din[15:0];
end
endmodule

module reg_3 
(
    input logic Clk, Reset, Load,
    input logic [2:0] Din,
//        output logic Shift_Out,
    output logic [2:0] Dout
);
always_ff @ (posedge Clk) begin
    if (~Reset) // Asynchronous Reset
        Dout <= 3'b0;
    else if (Load)
        Dout <= Din[2:0];
end
endmodule

module reg_1 
(
    input logic Clk, Reset, Load,
    input logic Din,
//        output logic Shift_Out,
    output logic Dout
);
always_ff @ (posedge Clk) begin
    if (~Reset) // Asynchronous Reset
        Dout <= 1'b0;
    else if (Load)
        Dout <= Din;
end
endmodule

module reg_12 
(
    input logic Clk, Reset, Load,
    input logic[11:0] Din,
//        output logic Shift_Out,
    output logic[11:0] Dout
);
always_ff @ (posedge Clk) begin
    if (~Reset) // Asynchronous Reset
        Dout <= 12'b0;
    else if (Load)
        Dout <= Din[11:0];
end
endmodule
