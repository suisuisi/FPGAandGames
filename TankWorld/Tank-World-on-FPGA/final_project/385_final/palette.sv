module palette (
               input logic [11:0] RGB_12,
               output logic [7:0] R, G, B,
					input logic [9:0] DrawX
               );
					
logic [23:0] out;
assign R = out[23:16];
assign G = out[15:8];
assign B = out[7:0];

always_comb
    begin
        unique case (RGB_12)
             12'h000:  out = 24'h3f007f - DrawX[9:3];
             12'hb40:  out = 24'hb04000;
             12'hfff:  out = 24'hf0f0f0;
				 12'h222:  out = 24'h3f007f - DrawX[9:3];
				 12'h6af:  out = 24'h60a0f0;
				 12'h603:  out = 24'h3f007f - DrawX[9:3];
				 12'hee9:  out = 24'he0e090;
				 12'hb27:  out = 24'hb02070;
				 12'h16d:  out = 24'h1060d0;
				 12'hf87:  out = 24'hf08070;
				 12'h666:  out = 24'h606060;
				 12'hbbb:  out = 24'hb0b0b0;
				 12'hc7f:  out = 24'hc070f0;
				 12'h4cd:  out = 24'h40c0d0;
				 12'h8d0:  out = 24'h80d000;
				 12'h380:  out = 24'h308000;
				 12'h916:  out = 24'h901060;
				 12'hd29:  out = 24'hd02090;
				 12'h72f:  out = 24'h7020f0;
				 12'h660:  out = 24'h606000;
				 12'hbb0:  out = 24'hb0b000;
				 12'h5ef:  out = 24'h50e0f0;
				 12'hfa9:  out = 24'hf0a090;
				 12'hf76:  out = 24'hf07060;
				 12'h777:  out = 24'h707070;
				 12'h555:  out = 24'h505050;
				 12'h999:  out = 24'h909090;
//				 12'h100:  out = 24'hf0f0f0; //make the number looks better
//				 12'h200:  out = 24'hf0f0f0; //make the number looks better
//				 12'h333:  out = 24'hf0f0f0; //make the number looks better
//				 12'h444:  out = 24'hf0f0f0; //make the number looks better
//				 12'h500:  out = 24'hf0f0f0; //make the number looks better
//				 12'h600:  out = 24'hf0f0f0; //make the number looks better
//				 12'h700:  out = 24'hf0f0f0; //make the number looks better
//				 12'h888:  out = 24'hf0f0f0; //make the number looks better
//				 12'h900:  out = 24'hf0f0f0; //make the number looks better
//				 12'haaa:  out = 24'hf0f0f0; //make the number looks better
//				 12'hb00:  out = 24'hf0f0f0; //make the number looks better
//				 12'hccc:  out = 24'hf0f0f0; //make the number looks better
//				 12'hddd:  out = 24'hf0f0f0; //make the number looks better
//				 12'heee:  out = 24'hf0f0f0; //make the number looks better
				 12'hf00:  out = 24'hf00000; //make the number looks better
				 //12'he00:  out = 24'he00000;
				 default:  out = 24'h000000;		
        endcase
    end

endmodule
