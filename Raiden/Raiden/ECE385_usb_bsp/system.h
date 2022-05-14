/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'usb_nios2_cpu' in SOPC Builder design 'ECE385'
 * SOPC Builder design path: ../ECE385.sopcinfo
 *
 * Generated: Tue Jun 04 17:31:39 CST 2019
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00000020
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x11
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00010020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x11
#define ALT_CPU_NAME "usb_nios2_cpu"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00010000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00000020
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x11
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00010020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x11
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00010000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/usb_jtag_uart"
#define ALT_STDERR_BASE 0x808
#define ALT_STDERR_DEV usb_jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/usb_jtag_uart"
#define ALT_STDIN_BASE 0x808
#define ALT_STDIN_DEV usb_jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/usb_jtag_uart"
#define ALT_STDOUT_BASE 0x808
#define ALT_STDOUT_DEV usb_jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "ECE385"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * usb_hpi_address configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_address altera_avalon_pio
#define USB_HPI_ADDRESS_BASE 0x810
#define USB_HPI_ADDRESS_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_ADDRESS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_ADDRESS_CAPTURE 0
#define USB_HPI_ADDRESS_DATA_WIDTH 2
#define USB_HPI_ADDRESS_DO_TEST_BENCH_WIRING 0
#define USB_HPI_ADDRESS_DRIVEN_SIM_VALUE 0
#define USB_HPI_ADDRESS_EDGE_TYPE "NONE"
#define USB_HPI_ADDRESS_FREQ 50000000
#define USB_HPI_ADDRESS_HAS_IN 0
#define USB_HPI_ADDRESS_HAS_OUT 1
#define USB_HPI_ADDRESS_HAS_TRI 0
#define USB_HPI_ADDRESS_IRQ -1
#define USB_HPI_ADDRESS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_ADDRESS_IRQ_TYPE "NONE"
#define USB_HPI_ADDRESS_NAME "/dev/usb_hpi_address"
#define USB_HPI_ADDRESS_RESET_VALUE 0
#define USB_HPI_ADDRESS_SPAN 16
#define USB_HPI_ADDRESS_TYPE "altera_avalon_pio"


/*
 * usb_hpi_cs configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_cs altera_avalon_pio
#define USB_HPI_CS_BASE 0x850
#define USB_HPI_CS_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_CS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_CS_CAPTURE 0
#define USB_HPI_CS_DATA_WIDTH 1
#define USB_HPI_CS_DO_TEST_BENCH_WIRING 0
#define USB_HPI_CS_DRIVEN_SIM_VALUE 0
#define USB_HPI_CS_EDGE_TYPE "NONE"
#define USB_HPI_CS_FREQ 50000000
#define USB_HPI_CS_HAS_IN 0
#define USB_HPI_CS_HAS_OUT 1
#define USB_HPI_CS_HAS_TRI 0
#define USB_HPI_CS_IRQ -1
#define USB_HPI_CS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_CS_IRQ_TYPE "NONE"
#define USB_HPI_CS_NAME "/dev/usb_hpi_cs"
#define USB_HPI_CS_RESET_VALUE 0
#define USB_HPI_CS_SPAN 16
#define USB_HPI_CS_TYPE "altera_avalon_pio"


/*
 * usb_hpi_data configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_data altera_avalon_pio
#define USB_HPI_DATA_BASE 0x820
#define USB_HPI_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_DATA_CAPTURE 0
#define USB_HPI_DATA_DATA_WIDTH 16
#define USB_HPI_DATA_DO_TEST_BENCH_WIRING 0
#define USB_HPI_DATA_DRIVEN_SIM_VALUE 0
#define USB_HPI_DATA_EDGE_TYPE "NONE"
#define USB_HPI_DATA_FREQ 50000000
#define USB_HPI_DATA_HAS_IN 1
#define USB_HPI_DATA_HAS_OUT 1
#define USB_HPI_DATA_HAS_TRI 0
#define USB_HPI_DATA_IRQ -1
#define USB_HPI_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_DATA_IRQ_TYPE "NONE"
#define USB_HPI_DATA_NAME "/dev/usb_hpi_data"
#define USB_HPI_DATA_RESET_VALUE 0
#define USB_HPI_DATA_SPAN 16
#define USB_HPI_DATA_TYPE "altera_avalon_pio"


/*
 * usb_hpi_r configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_r altera_avalon_pio
#define USB_HPI_R_BASE 0x830
#define USB_HPI_R_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_R_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_R_CAPTURE 0
#define USB_HPI_R_DATA_WIDTH 1
#define USB_HPI_R_DO_TEST_BENCH_WIRING 0
#define USB_HPI_R_DRIVEN_SIM_VALUE 0
#define USB_HPI_R_EDGE_TYPE "NONE"
#define USB_HPI_R_FREQ 50000000
#define USB_HPI_R_HAS_IN 0
#define USB_HPI_R_HAS_OUT 1
#define USB_HPI_R_HAS_TRI 0
#define USB_HPI_R_IRQ -1
#define USB_HPI_R_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_R_IRQ_TYPE "NONE"
#define USB_HPI_R_NAME "/dev/usb_hpi_r"
#define USB_HPI_R_RESET_VALUE 0
#define USB_HPI_R_SPAN 16
#define USB_HPI_R_TYPE "altera_avalon_pio"


/*
 * usb_hpi_reset configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_reset altera_avalon_pio
#define USB_HPI_RESET_BASE 0x860
#define USB_HPI_RESET_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_RESET_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_RESET_CAPTURE 0
#define USB_HPI_RESET_DATA_WIDTH 1
#define USB_HPI_RESET_DO_TEST_BENCH_WIRING 0
#define USB_HPI_RESET_DRIVEN_SIM_VALUE 0
#define USB_HPI_RESET_EDGE_TYPE "NONE"
#define USB_HPI_RESET_FREQ 50000000
#define USB_HPI_RESET_HAS_IN 0
#define USB_HPI_RESET_HAS_OUT 1
#define USB_HPI_RESET_HAS_TRI 0
#define USB_HPI_RESET_IRQ -1
#define USB_HPI_RESET_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_RESET_IRQ_TYPE "NONE"
#define USB_HPI_RESET_NAME "/dev/usb_hpi_reset"
#define USB_HPI_RESET_RESET_VALUE 0
#define USB_HPI_RESET_SPAN 16
#define USB_HPI_RESET_TYPE "altera_avalon_pio"


/*
 * usb_hpi_w configuration
 *
 */

#define ALT_MODULE_CLASS_usb_hpi_w altera_avalon_pio
#define USB_HPI_W_BASE 0x840
#define USB_HPI_W_BIT_CLEARING_EDGE_REGISTER 0
#define USB_HPI_W_BIT_MODIFYING_OUTPUT_REGISTER 0
#define USB_HPI_W_CAPTURE 0
#define USB_HPI_W_DATA_WIDTH 1
#define USB_HPI_W_DO_TEST_BENCH_WIRING 0
#define USB_HPI_W_DRIVEN_SIM_VALUE 0
#define USB_HPI_W_EDGE_TYPE "NONE"
#define USB_HPI_W_FREQ 50000000
#define USB_HPI_W_HAS_IN 0
#define USB_HPI_W_HAS_OUT 1
#define USB_HPI_W_HAS_TRI 0
#define USB_HPI_W_IRQ -1
#define USB_HPI_W_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_HPI_W_IRQ_TYPE "NONE"
#define USB_HPI_W_NAME "/dev/usb_hpi_w"
#define USB_HPI_W_RESET_VALUE 0
#define USB_HPI_W_SPAN 16
#define USB_HPI_W_TYPE "altera_avalon_pio"


/*
 * usb_jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_usb_jtag_uart altera_avalon_jtag_uart
#define USB_JTAG_UART_BASE 0x808
#define USB_JTAG_UART_IRQ 0
#define USB_JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define USB_JTAG_UART_NAME "/dev/usb_jtag_uart"
#define USB_JTAG_UART_READ_DEPTH 64
#define USB_JTAG_UART_READ_THRESHOLD 8
#define USB_JTAG_UART_SPAN 8
#define USB_JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define USB_JTAG_UART_WRITE_DEPTH 64
#define USB_JTAG_UART_WRITE_THRESHOLD 8


/*
 * usb_keycode configuration
 *
 */

#define ALT_MODULE_CLASS_usb_keycode altera_avalon_onchip_memory2
#define USB_KEYCODE_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define USB_KEYCODE_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define USB_KEYCODE_BASE 0xc00
#define USB_KEYCODE_CONTENTS_INFO ""
#define USB_KEYCODE_DUAL_PORT 1
#define USB_KEYCODE_GUI_RAM_BLOCK_TYPE "AUTO"
#define USB_KEYCODE_INIT_CONTENTS_FILE "ECE385_usb_keycode"
#define USB_KEYCODE_INIT_MEM_CONTENT 1
#define USB_KEYCODE_INSTANCE_ID "NONE"
#define USB_KEYCODE_IRQ -1
#define USB_KEYCODE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_KEYCODE_NAME "/dev/usb_keycode"
#define USB_KEYCODE_NON_DEFAULT_INIT_FILE_ENABLED 0
#define USB_KEYCODE_RAM_BLOCK_TYPE "AUTO"
#define USB_KEYCODE_READ_DURING_WRITE_MODE "OLD_DATA"
#define USB_KEYCODE_SINGLE_CLOCK_OP 0
#define USB_KEYCODE_SIZE_MULTIPLE 1
#define USB_KEYCODE_SIZE_VALUE 1024
#define USB_KEYCODE_SPAN 1024
#define USB_KEYCODE_TYPE "altera_avalon_onchip_memory2"
#define USB_KEYCODE_WRITABLE 1


/*
 * usb_nios2_onchip_mem configuration
 *
 */

#define ALT_MODULE_CLASS_usb_nios2_onchip_mem altera_avalon_onchip_memory2
#define USB_NIOS2_ONCHIP_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define USB_NIOS2_ONCHIP_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define USB_NIOS2_ONCHIP_MEM_BASE 0x10000
#define USB_NIOS2_ONCHIP_MEM_CONTENTS_INFO ""
#define USB_NIOS2_ONCHIP_MEM_DUAL_PORT 0
#define USB_NIOS2_ONCHIP_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define USB_NIOS2_ONCHIP_MEM_INIT_CONTENTS_FILE "ECE385_usb"
#define USB_NIOS2_ONCHIP_MEM_INIT_MEM_CONTENT 1
#define USB_NIOS2_ONCHIP_MEM_INSTANCE_ID "NONE"
#define USB_NIOS2_ONCHIP_MEM_IRQ -1
#define USB_NIOS2_ONCHIP_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_NIOS2_ONCHIP_MEM_NAME "/dev/usb_nios2_onchip_mem"
#define USB_NIOS2_ONCHIP_MEM_NON_DEFAULT_INIT_FILE_ENABLED 1
#define USB_NIOS2_ONCHIP_MEM_RAM_BLOCK_TYPE "AUTO"
#define USB_NIOS2_ONCHIP_MEM_READ_DURING_WRITE_MODE "OLD_DATA"
#define USB_NIOS2_ONCHIP_MEM_SINGLE_CLOCK_OP 1
#define USB_NIOS2_ONCHIP_MEM_SIZE_MULTIPLE 1
#define USB_NIOS2_ONCHIP_MEM_SIZE_VALUE 16384
#define USB_NIOS2_ONCHIP_MEM_SPAN 16384
#define USB_NIOS2_ONCHIP_MEM_TYPE "altera_avalon_onchip_memory2"
#define USB_NIOS2_ONCHIP_MEM_WRITABLE 1


/*
 * usb_nios2_sysid configuration
 *
 */

#define ALT_MODULE_CLASS_usb_nios2_sysid altera_avalon_sysid_qsys
#define USB_NIOS2_SYSID_BASE 0x800
#define USB_NIOS2_SYSID_ID 0
#define USB_NIOS2_SYSID_IRQ -1
#define USB_NIOS2_SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define USB_NIOS2_SYSID_NAME "/dev/usb_nios2_sysid"
#define USB_NIOS2_SYSID_SPAN 8
#define USB_NIOS2_SYSID_TIMESTAMP 1559640077
#define USB_NIOS2_SYSID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
