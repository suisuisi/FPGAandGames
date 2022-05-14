module VGA_layer #(
	parameter LAYERS = 64
) (
	input logic [LAYERS-1:0] VGA_SPRITE_ISOBJ,
	input logic [LAYERS-1:0][15:0] VGA_SPRITE_PIXEL,
						
	output logic [7:0] VGA_R, VGA_G, VGA_B,
	input logic [9:0] VGA_DrawY,
	input logic [15:0] VGA_VAL
);

logic [15:0] VGA_L1_ISOBJ;
logic [15:0][15:0] VGA_L1_PIXEL;
logic [3:0] VGA_L2_ISOBJ;
logic [3:0][15:0] VGA_L2_PIXEL;
logic [0:0] VGA_L3_ISOBJ;
logic [0:0][15:0] VGA_L3_PIXEL;
genvar i;
generate
	for(i = 0; i < 16; i++) begin: generate_VGA_layer_1
		VGA_layer_selector VGA_layer_1 (
			.VGA_SPRITE_ISOBJ(VGA_SPRITE_ISOBJ[i*4+3 : i*4]),
			.VGA_SPRITE_PIXEL(VGA_SPRITE_PIXEL[i*4+3 : i*4]),
			.VGA_PIXEL(VGA_L1_PIXEL[i]),
			.VGA_ISOBJ(VGA_L1_ISOBJ[i])
		);
	end
	for(i = 0; i < 4; i++) begin: generate_VGA_layer_2
		VGA_layer_selector VGA_layer_2 (
			.VGA_SPRITE_ISOBJ(VGA_L1_ISOBJ[i*4+3 : i*4]),
			.VGA_SPRITE_PIXEL(VGA_L1_PIXEL[i*4+3 : i*4]),
			.VGA_PIXEL(VGA_L2_PIXEL[i]),
			.VGA_ISOBJ(VGA_L2_ISOBJ[i])
		);
	end
	for(i = 0; i < 1; i++) begin: generate_VGA_layer_3
		VGA_layer_selector VGA_layer_3 (
			.VGA_SPRITE_ISOBJ(VGA_L2_ISOBJ[i*4+3 : i*4]),
			.VGA_SPRITE_PIXEL(VGA_L2_PIXEL[i*4+3 : i*4]),
			.VGA_PIXEL(VGA_L3_PIXEL[i]),
			.VGA_ISOBJ(VGA_L3_ISOBJ[i])
		);
	end
endgenerate

logic [15:0] VGA_DISPLAY;
assign VGA_R = {VGA_DISPLAY[4:0], VGA_DISPLAY[4:2]};
assign VGA_G = {VGA_DISPLAY[10:5], VGA_DISPLAY[10:9]};
assign VGA_B = {VGA_DISPLAY[15:11], VGA_DISPLAY[15:13]};
assign VGA_DISPLAY = (!VGA_L3_ISOBJ[0] || VGA_DrawY >= 464) ? VGA_VAL : VGA_L3_PIXEL[0];

endmodule

module VGA_layer_selector (
	input logic [3:0] VGA_SPRITE_ISOBJ,
	input logic [3:0][15:0] VGA_SPRITE_PIXEL,
	output logic [15:0] VGA_PIXEL,
	output logic VGA_ISOBJ
);

always_comb begin
	if(VGA_SPRITE_ISOBJ[0]) begin
		VGA_PIXEL = VGA_SPRITE_PIXEL[0];
	end else if(VGA_SPRITE_ISOBJ[1]) begin
		VGA_PIXEL = VGA_SPRITE_PIXEL[1];
	end else if(VGA_SPRITE_ISOBJ[2]) begin
		VGA_PIXEL = VGA_SPRITE_PIXEL[2];
	end else if(VGA_SPRITE_ISOBJ[3]) begin
		VGA_PIXEL = VGA_SPRITE_PIXEL[3];
	end else begin
		VGA_PIXEL = 16'h0000;
	end
end

assign VGA_ISOBJ = VGA_SPRITE_ISOBJ[0] | VGA_SPRITE_ISOBJ[1] | VGA_SPRITE_ISOBJ[2] | VGA_SPRITE_ISOBJ[3];

endmodule
