`define S16 s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0
`define U16 u15,u14,u13,u12,u11,u10,u9,u8,u7,u6,u5,u4,u3,u2,u1,u0
`define D16 d15,d14,d13,d12,d11,d10,d9,d8,d7,d6,d5,d4,d3,d2,d1,d0
`define L16 l15,l14,l13,l12,l11,l10,l9,l8,l7,l6,l5,l4,l3,l2,l1,l0
`define R16 r15,r14,r13,r12,r11,r10,r9,r8,r7,r6,r5,r4,r3,r2,r1,r0
`define P16 p15,p14,p13,p12,p11,p10,p9,p8,p7,p6,p5,p4,p3,p2,p1,p0

`timescale 1ns / 1ps

// Project F: Display Controller  Game top
//运行游戏的主模块，决定游戏的状态，处理输入与输出的数据，调用各个模块。
/***************************************************
game模块共有三个always语句，其中第一个always语句是处理按键的输入与游戏的改变输出，即数字的大小及位置的改变，数字的合并；
第二个always语句是处理屏幕颜色的变化，其将640*480分辨率的显示屏等分为160*120个格子，决定每个格子的颜色，即将游戏界面显示在屏幕上；
第三个always语句处理笑脸随游戏状态的改变，游戏状态有status表示，
0 代表游戏继续，显示平淡脸；1 代表游戏失败，显示哭脸；2 代表游戏胜利，显示笑脸
*****************************************************/
// (C)2020 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

// This demo requires the following Verilog modules:
//  gen.v
//  move.v
//  random.v
// seg.v 
// shake.v


module game(
	input rst_n,clk,
	input [3:0] key,
	output OLED_CLK_SLAVE,OLED_DATA,OLED_DC,OLED_CS,
	output Hsync,Vsync,
	output [3:0] vgaRed,vgaGreen,vgaBlue,
	output OLED_RES
	);

/*
#BTND--key[3]

#BTNL--key[1]
	
#BTNR--key[0]

#BTNU--key[2]
*/

	
/*RES OLED复位信号，屏幕端已经做了RC，程序中置高即可*/
	
	assign OLED_RES = 1'b1;
    
/*RES OLED复位信号，屏幕端已经做了RC，程序中置高即可*/    
    wire rst;
    assign rst = ~rst_n;
	reg [3:0] `P16,`S16;
	wire [3:0] `U16,`D16,`L16,`R16,gu3,gu2,gu1,gu0,gd15,gd14,gd13,gd12,gl12,gl8,gl4,gl0,gr15,gr11,gr7,gr3;
    reg [15:0] counter;
    wire clk_game,clk_rand,clk_vga;
    wire [3:0] keyin;
    reg [1:0] state;
	reg [7:0] step;
    reg [7:0] score;
    reg [1:0] status;
    assign clk_game = counter[10];
    assign clk_rand = counter[15];
    assign clk_vga = counter[1];
    
    /*利用FIFO进行滤波操作*/
    shake shake_3(rst,clk_game,~key[3],keyin[3]);
    shake shake_2(rst,clk_game,~key[2],keyin[2]);
    shake shake_1(rst,clk_game,~key[1],keyin[1]);
    shake shake_0(rst,clk_game,~key[0],keyin[0]);
    
    /*没有按键的板卡可以利用VIO简单测试，上边的信号需要注释掉*/
/*	
	vio_0 key_out (
  .clk(clk),                // input wire clk
  .probe_out0(keyin[3]),  // output wire [0 : 0] probe_out0
  .probe_out1(keyin[2]),  // output wire [0 : 0] probe_out1
  .probe_out2(keyin[1]),  // output wire [0 : 0] probe_out2
  .probe_out3(keyin[0])  // output wire [0 : 0] probe_out3
);
*/	
	
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
	gen gu(rst,clk_rand,s3,s2,s1,s0,gu3,gu2,gu1,gu0);
	gen gd(rst,clk_rand,s15,s14,s13,s12,gd15,gd14,gd13,gd12);
	gen gl(rst,clk_rand,s12,s8,s4,s0,gl12,gl8,gl4,gl0);
	gen gr(rst,clk_rand,s15,s11,s7,s3,gr15,gr11,gr7,gr3);
	
	always @(posedge rst or posedge clk_game) begin
		if(rst) begin
			s15 <= 4'h0;s14 <= 4'h1;s13 <= 4'h0;s12 <= 4'h2;
			s11 <= 4'h0;s10 <= 4'h2;s9 <= 4'h0;s8 <= 4'h0;
			s7 <= 4'h0;s6 <= 4'h0;s5 <= 4'h0;s4 <= 4'h0;
			s3 <= 4'h0;s2 <= 4'h0;s1 <= 4'h1;s0 <= 4'h0;
			{`P16} <= 0;step <= 0;score <= 0;status <= 0;state <= 0;
		end else begin
			case(state)
				2'b00 : begin
					case(keyin)
						4'b0000 : begin {`S16} <= {`S16};state <= 0;end
						4'b1000 : begin {`S16} <= {`U16};state <= 1;end
						4'b0100 : begin {`S16} <= {`D16};state <= 1;end
						4'b0010 : begin {`S16} <= {`L16};state <= 1;end
						4'b0001 : begin {`S16} <= {`R16};state <= 1;end
						default : begin {`S16} <= {`S16};state <= 0;end
					endcase
					{`P16} <= {`S16};step <= step;score <= score;status <= status;
				end
				2'b01 : begin
				    if({`P16} == {`S16}) begin {`S16} <= {`S16};end
				    else case(keyin)
                            4'b1000 : begin {`S16} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,gu3,gu2,gu1,gu0};end
                            4'b0100 : begin {`S16} <= {gd15,gd14,gd13,gd12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};end
                            4'b0010 : begin {`S16} <= {s15,s14,s13,gl12,s11,s10,s9,gl8,s7,s6,s5,gl4,s3,s2,s1,gl0};end
                            4'b0001 : begin {`S16} <= {gr15,s14,s13,s12,gr11,s10,s9,s8,gr7,s6,s5,s4,gr3,s2,s1,s0};end
                            default : begin {`S16} <= {s15,s14,s13,s12,s11,s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0};end
                        endcase
					{`P16} <= {`P16};step <= step;score <= score;state <= 2;status <= status;
				end
				2'b10 : begin
					{`S16} <= {`S16};{`P16} <= {`P16};step <= step + 1;score <= score;
					if({`U16}=={`D16} && {`L16}=={`R16}) begin status <= 1;state<= 3;end//dead
				    else if(keyin == 4'b0000) begin
				        if(s15==4'hb||s14==4'hb||s13==4'hb||s12==4'hb||s11==4'hb||s10==4'hb||s9==4'hb||s8==4'hb||s7==4'hb||s6==4'hb||s5==4'hb||s4==4'hb||s3==4'hb||s2==4'hb||s1==4'hb||s0==4'hb)
				            status <= 2;
				        else status <= status;
				        state <= 0;
				    end else begin
				        status <= status;
				        state <= 2;
				    end
				end
				2'b11 : begin {`S16} <= {`S16};{`P16} <= {`P16};step <= step;score <= score;status <= status;state <= 3;end
				default : begin {`S16} <= {`S16};{`P16} <= {`P16};step <= step;score <= score;status <= status;state <= 0;end
			endcase
		end
	end
	
	wire [0:287] e15,e14,e13,e12,e11,e10,e9,e8,e7,e6,e5,e4,e3,e2,e1,e0;
	reg [0:103] faceu,faced;
	reg [9:0] position;
    reg [7:0] din;
    wire [6:0] xin,xin_shift;
    wire [2:0] yin;
    assign xin = position[6:0];
    assign yin = position[9:7];
    assign xin_shift = xin + 7'h01;
        
	seg seg15(s15,e15);seg seg14(s14,e14);seg seg13(s13,e13);seg seg12(s12,e12);
    seg seg11(s11,e11);seg seg10(s10,e10);seg seg9(s9,e9);seg seg8(s8,e8);
    seg seg7(s7,e7);seg seg6(s6,e6);seg seg5(s5,e5);seg seg4(s4,e4);
    seg seg3(s3,e3);seg seg2(s2,e2);seg seg1(s1,e1);seg seg0(s0,e0);
    
        /*OLED驱动*/
    draw draw_0(
    .rst            (rst            ),
    .clk            (clk            ),
    .xin             (xin_shift      ),
    .yin            (yin            ),
    .din            (din            ),
    .J              ({OLED_CLK_SLAVE,OLED_DATA,OLED_DC,OLED_CS}),
    .ready          (ready          )
    );
	
	always @(posedge rst or posedge ready) begin
        if(rst) begin position <= 0;din <= 8'h00;end
        else begin
            position <= position + 1;
            case(yin)
                3'h0 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= {e15[(xin- 0)*8+7],e15[(xin- 0)*8+6],e15[(xin- 0)*8+5],e15[(xin- 0)*8+4],e15[(xin- 0)*8+3],e15[(xin- 0)*8+2],e15[(xin- 0)*8+1],e15[(xin- 0)*8+0]} | 8'h01;
                  else if(xin<36) din <= {e14[(xin-18)*8+7],e14[(xin-18)*8+6],e14[(xin-18)*8+5],e14[(xin-18)*8+4],e14[(xin-18)*8+3],e14[(xin-18)*8+2],e14[(xin-18)*8+1],e14[(xin-18)*8+0]} | 8'h01;
                  else if(xin<54) din <= {e13[(xin-36)*8+7],e13[(xin-36)*8+6],e13[(xin-36)*8+5],e13[(xin-36)*8+4],e13[(xin-36)*8+3],e13[(xin-36)*8+2],e13[(xin-36)*8+1],e13[(xin-36)*8+0]} | 8'h01;
                  else if(xin<72) din <= {e12[(xin-54)*8+7],e12[(xin-54)*8+6],e12[(xin-54)*8+5],e12[(xin-54)*8+4],e12[(xin-54)*8+3],e12[(xin-54)*8+2],e12[(xin-54)*8+1],e12[(xin-54)*8+0]} | 8'h01;
                  else din <= 8'h00;
                3'h1 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= {e15[(xin+18)*8+7],e15[(xin+18)*8+6],e15[(xin+18)*8+5],e15[(xin+18)*8+4],e15[(xin+18)*8+3],e15[(xin+18)*8+2],e15[(xin+18)*8+1],e15[(xin+18)*8+0]};
                  else if(xin<36) din <= {e14[(xin- 0)*8+7],e14[(xin- 0)*8+6],e14[(xin- 0)*8+5],e14[(xin- 0)*8+4],e14[(xin- 0)*8+3],e14[(xin- 0)*8+2],e14[(xin- 0)*8+1],e14[(xin- 0)*8+0]};
                  else if(xin<54) din <= {e13[(xin-18)*8+7],e13[(xin-18)*8+6],e13[(xin-18)*8+5],e13[(xin-18)*8+4],e13[(xin-18)*8+3],e13[(xin-18)*8+2],e13[(xin-18)*8+1],e13[(xin-18)*8+0]};
                  else if(xin<72) din <= {e12[(xin-36)*8+7],e12[(xin-36)*8+6],e12[(xin-36)*8+5],e12[(xin-36)*8+4],e12[(xin-36)*8+3],e12[(xin-36)*8+2],e12[(xin-36)*8+1],e12[(xin-36)*8+0]};
                  else din <= 8'h00;
                3'h2 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= {e11[(xin- 0)*8+7],e11[(xin- 0)*8+6],e11[(xin- 0)*8+5],e11[(xin- 0)*8+4],e11[(xin- 0)*8+3],e11[(xin- 0)*8+2],e11[(xin- 0)*8+1],e11[(xin- 0)*8+0]} | 8'h01;
                  else if(xin<36) din <= {e10[(xin-18)*8+7],e10[(xin-18)*8+6],e10[(xin-18)*8+5],e10[(xin-18)*8+4],e10[(xin-18)*8+3],e10[(xin-18)*8+2],e10[(xin-18)*8+1],e10[(xin-18)*8+0]} | 8'h01;
                  else if(xin<54) din <= { e9[(xin-36)*8+7], e9[(xin-36)*8+6], e9[(xin-36)*8+5], e9[(xin-36)*8+4], e9[(xin-36)*8+3], e9[(xin-36)*8+2], e9[(xin-36)*8+1], e9[(xin-36)*8+0]} | 8'h01;
                  else if(xin<72) din <= { e8[(xin-54)*8+7], e8[(xin-54)*8+6], e8[(xin-54)*8+5], e8[(xin-54)*8+4], e8[(xin-54)*8+3], e8[(xin-54)*8+2], e8[(xin-54)*8+1], e8[(xin-54)*8+0]} | 8'h01;
                  else if(xin>89 && xin<104) din <= {faceu[(xin-90)*8+7],faceu[(xin-90)*8+6],faceu[(xin-90)*8+5],faceu[(xin-90)*8+4],faceu[(xin-90)*8+3],faceu[(xin-90)*8+2],faceu[(xin-90)*8+1],faceu[(xin-90)*8+0]}; 
                  else din <= 8'h00;
                3'h3 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= {e11[(xin+18)*8+7],e11[(xin+18)*8+6],e11[(xin+18)*8+5],e11[(xin+18)*8+4],e11[(xin+18)*8+3],e11[(xin+18)*8+2],e11[(xin+18)*8+1],e11[(xin+18)*8+0]};
                  else if(xin<36) din <= {e10[(xin- 0)*8+7],e10[(xin- 0)*8+6],e10[(xin- 0)*8+5],e10[(xin- 0)*8+4],e10[(xin- 0)*8+3],e10[(xin- 0)*8+2],e10[(xin- 0)*8+1],e10[(xin- 0)*8+0]};
                  else if(xin<54) din <= { e9[(xin-18)*8+7], e9[(xin-18)*8+6], e9[(xin-18)*8+5], e9[(xin-18)*8+4], e9[(xin-18)*8+3], e9[(xin-18)*8+2], e9[(xin-18)*8+1], e9[(xin-18)*8+0]};
                  else if(xin<72) din <= { e8[(xin-36)*8+7], e8[(xin-36)*8+6], e8[(xin-36)*8+5], e8[(xin-36)*8+4], e8[(xin-36)*8+3], e8[(xin-36)*8+2], e8[(xin-36)*8+1], e8[(xin-36)*8+0]};
                  else if(xin>89 && xin<104) din <= {faced[(xin-90)*8+7],faced[(xin-90)*8+6],faced[(xin-90)*8+5],faced[(xin-90)*8+4],faced[(xin-90)*8+3],faced[(xin-90)*8+2],faced[(xin-90)*8+1],faced[(xin-90)*8+0]}; 
                  else din <= 8'h00;
                3'h4 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= { e7[(xin- 0)*8+7], e7[(xin- 0)*8+6], e7[(xin- 0)*8+5], e7[(xin- 0)*8+4], e7[(xin- 0)*8+3], e7[(xin- 0)*8+2], e7[(xin- 0)*8+1], e7[(xin- 0)*8+0]} | 8'h01;
                  else if(xin<36) din <= { e6[(xin-18)*8+7], e6[(xin-18)*8+6], e6[(xin-18)*8+5], e6[(xin-18)*8+4], e6[(xin-18)*8+3], e6[(xin-18)*8+2], e6[(xin-18)*8+1], e6[(xin-18)*8+0]} | 8'h01;
                  else if(xin<54) din <= { e5[(xin-36)*8+7], e5[(xin-36)*8+6], e5[(xin-36)*8+5], e5[(xin-36)*8+4], e5[(xin-36)*8+3], e5[(xin-36)*8+2], e5[(xin-36)*8+1], e5[(xin-36)*8+0]} | 8'h01;
                  else if(xin<72) din <= { e4[(xin-54)*8+7], e4[(xin-54)*8+6], e4[(xin-54)*8+5], e4[(xin-54)*8+4], e4[(xin-54)*8+3], e4[(xin-54)*8+2], e4[(xin-54)*8+1], e4[(xin-54)*8+0]} | 8'h01;
                  else din <= 8'h00;
                3'h5 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= { e7[(xin+18)*8+7], e7[(xin+18)*8+6], e7[(xin+18)*8+5], e7[(xin+18)*8+4], e7[(xin+18)*8+3], e7[(xin+18)*8+2], e7[(xin+18)*8+1], e7[(xin+18)*8+0]};
                  else if(xin<36) din <= { e6[(xin- 0)*8+7], e6[(xin- 0)*8+6], e6[(xin- 0)*8+5], e6[(xin- 0)*8+4], e6[(xin- 0)*8+3], e6[(xin- 0)*8+2], e6[(xin- 0)*8+1], e6[(xin- 0)*8+0]};
                  else if(xin<54) din <= { e5[(xin-18)*8+7], e5[(xin-18)*8+6], e5[(xin-18)*8+5], e5[(xin-18)*8+4], e5[(xin-18)*8+3], e5[(xin-18)*8+2], e5[(xin-18)*8+1], e5[(xin-18)*8+0]};
                  else if(xin<72) din <= { e4[(xin-36)*8+7], e4[(xin-36)*8+6], e4[(xin-36)*8+5], e4[(xin-36)*8+4], e4[(xin-36)*8+3], e4[(xin-36)*8+2], e4[(xin-36)*8+1], e4[(xin-36)*8+0]};
                  else din <= 8'h00;
                3'h6 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= { e3[(xin- 0)*8+7], e3[(xin- 0)*8+6], e3[(xin- 0)*8+5], e3[(xin- 0)*8+4], e3[(xin- 0)*8+3], e3[(xin- 0)*8+2], e3[(xin- 0)*8+1], e3[(xin- 0)*8+0]} | 8'h01;
                  else if(xin<36) din <= { e2[(xin-18)*8+7], e2[(xin-18)*8+6], e2[(xin-18)*8+5], e2[(xin-18)*8+4], e2[(xin-18)*8+3], e2[(xin-18)*8+2], e2[(xin-18)*8+1], e2[(xin-18)*8+0]} | 8'h01;
                  else if(xin<54) din <= { e1[(xin-36)*8+7], e1[(xin-36)*8+6], e1[(xin-36)*8+5], e1[(xin-36)*8+4], e1[(xin-36)*8+3], e1[(xin-36)*8+2], e1[(xin-36)*8+1], e1[(xin-36)*8+0]} | 8'h01;
                  else if(xin<72) din <= { e0[(xin-54)*8+7], e0[(xin-54)*8+6], e0[(xin-54)*8+5], e0[(xin-54)*8+4], e0[(xin-54)*8+3], e0[(xin-54)*8+2], e0[(xin-54)*8+1], e0[(xin-54)*8+0]} | 8'h01;
                  else din <= 8'h00;
                3'h7 : if(xin==0||xin==18||xin==36||xin==54||xin==72) din <= 8'hff;
                  else if(xin<18) din <= { e3[(xin+18)*8+7], e3[(xin+18)*8+6], e3[(xin+18)*8+5], e3[(xin+18)*8+4], e3[(xin+18)*8+3], e3[(xin+18)*8+2], e3[(xin+18)*8+1], e3[(xin+18)*8+0]} | 8'h80;
                  else if(xin<36) din <= { e2[(xin- 0)*8+7], e2[(xin- 0)*8+6], e2[(xin- 0)*8+5], e2[(xin- 0)*8+4], e2[(xin- 0)*8+3], e2[(xin- 0)*8+2], e2[(xin- 0)*8+1], e2[(xin- 0)*8+0]} | 8'h80;
                  else if(xin<54) din <= { e1[(xin-18)*8+7], e1[(xin-18)*8+6], e1[(xin-18)*8+5], e1[(xin-18)*8+4], e1[(xin-18)*8+3], e1[(xin-18)*8+2], e1[(xin-18)*8+1], e1[(xin-18)*8+0]} | 8'h80;
                  else if(xin<72) din <= { e0[(xin-36)*8+7], e0[(xin-36)*8+6], e0[(xin-36)*8+5], e0[(xin-36)*8+4], e0[(xin-36)*8+3], e0[(xin-36)*8+2], e0[(xin-36)*8+1], e0[(xin-36)*8+0]} | 8'h80;
                  else din <= 8'h00;
                default : din <= 8'h00;
            endcase
        end
    end
    
    reg [2:0] db;
    wire [9:0] vx,vy;
    wire [7:0] inx;
    wire [4:0] iny;
    wire [2:0] calcy;
    
    vga vga_0(rst,clk_vga,db,vgaRed[3],vgaGreen[3],vgaBlue[3],Hsync,Vsync,vx,vy);
    assign vgaRed[2:0] = 3'h0;
    assign vgaGreen[2:0] = 3'h0;
    assign vgaBlue[2:0] = 3'h0;
    assign inx = vx[9:2];
    assign iny = vy[9:5];
    assign calcy = vy[4:2];
    
    always @(inx or iny) begin
        case(iny)
            5'h00 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx <= 72 && calcy == 3'b000) db <= 3'b111;
              else if(inx<18) db <= {3{e15[(inx- 0)*8+calcy]}} ^ (s15[2:0]);
              else if(inx<36) db <= {3{e14[(inx-18)*8+calcy]}} ^ (s14[2:0]);
              else if(inx<54) db <= {3{e13[(inx-36)*8+calcy]}} ^ (s13[2:0]);
              else if(inx<72) db <= {3{e12[(inx-54)*8+calcy]}} ^ (s12[2:0]);
              else db <= 3'b000;
            5'h01 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx<18) db <= {3{e15[(inx+18)*8+calcy]}} ^ (s15[2:0]);
              else if(inx<36) db <= {3{e14[(inx- 0)*8+calcy]}} ^ (s14[2:0]);
              else if(inx<54) db <= {3{e13[(inx-18)*8+calcy]}} ^ (s13[2:0]);
              else if(inx<72) db <= {3{e12[(inx-36)*8+calcy]}} ^ (s12[2:0]);
              else db <= 3'b000;
            5'h02 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx <= 72 && calcy == 3'b000) db <= 3'b111;
              else if(inx<18) db <= {3{e11[(inx- 0)*8+calcy]}} ^ (s11[2:0]);
              else if(inx<36) db <= {3{e10[(inx-18)*8+calcy]}} ^ (s10[2:0]);
              else if(inx<54) db <= {3{ e9[(inx-36)*8+calcy]}} ^ ( s9[2:0]);
              else if(inx<72) db <= {3{ e8[(inx-54)*8+calcy]}} ^ ( s8[2:0]);
              else if(inx>89 && inx<104)
                    case(status)
                        1 : db <= {faceu[(inx-90)*8+calcy],2'b00};
                        2 : db <= {1'b0,faceu[(inx-90)*8+calcy],1'b0};
                        default : db <= {2'b00,faceu[(inx-90)*8+calcy]};
                    endcase
              else db <= 3'b000;
            5'h03 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx<18) db <= {3{e11[(inx+18)*8+calcy]}} ^ (s11[2:0]);
              else if(inx<36) db <= {3{e10[(inx- 0)*8+calcy]}} ^ (s10[2:0]);
              else if(inx<54) db <= {3{ e9[(inx-18)*8+calcy]}} ^ ( s9[2:0]);
              else if(inx<72) db <= {3{ e8[(inx-36)*8+calcy]}} ^ ( s8[2:0]);
              else if(inx>89 && inx<104)
                    case(status)
                        1 : db <= {faced[(inx-90)*8+calcy],2'b00};
                        2 : db <= {1'b0,faced[(inx-90)*8+calcy],1'b0};
                        default : db <= {2'b00,faced[(inx-90)*8+calcy]};
                    endcase
              else db <= 3'b000;
            5'h04 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx <= 72 && calcy == 3'b000) db <= 3'b111;
              else if(inx<18) db <= {3{ e7[(inx- 0)*8+calcy]}} ^ (s7[2:0]);
              else if(inx<36) db <= {3{ e6[(inx-18)*8+calcy]}} ^ (s6[2:0]);
              else if(inx<54) db <= {3{ e5[(inx-36)*8+calcy]}} ^ (s5[2:0]);
              else if(inx<72) db <= {3{ e4[(inx-54)*8+calcy]}} ^ (s4[2:0]);
              else db <= 3'b000;
            5'h05 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx<18) db <= {3{ e7[(inx+18)*8+calcy]}} ^ (s7[2:0]);
              else if(inx<36) db <= {3{ e6[(inx- 0)*8+calcy]}} ^ (s6[2:0]);
              else if(inx<54) db <= {3{ e5[(inx-18)*8+calcy]}} ^ (s5[2:0]);
              else if(inx<72) db <= {3{ e4[(inx-36)*8+calcy]}} ^ (s4[2:0]);
              else db <= 3'b000;
            5'h06 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx <= 72 && calcy == 3'b000) db <= 3'b111;
              else if(inx<18) db <= {3{ e3[(inx- 0)*8+calcy]}} ^ (s3[2:0]);
              else if(inx<36) db <= {3{ e2[(inx-18)*8+calcy]}} ^ (s2[2:0]);
              else if(inx<54) db <= {3{ e1[(inx-36)*8+calcy]}} ^ (s1[2:0]);
              else if(inx<72) db <= {3{ e0[(inx-54)*8+calcy]}} ^ (s0[2:0]);
              else db <= 3'b000;
            5'h07 :if(inx==0||inx==18||inx==36||inx==54||inx==72) db <= 3'b111;
              else if(inx<18) db <= {3{ e3[(inx+18)*8+calcy]}} ^ (s3[2:0]);
              else if(inx<36) db <= {3{ e2[(inx- 0)*8+calcy]}} ^ (s2[2:0]);
              else if(inx<54) db <= {3{ e1[(inx-18)*8+calcy]}} ^ (s1[2:0]);
              else if(inx<72) db <= {3{ e0[(inx-36)*8+calcy]}} ^ (s0[2:0]);
              else db <= 3'b000;
            5'h08 :if(inx <= 72 && calcy == 3'b000) db <= 3'b111;
              else db <= 3'b000;
            default : db <= 3'b000;
        endcase
    end
    
    always @(status) begin
        case(status)
        0 : begin faceu <= 104'h08_08_08_08_08_00_00_00_08_08_08_08_08;
                  faced <= 104'h00_00_00_0c_02_01_61_01_02_0c_00_00_00;
            end
        1 : begin faceu <= 104'h22_14_08_14_22_00_00_00_22_14_08_14_22;
                  faced <= 104'h00_00_00_1c_22_41_41_41_22_1c_00_00_00;
            end
        2 : begin faceu <= 104'h06_0c_08_08_04_00_00_00_06_0c_08_08_04;
                  faced <= 104'h00_00_00_0c_02_01_61_01_02_0c_00_00_00;
            end
        default : begin faceu <= 104'h00_00_00_00_00_00_00_00_00_00_00_00_00;
                        faced <= 104'h00_00_00_0c_02_01_01_01_02_0c_00_00_00;
                  end
        endcase
    end
    //分频模块，将主频率分为clk_game, clk_rand, clk_vga
	always @(posedge rst or posedge clk) begin
		if(rst) counter <= 0;
		else counter <= counter + 1;
	end
endmodule