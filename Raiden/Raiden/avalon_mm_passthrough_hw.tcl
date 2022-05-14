# TCL File Generated by Component Editor 18.1
# Mon May 20 23:23:36 CST 2019
# DO NOT MODIFY


# 
# avalon_mm_passthrough "Lan Tian Avalon MM Passthrough" v1.0
#  2019.05.20.23:23:36
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module avalon_mm_passthrough
# 
set_module_property DESCRIPTION ""
set_module_property NAME avalon_mm_passthrough
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "Lan Tian Avalon MM Passthrough"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL avalon_mm_passthrough
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file avalon_mm_passthrough.sv SYSTEM_VERILOG PATH comp/avalon_mm_passthrough/avalon_mm_passthrough.sv TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter ADDR_WIDTH INTEGER 8
set_parameter_property ADDR_WIDTH DEFAULT_VALUE 8
set_parameter_property ADDR_WIDTH DISPLAY_NAME ADDR_WIDTH
set_parameter_property ADDR_WIDTH TYPE INTEGER
set_parameter_property ADDR_WIDTH UNITS None
set_parameter_property ADDR_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ADDR_WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock CLK clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset RESET reset Input 1


# 
# connection point avl
# 
add_interface avl avalon end
set_interface_property avl addressUnits WORDS
set_interface_property avl associatedClock clock
set_interface_property avl associatedReset reset
set_interface_property avl bitsPerSymbol 8
set_interface_property avl burstOnBurstBoundariesOnly false
set_interface_property avl burstcountUnits WORDS
set_interface_property avl explicitAddressSpan 0
set_interface_property avl holdTime 0
set_interface_property avl linewrapBursts false
set_interface_property avl maximumPendingReadTransactions 0
set_interface_property avl maximumPendingWriteTransactions 0
set_interface_property avl readLatency 0
set_interface_property avl readWaitTime 1
set_interface_property avl setupTime 0
set_interface_property avl timingUnits Cycles
set_interface_property avl writeWaitTime 0
set_interface_property avl ENABLED true
set_interface_property avl EXPORT_OF ""
set_interface_property avl PORT_NAME_MAP ""
set_interface_property avl CMSIS_SVD_VARIABLES ""
set_interface_property avl SVD_ADDRESS_GROUP ""

add_interface_port avl AVL_READ read Input 1
add_interface_port avl AVL_WRITE write Input 1
add_interface_port avl AVL_WRITEDATA writedata Input 32
add_interface_port avl AVL_READDATA readdata Output 32
add_interface_port avl AVL_ADDR address Input 8
set_interface_assignment avl embeddedsw.configuration.isFlash 0
set_interface_assignment avl embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avl embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avl embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_source
# 
add_interface clock_source clock start
set_interface_property clock_source associatedDirectClock ""
set_interface_property clock_source clockRate 0
set_interface_property clock_source clockRateKnown false
set_interface_property clock_source ENABLED true
set_interface_property clock_source EXPORT_OF ""
set_interface_property clock_source PORT_NAME_MAP ""
set_interface_property clock_source CMSIS_SVD_VARIABLES ""
set_interface_property clock_source SVD_ADDRESS_GROUP ""

add_interface_port clock_source PASS_CLK clk Output 1


# 
# connection point reset_source
# 
add_interface reset_source reset start
set_interface_property reset_source associatedClock clock
set_interface_property reset_source associatedDirectReset ""
set_interface_property reset_source associatedResetSinks reset
set_interface_property reset_source synchronousEdges DEASSERT
set_interface_property reset_source ENABLED true
set_interface_property reset_source EXPORT_OF ""
set_interface_property reset_source PORT_NAME_MAP ""
set_interface_property reset_source CMSIS_SVD_VARIABLES ""
set_interface_property reset_source SVD_ADDRESS_GROUP ""

add_interface_port reset_source PASS_RESET reset Output 1


# 
# connection point pass
# 
add_interface pass avalon start
set_interface_property pass addressUnits WORDS
set_interface_property pass associatedClock clock
set_interface_property pass associatedReset reset
set_interface_property pass bitsPerSymbol 8
set_interface_property pass burstOnBurstBoundariesOnly false
set_interface_property pass burstcountUnits WORDS
set_interface_property pass doStreamReads false
set_interface_property pass doStreamWrites false
set_interface_property pass holdTime 0
set_interface_property pass linewrapBursts false
set_interface_property pass maximumPendingReadTransactions 0
set_interface_property pass maximumPendingWriteTransactions 0
set_interface_property pass readLatency 0
set_interface_property pass readWaitTime 1
set_interface_property pass setupTime 0
set_interface_property pass timingUnits Cycles
set_interface_property pass writeWaitTime 0
set_interface_property pass ENABLED true
set_interface_property pass EXPORT_OF ""
set_interface_property pass PORT_NAME_MAP ""
set_interface_property pass CMSIS_SVD_VARIABLES ""
set_interface_property pass SVD_ADDRESS_GROUP ""

add_interface_port pass PASS_ADDR address Output 8
add_interface_port pass PASS_READ read Output 1
add_interface_port pass PASS_READDATA readdata Input 32
add_interface_port pass PASS_WRITE write Output 1
add_interface_port pass PASS_WRITEDATA writedata Output 32
