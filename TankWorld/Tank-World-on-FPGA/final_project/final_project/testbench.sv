module testbench();

timeunit 10ns;
timeprecision 1ns;
logic CLOCK_50;
logic    [3:0]  KEY;          //bit 0 is set up as Reset
         logic [6:0]  HEX0, HEX1, HEX2;
             // VGA Interface 
              logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B;        //VGA Blue
              logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS;       //VGA horizontal sync signal
             // CY7C67200 Interface
               wire  [15:0] OTG_DATA;     //CY7C67200 Data bus 16 Bits
              logic [1:0]  OTG_ADDR;     //CY7C67200 Address 2 Bits
              logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
                            OTG_INT;      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
              logic [12:0] DRAM_ADDR;    //SDRAM Address 13 Bits
               wire  [31:0] DRAM_DQ;      //SDRAM Data 32 Bits
              logic [1:0]  DRAM_BA;      //SDRAM Bank Address 2 Bits
              logic [3:0]  DRAM_DQM;     //SDRAM Data Mast 4 Bits
              logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK;     //SDRAM Clock
				  logic 			SRAM_CE_N, 			  //Chip Enable
											SRAM_UB_N,           //Upper Byte Enable
											SRAM_LB_N,           //Lower Byte Enable
											SRAM_OE_N,   		  //Read Enable
											SRAM_WE_N;           //Write Enable
				  logic [19:0] SRAM_ADDR;    //SRAM Address
				  wire	[15:0]   SRAM_DQ; 		  //I/O data wire
lab8 l(.*);

always begin : CLOCK_GENERATION
#1 CLOCK_50 = ~CLOCK_50;
end

initial begin: CLOCK_INITIALIZATION
    CLOCK_50 = 0;
end 

endmodule
