onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib font_romv1_opt

do {wave.do}

view wave
view structure
view signals

do {font_romv1.udo}

run -all

quit -force
