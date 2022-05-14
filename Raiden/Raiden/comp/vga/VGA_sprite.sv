module VGA_sprite (
	input logic Clk, Reset,

	input logic [15:0] SpriteX, SpriteY,
	input logic [15:0] SpriteWidth, SpriteHeight,
	
	input logic [9:0] VGA_DrawX, VGA_DrawY,
	output logic [11:0] AVL_Addr,
	input logic [15:0] AVL_ReadData,
	
	output logic VGA_isObject,
	output logic [15:0] VGA_Pixel
);

logic [11:0] Pixel_Addr;
logic VGA_isInObject, VGA_isInObject_prev;

logic [15:0] SpriteRight, SpriteBottom;
assign SpriteRight = SpriteX + SpriteWidth;
assign SpriteBottom = SpriteY + SpriteHeight;

always_comb begin
	VGA_isInObject = 1'b0;
	AVL_Addr = 11'b0;
	
	if((VGA_DrawX >= SpriteX || SpriteX[15])
		&& (VGA_DrawX < SpriteRight && !SpriteRight[15])
		&& (VGA_DrawY >= SpriteY || SpriteY[15])
		&& (VGA_DrawY < SpriteBottom && !SpriteBottom[15])
	) begin
		VGA_isInObject = 1'b1;
		AVL_Addr = SpriteWidth * (VGA_DrawY - SpriteY) + (VGA_DrawX - SpriteX);
	end
end

always_ff @ (posedge Clk) begin
	if(Reset) begin
		VGA_isInObject_prev <= 1'b0;
	end else begin
		VGA_isInObject_prev <= VGA_isInObject;
	end
end

assign VGA_Pixel = AVL_ReadData[15:0];
//assign VGA_Pixel = 16'h0000;
assign VGA_isObject = (AVL_ReadData[15:0] != 16'h0000) && VGA_isInObject_prev;
//assign VGA_isObject = VGA_isInObject_prev;

endmodule
