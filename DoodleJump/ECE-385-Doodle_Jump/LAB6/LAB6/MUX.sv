module Mux2 (
        input logic Select,
        input logic [15:0] A,
		  input logic [15:0] B,
        output logic [15:0] out
    );
   always_comb
	begin
			case(Select)
			1'b0: out=A;
			1'b1: out=B;
			endcase
	end
endmodule

module Mux2_3 (
        input logic Select,
        input logic [2:0] A,
		  input logic [2:0] B,
        output logic [2:0] out
    );
   always_comb
	begin
			case(Select)
			1'b0: out=A;
			1'b1: out=B;
			endcase
	end
endmodule



module Mux4 (
        input logic [1:0]Select,
        input logic [15:0] A,
		  input logic [15:0] B,
		  input logic [15:0] C,
		  input logic [15:0] D,
        output logic [15:0] out
    );
   always_comb
	begin
			case(Select)
			2'b00: out=A;
			2'b01: out=B;
			2'b10: out=C;
			2'b11: out=D;
			endcase
	end
endmodule



module Mux_bus (
        input logic [3:0] Select,
        input logic [15:0] A,
		  input logic [15:0] B,
		  input logic [15:0] C,
		  input logic [15:0] D,
        output logic [15:0] out
    );
   always_comb
	begin
			case(Select)
			4'b0001: out=A;
			4'b0010: out=B;
			4'b0100: out=C;
			4'b1000: out=D;
			default: out = 16'h0000;
			endcase
	end
endmodule


