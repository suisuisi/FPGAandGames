module InvAddRoundKey(
    input logic [127:0] state,
    input logic [127:0] key,
    output logic [127:0] result
                );
    always_comb 
    begin
        result = key ^ state;        
    end
endmodule
