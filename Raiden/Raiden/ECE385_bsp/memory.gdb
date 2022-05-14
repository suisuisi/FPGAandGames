# memory.gdb - GDB memory region definitions
#
# Machine generated for CPU 'nios2_cpu' in SOPC Builder design 'ECE385'
# SOPC Builder design path: ../ECE385.sopcinfo
#
# Generated: Mon Jun 03 20:40:29 CST 2019

# DO NOT MODIFY THIS FILE
#
# Changing this file will have subtle consequences
# which will almost certainly lead to a nonfunctioning
# system. If you do modify this file, be aware that your
# changes will be overwritten and lost when this file
# is generated again.
#
# DO NOT MODIFY THIS FILE

# License Agreement
#
# Copyright (c) 2008
# Altera Corporation, San Jose, California, USA.
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# This agreement shall be governed in all respects by the laws of the State
# of California and by the laws of the United States of America.

# Define memory regions for each memory connected to the CPU.
# The cache attribute is specified which improves GDB performance
# by allowing GDB to cache memory contents on the host.

# vga_sprite_7
memory 0x0 0x1000 cache

# vga_sprite_6
memory 0x1000 0x2000 cache

# vga_sprite_5
memory 0x2000 0x3000 cache

# vga_sprite_4
memory 0x3000 0x4000 cache

# vga_sprite_3
memory 0x4000 0x5000 cache

# vga_sprite_2
memory 0x5000 0x6000 cache

# vga_sprite_1
memory 0x6000 0x7000 cache

# vga_sprite_0
memory 0x7000 0x8000 cache

# usb_keycode
memory 0x9000 0x9400 cache

# nios2_onchip_mem
memory 0x40000 0x80000 cache

# sdram
memory 0x8000000 0x10000000 cache
