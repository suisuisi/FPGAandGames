module VGA(
  clk_n,
  rst,
  hsync_r,
  vsync_r,
  OutRed,
  OutGreen,
  OutBlue,
  num
  );
  input clk_n;
  input rst;
  input [199:0] num;
  output reg hsync_r;
  output reg vsync_r;
  output[3:0] OutRed;
  output[3:0] OutGreen;
  output[3:0] OutBlue;
  
  wire [9:0] R [19:0];
  assign R[0] = num[9:0];
  assign R[1] = num[19:10];
  assign R[2] = num[29:20];
  assign R[3] = num[39:30];
  assign R[4] = num[49:40];
  assign R[5] = num[59:50];
  assign R[6] = num[69:60];
  assign R[7] = num[79:70];
  assign R[8] = num[89:80];
  assign R[9] = num[99:90];
  assign R[10] = num[109:100];
  assign R[11] = num[119:110];
  assign R[12] = num[129:120];
  assign R[13] = num[139:130];
  assign R[14] = num[149:140];
  assign R[15] = num[159:150];
  assign R[16] = num[169:160];
  assign R[17] = num[179:170];
  assign R[18] = num[189:180];
  assign R[19] = num[199:190];
  
  reg[9:0]xsync,ysync;
  always @(posedge clk_n or posedge rst) begin
    if (rst) begin  
      xsync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      xsync <= 10'd0;
    end
    else begin
      xsync <= xsync + 1;
    end
  end

  always @(posedge clk_n or posedge rst) begin
    if (rst) begin
      ysync <= 10'd0;
    end
    else if (ysync == 10'd524) begin
      ysync <= 10'd0;
    end
    else if (xsync == 10'd799) begin
      ysync <= ysync + 1;
    end
  end
  
  always @(posedge clk_n or posedge rst) begin
    if (rst) begin
      hsync_r <= 1'b0;
    end
    else if (xsync == 799) begin
      hsync_r <=1'b0;
    end
    else if (xsync == 95) begin
      hsync_r <= 1'b1;
    end
  end

  always @(posedge clk_n or posedge rst) begin
    if (rst) begin
      vsync_r <= 1'b0;
    end
    else if (ysync == 0) begin
      vsync_r <=1'b0;
    end
    else if (ysync == 1) begin
      vsync_r <= 1'b1;
    end
  end
  
  wire valid;
  assign valid = (xsync > 143) && (xsync < 784) && (ysync > 34) && (ysync < 515);

  wire [9:0]x_pos, y_pos;
  assign x_pos = xsync - 143;
  assign y_pos = ysync -34;
  
wire [9:0] x;
wire [19:0] y;

assign x[0] = (x_pos >= 201) && (x_pos <= 224);
assign x[1] = (x_pos >= 225) && (x_pos <= 248);
assign x[2] = (x_pos >= 249) && (x_pos <= 272);
assign x[3] = (x_pos >= 273) && (x_pos <= 296);
assign x[4] = (x_pos >= 297) && (x_pos <= 320);
assign x[5] = (x_pos >= 321) && (x_pos <= 344);
assign x[6] = (x_pos >= 345) && (x_pos <= 368);
assign x[7] = (x_pos >= 369) && (x_pos <= 392);
assign x[8] = (x_pos >= 393) && (x_pos <= 416);
assign x[9] = (x_pos >= 417) && (x_pos <= 440);

assign y[0]  = (y_pos >= 1) && (y_pos <= 24); 
assign y[1]  = (y_pos >= 25) && (y_pos <= 48);
assign y[2]  = (y_pos >= 49) && (y_pos <= 72);
assign y[3]  = (y_pos >= 73) && (y_pos <= 96);
assign y[4]  = (y_pos >= 97) && (y_pos <=120);
assign y[5]  = (y_pos >= 121) && (y_pos <=144); 
assign y[6]  = (y_pos >= 145) && (y_pos <=168); 
assign y[7]  = (y_pos >= 169) && (y_pos <=192); 
assign y[8]  = (y_pos >= 193) && (y_pos <=216); 
assign y[9]  = (y_pos >= 217) && (y_pos <=240); 
assign y[10] = (y_pos >= 241) && (y_pos <=264); 
assign y[11] = (y_pos >= 265) && (y_pos <=288); 
assign y[12] = (y_pos >= 289) && (y_pos <=312); 
assign y[13] = (y_pos >= 313) && (y_pos <=336); 
assign y[14] = (y_pos >= 337) && (y_pos <=360); 
assign y[15] = (y_pos >= 361) && (y_pos <=384); 
assign y[16] = (y_pos >= 385) && (y_pos <=408); 
assign y[17] = (y_pos >= 409) && (y_pos <=432); 
assign y[18] = (y_pos >= 433) && (y_pos <=456); 
assign y[19] = (y_pos >= 457) && (y_pos <=480); 

//wire [9:0]R [19:0];
//assign R[0]  = 10'b0000000001;
//assign R[1]  = 10'b0000000101;
//assign R[2]  = 10'b0000010001;
//assign R[3]  = 10'b0001000001;
//assign R[4]  = 10'b0100000001;
//assign R[5]  = 10'b0100000001;
//assign R[6]  = 10'b0010000001;
//assign R[7]  = 10'b0001000001;
//assign R[8]  = 10'b0000100001;
//assign R[9]  = 10'b0000010001;
//assign R[10] = 10'b0000001001;
//assign R[11] = 10'b0000000101;
//assign R[12] = 10'b0000000011;
//assign R[13] = 10'b0000000001;
//assign R[14] = 10'b0000001001;
//assign R[15] = 10'b0000100001;
//assign R[16] = 10'b0100000001;
//assign R[17] = 10'b0000000001;
//assign R[18] = 10'b1111111111;
//assign R[19] = 10'b1010101010;

  parameter high = 12'b1111_1111_1111;
  reg [11:0] vga_rgb;
  
  //integer j, k;
  always @(posedge clk_n or posedge rst) begin
    if (rst) begin
      vga_rgb <= 0;
    end
    else if (valid)
    begin
        if (x_pos>=201 && x_pos<=440)
            if (x[0]&y[0]&R[0][0])
                vga_rgb <= high;
            else if (x[1] & y[0] &R[0][1])
                vga_rgb <= high;
            else if (x[2] & y[0] &R[0][2])
                vga_rgb <= high;            
            else if (x[3] & y[0] &R[0][3])
                 vga_rgb <= high;
            else if (x[4] & y[0] &R[0][4])
                 vga_rgb <= high;
            else if (x[5] & y[0] &R[0][5])
                 vga_rgb <= high;        
            else if (x[6] & y[0] &R[0][6])
                 vga_rgb <= high;
            else if (x[7] & y[0] &R[0][7])
                 vga_rgb <= high;
            else if (x[8] & y[0] & R[0][8])
                 vga_rgb <= high;
            else if (x[9] & y[0] & R[0][9])
                vga_rgb <= high;

            else if (x[0]&y[1]&R[1][0])
                vga_rgb <= high;
            else if (x[1] & y[1] &R[1][1])
                vga_rgb <= high;
            else if (x[2] & y[1] &R[1][2])
                vga_rgb <= high;            
            else if (x[3] & y[1] &R[1][3])
                 vga_rgb <= high;
            else if (x[4] & y[1] &R[1][4])
                 vga_rgb <= high;
            else if (x[5] & y[1] &R[1][5])
                 vga_rgb <= high;        
            else if (x[6] & y[1] &R[1][6])
                 vga_rgb <= high;
            else if (x[7] & y[1] &R[1][7])
                 vga_rgb <= high;
            else if (x[8] & y[1] & R[1][8])
                 vga_rgb <= high;
            else if (x[9] & y[1] & R[1][9])
                vga_rgb <= high;

            else if (x[0]&y[2]&R[2][0])
                vga_rgb <= high;
            else if (x[1] & y[2] &R[2][1])
                vga_rgb <= high;
            else if (x[2] & y[2] &R[2][2])
                vga_rgb <= high;            
            else if (x[3] & y[2] &R[2][3])
                 vga_rgb <= high;
            else if (x[4] & y[2] &R[2][4])
                 vga_rgb <= high;
            else if (x[5] & y[2] &R[2][5])
                 vga_rgb <= high;        
            else if (x[6] & y[2] &R[2][6])
                 vga_rgb <= high;
            else if (x[7] & y[2] &R[2][7])
                 vga_rgb <= high;
            else if (x[8] & y[2] & R[2][8])
                 vga_rgb <= high;
            else if (x[9] & y[2] & R[2][9])
                vga_rgb <= high;


            else if (x[0]&y[3]&R[3][0])
                vga_rgb <= high;
            else if (x[1] & y[3] &R[3][1])
                vga_rgb <= high;
            else if (x[2] & y[3] &R[3][2])
                vga_rgb <= high;            
            else if (x[3] & y[3] &R[3][3])
                 vga_rgb <= high;
            else if (x[4] & y[3] &R[3][4])
                 vga_rgb <= high;
            else if (x[5] & y[3] &R[3][5])
                 vga_rgb <= high;        
            else if (x[6] & y[3] &R[3][6])
                 vga_rgb <= high;
            else if (x[7] & y[3] &R[3][7])
                 vga_rgb <= high;
            else if (x[8] & y[3] & R[3][8])
                 vga_rgb <= high;
            else if (x[9] & y[3] & R[3][9])
                vga_rgb <= high;

            else if (x[0] & y[4] & R[4][0])
                vga_rgb <= high;
            else if (x[1] & y[4] &R[4][1])
                vga_rgb <= high;
            else if (x[2] & y[4] &R[4][2])
                vga_rgb <= high;            
            else if (x[3] & y[4] &R[4][3])
                 vga_rgb <= high;
            else if (x[4] & y[4] &R[4][4])
                 vga_rgb <= high;
            else if (x[5] & y[4] &R[4][5])
                 vga_rgb <= high;        
            else if (x[6] & y[4] &R[4][6])
                 vga_rgb <= high;
            else if (x[7] & y[4] &R[4][7])
                 vga_rgb <= high;
            else if (x[8] & y[4] & R[4][8])
                 vga_rgb <= high;
            else if (x[9] & y[4] & R[4][9])
                vga_rgb <= high;

            else if (x[0] &y[5] & R[5][0])
                vga_rgb <= high;
            else if (x[1] & y[5] & R[5][1])
                vga_rgb <= high;
            else if (x[2] & y[5] &R[5][2])
                vga_rgb <= high;            
            else if (x[3] & y[5] &R[5][3])
                 vga_rgb <= high;
            else if (x[4] & y[5] &R[5][4])
                 vga_rgb <= high;
            else if (x[5] & y[5] &R[5][5])
                 vga_rgb <= high;        
            else if (x[6] & y[5] &R[5][6])
                 vga_rgb <= high;
            else if (x[7] & y[5] &R[5][7])
                 vga_rgb <= high;
            else if (x[8] & y[5] & R[5][8])
                 vga_rgb <= high;
            else if (x[9] & y[5] & R[5][9])
                vga_rgb <= high;


            else if (x[0] & y[6] & R[6][0])
                vga_rgb <= high;
            else if (x[1] & y[6] & R[6][1])
                vga_rgb <= high;
            else if (x[2] & y[6] &R[6][2])
                vga_rgb <= high;            
            else if (x[3] & y[6] &R[6][3])
                 vga_rgb <= high;
            else if (x[4] & y[6] &R[6][4])
                 vga_rgb <= high;
            else if (x[5] & y[6] &R[6][5])
                 vga_rgb <= high;        
            else if (x[6] & y[6] &R[6][6])
                 vga_rgb <= high;
            else if (x[7] & y[6] &R[6][7])
                 vga_rgb <= high;
            else if (x[8] & y[6] & R[6][8])
                 vga_rgb <= high;
            else if (x[9] & y[6] & R[6][9])
                vga_rgb <= high;
            
            else if (x[0]&y[7]&R[7][0])
                vga_rgb <= high;
            else if (x[1] & y[7] &R[7][1])
                vga_rgb <= high;
            else if (x[2] & y[7] &R[7][2])
                vga_rgb <= high;            
            else if (x[3] & y[7] &R[7][3])
                 vga_rgb <= high;
            else if (x[4] & y[7] &R[7][4])
                 vga_rgb <= high;
            else if (x[5] & y[7] &R[7][5])
                 vga_rgb <= high;        
            else if (x[6] & y[7] &R[7][6])
                 vga_rgb <= high;
            else if (x[7] & y[7] &R[7][7])
                 vga_rgb <= high;
            else if (x[8] & y[7] & R[7][8])
                 vga_rgb <= high;
            else if (x[9] & y[7] & R[7][9])
                vga_rgb <= high;


            else if (x[0]&y[8]&R[8][0])
                vga_rgb <= high;
            else if (x[1] & y[8] &R[8][1])
                vga_rgb <= high;
            else if (x[2] & y[8] &R[8][2])
                vga_rgb <= high;            
            else if (x[3] & y[8] &R[8][3])
                 vga_rgb <= high;
            else if (x[4] & y[8] &R[8][4])
                 vga_rgb <= high;
            else if (x[5] & y[8] &R[8][5])
                 vga_rgb <= high;        
            else if (x[6] & y[8] &R[8][6])
                 vga_rgb <= high;
            else if (x[7] & y[8] &R[8][7])
                 vga_rgb <= high;
            else if (x[8] & y[8] & R[8][8])
                 vga_rgb <= high;
            else if (x[9] & y[8] & R[8][9])
                vga_rgb <= high;            


            else if (x[0]&y[9]&R[9][0])
                vga_rgb <= high;
            else if (x[1] & y[9] &R[9][1])
                vga_rgb <= high;
            else if (x[2] & y[9] &R[9][2])
                vga_rgb <= high;            
            else if (x[3] & y[9] &R[9][3])
                 vga_rgb <= high;
            else if (x[4] & y[9] &R[9][4])
                 vga_rgb <= high;
            else if (x[5] & y[9] &R[9][5])
                 vga_rgb <= high;        
            else if (x[6] & y[9] &R[9][6])
                 vga_rgb <= high;
            else if (x[7] & y[9] &R[9][7])
                 vga_rgb <= high;
            else if (x[8] & y[9] & R[9][8])
                 vga_rgb <= high;
            else if (x[9] & y[9] & R[9][9])
                vga_rgb <= high;

            else if (x[0]&y[10]&R[10][0])
                vga_rgb <= high;
            else if (x[1] & y[10] &R[10][1])
                vga_rgb <= high;
            else if (x[2] & y[10] &R[10][2])
                vga_rgb <= high;            
            else if (x[3] & y[10] &R[10][3])
                 vga_rgb <= high;
            else if (x[4] & y[10] &R[10][4])
                 vga_rgb <= high;
            else if (x[5] & y[10] &R[10][5])
                 vga_rgb <= high;        
            else if (x[6] & y[10] &R[10][6])
                 vga_rgb <= high;
            else if (x[7] & y[10] &R[10][7])
                 vga_rgb <= high;
            else if (x[8] & y[10] & R[10][8])
                 vga_rgb <= high;
            else if (x[9] & y[10] & R[10][9])
                vga_rgb <= high;

            else if (x[0]&y[11]&R[11][0])
                vga_rgb <= high;
            else if (x[1] & y[11] &R[11][1])
                vga_rgb <= high;
            else if (x[2] & y[11] &R[11][2])
                vga_rgb <= high;            
            else if (x[3] & y[11] &R[11][3])
                 vga_rgb <= high;
            else if (x[4] & y[11] &R[11][4])
                 vga_rgb <= high;
            else if (x[5] & y[11] &R[11][5])
                 vga_rgb <= high;        
            else if (x[6] & y[11] &R[11][6])
                 vga_rgb <= high;
            else if (x[7] & y[11] &R[11][7])
                 vga_rgb <= high;
            else if (x[8] & y[11] & R[11][8])
                 vga_rgb <= high;
            else if (x[9] & y[11] & R[11][9])
                vga_rgb <= high;

            else if (x[0]&y[12]&R[12][0])
                vga_rgb <= high;
            else if (x[1] & y[12] &R[12][1])
                vga_rgb <= high;
            else if (x[2] & y[12] &R[12][2])
                vga_rgb <= high;            
            else if (x[3] & y[12] &R[12][3])
                 vga_rgb <= high;
            else if (x[4] & y[12] &R[12][4])
                 vga_rgb <= high;
            else if (x[5] & y[12] &R[12][5])
                 vga_rgb <= high;        
            else if (x[6] & y[12] &R[12][6])
                 vga_rgb <= high;
            else if (x[7] & y[12] &R[12][7])
                 vga_rgb <= high;
            else if (x[8] & y[12] & R[12][8])
                 vga_rgb <= high;
            else if (x[9] & y[12] & R[12][9])
                vga_rgb <= high;


            else if (x[0]&y[13]&R[13][0])
                vga_rgb <= high;
            else if (x[1] & y[13] &R[13][1])
                vga_rgb <= high;
            else if (x[2] & y[13] &R[13][2])
                vga_rgb <= high;            
            else if (x[3] & y[13] &R[13][3])
                 vga_rgb <= high;
            else if (x[4] & y[13] &R[13][4])
                 vga_rgb <= high;
            else if (x[5] & y[13] &R[13][5])
                 vga_rgb <= high;        
            else if (x[6] & y[13] &R[13][6])
                 vga_rgb <= high;
            else if (x[7] & y[13] &R[13][7])
                 vga_rgb <= high;
            else if (x[8] & y[13] & R[13][8])
                 vga_rgb <= high;
            else if (x[9] & y[13] & R[13][9])
                vga_rgb <= high;

            else if (x[0] & y[14] & R[14][0])
                vga_rgb <= high;
            else if (x[1] & y[14] &R[14][1])
                vga_rgb <= high;
            else if (x[2] & y[14] &R[14][2])
                vga_rgb <= high;            
            else if (x[3] & y[14] &R[14][3])
                 vga_rgb <= high;
            else if (x[4] & y[14] &R[14][4])
                 vga_rgb <= high;
            else if (x[5] & y[14] &R[14][5])
                 vga_rgb <= high;        
            else if (x[6] & y[14] &R[14][6])
                 vga_rgb <= high;
            else if (x[7] & y[14] &R[14][7])
                 vga_rgb <= high;
            else if (x[8] & y[14] & R[14][8])
                 vga_rgb <= high;
            else if (x[9] & y[14] & R[14][9])
                vga_rgb <= high;

            else if (x[0] &y[15] & R[15][0])
                vga_rgb <= high;
            else if (x[1] & y[15] & R[15][1])
                vga_rgb <= high;
            else if (x[2] & y[15] &R[15][2])
                vga_rgb <= high;            
            else if (x[3] & y[15] &R[15][3])
                 vga_rgb <= high;
            else if (x[4] & y[15] &R[15][4])
                 vga_rgb <= high;
            else if (x[5] & y[15] &R[15][5])
                 vga_rgb <= high;        
            else if (x[6] & y[15] &R[15][6])
                 vga_rgb <= high;
            else if (x[7] & y[15] &R[15][7])
                 vga_rgb <= high;
            else if (x[8] & y[15] & R[15][8])
                 vga_rgb <= high;
            else if (x[9] & y[15] & R[15][9])
                vga_rgb <= high;


            else if (x[0] & y[16] & R[16][0])
                vga_rgb <= high;
            else if (x[1] & y[16] & R[16][1])
                vga_rgb <= high;
            else if (x[2] & y[16] &R[16][2])
                vga_rgb <= high;            
            else if (x[3] & y[16] &R[16][3])
                 vga_rgb <= high;
            else if (x[4] & y[16] &R[16][4])
                 vga_rgb <= high;
            else if (x[5] & y[16] &R[16][5])
                 vga_rgb <= high;        
            else if (x[6] & y[16] &R[16][6])
                 vga_rgb <= high;
            else if (x[7] & y[16] &R[16][7])
                 vga_rgb <= high;
            else if (x[8] & y[16] & R[16][8])
                 vga_rgb <= high;
            else if (x[9] & y[16] & R[16][9])
                vga_rgb <= high;
            
            else if (x[0]&y[17]&R[17][0])
                vga_rgb <= high;
            else if (x[1] & y[17] &R[17][1])
                vga_rgb <= high;
            else if (x[2] & y[17] &R[17][2])
                vga_rgb <= high;            
            else if (x[3] & y[17] &R[17][3])
                 vga_rgb <= high;
            else if (x[4] & y[17] &R[17][4])
                 vga_rgb <= high;
            else if (x[5] & y[17] &R[17][5])
                 vga_rgb <= high;        
            else if (x[6] & y[17] &R[17][6])
                 vga_rgb <= high;
            else if (x[7] & y[17] &R[17][7])
                 vga_rgb <= high;
            else if (x[8] & y[17] & R[17][8])
                 vga_rgb <= high;
            else if (x[9] & y[17] & R[17][9])
                vga_rgb <= high;


            else if (x[0]&y[18]&R[18][0])
                vga_rgb <= high;
            else if (x[1] & y[18] &R[18][1])
                vga_rgb <= high;
            else if (x[2] & y[18] &R[18][2])
                vga_rgb <= high;            
            else if (x[3] & y[18] &R[18][3])
                 vga_rgb <= high;
            else if (x[4] & y[18] &R[18][4])
                 vga_rgb <= high;
            else if (x[5] & y[18] &R[18][5])
                 vga_rgb <= high;        
            else if (x[6] & y[18] &R[18][6])
                 vga_rgb <= high;
            else if (x[7] & y[18] &R[18][7])
                 vga_rgb <= high;
            else if (x[8] & y[18] & R[18][8])
                 vga_rgb <= high;
            else if (x[9] & y[18] & R[18][9])
                vga_rgb <= high;            


            else if (x[0]&y[19]&R[19][0])
                vga_rgb <= high;
            else if (x[1] & y[19] &R[19][1])
                vga_rgb <= high;
            else if (x[2] & y[19] &R[19][2])
                vga_rgb <= high;            
            else if (x[3] & y[19] &R[19][3])
                 vga_rgb <= high;
            else if (x[4] & y[19] &R[19][4])
                 vga_rgb <= high;
            else if (x[5] & y[19] &R[19][5])
                 vga_rgb <= high;        
            else if (x[6] & y[19] &R[19][6])
                 vga_rgb <= high;
            else if (x[7] & y[19] &R[19][7])
                 vga_rgb <= high;
            else if (x[8] & y[19] & R[19][8])
                 vga_rgb <= high;
            else if (x[9] & y[19] & R[19][9])
                vga_rgb <= high;


            else
                vga_rgb <= 12'b0000_0000_1111;
         else
            vga_rgb <= 12'b0000_0000_0000;
    end
    else
    begin
      vga_rgb <= 0;
    end
end

  assign OutRed = vga_rgb[11:8];
  assign OutGreen = vga_rgb[7:4];
  assign OutBlue = vga_rgb[3:0];
endmodule