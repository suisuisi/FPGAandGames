transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Router.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Reg_4.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Control.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/compute.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Register_unit.sv}
vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/Processor.sv}

vlog -sv -work work +incdir+C:/Users/Howar/Desktop/ECE\ 385/LAB4/IQTexercise {C:/Users/Howar/Desktop/ECE 385/LAB4/IQTexercise/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
