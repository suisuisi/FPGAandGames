module sp_addr_lookup(
								input is_one_tank, are_two_tanks, is_tank_final, en_tank, en_count, en_number,
								input [1:0] is_tank_out,
								input [9:0] DrawX, DrawY,
								input [19:0] DistX, DistY,
								output [19:0] Addr_out
							);
							
logic [19:0] DrawX_ext, DrawY_ext;

always_comb 
   begin
	Addr_out = 20'b0;
	DrawX_ext[19:10] = {10{1'b0}};
	DrawX_ext[9:0] = DrawX;
	DrawY_ext[19:10] = {10{1'b0}};
	DrawY_ext[9:0] = DrawY;
	if (is_one_tank == 1)
		Addr_out = (DrawY_ext - 20'd285 + 20'd155) * 20'd320 + (DrawX_ext - 20'd195);
	else if (are_two_tanks == 1)
		Addr_out = (DrawY_ext - 20'd315 + 20'd155) * 20'd320 + (DrawX_ext - 20'd195);
		
	if (en_tank == 1)
		Addr_out = (DrawY_ext - 20'd458 + 20'd155) * 20'd320 + (DrawX_ext - 20'd2);
	else if (en_count == 1)
		Addr_out = (DrawY_ext - 20'd428 + 20'd190) * 20'd320 + (DrawX_ext - 20'd567 + 20'd245);
	else if (en_number == 1)
		Addr_out = (DrawY_ext - 20'd442 + 20'd201) * 20'd320 + (DrawX_ext - 20'd408);
		
	if (is_tank_final == 1)
		unique case (is_tank_out)
		2'b00: Addr_out = (DistY + 20'd155) * 20'd320 + DistX;
		2'b01: Addr_out = (DistY + 20'd155) * 20'd320 + DistX + 20'd37;
		2'b10: Addr_out = (DistY + 20'd155) * 20'd320 + DistX + 20'd91;
		2'b11: Addr_out = (DistY + 20'd155) * 20'd320 + DistX + 20'd110;
		endcase
	end

endmodule 