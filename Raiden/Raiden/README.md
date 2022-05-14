ECE385 Final Project - Raiden Game with FPGA
============================================

WARNING
-------

from https://github.com/xddxdd/zjui-ece385-final





Please watch Raiden.mp4



You **SHOULD NOT** copy these code into your own ECE 385 project without proper citation. Doing this is a violation of academic integrity. **You have been warned.**

I do not own the copyright to artworks in this project. They are downloaded from websites that provide these artworks for free.

Overview
--------

This is the final project for my ECE 385 course taken at ZJU-UIUC Institute (same as the ECE 385 in UIUC). The project consists of circuitry on a DE2-115 board and softwares running on NIOS-II soft processor.

This project is completed together by me and my teammate in this course.

A more detailed writeup is at https://lantian.pub/en/article/modify-computer/cyclone-iv-fpga-development-bugs-resolve.lantian

Features
--------

- 16-bit color depth VGA framebuffer stored on SRAM
  - Based on a self-made SRAM multiplexer
    - SRAM runs at double clock speed to emulate dual-port access
    - Simultaneous NIOS-II CPU and VGA driver access
  - Y offset support (for fast scrolling)
  - English and Chinese character display
    - Uses UTF-8 encoding, can be easily extended
- Up to 8 sprites based on dual-port on chip memory
  - Dimensions and position controlled by registers connected to Avalon-MM bus
- Up to 56 bullets
  - Position, radius and color controlled by registers connected to Avalon-MM bus
- Sound support based on WM8731 chip
  - Based on WM8731 driver by a former student, provided as supplementary material in the course
  - Timer & interrupt based implementation, can do simple sound mixing
  - Nearly no impact on performance
- Network support
  - Hardware part is partly based on [https://github.com/alexforencich/verilog-ethernet](https://github.com/alexforencich/verilog-ethernet)
    - Minor modifications made to adapt to Avalon interfaces
  - Hardware MDIO communication is based on self-made module
    - Presents MDIO registers as Avalon-MM slave peripheral
  - Software part is based on lwIP [(https://savannah.nongnu.org/projects/lwip/)](https://savannah.nongnu.org/projects/lwip/)
    - Adapted to work on NIOS-II processor
    - Works, but with minor instabilities
- USB support
  - Separate NIOS-II processor for USB processing
    - Communicate with main processor via dual-port on chip memory
    - Allow separate reset (to workaround buggy keyboards)

How to Run
----------

1. Compile the SystemVerilog code and program it onto a DE2-115 development board.
2. Compile the C code in `ECE385_usb_src` folder and program it onto the **second** NIOS-II core in the circuit. That is the CPU for USB communication.
3. Plug in the keyboard, press the second button to the right to reset the USB CPU, until the keyboard works (console prints out all the way to step 9).
4. Compile the C code in `ECE385_src` folder and program it onto the **first** NIOS-II core. That is the CPU for main game logic.
5. Plug in VGA, Ethernet and sound cable and start playing.
