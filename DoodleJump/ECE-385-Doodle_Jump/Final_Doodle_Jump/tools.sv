

//-------------------------------------------------------------------------
//      tool.sv                                                          --
//      Created by Yuhao Ge & Haina Lou                                  --
//      Fall 2021                                                        --
//                                                                       --
//      This module is used to generate tools which can be used by doodle--
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module tool ( input     Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					   input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						input [9:0]   Ball_X_Pos_out, Ball_Y_Pos_out, Ball_Size_out,Ball_Y_Step_out,
						input [13:0][9:0]	  tool_x, tool_y, tool_size, 
						output logic  gain, is_tool
					  );	
	 logic check;
	 logic [13:0] sub_is_tool, sub_check;
	 
	 always_comb 
	 begin
		 for (int j=0; j<14; j++)
		 begin
				sub_is_tool[j] = ((DrawX <= tool_x[j] + tool_size[j]) && (DrawX >= tool_x[j] + ~tool_size[j] + 10'b1)) && 
									  ((DrawY <= tool_y[j] + tool_size[j]) && (DrawY >= tool_y[j] + ~tool_size[j] + 10'b1)) && (tool_size[j] > 0);
									  
				sub_check[j] = ((Ball_X_Pos_out + Ball_Size_out > tool_x[j] - tool_size[j]) && (Ball_X_Pos_out - Ball_Size_out < tool_x[j] + tool_size[j]) && (tool_size[j] > 0) &&
					             (Ball_Y_Pos_out + Ball_Size_out > tool_y[j] - tool_size[j]) && (Ball_Y_Pos_out - Ball_Size_out < tool_y[j] + tool_size[j]) && Ball_Y_Step_out <= 10'd20);
		 end
	 
		 is_tool = sub_is_tool[0] || sub_is_tool[1] || sub_is_tool[2] || sub_is_tool[3] || sub_is_tool[4] || sub_is_tool[5] || sub_is_tool[6] ||
					  sub_is_tool[7] || sub_is_tool[8] || sub_is_tool[9] || sub_is_tool[10]|| sub_is_tool[11]|| sub_is_tool[12]|| sub_is_tool[13];
						
		 check = sub_check[0] || sub_check[1] || sub_check[2] || sub_check[3] || sub_check[4] || sub_check[5] || sub_check[6] || sub_check[7] ||
		         sub_check[8] || sub_check[9] || sub_check[10]|| sub_check[11]|| sub_check[12]|| sub_check[13];
	 end	
	 
	 
	always_ff @ (posedge Clk)
	begin
		if (Reset == 1'b1)
			gain <= 1'b0;
		else
			begin
				if (check)
					begin
						gain <= 1'b1;
					end
				else
					gain <= 1'b0;
			end
	end		
endmodule