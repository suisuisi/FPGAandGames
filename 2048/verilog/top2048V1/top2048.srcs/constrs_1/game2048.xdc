## This file is a general .xdc for the  board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN Y9 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
	
#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

	
##Buttons
#set_property PACKAGE_PIN P16 [get_ports rst]						
#	set_property IOSTANDARD LVCMOS33 [get_ports rst]
##BTND
#set_property PACKAGE_PIN T18 [get_ports key[3]]
#	set_property IOSTANDARD LVCMOS33 [get_ports key[3]]
##BTNL
#set_property PACKAGE_PIN N15 [get_ports key[1]]
#	set_property IOSTANDARD LVCMOS33 [get_ports key[1]]
##BTNR
#set_property PACKAGE_PIN R18	  [get_ports key[0]]
#	set_property IOSTANDARD LVCMOS33 [get_ports key[0]]
##BTNU
#set_property PACKAGE_PIN R16 [get_ports key[2]]
#	set_property IOSTANDARD LVCMOS33 [get_ports key[2]]

##Buttons
set_property PACKAGE_PIN AB9 [get_ports rst_n]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
#BTND
set_property PACKAGE_PIN AB11 [get_ports key[3]]
	set_property IOSTANDARD LVCMOS33 [get_ports key[3]]
#BTNL
set_property PACKAGE_PIN AB10 [get_ports key[1]]
	set_property IOSTANDARD LVCMOS33 [get_ports key[1]]
#BTNR
set_property PACKAGE_PIN AA11 [get_ports key[0]]
	set_property IOSTANDARD LVCMOS33 [get_ports key[0]]
#BTNU
set_property PACKAGE_PIN Y11 [get_ports key[2]]
	set_property IOSTANDARD LVCMOS33 [get_ports key[2]]
 




##Pmod Header JB
##Sch name = JB1

set_property PACKAGE_PIN AA4 [get_ports {OLED_CS}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OLED_CS}]
##Sch name = JB2
set_property PACKAGE_PIN Y4 [get_ports {OLED_DC}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OLED_DC}]
##Sch name = JB3
set_property PACKAGE_PIN AB7 [get_ports {OLED_DATA}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OLED_DATA}]
##Sch name = JB4
set_property PACKAGE_PIN R6 [get_ports {OLED_CLK_SLAVE}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OLED_CLK_SLAVE}]

set_property PACKAGE_PIN AB6 [get_ports {OLED_RES}]
	set_property IOSTANDARD LVCMOS33 [get_ports {OLED_RES}]



##VGA Connector
set_property PACKAGE_PIN V20 [get_ports {vgaRed[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
set_property PACKAGE_PIN U20 [get_ports {vgaRed[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
set_property PACKAGE_PIN V19 [get_ports {vgaRed[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
set_property PACKAGE_PIN V18 [get_ports {vgaRed[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
set_property PACKAGE_PIN Y21 [get_ports {vgaBlue[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
set_property PACKAGE_PIN Y20 [get_ports {vgaBlue[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
set_property PACKAGE_PIN AB20 [get_ports {vgaBlue[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
set_property PACKAGE_PIN AB19 [get_ports {vgaBlue[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
set_property PACKAGE_PIN AB22 [get_ports {vgaGreen[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
set_property PACKAGE_PIN AA22 [get_ports {vgaGreen[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
set_property PACKAGE_PIN AB21 [get_ports {vgaGreen[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
set_property PACKAGE_PIN AA21 [get_ports {vgaGreen[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
set_property PACKAGE_PIN AA19 [get_ports Hsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
set_property PACKAGE_PIN Y19 [get_ports Vsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Vsync]


