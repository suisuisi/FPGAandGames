module I2C_Protocol(
	input clk,reset,ignition,
	input [15:0] MUX_input,	
	inout SDIN,
	output reg finish_flag,
	output reg [2:0] ACK,
//	output reg [15:0] data_check,
	output reg SCLK
//	output reg [4:0] LEDG
);
reg [13:0] counter;		//to generate 2.5kHz clock
reg [4:0] tick_counter; //to measure number of clock ticks 
reg serial_data,start_condition,out;
assign SDIN = (out)? serial_data: 1'bz;
//============================================	
// Design structure:
// state:0 start condition
// state:1 send 0x34 address
// state:2 wait for ACK
// state:3 send register address
// state:4 wait for ACK
// state:5 send data to registers
//	state:6 wait for ACK
// state:7 stop conition
//============================================
//	clock generation and number of clock ticks
always @(posedge clk)
	begin
	if (!reset) 
		begin
		counter <= 0;
		SCLK <= 1;		//SCLK idle condition
		end 
	else if (start_condition && ignition)	//if start bit is recieved initiate starting procedures 
		begin
		counter <= counter + 1;
		if (counter <= 9999) SCLK <= 1; 		   	//9999
		else if (counter == 19999) counter <= 0;	//19999
		else if (tick_counter == 29) SCLK <= 1;
		else SCLK <= 0;
		end
	else if (ignition == 0) counter <= 0;
	else SCLK <= 1; 
	end
always @(negedge SCLK) // was SCLK 
	begin
	if(!reset) tick_counter <= 0;
	else
		begin
		tick_counter <= tick_counter + 1;
//		LEDG <= tick_counter;
		if (tick_counter == 28) tick_counter <= 0; // 28 clock cycles needed to complete configuration cycle from I2C bus
		end
	end
//============================================
always @(posedge clk)
	begin
	if (tick_counter == 9 || tick_counter == 18 || tick_counter == 27) out <= 0; // ACK ticks
	else out <= 1;
	end
//============================================
always @(posedge clk)
	begin
		case(tick_counter)
		0://SDIN will be high for 60us then low until SCLK goes high
			begin
			ACK <= 3'b000;
			finish_flag <= 0;
			start_condition <= 1;
			serial_data <= 1;	//SDIN idle condition
			if (counter > 3000) serial_data <= 0; // was 3000
			end
		1://push 0x34 address through I2C data bus, 0x34 = 00110100
		  //push 0
			begin
			serial_data <= 0;
			end
		2://push 0
			begin
			serial_data <= 0;
			end
		3://push 1
			begin
			serial_data <= 1;
			end
		4://push 1
			begin
			serial_data <= 1;
			end
		5://push 0
			begin
			serial_data <= 0;
			end
		6://push 1
			begin
			serial_data <= 1;
			end
		7://push 0
			begin
			serial_data <= 0;
			end
		8://push 0
			begin
			serial_data <= 0;
			end
		9://wait for ACK
			begin
			ACK[0] <= !SDIN; //was SDIN
			end
		10://start sending register address, 7 bits each address
			//push MSB first (MUX_input[15])
			begin
			serial_data <= MUX_input[15];
//			data_check[15] <= MUX_input[15];
			end
		11://push MUX_input[14]
			begin
			serial_data <= MUX_input[14];
//			data_check[14] <= MUX_input[14];
			end
		12://push MUX_input[13]
			begin
			serial_data <= MUX_input[13];
//			data_check[13] <= MUX_input[13];
			end
		13://push MUX_input[12]
			begin
			serial_data <= MUX_input[12];
//			data_check[12] <= MUX_input[12];
			end
		14://push MUX_input[11]
			begin
			serial_data <= MUX_input[11];
//			data_check[11] <= MUX_input[11];
			end
		15://push MUX_input[10]
			begin
			serial_data <= MUX_input[10];
//			data_check[10] <= MUX_input[10];
			end
		16://push MUX_input[9]
			begin
			serial_data <= MUX_input[9];
//			data_check[9] <= MUX_input[9];
			end
		17://start filling control registers, 9 bits each register
			//push MUX_input[8]
			begin
			serial_data <= MUX_input[8];
//			data_check[8] <= MUX_input[8];
			end
		18://wait for ACK
			begin
			ACK[1] <= !SDIN;
			end
		19://push MUX_input[7]
			begin
			serial_data <= MUX_input[7];
//			data_check[7] <= MUX_input[7];
			end
		20://push MUX_input[6]
			begin
			serial_data <= MUX_input[6];
//			data_check[6] <= MUX_input[6];
			end
		21://push MUX_input[5]
			begin
			serial_data <= MUX_input[5];
//			data_check[5] <= MUX_input[5];
			end
		22://push MUX_input[4]
			begin
			serial_data <= MUX_input[4];
//			data_check[4] <= MUX_input[4];
			end
		23://push MUX_input[3]
			begin
			serial_data <= MUX_input[3];
//			data_check[3] <= MUX_input[3];
			end
		24://push MUX_input[2]
			begin
			serial_data <= MUX_input[2];
//			data_check[2] <= MUX_input[2];
			end
		25://push MUX_input[1]
			begin
			serial_data <= MUX_input[1];
//			data_check[1] <= MUX_input[1];
			end
		26://push MUX_input[0]
			begin
			serial_data <= MUX_input[0];
//			data_check[0] <= MUX_input[0];
			end	
		27://wait for ACK
			begin
			ACK[2] <= !SDIN;
			end
		28://bring serial_data to low and stop condition
			begin
			serial_data <= 0;
			finish_flag <= 1;
			if (counter > 3000 && SCLK == 1 /*|| counter == 0*/) serial_data <= 1;
			end
		endcase
	end
endmodule 