	lab9_soc u0 (
		.aes_export_new_signal (<connected-to-aes_export_new_signal>), // aes_export.new_signal
		.clk_clk               (<connected-to-clk_clk>),               //        clk.clk
		.reset_reset_n         (<connected-to-reset_reset_n>),         //      reset.reset_n
		.sdram_clk_clk         (<connected-to-sdram_clk_clk>),         //  sdram_clk.clk
		.sdram_wire_addr       (<connected-to-sdram_wire_addr>),       // sdram_wire.addr
		.sdram_wire_ba         (<connected-to-sdram_wire_ba>),         //           .ba
		.sdram_wire_cas_n      (<connected-to-sdram_wire_cas_n>),      //           .cas_n
		.sdram_wire_cke        (<connected-to-sdram_wire_cke>),        //           .cke
		.sdram_wire_cs_n       (<connected-to-sdram_wire_cs_n>),       //           .cs_n
		.sdram_wire_dq         (<connected-to-sdram_wire_dq>),         //           .dq
		.sdram_wire_dqm        (<connected-to-sdram_wire_dqm>),        //           .dqm
		.sdram_wire_ras_n      (<connected-to-sdram_wire_ras_n>),      //           .ras_n
		.sdram_wire_we_n       (<connected-to-sdram_wire_we_n>)        //           .we_n
	);

