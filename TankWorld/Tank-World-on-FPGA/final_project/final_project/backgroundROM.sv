// Read only guys!!!!
module bgROM

(

		input [19:0] read_address,

		input Clk,

		output logic [11:0] data_Out

);
logic [11:0] mem [0:76799];
initial

begin

	 $readmemh("background2.txt", mem);

end

always_ff @ (posedge Clk) begin


	data_Out<= mem[read_address];

end



endmodule