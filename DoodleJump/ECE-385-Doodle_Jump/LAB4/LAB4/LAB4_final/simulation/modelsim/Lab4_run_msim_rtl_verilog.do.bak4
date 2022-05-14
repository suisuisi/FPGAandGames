transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/LAB4_final {C:/Users/Howar/Desktop/ECE 385/LAB4/LAB4_final/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/LAB4_final {C:/Users/Howar/Desktop/ECE 385/LAB4/LAB4_final/carry_lookahead_adder.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/LAB4_final {C:/Users/Howar/Desktop/ECE 385/LAB4/LAB4_final/lab4_adders_toplevel.sv}

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/LAB4_final {C:/Users/Howar/Desktop/ECE 385/LAB4/LAB4_final/testbench_adder.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
