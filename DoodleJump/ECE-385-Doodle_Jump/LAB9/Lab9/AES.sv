/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);
logic [1407:0] KeySchedule;
logic [127:0] key;
logic [3:0] loop,key_wait;
logic [3:0] loop_next,key_wait_next;
logic [31:0]msg_in , msg_mc_out;
logic [127:0] msg, msg_out, msg_sb_out,msg_shift_out,msg_add_out;
logic [127:0] next_msg;

// assign AES_MSG_DEC = 128'b0;
// assign AES_DONE = 1'b0;



InvAddRoundKey myadroky(.state(msg),.key(key),.result(msg_add_out));
InvShiftRows myshiftrows(.data_in(msg),.data_out(msg_shift_out));
InvSubBytes SB0(.clk(CLK),.in(msg[7:0]),.out(msg_sb_out[7:0]));
InvSubBytes SB1(.clk(CLK),.in(msg[15:8]),.out(msg_sb_out[15:8]));
InvSubBytes SB2(.clk(CLK),.in(msg[23:16]),.out(msg_sb_out[23:16]));
InvSubBytes SB3(.clk(CLK),.in(msg[31:24]),.out(msg_sb_out[31:24]));
InvSubBytes SB4(.clk(CLK),.in(msg[39:32]),.out(msg_sb_out[39:32]));
InvSubBytes SB5(.clk(CLK),.in(msg[47:40]),.out(msg_sb_out[47:40]));
InvSubBytes SB6(.clk(CLK),.in(msg[55:48]),.out(msg_sb_out[55:48]));
InvSubBytes SB7(.clk(CLK),.in(msg[63:56]),.out(msg_sb_out[63:56]));
InvSubBytes SB8(.clk(CLK),.in(msg[71:64]),.out(msg_sb_out[71:64]));
InvSubBytes SB9(.clk(CLK),.in(msg[79:72]),.out(msg_sb_out[79:72]));
InvSubBytes SB10(.clk(CLK),.in(msg[87:80]),.out(msg_sb_out[87:80]));
InvSubBytes SB11(.clk(CLK),.in(msg[95:88]),.out(msg_sb_out[95:88]));
InvSubBytes SB12(.clk(CLK),.in(msg[103:96]),.out(msg_sb_out[103:96]));
InvSubBytes SB13(.clk(CLK),.in(msg[111:104]),.out(msg_sb_out[111:104]));
InvSubBytes SB14(.clk(CLK),.in(msg[119:112]),.out(msg_sb_out[119:112]));
InvSubBytes SB15(.clk(CLK),.in(msg[127:120]),.out(msg_sb_out[127:120]));

InvMixColumns mymixcolm1(.in(msg_in),.out(msg_mc_out));

KeyExpansion mykeyexpansion(.clk(CLK),.Cipherkey(AES_KEY),.KeySchedule(KeySchedule));
			
enum logic [4:0]{
				WAIT,
				KEYEXPANSION,
				ADDROUNDKEY1,

				SHIFTEROWS,
				SUBBYTES,
				ADDROUNDKEY,
				MC1,
				MC2,
				MC3,
				MC4,

				SHIFTEROWS_OUT,
				SUBBYTES_OUT,
				ADDROUNDKEY_OUT,
				DONE				
				} state, next_state;

always_ff @ (posedge CLK)
	begin
		if (RESET) 
			begin
				state <= WAIT;
				loop <= 4'b0;
				key_wait <= 4'b0;
			end			
		else 
			begin
			state <= next_state;
			msg <= next_msg;
			loop <= loop_next;
			key_wait <= key_wait_next;
			end
	end

always_comb 
	begin
		next_state = state;
		loop_next = loop;
		key_wait_next = key_wait;
		next_msg = msg;
		AES_MSG_DEC = 128'b0;
		AES_DONE = 1'b0;
		key = 128'b0;
		msg_in = 32'b0;
		
		
		// assign next state
		unique case(state)
			WAIT:
				if (AES_START==1'b1)
				begin
					key_wait_next = 4'b0;
					loop_next = 4'b0;
					next_state = KEYEXPANSION;
				end
				
			KEYEXPANSION:
				if (key_wait < 4'd10)
					begin
						key_wait_next = key_wait + 4'b1;
						next_state = KEYEXPANSION;
					end
				else
					begin
						key_wait_next = 4'b0; 
						next_state = ADDROUNDKEY1;
					end				
			ADDROUNDKEY1:
				next_state = SHIFTEROWS;

			SHIFTEROWS:
				next_state = SUBBYTES;
			SUBBYTES:
				next_state = ADDROUNDKEY;
			ADDROUNDKEY:
				next_state = MC1;
			MC1:
				next_state = MC2;
			MC2:
				next_state = MC3;
			MC3:
				next_state = MC4;
			MC4:
				if (loop < 4'd8)	
				begin			
					next_state = SHIFTEROWS;
					loop_next = loop + 4'b1;
				end
				else
					begin
						loop_next = 4'b0;
						next_state = SHIFTEROWS_OUT;
					end

			SHIFTEROWS_OUT:
				next_state = SUBBYTES_OUT;
			SUBBYTES_OUT:
				next_state = ADDROUNDKEY_OUT;
			ADDROUNDKEY_OUT:
				next_state = DONE;
			DONE:
				if (AES_START==1'b0)
					next_state = WAIT;
				
			default: next_state = WAIT;
		endcase


		
		// loop_next = loop;
		// next_state = state;


		// assign control signals
		case(state)
			WAIT:
			begin
				
			end
			KEYEXPANSION:
				next_msg = AES_MSG_ENC;
			ADDROUNDKEY1:
			begin
				key = KeySchedule[127:0];
				next_msg = msg_add_out;   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			end
			SHIFTEROWS:
				next_msg = msg_shift_out;  //!!!!!!!!!!!
			SUBBYTES:
				next_msg = msg_sb_out;
			ADDROUNDKEY:
				begin
					case(loop)
						4'd0:key = KeySchedule[255:128];
						4'd1:key = KeySchedule[383:256];
						4'd2:key = KeySchedule[511:384];
						4'd3:key = KeySchedule[639:512];
						4'd4:key = KeySchedule[767:640];
						4'd5:key = KeySchedule[895:768];
						4'd6:key = KeySchedule[1023:896];
						4'd7:key = KeySchedule[1151:1024];
						4'd8:key = KeySchedule[1279:1152];	
						default: key = 128'b0;						
					endcase
				next_msg = msg_add_out;
				end
			MC1: 
			begin 
				msg_in = msg[31:0];
				next_msg[31:0] = msg_mc_out; 				
			end
			MC2:
			begin
				msg_in = msg[63:32];
				next_msg[63:32] = msg_mc_out; 
			end				
			MC3:
				begin
				msg_in = msg[95:64];
				next_msg[95:64] = msg_mc_out; 
				end
			MC4:
				begin
					msg_in = msg[127:96];
					next_msg[127:96] = msg_mc_out;
				end

			SHIFTEROWS_OUT:
				next_msg = msg_shift_out;
			SUBBYTES_OUT:
				next_msg = msg_sb_out;
			ADDROUNDKEY_OUT:
				begin
					key = KeySchedule[1407:1280];
					next_msg = msg_add_out;
				end
			DONE:
				begin
					AES_MSG_DEC = msg;    
					AES_DONE = 1'b1;	
				end
			default: ;
				
		endcase
	end

endmodule
