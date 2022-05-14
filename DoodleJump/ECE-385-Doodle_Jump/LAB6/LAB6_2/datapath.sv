module datapath (
                input logic Clk, Reset,
				input logic [15:0]MDR_In,
                input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
                input logic GatePC, GateMDR, GateALU, GateMARMUX,
                input logic [1:0] PCMUX, ADDR2MUX, ALUK,
                input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
                input logic MIO_EN,
					 output logic [11:0] LED,
                output logic [15:0] MAR, MDR, IR, PC,
                output logic BEN                  
                );


logic [15:0] PC_MUX_OUT, PC_OUT, MDR_MUX_OUT, MDR_OUT, IR_OUT, MAR_OUT, ALU_OUT;
logic [15:0] BUS;   

//####################  WEEK2 #####################
logic [15:0] ADDR2MUXOUT,ADDR1MUXOUT, ADDROUT;
logic [15:0] SR1OUT, SR2OUT;
logic [15:0] SEXTIR10OUT, SEXTIR8OUT, SEXTIR5OUT, SEXRIR4OUT;
logic [2:0] SR1MUXOUT, DRMUXOUT;



//#################### endd WEEk2###################
assign MAR = MAR_OUT;
assign PC = PC_OUT;
assign IR = IR_OUT;
assign MDR = MDR_OUT;

Register12 LED_reg(
	.Din(IR[11:0]),
	.Load(LD_LED),
	.Reset(Reset),
	.clk(Clk),
	.Dout(LED)
);


Register MAR_RE(
    .Din(BUS),
    .Load(LD_MAR),
    .Reset(Reset),
    .clk(Clk),
    .Dout(MAR_OUT)
);

Register MDR_RE(
    .Din(MDR_MUX_OUT),
    .Load(LD_MDR),
    .Reset(Reset),
    .clk(Clk),
    .Dout(MDR_OUT)
);

Register IR_RE(
    .Din(BUS),
    .Load(LD_IR),
    .Reset(Reset),
    .clk(Clk),
    .Dout(IR_OUT)
);


// up_counter_load PC_COUN(
//     .data(PC_MUX_OUT),
//     .load(LD_PC),         //not sure
//     .clk(Clk),
//     .reset(Reset),
//     .out(PC_OUT)
// );

Register PC_COUN(
    .Din(PC_MUX_OUT),
    .Load(LD_PC),
    .Reset(Reset),
    .clk(Clk),
    .Dout(PC_OUT)
);

MUX3_1 PC_MUX(
	.A(PC_OUT+1'b1),
    .B(ADDROUT),							//////////////
    .C(BUS),
	.sel(PCMUX),
	.out(PC_MUX_OUT)
	);

MUX2_1 MDR_MUX(
	.A(BUS),
    .B(MDR_In),
	.sel(MIO_EN),
	.out(MDR_MUX_OUT)
	);


MUX4_1 Bus_Gate(
    .A(PC_OUT),
    .B(MDR_OUT),
    .C(ALU_OUT),
    .D(ADDROUT),
    .sel({GatePC,GateMDR,GateALU,GateMARMUX}),
    .out(BUS)
    );

//////////////////////week two///////////////////////
assign ADDROUT = ADDR2MUXOUT + ADDR1MUXOUT;

MUX4_1_16b ADDR2_MUX(
    .A(16'b0),
    .B(SEXTIR5OUT),
    .C(SEXTIR8OUT),
    .D(SEXTIR10OUT), 
    .sel(ADDR2MUX),
    .out(ADDR2MUXOUT)
    );

MUX2_1 ADDR1_MUX(
    .A(PC_OUT),
    .B(SR1OUT),
    .sel(ADDR1MUX),
    .out(ADDR1MUXOUT)
    );

MUX2_1_3b SR1_MUX(
    .A(IR[8:6]),
    .B(IR[11:9]),
    .sel(SR1MUX),
    .out(SR1MUXOUT)
);

MUX2_1_3b DR_MUX(
    .A(IR[11:9]),
    .B(3'b1),
    .sel(DRMUX),
    .out(DRMUXOUT)
);


ALU MYALU(
        .SEL(SR2MUX),
        .ALUK(ALUK),
		.SR1OUT(SR1OUT),
        .SR2OUT(SR2OUT),
        .IR40(SEXTIR4OUT),
		.ALUOUT(ALU_OUT)
    );

Register_file my_register(
    .DRMUXOUT(DRMUXOUT),
    .SR1MUXOUT(SR1MUXOUT), 
    .SR2(IR[2:0]), 
    .LD_REG(LD_REG), 
    .Clk(Clk), 
    .Reset(Reset),
    .BUS_VAL(BUS),
    .SR2OUT(SR2OUT),
    .SR1OUT(SR1OUT)
    );

SEXT10 SEXTADDR10(
    .IR(IR[10:0]),
    .OUT(SEXTIR10OUT)
);

SEXT8 SEXTADDR8(
    .IR(IR[8:0]),
    .OUT(SEXTIR8OUT)
);

SEXT5 SEXTADDR5(
    .IR(IR[5:0]),
    .OUT(SEXTIR5OUT)
);

SEXT4 SEXTADDR4(
    .IR(IR[4:0]),
    .OUT(SEXTIR4OUT)
);

NZP nzp(
        .LD_CC(LD_CC), 
        .LD_BEN(LD_BEN), 
        .Clk(Clk),
		.BUS_VAL(BUS),
        .IR911(IR[11:9]),
		.BEN(BEN)
);


endmodule