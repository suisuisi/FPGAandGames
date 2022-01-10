`timescale 1ns/1ns

module tb;
	reg rst,clk;
	reg [3:0] keyin;
	
	wire [7:0] s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0;
	wire [7:0] step;
	wire [7:0] score;
	wire [1:0] state;
	
	top2048 t(rst,clk,keyin,step,score,s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0,state);
	
	initial begin
		#0  rst = 1;
		#0  clk = 0;
		#5  rst = 0;
		#10 rst = 1;
	end
	
	always begin
		#10 clk = ~clk;
	end
	
	initial begin
		#0    keyin = 4'b0000;
		#20   keyin = 4'b0000;
		#20 
		$display ("Initial is");
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
		
		$display ("Press up");
		#100   keyin = 4'b1000;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
		
		$display ("Press right");
		#100  keyin = 4'b0001;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
	
		$display ("Press down");
		#100  keyin = 4'b0100;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
		
		$display ("Press left");
		#100  keyin = 4'b0010;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
	
		$display ("Press up");
		#100   keyin = 4'b1000;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
		
		$display ("Press left");
		#100  keyin = 4'b0010;
		#100  keyin = 4'b0000;
		#20 
		$display ("%h,%h,%h,%h",s15,s14,s13,s12);
		$display ("%h,%h,%h,%h",s11,s10,s9,s8);
		$display ("%h,%h,%h,%h",s7,s6,s5,s4);
		$display ("%h,%h,%h,%h",s3,s2,s1,s0);
		$display ("Step=%h",step);
		$display ("Score=%h\n",score);
		
	  end
endmodule
