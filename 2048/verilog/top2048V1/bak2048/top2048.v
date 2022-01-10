module game(rst,clk,keyin,step,score,s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0);
	input rst,clk;
	input [3:0] keyin;
	output reg [7:0] step;
	output reg [7:0] score;
	reg [1:0] state;
	output reg [3:0] s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0;
		
	wire [3:0] u15,u14,u13,u12,u11,u10,u9,u8,u7,u6,u5,u4,u3,u2,u1,u0;
	wire [3:0] d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0;
	wire [3:0] l15,l14,l13,l12,l11,l10,l9,l8,l7,l6,l5,l4,l3,l2,l1,l0;
	wire [3:0] r15,r14,r13,r12,r11,r10,r9,r8,r7,r6,r5,r4,r3,r2,r1,r0;
	wire [3:0] gu3,gu2,gu1,gu0,gd15,gd14,gd13,gd12,gl12,gl8,gl4,gl0,gr15,gr11,gr7,gr3;
	
	move mu3(s3,s7,s11,s15,u3,u7,u11,u15);
	move mu2(s2,s6,s10,s14,u2,u6,u10,u14);
	move mu1(s1,s5,s9,s13,u1,u5,u9,u13);
	move mu0(s0,s4,s8,s12,u0,u4,u8,u12);
	move md3(s15,s11,s7,s3,d15,d11,d7,d3);
	move md2(s14,s10,s6,s2,d14,d10,d6,d2);
	move md1(s13,s9,s5,s1,d13,d9,d5,d1);
	move md0(s12,s8,s4,s0,d12,d8,d4,d0);
	move ml3(s12,s13,s14,s15,l12,l13,l14,l15);
	move ml2(s8,s9,s10,s11,l8,l9,l10,l11);
	move ml1(s4,s5,s6,s7,l4,l5,l6,l7);
	move ml0(s0,s1,s2,s3,l0,l1,l2,l3);
	move mr3(s15,s14,s13,s12,r15,r14,r13,r12);
	move mr2(s11,s10,s9,s8,r11,r10,r9,r8);
	move mr1(s7,s6,s5,s4,r7,r6,r5,r4);
	move mr0(s3,s2,s1,s0,r3,r2,r1,r0);
	gen gu(rst,clk,s3,s2,s1,s0,gu3,gu2,gu1,gu0);
	gen gd(rst,clk,s15,s14,s13,s12,gd15,gd14,gd13,gd12);
	gen gl(rst,clk,s12,s8,s4,s0,gl12,gl8,gl4,gl0);
	gen gr(rst,clk,s15,s11,s7,s3,gr15,gr11,gr7,gr3);
	
	always @(posedge rst or posedge clk) begin
		if(rst) begin
			s15 <= 4'h0;s14 <= 4'h2;s13 <= 4'h0;s12 <= 4'h0;
			s11 <= 4'h0;s10 <= 4'h1;s9 <= 4'h0;s8 <= 4'h0;
			s7 <= 4'h0;s6 <= 4'h0;s5 <= 4'h2;s4 <= 4'h1;
			s3 <= 4'h2;s2 <= 4'h1;s1 <= 4'h1;s0 <= 4'h0;
			step <= 0;score <= 0;state <= 0;
		end else begin
			case(state)
				2'b00 : begin
					case(keyin)
						4'b0000 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};step <= step;score <= score;state <= 0;end
						4'b1000 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {u15,u14,u13,u12,u11,u10,u9,u8,u7,u6,u5,u4,u3,u2,u1,u0};step <= step;score <= score;state <= 1;end
						4'b0100 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0};step <= step;score <= score;state <= 1;end
						4'b0010 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {l15,l14,l13,l12,l11,l10,l9,l8,l7,l6,l5,l4,l3,l2,l1,l0};step <= step;score <= score;state <= 1;end
						4'b0001 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {r15,r14,r13,r12,r11,r10,r9,r8,r7,r6,r5,r4,r3,r2,r1,r0};step <= step;score <= score;state <= 1;end
						default : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};step <= step;score <= score;state <= 0;end
					endcase
				end
				2'b01 : begin
					case(keyin)
						4'b1000 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,gu3,gu2,gu1,gu0};step <= step;score <= score;state <= 2;end
						4'b0100 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {gd15,gd14,gd13,gd12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};step <= step;score <= score;state <= 2;end
						4'b0010 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,gl12,s11,s10,s9,gl8,s7,s6,s5,gl4,s3,s2,s1,gl0};step <= step;score <= score;state <= 2;end
						4'b0001 : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {gr15,s14,s13,s12,gr11,s10,s9,s8,gr7,s6,s5,s4,gr3,s2,s1,s0};step <= step;score <= score;state <= 2;end
						default : begin {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};step <= step;score <= score;state <= 0;end
					endcase
				end
				2'b10 : begin
					{s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};
					score <= s15 + s14 + s13 + s12 + s11 + s10 + s9 + s8 + s7 + s6 + s5 + s4 + s3 + s2 + s1 + s0;
					if((s15!=0)&&(s14!=0)&&(s13!=0)&&(s12!=0)&&(s11!=0)&&(s10!=0)&&(s9!=0)&&(s8!=0)&&(s7!=0)&&(s6!=0)&&(s5!=0)&&(s4!=0)&&(s3!=0)&&(s2!=0)&&(s1!=0)&&(s0!=0))
						begin step <= step;state <= 3;end
					else if(keyin == 4'b0000) begin step <= step + 1;state <= 0;end
				end
				2'b11 : begin
					{s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};
					step <= step;score <= score;state <= 3;
				end
				default : begin
					{s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};
					step <= step;score <= score;state <= 0;
				end
			endcase
		end
	end
endmodule

module seg(din,dout);
    input [7:0] din;
    output reg [0:287] dout;
    
    always @(din) begin
        case(din)
        4'h0 : dout <= 288'h00_00_00_00_00_00_00_00_03_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_20_e0_00_00_00_00_00_00_00;
        8'h01 : dout <= 288'h00_00_00_00_00_00_00_00_00_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_00_00_00_00_00_00_00_00;
        8'h02 : dout <= 288'h00_00_00_00_00_00_00_00_02_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_a0_a0_00_00_00_00_00_00_00;
        8'h04 : dout <= 288'h00_00_00_00_00_00_00_00_03_00_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_80_80_e0_00_00_00_00_00_00_00;
        8'h08 : dout <= 288'h00_00_00_00_00_00_00_00_03_02_03_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_e0_a0_e0_00_00_00_00_00_00_00;
        8'h10 : dout <= 288'h00_00_00_00_00_00_00_03_00_00_03_02_02_00_00_00_00_00_00_00_00_00_00_00_00_e0_00_00_e0_a0_e0_00_00_00_00_00;
        8'h20 : dout <= 288'h00_00_00_00_00_00_02_02_03_00_02_02_03_00_00_00_00_00_00_00_00_00_00_00_a0_a0_e0_00_e0_a0_a0_00_00_00_00_00;
        8'h40 : dout <= 288'h00_00_00_00_00_00_03_02_02_00_03_00_03_00_00_00_00_00_00_00_00_00_00_00_e0_a0_e0_00_80_80_e0_00_00_00_00_00;
        8'h80 : dout <= 288'h00_00_00_00_00_03_00_00_02_02_03_00_03_02_03_00_00_00_00_00_00_00_00_e0_00_00_e0_a0_a0_00_e0_a0_e0_00_00_00;
        default : dout<=288'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;
        endcase
    end
endmodule

module move(i3,i2,i1,i0,o3,o2,o1,o0);
	input [3:0] i3,i2,i1,i0;
	output reg [3:0] o3,o2,o1,o0;
	
	wire f3,f2,f1,f0;
	assign f3=(i3!=0);
	assign f2=(i2!=0);
	assign f1=(i1!=0);
	assign f0=(i0!=0);
	
	always @(i3 or i2 or i1 or i0 or f3 or f2 or f1 or f0) begin
		case({f3,f2,f1,f0})
			4'b0000 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,4'h0};
			4'b0001 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0};
			4'b0010 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1};
			4'b0011 : if(i1!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i1,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+1};
			4'b0100 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i2};
			4'b0101 : if(i2!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+1};
			4'b0110 : if(i2!=i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1+1};
			4'b0111 : if(i2!=i1 && i1!=i0) {o3,o2,o1,o0} <= {4'h0,i2,i1,i0};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2,i0+1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i1+1,i0};
			4'b1000 : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i3};
			4'b1001 : if(i3!=i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i0+1};
			4'b1010 : if(i3!=i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i1+1};
			4'b1011 : if(i3!=i1 && i1!=i0) {o3,o2,o1,o0} <= {4'h0,i3,i1,i0};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0+1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i1+1,i0};
			4'b1100 : if(i3!=i2) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i2};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,i2+1};
			4'b1101 : if(i3!=i2 && i2!=i0) {o3,o2,o1,o0} <= {4'h0,i3,i2,i0};
			          else if(i2==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i0+1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i2+1,i0};
			4'b1110 : if(i3!=i2 && i2!=i1) {o3,o2,o1,o0} <= {4'h0,i3,i2,i1};
			          else if(i2==i1) {o3,o2,o1,o0} <= {4'h0,4'h0,i3,i1+1};
			          else {o3,o2,o1,o0} <= {4'h0,4'h0,i2+1,i1};
			4'b1111 : if(i3!=i2 && i2!=i1 && i1!=i0) {o3,o2,o1,o0} <= {i3,i2,i1,i0};
			          else if(i3==i2 && i1==i0) {o3,o2,o1,o0} <= {4'h0,4'h0,i2+1,i0+1};
			          else if(i1==i0) {o3,o2,o1,o0} <= {4'h0,i3,i2,i0+1};
			          else if(i2==i1) {o3,o2,o1,o0} <= {4'h0,i3,i1+1,i0};
			          else {o3,o2,o1,o0} <= {4'h0,i2+1,i1,i0};
			default : {o3,o2,o1,o0} <= {4'h0,4'h0,4'h0,4'h0};
		endcase
	end
endmodule

module gen(rst,clk,i3,i2,i1,i0,o3,o2,o1,o0);
    input rst,clk;
    input [3:0] i3,i2,i1,i0;
    output reg [3:0] o3,o2,o1,o0;
  
	wire f3,f2,f1,f0;
	assign f3=(i3!=4'h0);
	assign f2=(i2!=4'h0);
	assign f1=(i1!=4'h0);
	assign f0=(i0!=4'h0);
	
    wire [7:0] ran2;
    wire [11:0] ran3;
    wire [15:0] ran4;
  
	random ran(rst,clk,ran2,ran3,ran4);
  
    always @(i3 or i2 or i1 or i0 or f3 or f2 or f1 or f0) begin
		case({f3,f2,f1,f0})
			4'b0000 : {o3,o2,o1,o0} <= {ran4};
			4'b0001 : {o3,o2,o1,o0} <= {ran3,i0};
			4'b0010 : {o3,o2,o1,o0} <= {ran3[11:8],ran3[7:4],i1,ran3[3:0]};
			4'b0011 : {o3,o2,o1,o0} <= {ran2[7:4],ran2[3:0],i1,i0};
			4'b0100 : {o3,o2,o1,o0} <= {ran3[11:8],i2,ran3[7:4],ran3[3:0]};
			4'b0101 : {o3,o2,o1,o0} <= {ran2[8:4],i2,ran2[3:0],i0};
			4'b0110 : {o3,o2,o1,o0} <= {ran2[7:4],i2,i1,ran2[3:0]};
			4'b0111 : {o3,o2,o1,o0} <= {4'h1,i2,i1,i0};
			4'b1000 : {o3,o2,o1,o0} <= {i3,ran3};
			4'b1001 : {o3,o2,o1,o0} <= {i3,ran2[7:4],ran2[3:0],i0};
			4'b1010 : {o3,o2,o1,o0} <= {i3,ran2[7:4],i1,ran2[3:0]};
			4'b1011 : {o3,o2,o1,o0} <= {i3,4'h1,i1,i0};
			4'b1100 : {o3,o2,o1,o0} <= {i3,i2,ran2[7:4],ran2[3:0]};
			4'b1101 : {o3,o2,o1,o0} <= {i3,i2,4'h1,i0};
			4'b1110 : {o3,o2,o1,o0} <= {i3,i2,i1,4'h1};
			4'b1111 : {o3,o2,o1,o0} <= {i3,i2,i1,i0};
			default : {o3,o2,o1,o0} <= {i3,i2,i1,i0};
		endcase
	end
endmodule

module random(rst,clk,ran2,ran3,ran4);
    input rst,clk;
    output reg [7:0] ran2;
    output reg [11:0] ran3;
    output reg [15:0] ran4;
  
    always @(posedge rst or posedge clk) begin
		if(rst) begin
		  ran2 <= 8'h01;ran3 <= 12'h001;ran4 <= 16'h0001;
		end else begin
		  ran2 <= {ran2[3:0],ran2[7:4]};
		  ran3 <= {ran3[7:0],ran3[11:8]};
		  ran4 <= {ran4[11:0],ran4[15:12]};
		end
	end
endmodule
