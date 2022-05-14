module NZP
(
        input LD_CC, LD_BEN, Clk,
		input [15:0] BUS_VAL,
        input [2:0] IR911,
		output logic BEN
	);
		
    logic [2:0] LOGIC_OUT, NZP_OUT, LOGIC_OUT2;
    logic BEN_IN;

    always_comb 
        begin
            if (BUS_VAL == 16'b0)
                LOGIC_OUT = 3'b010;
            else if (BUS_VAL[15] == 1'b0)
                LOGIC_OUT = 3'b001;
            else 
                LOGIC_OUT = 3'b100;
        end

    Register3 nzp(
        .Din(LOGIC_OUT),
        .Load(LD_CC),
        .Reset(1'b0),
        .clk(Clk),
        .Dout(NZP_OUT)
    );
        assign LOGIC_OUT2 = NZP_OUT & IR911;
        always_comb 
            begin
                if (LOGIC_OUT2 == 3'b0)
                    BEN_IN= 1'b0;
                else
                    BEN_IN = 1'b1;
            end

    MYDFF dff(
        .Din(BEN_IN),
        .clk(Clk),
        .Load(LD_BEN),
        .Dout(BEN)
    );

endmodule