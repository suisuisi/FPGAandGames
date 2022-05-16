module clk_unit(
	clk,
	rst,
	clk_n
	);
	input clk, rst;
	output clk_n;

    reg clk_n;
    reg clk_tmp;
    always @(posedge clk_tmp or posedge rst) begin
       if (rst) begin  
        clk_n <= 0;
       end
      else begin
        clk_n <= ~clk_n;
      end
    end
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            clk_tmp <= 0;
        else
            clk_tmp <= ~clk_tmp;
    end
endmodule