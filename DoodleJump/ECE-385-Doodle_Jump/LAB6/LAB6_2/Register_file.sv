module Register_file (
    input [2:0] DRMUXOUT,SR1MUXOUT, SR2, 
    input LD_REG, Clk, Reset,
    input [15:0] BUS_VAL,
    output logic [15:0] SR2OUT,SR1OUT
);
    logic [15:0] R0, R1, R2, R3, R4, R5, R6, R7;

    always_ff @( posedge Clk) begin
        if (LD_REG) begin
            case (DRMUXOUT)
                3'b000: R0 <= BUS_VAL;
                3'b001: R1 <= BUS_VAL; 
                3'b010: R2 <= BUS_VAL; 
                3'b011: R3 <= BUS_VAL; 
                3'b100: R4 <= BUS_VAL; 
                3'b101: R5 <= BUS_VAL; 
                3'b110: R6 <= BUS_VAL; 
                default:R7 <= BUS_VAL; 
            endcase
        end
		  if (Reset) begin
            R0 <= 16'b0;
            R1 <= 16'b0;
            R2 <= 16'b0;
            R3 <= 16'b0;
            R4 <= 16'b0;
            R5 <= 16'b0;
            R6 <= 16'b0;
            R7 <= 16'b0;
        end
    end

    always_comb begin
        case (SR1MUXOUT)
            3'b000: SR1OUT = R0;
            3'b001: SR1OUT = R1;
            3'b010: SR1OUT = R2;
            3'b011: SR1OUT = R3;
            3'b100: SR1OUT = R4;
            3'b101: SR1OUT = R5;
            3'b110: SR1OUT = R6;
            default:SR1OUT = R7;
        endcase

        case (SR2)
            3'b000: SR2OUT = R0;
            3'b001: SR2OUT = R1;
            3'b010: SR2OUT = R2;
            3'b011: SR2OUT = R3;
            3'b100: SR2OUT = R4;
            3'b101: SR2OUT = R5;
            3'b110: SR2OUT = R6;
            default:SR2OUT = R7;
        endcase
    end


endmodule