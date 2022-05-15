onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib string_rom_head_opt

do {wave.do}

view wave
view structure
view signals

do {string_rom_head.udo}

run -all

quit -force
