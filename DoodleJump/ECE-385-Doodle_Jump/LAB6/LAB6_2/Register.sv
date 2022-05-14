module Register (
    input logic [15:0] Din,
    input Load,
    input Reset,
    input clk,
    output logic [15:0] Dout
);
    always_ff @( posedge clk ) 
    begin
        if (Reset)
            Dout <= 16'b0;
        else
            if (Load) 
                Dout <= Din;
            else
                Dout <= Dout;
    end
        
endmodule

module Register12 (
    input logic [11:0] Din,
    input Load,
    input Reset,
    input clk,
    output logic [11:0] Dout
);
    always_ff @( posedge clk ) 
    begin
        if (Reset)
            Dout <= 12'b0;
        else
            if (Load) 
                Dout <= Din;
            else
                Dout <= Dout;
    end
        
endmodule

module Register3(
    input logic [2:0] Din,
    input Load,
    input Reset,
    input clk,
    output logic [2:0] Dout
);

    always_ff @( posedge clk ) 
    begin
        if (Reset)
            Dout <= 3'b0;
        else
            if (Load) 
                Dout <= Din;
            else
                Dout <= Dout;
    end

endmodule


module MYDFF(
    input logic Din, clk, Load,
    output logic Dout
);

    always_ff @( posedge clk )
        begin
            if (Load)
                Dout <= Din;
            else
                Dout <= Dout;
        end

endmodule
