/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */
module  backgroundRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:12000];

initial
begin
	 $readmemh("ocmtxt/background.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule



module  start1RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/start1.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule
module  start2RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/start2.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule
module  start3RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/start3.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule

module  start4RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/start4.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule

//dead picture
module  dead1RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/dead1.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule

module  dead2RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/dead2.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule

module  dead3RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/dead3.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule

module  dead4RAM
(
		input [18:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:36000];

initial
begin
	 $readmemh("ocmtxt/dead4.txt", mem);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= mem[read_address];
end

endmodule







///


module  doodleRAM
(
		input [10:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memdoodle [0:1225];

initial
begin
	 $readmemh("ocmtxt/doodler.txt", memdoodle);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memdoodle[read_address];
end

endmodule

module  doodleleftRAM
(
		input [10:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memdoodleleft [0:1225];

initial
begin
	 $readmemh("ocmtxt/doodlel.txt", memdoodleleft);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memdoodleleft[read_address];
end

endmodule

module  doodleupRAM
(
		input [11:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memdoodleup [0:2401];

initial
begin
	 $readmemh("ocmtxt/doodleu.txt", memdoodleup);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memdoodleup[read_address];
end

endmodule


module  stairRAM
(
		input [9:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memstair [0:512];

initial
begin
	 $readmemh("ocmtxt/stair.txt", memstair);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memstair[read_address];
end

endmodule

module  monster1RAM
(
		input [9:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memsmonster [0:943];

initial
begin
	 $readmemh("ocmtxt/monster1.txt", memsmonster);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memsmonster[read_address];
end

endmodule

module  tool1RAM
(
		input [9:0] read_address,
		input Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] memstool [0:225];

initial
begin
	 $readmemh("ocmtxt/tool1.txt", memstool);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= memstool[read_address];
end

endmodule