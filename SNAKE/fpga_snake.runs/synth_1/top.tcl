# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.cache/wt [current_project]
set_property parent.project_path E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property ip_output_repo e:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files e:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/font_rom.coe
read_verilog -library xil_defaultlib {
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/random_gen.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/clk_divide.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/button_jitter.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/vga_sync.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/text.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/graph.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/directon_gen.v
  E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/imports/fpga_snake-master/top.v
}
read_ip -quiet E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/ip/font_romv1/font_romv1.xci
set_property used_in_implementation false [get_files -all e:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/sources_1/ip/font_romv1/font_romv1_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/constrs_1/new/top.xdc
set_property used_in_implementation false [get_files E:/FILE/GitHub/FPGAandGames/FPGAandGames/SNAKE/fpga_snake.srcs/constrs_1/new/top.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
