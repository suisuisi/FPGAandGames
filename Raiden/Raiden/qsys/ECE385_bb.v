
module ECE385 (
	clk_clk,
	eth0_mdio_mdc,
	eth0_mdio_mdio_in,
	eth0_mdio_mdio_out,
	eth0_mdio_mdio_oen,
	eth0_mdio_phy_addr,
	eth0_rx_fifo_in_data,
	eth0_rx_fifo_in_valid,
	eth0_rx_fifo_in_ready,
	eth0_rx_fifo_in_startofpacket,
	eth0_rx_fifo_in_endofpacket,
	eth0_rx_fifo_in_error,
	eth0_rx_fifo_in_clk_clk,
	eth0_rx_fifo_in_clk_reset_reset_n,
	eth0_tx_dma_buffer_in_0_data,
	eth0_tx_dma_buffer_in_0_valid,
	eth0_tx_dma_buffer_in_0_ready,
	eth0_tx_dma_buffer_in_0_startofpacket,
	eth0_tx_dma_buffer_in_0_endofpacket,
	eth0_tx_dma_buffer_in_0_empty,
	eth0_tx_dma_buffer_in_clk_0_clk,
	eth0_tx_dma_buffer_in_rst_0_reset,
	eth0_tx_dma_buffer_out_0_data,
	eth0_tx_dma_buffer_out_0_valid,
	eth0_tx_dma_buffer_out_0_ready,
	eth0_tx_dma_buffer_out_0_startofpacket,
	eth0_tx_dma_buffer_out_0_endofpacket,
	eth0_tx_fifo_out_data,
	eth0_tx_fifo_out_valid,
	eth0_tx_fifo_out_ready,
	eth0_tx_fifo_out_startofpacket,
	eth0_tx_fifo_out_endofpacket,
	eth0_tx_fifo_out_empty,
	eth0_tx_fifo_out_clk_clk,
	eth0_tx_fifo_out_clk_reset_reset_n,
	eth1_mdio_mdc,
	eth1_mdio_mdio_in,
	eth1_mdio_mdio_out,
	eth1_mdio_mdio_oen,
	eth1_mdio_phy_addr,
	eth1_rx_fifo_in_data,
	eth1_rx_fifo_in_valid,
	eth1_rx_fifo_in_ready,
	eth1_rx_fifo_in_startofpacket,
	eth1_rx_fifo_in_endofpacket,
	eth1_rx_fifo_in_error,
	eth1_rx_fifo_in_clk_clk,
	eth1_rx_fifo_in_clk_reset_reset_n,
	eth1_tx_dma_buffer_in_0_data,
	eth1_tx_dma_buffer_in_0_valid,
	eth1_tx_dma_buffer_in_0_ready,
	eth1_tx_dma_buffer_in_0_startofpacket,
	eth1_tx_dma_buffer_in_0_endofpacket,
	eth1_tx_dma_buffer_in_0_empty,
	eth1_tx_dma_buffer_in_clk_0_clk,
	eth1_tx_dma_buffer_in_rst_0_reset,
	eth1_tx_dma_buffer_out_0_data,
	eth1_tx_dma_buffer_out_0_valid,
	eth1_tx_dma_buffer_out_0_ready,
	eth1_tx_dma_buffer_out_0_startofpacket,
	eth1_tx_dma_buffer_out_0_endofpacket,
	eth1_tx_fifo_out_data,
	eth1_tx_fifo_out_valid,
	eth1_tx_fifo_out_ready,
	eth1_tx_fifo_out_startofpacket,
	eth1_tx_fifo_out_endofpacket,
	eth1_tx_fifo_out_empty,
	eth1_tx_fifo_out_clk_clk,
	eth1_tx_fifo_out_clk_reset_reset_n,
	io_hex_export,
	io_keys_export,
	io_led_green_export,
	io_led_red_export,
	io_switches_export,
	io_vga_sync_export,
	nios2_pll_ethernet_clk,
	nios2_pll_sdram_clk,
	nios2_pll_vga_clk,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_reset_export,
	otg_hpi_w_export,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sram_sram_addr,
	sram_sram_ce_n,
	sram_sram_dq,
	sram_sram_lb_n,
	sram_sram_oe_n,
	sram_sram_ub_n,
	sram_sram_we_n,
	usb_clk_clk,
	usb_nios2_cpu_custom_instruction_master_readra,
	usb_reset_reset_n,
	vga_vga_drawx,
	vga_vga_drawy,
	vga_vga_val,
	vga_background_offset_export,
	vga_sprite_0_clk2_clk,
	vga_sprite_0_reset2_reset,
	vga_sprite_0_s2_address,
	vga_sprite_0_s2_chipselect,
	vga_sprite_0_s2_clken,
	vga_sprite_0_s2_write,
	vga_sprite_0_s2_readdata,
	vga_sprite_0_s2_writedata,
	vga_sprite_0_s2_byteenable,
	vga_sprite_1_clk2_clk,
	vga_sprite_1_reset2_reset,
	vga_sprite_1_s2_address,
	vga_sprite_1_s2_chipselect,
	vga_sprite_1_s2_clken,
	vga_sprite_1_s2_write,
	vga_sprite_1_s2_readdata,
	vga_sprite_1_s2_writedata,
	vga_sprite_1_s2_byteenable,
	vga_sprite_2_clk2_clk,
	vga_sprite_2_reset2_reset,
	vga_sprite_2_s2_address,
	vga_sprite_2_s2_chipselect,
	vga_sprite_2_s2_clken,
	vga_sprite_2_s2_write,
	vga_sprite_2_s2_readdata,
	vga_sprite_2_s2_writedata,
	vga_sprite_2_s2_byteenable,
	vga_sprite_3_clk2_clk,
	vga_sprite_3_reset2_reset,
	vga_sprite_3_s2_address,
	vga_sprite_3_s2_chipselect,
	vga_sprite_3_s2_clken,
	vga_sprite_3_s2_write,
	vga_sprite_3_s2_readdata,
	vga_sprite_3_s2_writedata,
	vga_sprite_3_s2_byteenable,
	vga_sprite_4_clk2_clk,
	vga_sprite_4_reset2_reset,
	vga_sprite_4_s2_address,
	vga_sprite_4_s2_chipselect,
	vga_sprite_4_s2_clken,
	vga_sprite_4_s2_write,
	vga_sprite_4_s2_readdata,
	vga_sprite_4_s2_writedata,
	vga_sprite_4_s2_byteenable,
	vga_sprite_5_clk2_clk,
	vga_sprite_5_reset2_reset,
	vga_sprite_5_s2_address,
	vga_sprite_5_s2_chipselect,
	vga_sprite_5_s2_clken,
	vga_sprite_5_s2_write,
	vga_sprite_5_s2_readdata,
	vga_sprite_5_s2_writedata,
	vga_sprite_5_s2_byteenable,
	vga_sprite_6_clk2_clk,
	vga_sprite_6_reset2_reset,
	vga_sprite_6_s2_address,
	vga_sprite_6_s2_chipselect,
	vga_sprite_6_s2_clken,
	vga_sprite_6_s2_write,
	vga_sprite_6_s2_readdata,
	vga_sprite_6_s2_writedata,
	vga_sprite_6_s2_byteenable,
	vga_sprite_7_clk2_clk,
	vga_sprite_7_reset2_reset,
	vga_sprite_7_s2_address,
	vga_sprite_7_s2_chipselect,
	vga_sprite_7_s2_clken,
	vga_sprite_7_s2_write,
	vga_sprite_7_s2_readdata,
	vga_sprite_7_s2_writedata,
	vga_sprite_7_s2_byteenable,
	vga_sprite_params_pass_address,
	vga_sprite_params_pass_read,
	vga_sprite_params_pass_readdata,
	vga_sprite_params_pass_write,
	vga_sprite_params_pass_writedata,
	vga_sprite_params_reset_reset,
	audio_pio_export);	

	input		clk_clk;
	output		eth0_mdio_mdc;
	input		eth0_mdio_mdio_in;
	output		eth0_mdio_mdio_out;
	output		eth0_mdio_mdio_oen;
	input	[4:0]	eth0_mdio_phy_addr;
	input	[7:0]	eth0_rx_fifo_in_data;
	input		eth0_rx_fifo_in_valid;
	output		eth0_rx_fifo_in_ready;
	input		eth0_rx_fifo_in_startofpacket;
	input		eth0_rx_fifo_in_endofpacket;
	input	[2:0]	eth0_rx_fifo_in_error;
	input		eth0_rx_fifo_in_clk_clk;
	input		eth0_rx_fifo_in_clk_reset_reset_n;
	input	[31:0]	eth0_tx_dma_buffer_in_0_data;
	input		eth0_tx_dma_buffer_in_0_valid;
	output		eth0_tx_dma_buffer_in_0_ready;
	input		eth0_tx_dma_buffer_in_0_startofpacket;
	input		eth0_tx_dma_buffer_in_0_endofpacket;
	input	[1:0]	eth0_tx_dma_buffer_in_0_empty;
	input		eth0_tx_dma_buffer_in_clk_0_clk;
	input		eth0_tx_dma_buffer_in_rst_0_reset;
	output	[7:0]	eth0_tx_dma_buffer_out_0_data;
	output		eth0_tx_dma_buffer_out_0_valid;
	input		eth0_tx_dma_buffer_out_0_ready;
	output		eth0_tx_dma_buffer_out_0_startofpacket;
	output		eth0_tx_dma_buffer_out_0_endofpacket;
	output	[31:0]	eth0_tx_fifo_out_data;
	output		eth0_tx_fifo_out_valid;
	input		eth0_tx_fifo_out_ready;
	output		eth0_tx_fifo_out_startofpacket;
	output		eth0_tx_fifo_out_endofpacket;
	output	[1:0]	eth0_tx_fifo_out_empty;
	input		eth0_tx_fifo_out_clk_clk;
	input		eth0_tx_fifo_out_clk_reset_reset_n;
	output		eth1_mdio_mdc;
	input		eth1_mdio_mdio_in;
	output		eth1_mdio_mdio_out;
	output		eth1_mdio_mdio_oen;
	input	[4:0]	eth1_mdio_phy_addr;
	input	[7:0]	eth1_rx_fifo_in_data;
	input		eth1_rx_fifo_in_valid;
	output		eth1_rx_fifo_in_ready;
	input		eth1_rx_fifo_in_startofpacket;
	input		eth1_rx_fifo_in_endofpacket;
	input	[2:0]	eth1_rx_fifo_in_error;
	input		eth1_rx_fifo_in_clk_clk;
	input		eth1_rx_fifo_in_clk_reset_reset_n;
	input	[31:0]	eth1_tx_dma_buffer_in_0_data;
	input		eth1_tx_dma_buffer_in_0_valid;
	output		eth1_tx_dma_buffer_in_0_ready;
	input		eth1_tx_dma_buffer_in_0_startofpacket;
	input		eth1_tx_dma_buffer_in_0_endofpacket;
	input	[1:0]	eth1_tx_dma_buffer_in_0_empty;
	input		eth1_tx_dma_buffer_in_clk_0_clk;
	input		eth1_tx_dma_buffer_in_rst_0_reset;
	output	[7:0]	eth1_tx_dma_buffer_out_0_data;
	output		eth1_tx_dma_buffer_out_0_valid;
	input		eth1_tx_dma_buffer_out_0_ready;
	output		eth1_tx_dma_buffer_out_0_startofpacket;
	output		eth1_tx_dma_buffer_out_0_endofpacket;
	output	[31:0]	eth1_tx_fifo_out_data;
	output		eth1_tx_fifo_out_valid;
	input		eth1_tx_fifo_out_ready;
	output		eth1_tx_fifo_out_startofpacket;
	output		eth1_tx_fifo_out_endofpacket;
	output	[1:0]	eth1_tx_fifo_out_empty;
	input		eth1_tx_fifo_out_clk_clk;
	input		eth1_tx_fifo_out_clk_reset_reset_n;
	output	[31:0]	io_hex_export;
	input	[3:0]	io_keys_export;
	output	[8:0]	io_led_green_export;
	output	[17:0]	io_led_red_export;
	input	[17:0]	io_switches_export;
	input		io_vga_sync_export;
	output		nios2_pll_ethernet_clk;
	output		nios2_pll_sdram_clk;
	output		nios2_pll_vga_clk;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_reset_export;
	output		otg_hpi_w_export;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[31:0]	sdram_dq;
	output	[3:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output	[19:0]	sram_sram_addr;
	output		sram_sram_ce_n;
	inout	[15:0]	sram_sram_dq;
	output		sram_sram_lb_n;
	output		sram_sram_oe_n;
	output		sram_sram_ub_n;
	output		sram_sram_we_n;
	input		usb_clk_clk;
	output		usb_nios2_cpu_custom_instruction_master_readra;
	input		usb_reset_reset_n;
	input	[9:0]	vga_vga_drawx;
	input	[9:0]	vga_vga_drawy;
	output	[15:0]	vga_vga_val;
	output	[31:0]	vga_background_offset_export;
	input		vga_sprite_0_clk2_clk;
	input		vga_sprite_0_reset2_reset;
	input	[10:0]	vga_sprite_0_s2_address;
	input		vga_sprite_0_s2_chipselect;
	input		vga_sprite_0_s2_clken;
	input		vga_sprite_0_s2_write;
	output	[15:0]	vga_sprite_0_s2_readdata;
	input	[15:0]	vga_sprite_0_s2_writedata;
	input	[1:0]	vga_sprite_0_s2_byteenable;
	input		vga_sprite_1_clk2_clk;
	input		vga_sprite_1_reset2_reset;
	input	[10:0]	vga_sprite_1_s2_address;
	input		vga_sprite_1_s2_chipselect;
	input		vga_sprite_1_s2_clken;
	input		vga_sprite_1_s2_write;
	output	[15:0]	vga_sprite_1_s2_readdata;
	input	[15:0]	vga_sprite_1_s2_writedata;
	input	[1:0]	vga_sprite_1_s2_byteenable;
	input		vga_sprite_2_clk2_clk;
	input		vga_sprite_2_reset2_reset;
	input	[10:0]	vga_sprite_2_s2_address;
	input		vga_sprite_2_s2_chipselect;
	input		vga_sprite_2_s2_clken;
	input		vga_sprite_2_s2_write;
	output	[15:0]	vga_sprite_2_s2_readdata;
	input	[15:0]	vga_sprite_2_s2_writedata;
	input	[1:0]	vga_sprite_2_s2_byteenable;
	input		vga_sprite_3_clk2_clk;
	input		vga_sprite_3_reset2_reset;
	input	[10:0]	vga_sprite_3_s2_address;
	input		vga_sprite_3_s2_chipselect;
	input		vga_sprite_3_s2_clken;
	input		vga_sprite_3_s2_write;
	output	[15:0]	vga_sprite_3_s2_readdata;
	input	[15:0]	vga_sprite_3_s2_writedata;
	input	[1:0]	vga_sprite_3_s2_byteenable;
	input		vga_sprite_4_clk2_clk;
	input		vga_sprite_4_reset2_reset;
	input	[10:0]	vga_sprite_4_s2_address;
	input		vga_sprite_4_s2_chipselect;
	input		vga_sprite_4_s2_clken;
	input		vga_sprite_4_s2_write;
	output	[15:0]	vga_sprite_4_s2_readdata;
	input	[15:0]	vga_sprite_4_s2_writedata;
	input	[1:0]	vga_sprite_4_s2_byteenable;
	input		vga_sprite_5_clk2_clk;
	input		vga_sprite_5_reset2_reset;
	input	[10:0]	vga_sprite_5_s2_address;
	input		vga_sprite_5_s2_chipselect;
	input		vga_sprite_5_s2_clken;
	input		vga_sprite_5_s2_write;
	output	[15:0]	vga_sprite_5_s2_readdata;
	input	[15:0]	vga_sprite_5_s2_writedata;
	input	[1:0]	vga_sprite_5_s2_byteenable;
	input		vga_sprite_6_clk2_clk;
	input		vga_sprite_6_reset2_reset;
	input	[10:0]	vga_sprite_6_s2_address;
	input		vga_sprite_6_s2_chipselect;
	input		vga_sprite_6_s2_clken;
	input		vga_sprite_6_s2_write;
	output	[15:0]	vga_sprite_6_s2_readdata;
	input	[15:0]	vga_sprite_6_s2_writedata;
	input	[1:0]	vga_sprite_6_s2_byteenable;
	input		vga_sprite_7_clk2_clk;
	input		vga_sprite_7_reset2_reset;
	input	[10:0]	vga_sprite_7_s2_address;
	input		vga_sprite_7_s2_chipselect;
	input		vga_sprite_7_s2_clken;
	input		vga_sprite_7_s2_write;
	output	[15:0]	vga_sprite_7_s2_readdata;
	input	[15:0]	vga_sprite_7_s2_writedata;
	input	[1:0]	vga_sprite_7_s2_byteenable;
	output	[7:0]	vga_sprite_params_pass_address;
	output		vga_sprite_params_pass_read;
	input	[31:0]	vga_sprite_params_pass_readdata;
	output		vga_sprite_params_pass_write;
	output	[31:0]	vga_sprite_params_pass_writedata;
	output		vga_sprite_params_reset_reset;
	output	[31:0]	audio_pio_export;
endmodule
