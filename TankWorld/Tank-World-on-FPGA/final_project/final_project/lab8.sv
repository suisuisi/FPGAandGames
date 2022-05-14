//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, 
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
            );
    
    logic Reset_h, Clk;
    logic [7:0] keycode;
   
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    
	 
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
									);
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     final_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
									);
    
	 logic [9:0] DrawX, DrawY;
	 logic is_tank, en_number; //en_number is to draw the number of enemy play would like to choose
	 logic [19:0] DrawX_ext, DrawY_ext;
	 logic [19:0] DistX_out, DistY_out;
	 logic [19:0] read_address;
	 logic [19:0] sp_address;
	 logic [11:0] bg_data, str_data, code;
	 logic [11:0] en_data, lt_data;
	 logic [1:0] mode;
	 logic is_one_tank, are_two_tanks, en_tank, en_state, en_count;
	 logic one_player_mode, two_players_mode;
	 logic Reset_tank;
	 logic is_tank_final;
	 logic [1:0] is_tank_out;
	 
//	 assign nu_address = read_address[14:0];
	 
	 sp_addr_lookup sal(.is_one_tank, .are_two_tanks, .is_tank_final, .is_tank_out, 
							  .DistX(DistX_out), .DistY(DistY_out), .DrawX, .DrawY, 
							  .Addr_out(sp_address), .en_number,
							  .*);
							  
 	 bgROM bg(.read_address, .Clk, .data_Out(bg_data));
	 
	 spROM sp(.read_address(sp_address), .Clk, .data_Out(str_data));
	 
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
	 
	 tanks_selector ts(.keycode, .Reset(Reset_h), .*);
	 
	 en_draw es(.Reset(Reset_h), .keycode, .is_tank(en_tank), .is_count(en_count), .is_number(en_number), .en_state, .*);

    VGA_controller vga_controller_instance(.VGA_CLK(VGA_CLK), .Reset(Reset_h), .Clk(Clk), .*);
		 
    tanks tank_instance(.frame_clk(VGA_VS), .Reset(Reset_tank), .is_tank, .*);
    
    color_mapper color_instance(.*, .code(code));
    
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 
	 HexDriver hex_inst_2 (keycode[3:0], HEX0);
	 
	 	 
	 
	 always_comb 
	 begin
		DrawX_ext[19:10] = {10{1'b0}};
		DrawX_ext[9:0] = DrawX;
		DrawY_ext[19:10] = {10{1'b0}};
		DrawY_ext[9:0] = DrawY;
		read_address = ((DrawY_ext >> 1) * 20'd320 + (DrawX_ext >> 1));
	 end
	 
	 always_comb
	 begin
		if (is_tank == 1'b1 && mode == 2'b10)
			is_tank_final = 1'b1;
		else 
			is_tank_final = 1'b0;
	 end
	 
	 always_comb 
	 begin
		if (is_one_tank == 1 || are_two_tanks == 1 || is_tank_final == 1'b1 || en_state == 1 || en_number == 1)
			code = str_data;
		else 
			code = bg_data;
	 end

	 enum logic [2:0] {BG, BG_WAIT, EN, EN_WAIT, GAME_RST, GAME, END} State, Next_State;
	 
	 always_ff @ (posedge Clk) 
	 begin
		if (Reset_h) 
			State <= BG;
		else
			State <= Next_State;
	 end
	 
	 always_comb
		begin
		mode = 2'b00;
		Reset_tank = 1'b0;
		en_state = 1'b0;
		unique case (State)
			BG:
				begin
				if ((one_player_mode == 1 || two_players_mode == 1) && (keycode == 8'h2c || keycode == 8'h28))
					Next_State = BG_WAIT;
				else 
					Next_State = BG;
				end
			BG_WAIT:
				begin 
				if ((one_player_mode == 1 || two_players_mode == 1) && (keycode == 8'h2c || keycode == 8'h28))
					Next_State = BG_WAIT;
				else 
					Next_State = EN;
				end
			EN: 
				begin
					if (keycode == 8'h2c || keycode == 8'h28)
						Next_State = EN_WAIT;
					else
						Next_State = EN;
				end
			EN_WAIT:
				begin
					if (keycode == 8'h00)
						Next_State = GAME_RST;
					else
						Next_State = EN_WAIT;
				end
			GAME_RST:
				Next_State = GAME;
			GAME:
				begin
					if (keycode == 8'hff)
						Next_State = END;
					else
						Next_State = GAME;
				end
			END:
			begin
				if (keycode == 8'h14)
					Next_State = BG;
				else
					Next_State = END;
			end
		endcase
		
		case (State) 
			BG: mode = 2'b00;
			BG_WAIT: mode = 2'b00;
			EN:
			begin
				mode = 2'b01;
				en_state = 1'b1;
			end
			EN_WAIT: 
			begin
				mode = 2'b01;
				en_state = 1'b1;
			end
			GAME_RST: 
				begin
					Reset_tank = 1'b1;
					mode = 2'b10;
				end	
			GAME:
				mode = 2'b10;
			END: mode = 2'b11;
		endcase
end
	 
endmodule
