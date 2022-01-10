
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
