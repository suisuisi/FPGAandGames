module lantian_mdio #(
	parameter [6:0] CLOCK_DIVIDER = 40
) (
	input logic [4:0] avalon_slave_address,
	input logic avalon_slave_read,
	output logic [31:0] avalon_slave_readdata,
	output logic avalon_slave_waitrequest,
	input logic avalon_slave_write,
	input logic [31:0] avalon_slave_writedata,
	
	input logic clk,
	input logic reset,
	
	output logic mdc,
	input logic mdio_in,
	output logic mdio_out,
	output logic mdio_oen,
	input logic[4:0] phy_addr
);

logic[6:0] CLOCK_DIVIDER_HALF;
assign CLOCK_DIVIDER_HALF = {1'b0, CLOCK_DIVIDER[6:1]};

logic [5:0] counter, next_counter;

always_ff @ (posedge clk) begin
	if(reset) begin
		counter <= 6'b0;
	end else begin
		counter <= next_counter;
	end
end

always_comb begin
	if(counter == 6'b0) begin
		next_counter = CLOCK_DIVIDER;
	end else begin
		next_counter = counter - 1;
	end
end

assign mdc = counter < CLOCK_DIVIDER_HALF;

enum logic [6:0] {
	IDLE,
	
	W_PREP,
	W_START_0,
	W_START_1,
	W_OPCODE_0,
	W_OPCODE_1,
	W_PHY_ADDR_0,
	W_PHY_ADDR_1,
	W_PHY_ADDR_2,
	W_PHY_ADDR_3,
	W_PHY_ADDR_4,
	W_REG_ADDR_0,
	W_REG_ADDR_1,
	W_REG_ADDR_2,
	W_REG_ADDR_3,
	W_REG_ADDR_4,
	W_TA_0,
	W_TA_1,
	W_DATA_0,
	W_DATA_1,
	W_DATA_2,
	W_DATA_3,
	W_DATA_4,
	W_DATA_5,
	W_DATA_6,
	W_DATA_7,
	W_DATA_8,
	W_DATA_9,
	W_DATA_10,
	W_DATA_11,
	W_DATA_12,
	W_DATA_13,
	W_DATA_14,
	W_DATA_15,
	W_DONE,
	
	R_PREP,
	R_START_0,
	R_START_1,
	R_OPCODE_0,
	R_OPCODE_1,
	R_PHY_ADDR_0,
	R_PHY_ADDR_1,
	R_PHY_ADDR_2,
	R_PHY_ADDR_3,
	R_PHY_ADDR_4,
	R_REG_ADDR_0,
	R_REG_ADDR_1,
	R_REG_ADDR_2,
	R_REG_ADDR_3,
	R_REG_ADDR_4,
	R_TA_0,
	R_TA_1,
	R_DATA_0,
	R_DATA_1,
	R_DATA_2,
	R_DATA_3,
	R_DATA_4,
	R_DATA_5,
	R_DATA_6,
	R_DATA_7,
	R_DATA_8,
	R_DATA_9,
	R_DATA_10,
	R_DATA_11,
	R_DATA_12,
	R_DATA_13,
	R_DATA_14,
	R_DATA_15,
	R_DONE
} state_current, state_next;

assign avalon_slave_readdata[31:16] = 16'b0;

always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[0] <= 1'b0;
	end else if(state_current == R_DATA_15) begin
		avalon_slave_readdata[0] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[1] <= 1'b0;
	end else if(state_current == R_DATA_14) begin
		avalon_slave_readdata[1] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[2] <= 1'b0;
	end else if(state_current == R_DATA_13) begin
		avalon_slave_readdata[2] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[3] <= 1'b0;
	end else if(state_current == R_DATA_12) begin
		avalon_slave_readdata[3] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[4] <= 1'b0;
	end else if(state_current == R_DATA_11) begin
		avalon_slave_readdata[4] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[5] <= 1'b0;
	end else if(state_current == R_DATA_10) begin
		avalon_slave_readdata[5] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[6] <= 1'b0;
	end else if(state_current == R_DATA_9) begin
		avalon_slave_readdata[6] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[7] <= 1'b0;
	end else if(state_current == R_DATA_8) begin
		avalon_slave_readdata[7] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[8] <= 1'b0;
	end else if(state_current == R_DATA_7) begin
		avalon_slave_readdata[8] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[9] <= 1'b0;
	end else if(state_current == R_DATA_6) begin
		avalon_slave_readdata[9] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[10] <= 1'b0;
	end else if(state_current == R_DATA_5) begin
		avalon_slave_readdata[10] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[11] <= 1'b0;
	end else if(state_current == R_DATA_4) begin
		avalon_slave_readdata[11] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[12] <= 1'b0;
	end else if(state_current == R_DATA_3) begin
		avalon_slave_readdata[12] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[13] <= 1'b0;
	end else if(state_current == R_DATA_2) begin
		avalon_slave_readdata[13] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[14] <= 1'b0;
	end else if(state_current == R_DATA_1) begin
		avalon_slave_readdata[14] <= mdio_in;
	end
end
always_ff @ (posedge mdc) begin
	if(reset) begin
		avalon_slave_readdata[15] <= 1'b0;
	end else if(state_current == R_DATA_0) begin
		avalon_slave_readdata[15] <= mdio_in;
	end
end



assign avalon_slave_waitrequest = !(state_current == W_DONE || state_current == R_DONE);

always_ff @ (posedge clk) begin
	if(reset) begin
		state_current <= IDLE;
	end else begin
		state_current <= state_next;
	end
end

always_comb begin
	state_next = state_current;
	
	unique case(state_current)
		IDLE: begin
			if(avalon_slave_read) begin
				state_next = R_PREP;
			end else if(avalon_slave_write) begin
				state_next = W_PREP;
			end
		end
		
		R_PREP:       if(counter == 6'b0) state_next = R_START_0;
		R_START_0:    if(counter == 6'b0) state_next = R_START_1;
		R_START_1:    if(counter == 6'b0) state_next = R_OPCODE_0;
		R_OPCODE_0:   if(counter == 6'b0) state_next = R_OPCODE_1;
		R_OPCODE_1:   if(counter == 6'b0) state_next = R_PHY_ADDR_0;
		R_PHY_ADDR_0: if(counter == 6'b0) state_next = R_PHY_ADDR_1;
		R_PHY_ADDR_1: if(counter == 6'b0) state_next = R_PHY_ADDR_2;
		R_PHY_ADDR_2: if(counter == 6'b0) state_next = R_PHY_ADDR_3;
		R_PHY_ADDR_3: if(counter == 6'b0) state_next = R_PHY_ADDR_4;
		R_PHY_ADDR_4: if(counter == 6'b0) state_next = R_REG_ADDR_0;
		R_REG_ADDR_0: if(counter == 6'b0) state_next = R_REG_ADDR_1;
		R_REG_ADDR_1: if(counter == 6'b0) state_next = R_REG_ADDR_2;
		R_REG_ADDR_2: if(counter == 6'b0) state_next = R_REG_ADDR_3;
		R_REG_ADDR_3: if(counter == 6'b0) state_next = R_REG_ADDR_4;
		R_REG_ADDR_4: if(counter == 6'b0) state_next = R_TA_0;
		R_TA_0:       if(counter == 6'b0) state_next = R_TA_1;
		R_TA_1:       if(counter == 6'b0) state_next = R_DATA_0;
		R_DATA_0:     if(counter == 6'b0) state_next = R_DATA_1;
		R_DATA_1:     if(counter == 6'b0) state_next = R_DATA_2;
		R_DATA_2:     if(counter == 6'b0) state_next = R_DATA_3;
		R_DATA_3:     if(counter == 6'b0) state_next = R_DATA_4;
		R_DATA_4:     if(counter == 6'b0) state_next = R_DATA_5;
		R_DATA_5:     if(counter == 6'b0) state_next = R_DATA_6;
		R_DATA_6:     if(counter == 6'b0) state_next = R_DATA_7;
		R_DATA_7:     if(counter == 6'b0) state_next = R_DATA_8;
		R_DATA_8:     if(counter == 6'b0) state_next = R_DATA_9;
		R_DATA_9:     if(counter == 6'b0) state_next = R_DATA_10;
		R_DATA_10:    if(counter == 6'b0) state_next = R_DATA_11;
		R_DATA_11:    if(counter == 6'b0) state_next = R_DATA_12;
		R_DATA_12:    if(counter == 6'b0) state_next = R_DATA_13;
		R_DATA_13:    if(counter == 6'b0) state_next = R_DATA_14;
		R_DATA_14:    if(counter == 6'b0) state_next = R_DATA_15;
		R_DATA_15:    if(counter == 6'b0) state_next = R_DONE;
		R_DONE: begin
			if(~avalon_slave_read) begin
				state_next = IDLE;
			end
		end
		
		W_PREP:       if(counter == 6'b0) state_next = W_START_0;
		W_START_0:    if(counter == 6'b0) state_next = W_START_1;
		W_START_1:    if(counter == 6'b0) state_next = W_OPCODE_0;
		W_OPCODE_0:   if(counter == 6'b0) state_next = W_OPCODE_1;
		W_OPCODE_1:   if(counter == 6'b0) state_next = W_PHY_ADDR_0;
		W_PHY_ADDR_0: if(counter == 6'b0) state_next = W_PHY_ADDR_1;
		W_PHY_ADDR_1: if(counter == 6'b0) state_next = W_PHY_ADDR_2;
		W_PHY_ADDR_2: if(counter == 6'b0) state_next = W_PHY_ADDR_3;
		W_PHY_ADDR_3: if(counter == 6'b0) state_next = W_PHY_ADDR_4;
		W_PHY_ADDR_4: if(counter == 6'b0) state_next = W_REG_ADDR_0;
		W_REG_ADDR_0: if(counter == 6'b0) state_next = W_REG_ADDR_1;
		W_REG_ADDR_1: if(counter == 6'b0) state_next = W_REG_ADDR_2;
		W_REG_ADDR_2: if(counter == 6'b0) state_next = W_REG_ADDR_3;
		W_REG_ADDR_3: if(counter == 6'b0) state_next = W_REG_ADDR_4;
		W_REG_ADDR_4: if(counter == 6'b0) state_next = W_TA_0;
		W_TA_0:       if(counter == 6'b0) state_next = W_TA_1;
		W_TA_1:       if(counter == 6'b0) state_next = W_DATA_0;
		W_DATA_0:     if(counter == 6'b0) state_next = W_DATA_1;
		W_DATA_1:     if(counter == 6'b0) state_next = W_DATA_2;
		W_DATA_2:     if(counter == 6'b0) state_next = W_DATA_3;
		W_DATA_3:     if(counter == 6'b0) state_next = W_DATA_4;
		W_DATA_4:     if(counter == 6'b0) state_next = W_DATA_5;
		W_DATA_5:     if(counter == 6'b0) state_next = W_DATA_6;
		W_DATA_6:     if(counter == 6'b0) state_next = W_DATA_7;
		W_DATA_7:     if(counter == 6'b0) state_next = W_DATA_8;
		W_DATA_8:     if(counter == 6'b0) state_next = W_DATA_9;
		W_DATA_9:     if(counter == 6'b0) state_next = W_DATA_10;
		W_DATA_10:    if(counter == 6'b0) state_next = W_DATA_11;
		W_DATA_11:    if(counter == 6'b0) state_next = W_DATA_12;
		W_DATA_12:    if(counter == 6'b0) state_next = W_DATA_13;
		W_DATA_13:    if(counter == 6'b0) state_next = W_DATA_14;
		W_DATA_14:    if(counter == 6'b0) state_next = W_DATA_15;
		W_DATA_15:    if(counter == 6'b0) state_next = W_DONE;
		W_DONE: begin
			if(~avalon_slave_write) begin
				state_next = IDLE;
			end
		end
	endcase
end

always_comb begin
	mdio_oen = 1'b1;
	mdio_out = 1'b0;
	
	unique case(state_current)
		W_START_0:    begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		W_START_1:    begin mdio_oen = 1'b0; mdio_out = 1'b1; end
		W_OPCODE_0:   begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		W_OPCODE_1:   begin mdio_oen = 1'b0; mdio_out = 1'b1; end
		W_PHY_ADDR_0: begin mdio_oen = 1'b0; mdio_out = phy_addr[4]; end
		W_PHY_ADDR_1: begin mdio_oen = 1'b0; mdio_out = phy_addr[3]; end
		W_PHY_ADDR_2: begin mdio_oen = 1'b0; mdio_out = phy_addr[2]; end
		W_PHY_ADDR_3: begin mdio_oen = 1'b0; mdio_out = phy_addr[1]; end
		W_PHY_ADDR_4: begin mdio_oen = 1'b0; mdio_out = phy_addr[0]; end
		W_REG_ADDR_0: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[4]; end
		W_REG_ADDR_1: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[3]; end
		W_REG_ADDR_2: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[2]; end
		W_REG_ADDR_3: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[1]; end
		W_REG_ADDR_4: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[0]; end
		W_TA_0:       begin mdio_oen = 1'b0; mdio_out = 1'b1; end
		W_TA_1:       begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		W_DATA_0:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[15]; end
		W_DATA_1:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[14]; end
		W_DATA_2:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[13]; end
		W_DATA_3:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[12]; end
		W_DATA_4:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[11]; end
		W_DATA_5:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[10]; end
		W_DATA_6:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[9]; end
		W_DATA_7:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[8]; end
		W_DATA_8:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[7]; end
		W_DATA_9:     begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[6]; end
		W_DATA_10:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[5]; end
		W_DATA_11:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[4]; end
		W_DATA_12:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[3]; end
		W_DATA_13:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[2]; end
		W_DATA_14:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[1]; end
		W_DATA_15:    begin mdio_oen = 1'b0; mdio_out = avalon_slave_writedata[0]; end
		
		R_START_0:    begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		R_START_1:    begin mdio_oen = 1'b0; mdio_out = 1'b1; end
		R_OPCODE_0:   begin mdio_oen = 1'b0; mdio_out = 1'b1; end
		R_OPCODE_1:   begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		R_PHY_ADDR_0: begin mdio_oen = 1'b0; mdio_out = phy_addr[4]; end
		R_PHY_ADDR_1: begin mdio_oen = 1'b0; mdio_out = phy_addr[3]; end
		R_PHY_ADDR_2: begin mdio_oen = 1'b0; mdio_out = phy_addr[2]; end
		R_PHY_ADDR_3: begin mdio_oen = 1'b0; mdio_out = phy_addr[1]; end
		R_PHY_ADDR_4: begin mdio_oen = 1'b0; mdio_out = phy_addr[0]; end
		R_REG_ADDR_0: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[4]; end
		R_REG_ADDR_1: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[3]; end
		R_REG_ADDR_2: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[2]; end
		R_REG_ADDR_3: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[1]; end
		R_REG_ADDR_4: begin mdio_oen = 1'b0; mdio_out = avalon_slave_address[0]; end
		R_TA_0:       begin mdio_oen = 1'b1; end
		R_TA_1:       begin mdio_oen = 1'b0; mdio_out = 1'b0; end
		
		default: ;
	endcase
end

endmodule
