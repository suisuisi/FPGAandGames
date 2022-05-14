
module InvShiftRows (input logic [127:0] data_in, output logic [127:0] data_out);

logic [0:127] in;
logic [0:127] out;

assign in = data_in;
assign data_out = out;

logic [7:0] a0 [0:3];
logic [7:0] a1 [0:3];
logic [7:0] a2 [0:3];
logic [7:0] a3 [0:3];

assign a0[0] = in[0:7];
assign a1[0] = in[8:15];
assign a2[0] = in[16:23];
assign a3[0] = in[24:31];

assign a0[1] = in[32:39];
assign a1[1] = in[40:47];
assign a2[1] = in[48:55];
assign a3[1] = in[56:63];

assign a0[2] = in[64:71];
assign a1[2] = in[72:79];
assign a2[2] = in[80:87];
assign a3[2] = in[88:95];

assign a0[3] = in[96:103];
assign a1[3] = in[104:111];
assign a2[3] = in[112:119];
assign a3[3] = in[120:127];

assign out[0:7] = a0[0];
assign out[8:15] = a1[3];
assign out[16:23] = a2[2];
assign out[24:31] = a3[1];

assign out[32:39] = a0[1];
assign out[40:47] = a1[0];
assign out[48:55] = a2[3];
assign out[56:63] = a3[2];

assign out[64:71] = a0[2];
assign out[72:79] = a1[1];
assign out[80:87] = a2[0];
assign out[88:95] = a3[3];

assign out[96:103] = a0[3];
assign out[104:111] = a1[2];
assign out[112:119] = a2[1];
assign out[120:127] = a3[0];

endmodule
