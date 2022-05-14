// same as bgROM, read only guys!!!!
module spROM (
						input [19:0] read_address,
						input Clk, 
						output logic [11:0] data_Out
				  );

				  // mem has width of 3 bits and a total of 400 addresses

logic [11:0] mem [0:76799];



initial

begin

	 $readmemh("sp3.txt", mem);

end





always_ff @ (posedge Clk) begin


	data_Out<= mem[read_address];

end



endmodule