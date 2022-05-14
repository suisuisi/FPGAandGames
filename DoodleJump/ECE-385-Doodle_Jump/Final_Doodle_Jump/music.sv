//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Yuhao Ge (2021.12.28)                                   --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board        --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module music (input logic  Clk,
				  input logic  [16:0]Add,
				  output logic [16:0]music_content
);
				  
	logic [16:0] music_memory [0:80549];	// The length of the txt file
	initial 
	begin 
		$readmemh("mj.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
			music_content <= music_memory[Add];
		end
endmodule
