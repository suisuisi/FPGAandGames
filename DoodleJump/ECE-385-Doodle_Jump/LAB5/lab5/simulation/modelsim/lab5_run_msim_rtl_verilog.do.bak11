transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/ripple_adder.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/Register_unit.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/Control.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/Processor.sv}

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB5/lab5final {C:/Users/Howar/Desktop/ECE 385/LAB5/lab5final/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 5000 ns
