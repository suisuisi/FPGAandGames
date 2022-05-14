/************************************************************************
Key Expansion

Po-Han Huang, Spring 2017
Joe Meng, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

// Note that KeyExpansion does not complete in single clock cycle.
// Run simulation to see how many clock cycles it takes for key schedule to complete.
module KeyExpansion (
	input  logic clk,
	input  logic [127:0]  Cipherkey,
	output logic [1407:0] KeySchedule
);

// Rcon table
const byte unsigned Rcon [0:9] = '{ 8'h01,8'h02,8'h04,8'h08,8'h10,
											 8'h20,8'h40,8'h80,8'h1b,8'h36 };

logic [127:0] key0, key1, key2, key3, key4, key5, key6, key7, key8, key9;

KeyExpansionOne key_0 (.*, .oldkey(Cipherkey), .newkey(key0), .Rcon(Rcon[0]));
KeyExpansionOne key_1 (.*, .oldkey(key0), .newkey(key1), .Rcon(Rcon[1]));
KeyExpansionOne key_2 (.*, .oldkey(key1), .newkey(key2), .Rcon(Rcon[2]));
KeyExpansionOne key_3 (.*, .oldkey(key2), .newkey(key3), .Rcon(Rcon[3]));
KeyExpansionOne key_4 (.*, .oldkey(key3), .newkey(key4), .Rcon(Rcon[4]));
KeyExpansionOne key_5 (.*, .oldkey(key4), .newkey(key5), .Rcon(Rcon[5])); 
KeyExpansionOne key_6 (.*, .oldkey(key5), .newkey(key6), .Rcon(Rcon[6]));
KeyExpansionOne key_7 (.*, .oldkey(key6), .newkey(key7), .Rcon(Rcon[7]));
KeyExpansionOne key_8 (.*, .oldkey(key7), .newkey(key8), .Rcon(Rcon[8]));
KeyExpansionOne key_9 (.*, .oldkey(key8), .newkey(key9), .Rcon(Rcon[9]));

assign KeySchedule[1407:0] = {Cipherkey, key0, key1, key2, key3, key4, key5, key6, key7, key8, key9};

endmodule


module KeyExpansionOne (
	input  logic clk,
	input  logic [127:0] oldkey, 
	output logic [127:0] newkey,
	input  logic [7:0] Rcon
);
        
	// Obtain words from previous key
	logic [31:0] wp0, wp1, wp2, wp3;
	logic [7:0]  wp03, wp13, wp23, wp33;
	logic [31:0] subword;
	assign {wp0, wp1, wp2, wp3} = oldkey;
	assign {wp03, wp13, wp23, wp33} = wp3;

	// Obtain SubWord using SubBytes.  Notice that RotWord is implemented using rotated input
	SubBytes subbytes_0(.*, .in(wp13), .out(subword[31:24]));
	SubBytes subbytes_1(.*, .in(wp23), .out(subword[23:16]));
	SubBytes subbytes_2(.*, .in(wp33), .out(subword[15:8]));
	SubBytes subbytes_3(.*, .in(wp03), .out(subword[7:0]));

	logic [31:0] w0, w1, w2, w3;
	assign w0 = wp0 ^ {subword[31:24] ^ Rcon, subword[23:0]};
	assign w1 = wp1 ^ w0;
	assign w2 = wp2 ^ w1;
	assign w3 = wp3 ^ w2;

	assign newkey = {w0, w1, w2, w3};

endmodule
