module top(
	clk,
	rst,
	number,
	hsync_r,
	vsync_r,
	OutRed,
	OutGreen,
	OutBlue);
    output hsync_r, vsync_r;
    output [3:0]OutRed, OutGreen;
    output [3:0]OutBlue;
    input  [199:0]number;
    input  clk,rst;
    
    wire clk_n;
    //wire [19:0]number1, number2, number3, number4, number5, number6, number7, number8, number9, number10;

    
//    control mycontrol(
//       .number(number),
//       .number1(number1),
//       .number2(number2), 
//       .number3(number3), 
//       .number4(number4), 
//       .number5(number5), 
//       .number6(number6), 
//       .number7(number7), 
//       .number8(number8), 
//       .number9(number9), 
//       .number10(number10)
//    );


    clk_unit myclk(
	    .clk(clk),
	    .rst(rst),
	    .clk_n(clk_n)
	);


    VGA myvga(
        ////output
    	.hsync_r(hsync_r),
    	.vsync_r(vsync_r),
    	.OutRed(OutRed),
    	.OutGreen(OutGreen),
    	.OutBlue(OutBlue),
        ////input
        .clk_n(clk_n),
        .rst(rst),
//    	.number1(number1),
//        .number2(number2), 
//        .number3(number3), 
//        .number4(number4), 
//        .number5(number5), 
//        .number6(number6), 
//         .number7(number7), 
//        .number8(number8), 
//        .number9(number9), 
//        .number10(number10)
         .num(number)
    );

endmodule