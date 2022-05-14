module datapath(
	input logic Clk,
	input logic Reset,
	input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
	input logic GatePC, GateMDR, GateALU, GateMARMUX,
	input logic [1:0] PCMUX, ADDR2MUX, ALUK,
	input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
	input logic MIO_EN,
	input logic [15:0]MDR_In,
	output logic BEN,
	output logic [11:0]LED,
	output logic [15:0]IR,
	output logic [15:0]MAR,
	output logic [15:0]MDR,
	output logic [15:0]PC
);
logic [15:0] Bus,PC_IN,MAR_In,ADD_OUT,MDR_DATA,ALU_OUT,MDR_value,SR1_Out,SR2_Out,ALUB,SEXT11,SEXT9,SEXT6,SEXT5,PC_next;
logic [2:0] DR_In, SR1;
logic [15:0] Add2, Add1;
logic [2:0] NZP,NZP_com;
logic BEN_com;

					 
/*---------registers----------*/
reg_16 MDR_reg(.*,.Load(LD_MDR),.Din(MDR_value),.Dout(MDR));//attention!

reg_16 MAR_reg(.*,.Load(LD_MAR),.Din(Bus),.Dout(MAR));

reg_16 PC_reg(.*,.Load(LD_PC),.Din(PC_IN),.Dout(PC));

reg_16 IR_reg(.*,.Load(LD_IR),.Din(Bus),.Dout(IR));

reg_12 LED_reg(.*,.Load(LD_LED),.Din(IR[11:0]),.Dout(LED));

reg_3 NZP_reg(.*,.Load(LD_CC),.Din(NZP_com),.Dout(NZP));

reg_1 BEN_reg(.*,.Load(LD_BEN),.Din(BEN_com),.Dout(BEN));

/*----------Reg_file---------*/
reg_file u_Reg_file(
	//ports
	.Clk     		( Clk     		),
	.Reset   		( Reset   		),
	.LD_REG  		( LD_REG  		),
	.DR_In   		( DR_In   		),
	.SR2     		( IR[2:0]  		),
	.SR1     		( SR1     		),
	.Bus_In  		( Bus	  		),
	.SR1_Out 		( SR1_Out 		),
	.SR2_Out 		( SR2_Out 		)
);

/*--------SEXT----------*/
SEXT u_SEXT(
	.IR     		( IR     		),
	.SEXT11 		( SEXT11 		),
	.SEXT9  		( SEXT9  		),
	.SEXT6  		( SEXT6  		),
	.SEXT5  		( SEXT5  		)
);

//create Mux
Mux4 PC_mux(.Select(PCMUX),.A(PC_next),.B(Bus),.C(ADD_OUT),.D(16'h0000),.out(PC_IN));// only first is correct

Mux2 MDR_mux(.Select(MIO_EN),.A(Bus),.B(MDR_In),.out(MDR_value)); 
	 
Mux_bus  bus_mux(
	.Select({GatePC, GateMDR, GateALU, GateMARMUX}),
	.A(ADD_OUT),
	.B(ALU_OUT),
	.C(MDR),
	.D(PC),
	.out(Bus)
);


Mux4 ADDR2_Mux(
	.Select 		( ADDR2MUX 		),
	.A      		( 16'h0000  	),
	.B      		( SEXT6			),
	.C      		( SEXT9			),
	.D      		( SEXT11    	),
	.out    		( Add2    		)
);

Mux2 ADDR1_Mux(
	.Select 		( ADDR1MUX 		),
	.A      		( PC      		),
	.B      		( SR1_Out      	),
	.out    		( Add1    		)
);

//ALU LEFT input
Mux2 SR2_Mux(
	.Select 		( SR2MUX 		),
	.A      		( SR2_Out  		),
	.B      		( SEXT5     	),
	.out    		( ALUB    		)
);

//REG FILE SR1 INPUT
Mux2_3 Mux_SR1(
	//ports
	.Select 		( SR1MUX 		),
	.A      		( IR[11:9] 		),
	.B      		( IR[8:6]		),
	.out    		( SR1    		)
);

//REG FILE DR input
Mux2_3 Mux_DR(
	.Select 		( DRMUX 		),
	.A      		( IR[11:9]      ),
	.B      		( 3'b111      	),
	.out    		( DR_In	    	)
);

/*-----------ALU-----------*/

ALU u_ALU(
	//ports
	.A       		( SR1_Out       ),
	.B       		( ALUB     		),
	.ALUK    		( ALUK    		),
	.ALU_Out 		( ALU_OUT 		)
);


always_comb
begin	 
	ADD_OUT=Add1 + Add2;
	PC_next=PC+1;

	//NZP
	if(Bus == 16'h0000)
		NZP_com = 3'b010;
	else if(Bus[15] == 1'b1)
		NZP_com = 3'b100;
	else
		NZP_com = 3'b001;
	// calculate BEN
	BEN_com = (IR[11]&NZP[2])+(IR[10]&NZP[1])+(IR[9]&NZP[0]);
end

endmodule
