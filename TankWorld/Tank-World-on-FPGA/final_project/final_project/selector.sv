module tanks_selector(
					input [7:0] keycode,
					input VGA_CLK,
					input[9:0] DrawX, DrawY,
					output are_two_tanks,
					output is_one_tank,
					output one_player_mode,
					output two_players_mode,
					input Reset
			);
			
enum logic [2:0] {OPM, TPM, OPM_WAIT, TPM_WAIT, OPM_DONE, TPM_DONE} State, Next_State;

always_ff @ (posedge VGA_CLK)
begin 
	if (Reset)
		State <= OPM;
	else
		State <= Next_State;
end 			

always_comb
begin 
	is_one_tank = 1'b0;
	are_two_tanks = 1'b0;
	one_player_mode = 1'b0;
	two_players_mode = 1'b0;
	unique case (State)
		OPM:
			begin
				if (keycode == 8'h52 || keycode == 8'h51 || keycode == 8'h1a || keycode == 8'h16)
					Next_State = OPM_WAIT;
				else if (keycode == 8'h28 ||  keycode == 8'h2c)
					Next_State = OPM_DONE;
				else
					Next_State = OPM;
			end
		OPM_WAIT:
			begin
				if (keycode == 8'h52 || keycode == 8'h51 || keycode == 8'h1a || keycode == 8'h16)
					Next_State = OPM_WAIT;
				else
					Next_State = TPM;
			end
		TPM:
			begin
				if (keycode == 8'h52 || keycode == 8'h51 || keycode == 8'h1a || keycode == 8'h16)
					Next_State = TPM_WAIT;
				else if (keycode == 8'h28 ||  keycode == 8'h2c)
					Next_State = TPM_DONE;
				else 
					Next_State = TPM;
			end
		TPM_WAIT:
			begin
				if (keycode == 8'h52 || keycode == 8'h51 || keycode == 8'h1a || keycode == 8'h16)
					Next_State = TPM_WAIT;
				else
					Next_State = OPM;
			end
		TPM_DONE: 
			Next_State = TPM_DONE;
		OPM_DONE:
			Next_State = OPM_DONE;
	endcase
	
	
	case (State)
		OPM_WAIT:	
			begin 
				if (DrawX > 195 && DrawX < 215 && DrawY > 285 && DrawY < 302)
					begin
						is_one_tank = 1'b1;
						are_two_tanks = 1'b0;
					end
				else
					begin
						is_one_tank = 1'b0;
						are_two_tanks = 1'b0;
					end
			end
		TPM_WAIT:	
			begin 
				if (DrawX > 195 && DrawX < 215 && DrawY > 315 && DrawY < 332)
					begin
						is_one_tank = 1'b0;
						are_two_tanks = 1'b1;
					end
				else
					begin
						is_one_tank = 1'b0;
						are_two_tanks = 1'b0;
					end
			end
		OPM:	
			begin 
				if (DrawX > 195 && DrawX < 215 && DrawY > 285 && DrawY < 302)
					begin
						is_one_tank = 1'b1;
						are_two_tanks = 1'b0;
					end
				else
					begin
						is_one_tank = 1'b0;
						are_two_tanks = 1'b0;
					end
			end
		TPM:
			begin
				if (DrawX > 195 && DrawX < 215 && DrawY > 315 && DrawY < 332)
					begin
						is_one_tank = 1'b0;
						are_two_tanks = 1'b1;
					end
				else 
					begin 
						is_one_tank = 1'b0;
						are_two_tanks = 1'b0;
					end
			   end
		TPM_DONE:
			begin
				is_one_tank = 1'b0;
				are_two_tanks = 1'b0;
				two_players_mode = 1'b1;
			end
		OPM_DONE:
			begin
				is_one_tank = 1'b0;
				are_two_tanks = 1'b0;
				two_players_mode = 1'b1;
			end
	endcase
				
end
					
endmodule 

module en_draw (input [7:0] keycode,
					 input VGA_CLK, Reset, en_state,
					 input [9:0] DrawX, DrawY,
					 output is_tank, is_count, is_number
					 );
					 
always_comb
begin
	if(en_state == 1'b1 && DrawX > 2 && DrawX < 22 && DrawY > 458 && DrawY < 478)
	begin
		is_tank = 1'b1;
		is_count = 1'b0;
		is_number = 1'b0;
	end
	else if(en_state == 1'b1 && DrawX > 567 && DrawX < 639 && DrawY > 428 && DrawY < 479)
	begin
		is_tank = 1'b0;
		is_count = 1'b1;
		is_number = 1'b0;
	end
	else if(en_state == 1'b1 && DrawX > 408 && DrawX < 560 && DrawY < 479 && DrawY > 441)
	begin
		is_tank = 1'b0;
		is_count = 1'b0;
		is_number = 1'b1;
	end
	else
	begin
		is_tank = 1'b0;
		is_count = 1'b0;
		is_number = 1'b0;
	end
end

endmodule 