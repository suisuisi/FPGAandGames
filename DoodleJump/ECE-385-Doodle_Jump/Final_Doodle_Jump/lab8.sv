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


//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Modified by Yuhao Ge & Haina Lou                                 --
//      Fall 2021                                                        --
//                                                                       --
//      Serves as the top level module for ECE 385 Final Project         --
//      Modified basing on the Lab 8 material                            --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------



module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
				 output logic [7:0]  LEDG,
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
                                 DRAM_CLK,      //SDRAM Clock
            //SRAM
            output logic [19:0] SRAM_ADDR,
            output logic SRAM_CE_N, SRAM_UB_N, SRAM_LB_N, SRAM_OE_N,SRAM_WE_N,
            inout wire [15:0] SRAM_D,
				//Audio
				input	AUD_ADCDAT,
				input AUD_DACLRCK,
				input AUD_ADCLRCK,
				input AUD_BCLK,
				output logic AUD_DACDAT,
				output logic AUD_XCK,
				output logic I2C_SCLK,
				output logic I2C_SDAT
                    );
    
    logic Reset_h, Clk;
	 logic [3:0] counter;
    logic [15:0] keycode;
	 logic [19:0] random_num;
	 logic [31:0] tot_distance;
	 
	 logic active, fly;  //status of the monster and bullet
	 logic death, hit, beat_mons;   // return value of the doodle monster check module
	 logic drop;
	 logic gain; //from tool module
    
	 logic gene;  //generate a monster
	 logic shoot; //genetate a bullet
	 logic[2:0] direction;
	 
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
		  music <= ~(KEY[1]); 
		  if ( (keycode[7:0] == 8'd82) || (keycode[15:8] == 8'd82))
		  begin
			  shoot <= 1; 
			  direction = 3'd2;
		  end
		  else if ( (keycode[7:0] == 8'd80) || (keycode[15:8] == 8'd80))
		  begin
			  shoot <= 1; 
			  direction = 3'd1;
		  end
		  else if ( (keycode[7:0] == 8'd79) || (keycode[15:8] == 8'd79))
		  begin
			  shoot <= 1; 
			  direction = 3'd3;
		  end
		  else
		  begin
			  shoot <= 0;
			  direction = 3'd2;
		  end
		  
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
	 
	 // new middle valiables
	 logic [9:0] DrawX,DrawY;
	 logic is_ball, is_stair, is_doodle, collision, is_monster, is_bullet, is_tool;
	 logic [9:0] Ball_X_Pos_out, Ball_Y_Pos_out, Ball_Size_out, Ball_Y_Step_out;
	 logic [13:0][9:0]  stair_x, stair_y;
	 logic [9:0] stair_size;
	 logic [9:0] distance;
	 logic [9:0] monster_x, monster_y,monster_size_x,monster_size_y;
	 logic [9:0] bullet_x, bullet_y, bullet_size;
	 logic [13:0][9:0] tool_x,tool_y,tool_size;
	 
	 
	 logic [13:0] move_message, active_message, tool_message;
    
	 // For audio part
    logic INIT_FINISH, data_over, INIT;
	 logic [16:0] Add;
	 logic [16:0] music_content;
	 logic music;
	 
	 //logic adc_full,AUD_XCK,AUD_BCLK,AUD_ADCDAT,AUD_DACDAT,AUD_DACLRCK,AUD_ADCLRCK,I2C_SDAT,I2C_SCLK,ADCDATA;
	 
    logic [1:0] doodle_state;
    logic is_score;
	 

    logic [2:0] show;
    logic restart;
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
     lab8_soc nios_system(
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
									  .random_export(random_num),    
									  .gene_export(gene),                     //    gene.export
									  .tot_distance_export(tot_distance),     //    tot_distance.export 
									  .active_message_export(active_message),
									  .move_message_export(move_message),
									  .tool_message_export(tool_message),
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );



    //SRAM

    assign SRAM_CE_N = 1'b0;
    assign SRAM_UB_N = 1'b0;
    assign SRAM_OE_N = 1'b0;
    assign SRAM_LB_N = 1'b0;
    assign SRAM_WE_N = 1'b1;
    logic [5:0]Data_out;
    //read_SRAM readpicture(.Clk,.SRAM_ADDR,.Data_out,.SRAM_DQ);
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.Clk, .Reset(Reset_h),.*);
    
    // Which signal should be frame_clk?
    ball ball_instance(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .*);
						
	 stair stair1(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .*);
	 
	 collision coll(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .Ball_X_Pos(Ball_X_Pos_out), .Ball_Y_Pos(Ball_Y_Pos_out), 
						.Ball_Size(Ball_Size_out), .Ball_Y_Step(Ball_Y_Step_out), 
						.stair_x, .stair_y, .stair_size, .collision );
	 
    color_mapper color_instance(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .Ball_X_Pos(Ball_X_Pos_out),.Ball_Y_Pos(Ball_Y_Pos_out),.*);

    //color_mapper color_instance(.*,.Ball_X_Pos(Ball_X_Pos_out),.Ball_Y_Pos(Ball_Y_Pos_out));

    // controll machine
    controller mycontroller(.*,.Reset(Reset_h),.frame_clk(VGA_VS),.show,.restart);

    score myscore(.Clk,.Reset(Reset_h|restart),.DrawX, .DrawY,.score_num,.is_score(is_score),.show );

    //important !!!!!!!!!!!!!!!!!!!
    doodlestate dlstate(.Clk(Clk),.frame_clk(VGA_VS),.Reset(Reset|restart),.keycode(keycode),.state(doodle_state));

	 
    monsters monster1(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .*);
	 
	 doo_mons doo_mons1(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .Ball_Y_Step(Ball_Y_Step_out), .*);
	 
	 bull_mons bull_mons1(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .*);
	 
	 tot_distance tot_distance1(.Clk, .Reset(Reset_h|restart), .*);
	 
	 bullets bullet1(.Clk, .Reset(Reset_h|restart), .frame_clk(VGA_VS), .*);
	 
    tool spring(.Clk,.Reset(Reset_h|restart), .frame_clk(VGA_VS),.*);
	 
	 audio audio1 (.*, .Reset(Reset_h));
	 
	 music music1 (.*);
	 
	 logic [3:0]level;
	 assign level = tot_distance/15000;
	 logic[10:0] score_num;
	 assign score_num = tot_distance/500;
	 
	 logic[16:0] music_frequency;
	 
	 always_comb begin
		music_frequency = 16'd121;
	 end
	 
	 
	 audio_interface music_int ( .LDATA(music_content), 
									 .RDATA(music_content),
									 .CLK(Clk),
									 .Reset(Reset_h), 
									 .INIT(INIT),
									 .INIT_FINISH(INIT_FINISH),
									 .adc_full(adc_full),
									 .data_over(data_over),
									 .AUD_MCLK(AUD_XCK),
									 .AUD_BCLK(AUD_BCLK),     
									 .AUD_ADCDAT(AUD_ADCDAT),
									 .AUD_DACDAT(AUD_DACDAT),
									 .AUD_DACLRCK(AUD_DACLRCK),
									 .AUD_ADCLRCK(AUD_ADCLRCK),
									 .I2C_SDAT(I2C_SDAT),
									 .I2C_SCLK(I2C_SCLK),
									 .ADCDATA(ADCDATA),
	 );
	
	 
    // Display keycode on hex display
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);
    HexDriver hex_inst_2 (keycode[11:8], HEX2);
	 HexDriver hex_inst_3 (keycode[15:12], HEX3);
	 
    HexDriver hex_inst_4 (tot_distance/500, HEX4);
	 HexDriver hex_inst_5 (hit, HEX5);
	 HexDriver hex_inst_6 (level[3:0], HEX6);
	 

	 
	 
//	  always_comb
//		 begin
//		 // default case
//		 LEDG = 8'b0000;
//		  case(keycode)
//			  8'h04: begin
//				  LEDG = 8'b0010;
//				 end
//			  8'h07: begin
//				  LEDG = 8'b0001;
//				 end
//			  8'h1a: begin
//				  LEDG = 8'b1000;
//				 end
//			  8'h16: begin
//				  LEDG = 8'b0100;
//				 end
//		  endcase
//		 end
//	 
	 
	 
	 
endmodule
