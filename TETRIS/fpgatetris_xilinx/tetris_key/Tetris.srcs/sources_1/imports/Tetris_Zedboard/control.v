module control(
	number,
	number1,
  number2, 
  number3, 
  number4, 
  number5, 
  number6, 
  number7, 
  number8, 
  number9, 
  number10
	);
    input  [199:0]number;
    output [19:0]number1, number2, number3, number4, number5, number6, number7, number8, number9, number10;
    assign number1 = number[19:0];
    assign number2 = number[39:20];
    assign number3 = number[59:40];
    assign number4 = number[79:60];
    assign number5 = number[99:80];
    assign number6 = number[119:100];
    assign number7 = number[139:120];
    assign number8 = number[159:140];
    assign number9 = number[179:160];
    assign number10 = number[199:180];
    
endmodule
