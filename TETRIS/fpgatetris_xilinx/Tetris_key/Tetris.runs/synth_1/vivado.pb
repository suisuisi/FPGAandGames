
?
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board26
"digilentinc.com:genesys2:part0:1.12default:default2X
DC:/Xilinx/Vivado/2016.2/data/boards/board_files/genesys2/H/board.xml2default:default2$
xc7k325tffg900-22default:defaultZ49-26h px? 
s
Command: %s
53*	vivadotcl2B
.synth_design -top tetris -part xc7a35tcpg236-12default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-349h px? 
?
%s*synth2?
wStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:06 . Memory (MB): peak = 284.461 ; gain = 77.141
2default:defaulth px? 
?
synthesizing module '%s'638*oasys2
tetris2default:default2]
GC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/tetris.v2default:default2
232default:default8@Z8-638h px? 
Y
%s
*synth2A
-	Parameter ROW bound to: 20 - type: integer 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter COL bound to: 10 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'638*oasys2
key2default:default2Z
DC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/key.v2default:default2
212default:default8@Z8-638h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
key2default:default2
12default:default2
12default:default2Z
DC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/key.v2default:default2
212default:default8@Z8-256h px? 
?
synthesizing module '%s'638*oasys2%
game_control_unit2default:default2h
RC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/game_control_unit.v2default:default2
12default:default8@Z8-638h px? 
j
%s
*synth2R
>	Parameter time_val bound to: 26'b01011111010111100001000001 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter S_idle bound to: 4'b0000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter S_new bound to: 4'b0001 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter S_hold bound to: 4'b0010 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter S_move bound to: 4'b0011 
2default:defaulth p
x
? 
R
%s
*synth2:
&	Parameter S_shift bound to: 4'b0100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter S_down bound to: 4'b0101 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter S_remove_1 bound to: 4'b0110 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter S_remove_2 bound to: 4'b0111 
2default:defaulth p
x
? 
R
%s
*synth2:
&	Parameter S_isdie bound to: 4'b1000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter S_stop bound to: 4'b1001 
2default:defaulth p
x
? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2%
game_control_unit2default:default2
22default:default2
12default:default2h
RC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/game_control_unit.v2default:default2
12default:default8@Z8-256h px? 
?
synthesizing module '%s'638*oasys2!
Datapath_Unit2default:default2f
PC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/Tetris_Datapath.v2default:default2
12default:default8@Z8-638h px? 
Q
%s
*synth29
%	Parameter A_1 bound to: 7'b0001000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter B_1 bound to: 7'b0011000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter B_2 bound to: 7'b0010100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter B_3 bound to: 7'b0010010 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter B_4 bound to: 7'b0010001 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter C_1 bound to: 7'b0101000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter C_2 bound to: 7'b0100100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter C_3 bound to: 7'b0100010 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter C_4 bound to: 7'b0100001 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter D_1 bound to: 7'b0111000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter D_2 bound to: 7'b0110100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter E_1 bound to: 7'b1001000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter E_2 bound to: 7'b1000100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter E_3 bound to: 7'b1000010 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter E_4 bound to: 7'b1000001 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter F_1 bound to: 7'b1011000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter F_2 bound to: 7'b1010100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter G_1 bound to: 7'b1101000 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter G_2 bound to: 7'b1100100 
2default:defaulth p
x
? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
REMOVE_2_S_reg2default:default2!
Datapath_Unit2default:default2f
PC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/Tetris_Datapath.v2default:default2
1982default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
REMOVE_2_C_reg2default:default2!
Datapath_Unit2default:default2f
PC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/Tetris_Datapath.v2default:default2
2222default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2
SIG_reg2default:default2!
Datapath_Unit2default:default2f
PC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/Tetris_Datapath.v2default:default2
2202default:default8@Z8-5788h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2!
Datapath_Unit2default:default2
32default:default2
12default:default2f
PC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/Tetris_Datapath.v2default:default2
12default:default8@Z8-256h px? 
?
synthesizing module '%s'638*oasys2
merge2default:default2\
FC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/merge.v2default:default2
12default:default8@Z8-638h px? 
Y
%s
*synth2A
-	Parameter ROW bound to: 20 - type: integer 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter COL bound to: 10 - type: integer 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter A1 bound to: 7'b0001000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter B1 bound to: 7'b0011000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter B2 bound to: 7'b0010100 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter B3 bound to: 7'b0010010 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter B4 bound to: 7'b0010001 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter C1 bound to: 7'b0101000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter C2 bound to: 7'b0100100 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter C3 bound to: 7'b0100010 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter C4 bound to: 7'b0100001 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter D1 bound to: 7'b0111000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter D2 bound to: 7'b0110100 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter E1 bound to: 7'b1001000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter E2 bound to: 7'b1000100 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter E3 bound to: 7'b1000010 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter E4 bound to: 7'b1000001 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter F1 bound to: 7'b1011000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter F2 bound to: 7'b1010100 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter G1 bound to: 7'b1101000 
2default:defaulth p
x
? 
P
%s
*synth28
$	Parameter G2 bound to: 7'b1100100 
2default:defaulth p
x
? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
merge2default:default2
42default:default2
12default:default2\
FC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/merge.v2default:default2
12default:default8@Z8-256h px? 
?
synthesizing module '%s'638*oasys2
top2default:default2^
HC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/vag_top.v2default:default2
12default:default8@Z8-638h px? 
?
synthesizing module '%s'638*oasys2
clk_unit2default:default2_
IC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/clk_unit.v2default:default2
12default:default8@Z8-638h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
clk_unit2default:default2
52default:default2
12default:default2_
IC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/clk_unit.v2default:default2
12default:default8@Z8-256h px? 
?
synthesizing module '%s'638*oasys2
VGA2default:default2Z
DC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/vga.v2default:default2
12default:default8@Z8-638h px? 
X
%s
*synth2@
,	Parameter high bound to: 12'b111111111111 
2default:defaulth p
x
? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
VGA2default:default2
62default:default2
12default:default2Z
DC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/vga.v2default:default2
12default:default8@Z8-256h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
top2default:default2
72default:default2
12default:default2^
HC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/vag_top.v2default:default2
12default:default8@Z8-256h px? 
?
%done synthesizing module '%s' (%s#%s)256*oasys2
tetris2default:default2
82default:default2
12default:default2]
GC:/Vivado/Tetris/Tetris.srcs/sources_1/imports/Tetris_Zedboard/tetris.v2default:default2
232default:default8@Z8-256h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[39]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[38]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[37]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[36]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[35]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[34]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[33]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[32]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[31]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[30]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[29]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[28]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[27]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[26]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[25]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[24]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[23]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[22]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[21]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[20]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[19]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[18]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[17]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[16]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[15]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[14]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[13]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[12]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[11]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[10]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[9]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[8]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[7]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[6]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[5]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[4]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[3]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[2]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[1]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[0]2default:defaultZ8-3331h px? 
?
!design %s has unconnected port %s3331*oasys2%
game_control_unit2default:default2 
shift_finish2default:defaultZ8-3331h px? 
?
%s*synth2?
xFinished RTL Elaboration : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 467.496 ; gain = 260.176
2default:defaulth px? 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:11 ; elapsed = 00:00:13 . Memory (MB): peak = 467.496 ; gain = 260.176
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
Loading part %s157*device2#
xc7a35tcpg236-12default:defaultZ21-403h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
>

Processing XDC Constraints
244*projectZ1-262h px? 
=
Initializing timing engine
348*projectZ1-569h px? 
?
Parsing XDC File [%s]
179*designutils2P
<C:/Vivado/Tetris/Tetris.srcs/constrs_1/new/tetris_basys3.xdc2default:defaultZ20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2P
<C:/Vivado/Tetris/Tetris.srcs/constrs_1/new/tetris_basys3.xdc2default:defaultZ20-178h px? 
?
?Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2P
<C:/Vivado/Tetris/Tetris.srcs/constrs_1/new/tetris_basys3.xdc2default:default2,
.Xil/tetris_propImpl.xdc2default:defaultZ1-236h px? 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0102default:default2
753.8632default:default2
0.0002default:defaultZ17-268h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
~Finished Constraint Validation : Time (s): cpu = 00:00:24 ; elapsed = 00:00:27 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Loading part: xc7a35tcpg236-1
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:24 ; elapsed = 00:00:27 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:24 ; elapsed = 00:00:27 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2%
game_control_unit2default:defaultZ8-802h px? 
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2!
auto_down_reg2default:default2
262default:default2
252default:defaultZ8-5545h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
isdie2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
move2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
stop2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
remove_22default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
remove_12default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
	move_down2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
shift2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
hold2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

gen_random2default:default2
42default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

next_state2default:default2
12default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

next_state2default:default2
12default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

next_state2default:default2
12default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

next_state2default:default2
12default:default2
52default:defaultZ8-5544h px? 
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

next_state2default:default2
12default:default2
52default:defaultZ8-5544h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[23]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[22]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[21]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[20]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[19]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[18]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[17]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[16]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[15]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[14]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[13]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[12]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[11]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[10]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[9]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[8]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[7]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[6]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[5]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[4]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[3]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[2]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[1]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[0]2default:defaultZ8-5546h px? 
?
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
BLOCK_P2default:defaultZ8-5587h px? 
u
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
ysync2default:defaultZ8-5546h px? 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
hsync_r2default:defaultZ8-5546h px? 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
vsync_r2default:defaultZ8-5546h px? 
u
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
ysync2default:defaultZ8-5546h px? 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
hsync_r2default:defaultZ8-5546h px? 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
vsync_r2default:defaultZ8-5546h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  S_idle |                             0000 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                   S_new |                             0001 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                  S_hold |                             0010 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                  S_down |                             0011 |                             0101
2default:defaulth p
x
? 
?
%s
*synth2s
_              S_remove_1 |                             0100 |                             0110
2default:defaulth p
x
? 
?
%s
*synth2s
_              S_remove_2 |                             0101 |                             0111
2default:defaulth p
x
? 
?
%s
*synth2s
_                 S_isdie |                             0110 |                             1000
2default:defaulth p
x
? 
?
%s
*synth2s
_                  S_stop |                             0111 |                             1001
2default:defaulth p
x
? 
?
%s
*synth2s
_                  S_move |                             1000 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2s
_                 S_shift |                             1001 |                             0100
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2%
game_control_unit2default:defaultZ8-3354h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:50 ; elapsed = 00:00:57 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|      |RTL Partition      |Replication |Instances |
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|1     |Datapath_Unit__GB0 |           1|     33495|
2default:defaulth p
x
? 
a
%s
*synth2I
5|2     |Datapath_Unit__GB1 |           1|     14508|
2default:defaulth p
x
? 
a
%s
*synth2I
5|3     |Datapath_Unit__GB2 |           1|     14939|
2default:defaulth p
x
? 
a
%s
*synth2I
5|4     |Datapath_Unit__GB3 |           1|     17899|
2default:defaulth p
x
? 
a
%s
*synth2I
5|5     |Datapath_Unit__GB4 |           1|     29397|
2default:defaulth p
x
? 
a
%s
*synth2I
5|6     |tetris__GC0        |           1|     24171|
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     10 Bit       Adders := 6     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      9 Bit       Adders := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      8 Bit       Adders := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      6 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      5 Bit       Adders := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit       Adders := 5     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	              200 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               10 Bit    Registers := 26    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                8 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                7 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                5 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                4 Bit    Registers := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 18    
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	 203 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     10 Bit        Muxes := 1530  
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input     10 Bit        Muxes := 24    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  10 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 22    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  19 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 34    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      1 Bit        Muxes := 4     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  10 Input      1 Bit        Muxes := 9     
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Y
%s
*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Hierarchical RTL Component report 
2default:defaulth p
x
? 
B
%s
*synth2*
Module Datapath_Unit 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      6 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      5 Bit       Adders := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit       Adders := 5     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               10 Bit    Registers := 24    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                7 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                5 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                4 Bit    Registers := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 3     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     10 Bit        Muxes := 1530  
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input     10 Bit        Muxes := 24    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  10 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 22    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 26    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  20 Input      1 Bit        Muxes := 4     
2default:defaulth p
x
? 
8
%s
*synth2 
Module key 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      8 Bit       Adders := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                8 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                4 Bit    Registers := 4     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 5     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
? 
F
%s
*synth2.
Module game_control_unit 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 6     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  19 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  10 Input      1 Bit        Muxes := 9     
2default:defaulth p
x
? 
:
%s
*synth2"
Module merge 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     10 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      9 Bit       Adders := 8     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	              200 Bit    Registers := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
Module clk_unit 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 2     
2default:defaulth p
x
? 
8
%s
*synth2 
Module VGA 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     10 Bit       Adders := 4     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               10 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 2     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	 203 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 6     
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
[
%s
*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2j
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
HMultithreading enabled for synth_design using a maximum of %s processes.4031*oasys2
22default:defaultZ8-5580h px? 
?
%s*synth2?
?Start Parallel Synthesis Optimization  : Time (s): cpu = 00:00:52 ; elapsed = 00:00:59 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
N
%s
*synth26
"Start Cross Boundary Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[11]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[1]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[0]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[2]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[12]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[10]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[13]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[14]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[15]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[23]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[16]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[17]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[9]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[3]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[4]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[8]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[18]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[19]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[20]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[7]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[21]2default:defaultZ8-5546h px? 
y
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
	R_reg[22]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[5]2default:defaultZ8-5546h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
R_reg[6]2default:defaultZ8-5546h px? 
?
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
BLOCK_P2default:defaultZ8-5587h px? 
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2.
u_Controller/auto_down_reg2default:default2
262default:default2
252default:defaultZ8-5545h px? 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
hsync_r02default:defaultZ8-5546h px? 
?
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2'
u_VGA/myvga/hsync_r2default:defaultZ8-5546h px? 
?
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2%
u_VGA/myvga/ysync2default:defaultZ8-5546h px? 
?
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2'
u_VGA/myvga/vsync_r2default:defaultZ8-5546h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[39]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[38]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[37]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[36]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[35]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[34]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[33]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[32]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[31]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[30]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[29]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[28]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[27]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[26]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[25]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[24]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[23]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[22]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[21]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[20]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[19]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[18]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[17]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[16]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[15]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[14]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[13]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[12]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[11]2default:defaultZ8-3331h px? 

!design %s has unconnected port %s3331*oasys2
merge2default:default2
data_in[10]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[9]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[8]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[7]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[6]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[5]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[4]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[3]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[2]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[1]2default:defaultZ8-3331h px? 
~
!design %s has unconnected port %s3331*oasys2
merge2default:default2

data_in[0]2default:defaultZ8-3331h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary Optimization : Time (s): cpu = 00:01:00 ; elapsed = 00:01:24 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
~Finished Parallel Reinference  : Time (s): cpu = 00:01:00 ; elapsed = 00:01:24 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|      |RTL Partition      |Replication |Instances |
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|1     |Datapath_Unit__GB0 |           1|     33414|
2default:defaulth p
x
? 
a
%s
*synth2I
5|2     |Datapath_Unit__GB1 |           1|     14478|
2default:defaulth p
x
? 
a
%s
*synth2I
5|3     |Datapath_Unit__GB2 |           1|     14858|
2default:defaulth p
x
? 
a
%s
*synth2I
5|4     |Datapath_Unit__GB3 |           1|     17773|
2default:defaulth p
x
? 
a
%s
*synth2I
5|5     |Datapath_Unit__GB4 |           1|     29265|
2default:defaulth p
x
? 
a
%s
*synth2I
5|6     |tetris__GC0        |           1|     24195|
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
D
%s
*synth2,
Start Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2+
u_Controller/up_reg_reg2default:default2
FDC2default:default2.
u_Controller/opcode_reg[0]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_Controller/right_reg_reg2default:default2
FDC2default:default2.
u_Controller/opcode_reg[3]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2-
u_Controller/left_reg_reg2default:default2
FDC2default:default2.
u_Controller/opcode_reg[2]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2-
u_Controller/down_reg_reg2default:default2
FDC2default:default2.
u_Controller/opcode_reg[1]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[0]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[1]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[1]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[2]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[2]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[3]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[4]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[5]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[5]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[6]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[6]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[7]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[7]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[8]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[8]2default:default2
FDC2default:default2.
u_VGA/myvga/vga_rgb_reg[9]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2.
u_VGA/myvga/vga_rgb_reg[9]2default:default2
FDC2default:default2/
u_VGA/myvga/vga_rgb_reg[10]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2/
u_VGA/myvga/vga_rgb_reg[10]2default:default2
FDC2default:default2/
u_VGA/myvga/vga_rgb_reg[11]2default:defaultZ8-3886h px? 
?
"merging instance '%s' (%s) to '%s'3436*oasys2,
i_1/u_key/clk_cnt_reg[6]2default:default2
FDC2default:default2,
i_1/u_key/clk_cnt_reg[7]2default:defaultZ8-3886h px? 
?
6propagating constant %s across sequential element (%s)3333*oasys2
02default:default2.
i_1/\u_key/clk_cnt_reg[7] 2default:defaultZ8-3333h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
zFinished Area Optimization : Time (s): cpu = 00:01:47 ; elapsed = 00:02:23 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Parallel Area Optimization  : Time (s): cpu = 00:01:47 ; elapsed = 00:02:23 . Memory (MB): peak = 753.863 ; gain = 546.543
2default:defaulth px? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|      |RTL Partition      |Replication |Instances |
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
a
%s
*synth2I
5|1     |Datapath_Unit__GB0 |           1|      2108|
2default:defaulth p
x
? 
a
%s
*synth2I
5|2     |Datapath_Unit__GB1 |           1|      1208|
2default:defaulth p
x
? 
a
%s
*synth2I
5|3     |Datapath_Unit__GB2 |           1|      1271|
2default:defaulth p
x
? 
a
%s
*synth2I
5|4     |Datapath_Unit__GB3 |           1|      4062|
2default:defaulth p
x
? 
a
%s
*synth2I
5|5     |Datapath_Unit__GB4 |           1|      1239|
2default:defaulth p
x
? 
a
%s
*synth2I
5|6     |tetris__GC0        |           1|      3498|
2default:defaulth p
x
? 
a
%s
*synth2I
5+------+-------------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Applying XDC Timing Constraints : Time (s): cpu = 00:01:56 ; elapsed = 00:02:32 . Memory (MB): peak = 778.109 ; gain = 570.789
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
|Finished Timing Optimization : Time (s): cpu = 00:02:55 ; elapsed = 00:03:32 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
\
%s
*synth2D
0|      |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
\
%s
*synth2D
0|1     |tetris_GT0    |           1|     12998|
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
{Finished Technology Mapping : Time (s): cpu = 00:02:56 ; elapsed = 00:03:46 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Parallel Technology Mapping Optimization  : Time (s): cpu = 00:02:56 ; elapsed = 00:03:46 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
\
%s
*synth2D
0|      |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
\
%s
*synth2D
0|1     |tetris_GT0    |           1|      4809|
2default:defaulth p
x
? 
\
%s
*synth2D
0+------+--------------+------------+----------+
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Parallel Synthesis Optimization  : Time (s): cpu = 00:02:56 ; elapsed = 00:03:46 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
uFinished IO Insertion : Time (s): cpu = 00:02:57 ; elapsed = 00:03:47 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:02:57 ; elapsed = 00:03:48 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:02:57 ; elapsed = 00:03:48 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:02:57 ; elapsed = 00:03:48 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:02:58 ; elapsed = 00:03:49 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Nets : Time (s): cpu = 00:02:58 ; elapsed = 00:03:49 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Start ROM, RAM, DSP and Shift Register Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23

Static Shift Register Report:
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------------------+--------+-------+--------------+--------------------+-------------------+--------+---------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|Module Name | RTL Name                 | Length | Width | Reset Signal | Pull out first Reg | Pull out last Reg | SRL16E | SRLC32E | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------------------+--------+-------+--------------+--------------------+-------------------+--------+---------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|tetris      | u_key/shift_up_reg[3]    | 4      | 1     | YES          | NO                 | YES               | 1      | 0       | 
2default:defaulth p
x
? 
?
%s
*synth2?
?|tetris      | u_key/shift_down_reg[3]  | 4      | 1     | YES          | NO                 | YES               | 1      | 0       | 
2default:defaulth p
x
? 
?
%s
*synth2?
?|tetris      | u_key/shift_left_reg[3]  | 4      | 1     | YES          | NO                 | YES               | 1      | 0       | 
2default:defaulth p
x
? 
?
%s
*synth2?
?|tetris      | u_key/shift_right_reg[3] | 4      | 1     | YES          | NO                 | YES               | 1      | 0       | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------------------+--------+-------+--------------+--------------------+-------------------+--------+---------+

2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Finished ROM, RAM, DSP and Shift Register Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
D
%s*synth2,
+------+-------+------+
2default:defaulth px? 
D
%s*synth2,
|      |Cell   |Count |
2default:defaulth px? 
D
%s*synth2,
+------+-------+------+
2default:defaulth px? 
D
%s*synth2,
|1     |BUFG   |     1|
2default:defaulth px? 
D
%s*synth2,
|2     |CARRY4 |    10|
2default:defaulth px? 
D
%s*synth2,
|3     |LUT1   |     4|
2default:defaulth px? 
D
%s*synth2,
|4     |LUT2   |   128|
2default:defaulth px? 
D
%s*synth2,
|5     |LUT3   |   293|
2default:defaulth px? 
D
%s*synth2,
|6     |LUT4   |   348|
2default:defaulth px? 
D
%s*synth2,
|7     |LUT5   |   644|
2default:defaulth px? 
D
%s*synth2,
|8     |LUT6   |  2816|
2default:defaulth px? 
D
%s*synth2,
|9     |MUXF7  |    48|
2default:defaulth px? 
D
%s*synth2,
|10    |SRL16E |     4|
2default:defaulth px? 
D
%s*synth2,
|11    |FDCE   |   585|
2default:defaulth px? 
D
%s*synth2,
|12    |FDRE   |    14|
2default:defaulth px? 
D
%s*synth2,
|13    |IBUF   |     7|
2default:defaulth px? 
D
%s*synth2,
|14    |OBUF   |    14|
2default:defaulth px? 
D
%s*synth2,
+------+-------+------+
2default:defaulth px? 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
? 
_
%s
*synth2G
3+------+---------------+------------------+------+
2default:defaulth p
x
? 
_
%s
*synth2G
3|      |Instance       |Module            |Cells |
2default:defaulth p
x
? 
_
%s
*synth2G
3+------+---------------+------------------+------+
2default:defaulth p
x
? 
_
%s
*synth2G
3|1     |top            |                  |  4916|
2default:defaulth p
x
? 
_
%s
*synth2G
3|2     |  u_Controller |game_control_unit |   143|
2default:defaulth p
x
? 
_
%s
*synth2G
3|3     |  u_Datapath   |Datapath_Unit     |  4249|
2default:defaulth p
x
? 
_
%s
*synth2G
3|4     |  u_VGA        |top               |   260|
2default:defaulth p
x
? 
_
%s
*synth2G
3|5     |    myclk      |clk_unit          |     4|
2default:defaulth p
x
? 
_
%s
*synth2G
3|6     |    myvga      |VGA               |   256|
2default:defaulth p
x
? 
_
%s
*synth2G
3|7     |  u_key        |key               |    37|
2default:defaulth p
x
? 
_
%s
*synth2G
3|8     |  u_merge      |merge             |   205|
2default:defaulth p
x
? 
_
%s
*synth2G
3+------+---------------+------------------+------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:02:58 ; elapsed = 00:03:49 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
s
%s
*synth2[
GSynthesis finished with 0 errors, 0 critical warnings and 40 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
~Synthesis Optimization Runtime : Time (s): cpu = 00:02:38 ; elapsed = 00:03:37 . Memory (MB): peak = 955.188 ; gain = 461.500
2default:defaulth p
x
? 
?
%s
*synth2?
?INFO: Vivado Synthesis caught shared memory exception 'The system cannot find the file specified.'. Continuing without using shared memory (or continuing without parallel flow)
2default:defaulth p
x
? 
?
%s
*synth2?
Synthesis Optimization Complete : Time (s): cpu = 00:02:58 ; elapsed = 00:03:49 . Memory (MB): peak = 955.188 ; gain = 747.867
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
172default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
?
?Netlist '%s' is not ideal for floorplanning, since the cellview '%s' contains a large number of primitives.  Please consider enabling hierarchy in synthesis if you want to do floorplanning.
310*netlist2
tetris2default:default2!
Datapath_Unit2default:defaultZ29-101h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1232default:default2
862default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:02:592default:default2
00:03:482default:default2
955.1882default:default2
747.8672default:defaultZ17-268h px? 
?
sreport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.070 . Memory (MB): peak = 955.188 ; gain = 0.000
*commonh px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Fri Oct 28 10:06:25 20162default:defaultZ17-206h px? 


End Record