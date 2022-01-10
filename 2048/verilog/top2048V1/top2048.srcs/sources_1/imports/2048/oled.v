`define CLK_SLAVE J[3]
`define DATA J[2]
`define DC J[1]
`define CS J[0]
`timescale 1ns / 1ps

// Project F: OLED display
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  * display_clocks
//  * display_timings
//  * test_card_simple or another test card
module draw(rst,clk,xin,yin,din,J,ready);
	input rst,clk;
	input [6:0] xin;
	input [2:0] yin;
	input [7:0] din;
	output [3:0] J;
	output reg ready;
	reg init_done;
	reg req,req_init,req_draw,cmd_draw;
	reg [5:0] pc;
	reg [7:0] rom [0:31];
	reg [9:0] counter;
	reg [7:0] ir,ir_init;
	reg [0:7] ir_draw;
	reg [7:0] x;
	reg [2:0] y;
	reg [2:0] state;
	wire clk_div;
	assign clk_div = counter[5];
	wire cmd;
	assign cmd = init_done & cmd_draw;
	
	spi spi_0(rst,clk_div,req,ir,cmd,J);
	
	always @(posedge rst or posedge clk) begin
		if(rst) counter <= 0;
		else counter <= counter + 10'h001;
	end 
	
	always @(posedge rst or negedge clk_div) begin
		if(rst) begin req_init <= 0;ir_init <= 0;pc <= 0;init_done <= 0;end
		else case(J[0])
            1 : begin
                    if(pc == 5'h1f) begin
                        req_init <= 0;ir_init <= 0;
                        pc <= pc;init_done <= 1;
                    end else begin
                        req_init <= 1;ir_init <= rom[pc];
                        pc <= pc + 5'h01;init_done <= 0;
                    end
                end
            0 : begin req_init <= 0;ir_init <= 0;pc <= pc;init_done <= init_done;end
            default : begin req_init <= 0;ir_init <= 0;pc <= 0;init_done <= init_done;end
        endcase
	end
	
	always @(posedge rst or negedge init_done or negedge clk_div) begin
		if(rst == 1 || init_done == 0) begin 
			req_draw <= 0;ir_draw <= 0;cmd_draw <= 0;
			x <= 0;y <= 0;state <= 0;ready <= 0;
		end else case(J[0])
			0 : begin req_draw <= 0;ir_draw <= 0;cmd_draw <= 0;x <= x;y <= y;state <= state;ready <= ready;end
			1 : case(state)
					0 : if(x < 132) begin 
                            x <= x + 1;y <= y;req_draw <= 1;
                            ir_draw <= 8'h00;cmd_draw <= 1;
                            state <= 0;ready <= 0;
                        end else begin
                            req_draw <= 1;cmd_draw <= 0;
                            if(y < 7) begin x <= 0;y <= y + 1;ir_draw <= 8'hb0+y+1;state <= 0;ready <= 0;end
                            else begin x <= 0;y <= 0;ir_draw <= 8'hb0;state <= 1;ready <= 1;end
                        end
                    1 : begin
                    		x <= din;y <= 0;req_draw <= 1;
                    		ir_draw <= 8'hb0 + yin;cmd_draw <= 0;
                    		state <= 2;ready <= 0;
                    	end
                    2 : begin
                    		x <= x;y <= 0;req_draw <= 1;
                    		ir_draw <= {4'b0001,1'b0,xin[6:4]};cmd_draw <= 0;
                    		state <= 3;ready <= 0;
                    	end
                    3 : begin
                            x <= x;y <= 0;req_draw <= 1;
                            ir_draw <= {4'b0000,xin[3:0]};cmd_draw <= 0;
                            state <= 4;ready <= 0;
                    	end
                    4 : begin
                            x <= x;y <= 0;req_draw <= 1;
                            ir_draw <= x;cmd_draw <= 1;
                            state <= 1;ready <= 1;
                        end
					default : begin req_draw <= 0;cmd_draw <= 0;ir_draw <= 0;x <= x;y <= y;state <= 0;ready <= 0;end
				endcase
			default : begin req_draw <= 0;ir_draw <= 0;cmd_draw <= 0;x <= x;y <= y;state <= state;ready <= ready;end
		endcase
	end

	always @(posedge rst) begin
		rom[ 0] <= 8'hAE;rom[ 1] <= 8'h02;rom[ 2] <= 8'h10;rom[ 3] <= 8'h40;rom[ 4] <= 8'h81;rom[ 5] <= 8'hCF;rom[ 6] <= 8'hA1;rom[ 7] <= 8'hC8;
		rom[ 8] <= 8'hA6;rom[ 9] <= 8'hA8;rom[10] <= 8'h3f;rom[11] <= 8'hD3;rom[12] <= 8'h00;rom[13] <= 8'hd5;rom[14] <= 8'h80;rom[15] <= 8'hD9;
		rom[16] <= 8'hF1;rom[17] <= 8'hDA;rom[18] <= 8'h12;	rom[19] <= 8'hDB;rom[20] <= 8'h40;rom[21] <= 8'h20;rom[22] <= 8'h02;rom[23] <= 8'h8D;
		rom[24] <= 8'h14;rom[25] <= 8'hA4;rom[26] <= 8'hA6;rom[27] <= 8'hAF;rom[28] <= 8'hb0;rom[29] <= 8'h10;rom[30] <= 8'h01;rom[31] <= 8'he3;
	end
	
    always @(init_done or req_init or req_draw) begin
        if(init_done) req <= req_draw;
        else req <= req_init;
    end
    
    always @(init_done or ir_init or ir_draw) begin
        if(init_done) ir <= ir_draw;
        else ir <= ir_init;
    end
endmodule

module spi(rst,clk,req,din,cmd,J);
	input rst,clk;
	input [7:0] din;
	input req;
	input cmd;
	output reg [3:0] J;// J3=slave_clk J2=data J1=D/C# (1:data,0:cmd) J0=CS#
	reg [1:0] state;
	reg [7:0] data_buffer;
	reg [3:0] counter;
	
	always @(posedge rst or posedge clk) begin
		if(rst) begin
			`CS <= 1;
			state <= 0;
			counter <= 8;
			`CLK_SLAVE <= 1;
			`DATA <= 0;
			`DC <= 0;
			data_buffer <= 8'h00;
		end else begin
			case(state)
			0 : if(req) begin
					`CS <= 0;
					state <= 1;
					counter <= 8;
					`CLK_SLAVE <= 1;
					`DATA <= 0;
					`DC <= cmd;
					data_buffer <= din;
				end else begin
					`CS <= 1;
					state <= 0;
					counter <= 8;
					`CLK_SLAVE <= 1;
					`DATA <= 0;
					`DC <= `DC;
					data_buffer <= 8'h00;
				end					
			1 : if(counter == 0) begin
					`CS <= 0;
					state <= 2;
					`DC <= `DC;
					`CLK_SLAVE <= ~`CLK_SLAVE;
					`DATA <= data_buffer[7];
					counter <= counter;
					data_buffer <= data_buffer << 1;
				end else begin
					`CS <= 0;
					state <= 1;
					`DC <= `DC;
					`CLK_SLAVE <= ~`CLK_SLAVE;
					if(`CLK_SLAVE) begin 
						counter <= counter - 4'b0001;
						`DATA <= data_buffer[7];
						data_buffer <= data_buffer;
					end else begin
						counter <= counter;
						`DATA <= `DATA;
						data_buffer <= data_buffer << 1;
					end
				end
			2 : begin
					`CS <= 1;
					state <= 0;
					`DC <= 0;
					`CLK_SLAVE <= 1;
					`DATA <= 0;
					counter <= 8;
					data_buffer <= 8'h00;
				end
			default : begin
					`CS <= 1;
					state <= 0;
					`DC <= 0;
					`CLK_SLAVE <= 1;
					`DATA <= 0;
					counter <= 8;
					data_buffer <= 8'h00;
				end
			endcase
		end
	end
endmodule
