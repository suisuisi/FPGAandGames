/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2009 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

#ifndef __ALTERA_ETH_TSE_REGS_H__
#define __ALTERA_ETH_TSE_REGS_H__


#include "alt_types.h"
#include "io.h"

/* MAC Registers */

/* Revision register (read-only) */
#define IOADDR_ALTERA_TSEMAC_REV(base) __IO_CALC_ADDRESS_NATIVE(base,0x0)
#define IORD_ALTERA_TSEMAC_REV(base)   IORD_32DIRECT(base, 0)

/* Scratch register */
#define IOADDR_ALTERA_TSEMAC_SCRATCH(base)    __IO_CALC_ADDRESS_NATIVE(base,0x4)
#define IORD_ALTERA_TSEMAC_SCRATCH(base)      IORD_32DIRECT(base, 0x4)
#define IOWR_ALTERA_TSEMAC_SCRATCH(base,data) IOWR_32DIRECT(base, 0x4, data)

/* Command register */
#define IOADDR_ALTERA_TSEMAC_CMD_CONFIG(base)    __IO_CALC_ADDRESS_NATIVE(base,0x8)
#define IORD_ALTERA_TSEMAC_CMD_CONFIG(base)      IORD_32DIRECT(base, 0x8)
#define IOWR_ALTERA_TSEMAC_CMD_CONFIG(base,data) IOWR_32DIRECT(base, 0x8, data)

/* Command register bit definitions */
#define ALTERA_TSEMAC_CMD_TX_ENA_OFST          (0)   
#define ALTERA_TSEMAC_CMD_TX_ENA_MSK           (0x1)
#define ALTERA_TSEMAC_CMD_RX_ENA_OFST          (1)   
#define ALTERA_TSEMAC_CMD_RX_ENA_MSK           (0x2)
#define ALTERA_TSEMAC_CMD_XON_GEN_OFST        (2) 
#define ALTERA_TSEMAC_CMD_XON_GEN_MSK         (0x4)
#define ALTERA_TSEMAC_CMD_ETH_SPEED_OFST       (3)
#define ALTERA_TSEMAC_CMD_ETH_SPEED_MSK        (0x8)
#define ALTERA_TSEMAC_CMD_PROMIS_EN_OFST       (4)
#define ALTERA_TSEMAC_CMD_PROMIS_EN_MSK        (0x10)
#define ALTERA_TSEMAC_CMD_PAD_EN_OFST          (5)
#define ALTERA_TSEMAC_CMD_PAD_EN_MSK           (0x20)
#define ALTERA_TSEMAC_CMD_CRC_FWD_OFST         (6)  
#define ALTERA_TSEMAC_CMD_CRC_FWD_MSK          (0x40)
#define ALTERA_TSEMAC_CMD_PAUSE_FWD_OFST       (7)
#define ALTERA_TSEMAC_CMD_PAUSE_FWD_MSK        (0x80)
#define ALTERA_TSEMAC_CMD_PAUSE_IGNORE_OFST    (8)
#define ALTERA_TSEMAC_CMD_PAUSE_IGNORE_MSK     (0x100)
#define ALTERA_TSEMAC_CMD_TX_ADDR_INS_OFST     (9)
#define ALTERA_TSEMAC_CMD_TX_ADDR_INS_MSK      (0x200)
#define ALTERA_TSEMAC_CMD_HD_ENA_OFST          (10)
#define ALTERA_TSEMAC_CMD_HD_ENA_MSK           (0x400)
#define ALTERA_TSEMAC_CMD_EXCESS_COL_OFST      (11)
#define ALTERA_TSEMAC_CMD_EXCESS_COL_MSK       (0x800)
#define ALTERA_TSEMAC_CMD_LATE_COL_OFST        (12)
#define ALTERA_TSEMAC_CMD_LATE_COL_MSK         (0x1000)
#define ALTERA_TSEMAC_CMD_SW_RESET_OFST        (13)
#define ALTERA_TSEMAC_CMD_SW_RESET_MSK         (0x2000)
#define ALTERA_TSEMAC_CMD_MHASH_SEL_OFST       (14)
#define ALTERA_TSEMAC_CMD_MHASH_SEL_MSK        (0x4000)
#define ALTERA_TSEMAC_CMD_LOOPBACK_OFST        (15)
#define ALTERA_TSEMAC_CMD_LOOPBACK_MSK         (0x8000)
/* Bits (18:16) = address select */
#define ALTERA_TSEMAC_CMD_TX_ADDR_SEL_OFST     (16)   
#define ALTERA_TSEMAC_CMD_TX_ADDR_SEL_MSK      (0x70000)  
#define ALTERA_TSEMAC_CMD_MAGIC_ENA_OFST       (19)
#define ALTERA_TSEMAC_CMD_MAGIC_ENA_MSK        (0x80000)
#define ALTERA_TSEMAC_CMD_SLEEP_OFST           (20)
#define ALTERA_TSEMAC_CMD_SLEEP_MSK            (0x100000)
#define ALTERA_TSEMAC_CMD_WAKEUP_OFST          (21)
#define ALTERA_TSEMAC_CMD_WAKEUP_MSK           (0x200000)
#define ALTERA_TSEMAC_CMD_XOFF_GEN_OFST        (22)
#define ALTERA_TSEMAC_CMD_XOFF_GEN_MSK         (0x400000)
#define ALTERA_TSEMAC_CMD_CNTL_FRM_ENA_OFST    (23)
#define ALTERA_TSEMAC_CMD_CNTL_FRM_ENA_MSK     (0x800000)
#define ALTERA_TSEMAC_CMD_NO_LENGTH_CHECK_OFST (24)
#define ALTERA_TSEMAC_CMD_NO_LENGTH_CHECK_MSK  (0x1000000)
#define ALTERA_TSEMAC_CMD_ENA_10_OFST          (25)
#define ALTERA_TSEMAC_CMD_ENA_10_MSK           (0x2000000)
#define ALTERA_TSEMAC_CMD_RX_ERR_DISC_OFST     (26)
#define ALTERA_TSEMAC_CMD_RX_ERR_DISC_MSK      (0x4000000)
/* Bits (30..27) reserved */
#define ALTERA_TSEMAC_CMD_CNT_RESET_OFST       (31)
#define ALTERA_TSEMAC_CMD_CNT_RESET_MSK        (0x80000000)

/* Low word (bits 31:0) of MAC address */
#define IOADDR_ALTERA_TSEMAC_MAC_0(base)    __IO_CALC_ADDRESS_NATIVE(base,0xC)
#define IORD_ALTERA_TSEMAC_MAC_0(base)      IORD_32DIRECT(base, 0xC)
#define IOWR_ALTERA_TSEMAC_MAC_0(base,data) IOWR_32DIRECT(base, 0xC, data)

/* High half-word (bits 47:32) of MAC address. Upper 16 bits reserved */
#define IOADDR_ALTERA_TSEMAC_MAC_1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x10)
#define IORD_ALTERA_TSEMAC_MAC_1(base)      IORD_32DIRECT(base, 0x10)
#define IOWR_ALTERA_TSEMAC_MAC_1(base,data) IOWR_32DIRECT(base, 0x10, data)

/* Maximum frame length (bits 13:0), (bits 31:14 are reserved) */
#define IOADDR_ALTERA_TSEMAC_FRM_LENGTH(base)    __IO_CALC_ADDRESS_NATIVE(base,0x14)
#define IORD_ALTERA_TSEMAC_FRM_LENGTH(base)      IORD_32DIRECT(base, 0x14)
#define IOWR_ALTERA_TSEMAC_FRM_LENGTH(base,data) IOWR_32DIRECT(base, 0x14, data)

/* Receive pause quanta. Bits 31:16 reserved */
#define IOADDR_ALTERA_TSEMAC_PAUSE_QUANT(base)    __IO_CALC_ADDRESS_NATIVE(base,0x18)
#define IORD_ALTERA_TSEMAC_PAUSE_QUANT(base)      IORD_32DIRECT(base, 0x18)
#define IOWR_ALTERA_TSEMAC_PAUSE_QUANT(base,data) IOWR_32DIRECT(base, 0x18, data)

/* Sets RX FIFO section empty threshold */
#define IOADDR_ALTERA_TSEMAC_RX_SECTION_EMPTY(base)    __IO_CALC_ADDRESS_NATIVE(base,0x1C)
#define IORD_ALTERA_TSEMAC_RX_SECTION_EMPTY(base)      IORD_32DIRECT(base, 0x1C)
#define IOWR_ALTERA_TSEMAC_RX_SECTION_EMPTY(base,data) IOWR_32DIRECT(base, 0x1C, data)

/* Set RX FIFO section full threshold */
#define IOADDR_ALTERA_TSEMAC_RX_SECTION_FULL(base)    __IO_CALC_ADDRESS_NATIVE(base,0x20)
#define IORD_ALTERA_TSEMAC_RX_SECTION_FULL(base)      IORD_32DIRECT(base, 0x20)
#define IOWR_ALTERA_TSEMAC_RX_SECTION_FULL(base,data) IOWR_32DIRECT(base, 0x20, data)

/* Set TX FIFO section empty threshold */
#define IOADDR_ALTERA_TSEMAC_TX_SECTION_EMPTY(base)    __IO_CALC_ADDRESS_NATIVE(base,0x24)
#define IORD_ALTERA_TSEMAC_TX_SECTION_EMPTY(base)      IORD_32DIRECT(base, 0x24)
#define IOWR_ALTERA_TSEMAC_TX_SECTION_EMPTY(base,data) IOWR_32DIRECT(base, 0x24, data)

/* Set TX FIFO section full threshold */
#define IOADDR_ALTERA_TSEMAC_TX_SECTION_FULL(base)    __IO_CALC_ADDRESS_NATIVE(base,0x28)
#define IORD_ALTERA_TSEMAC_TX_SECTION_FULL(base)      IORD_32DIRECT(base, 0x28)
#define IOWR_ALTERA_TSEMAC_TX_SECTION_FULL(base,data) IOWR_32DIRECT(base, 0x28, data)

/* Set RX FIFO almost empty threshold */
#define IOADDR_ALTERA_TSEMAC_RX_ALMOST_EMPTY(base)    __IO_CALC_ADDRESS_NATIVE(base,0x2c)
#define IORD_ALTERA_TSEMAC_RX_ALMOST_EMPTY(base)      IORD_32DIRECT(base, 0x2c)
#define IOWR_ALTERA_TSEMAC_RX_ALMOST_EMPTY(base,data) IOWR_32DIRECT(base, 0x2c, data)

/* Set RX FIFO almost full threshold */
#define IOADDR_ALTERA_TSEMAC_RX_ALMOST_FULL(base)    __IO_CALC_ADDRESS_NATIVE(base,0x30)
#define IORD_ALTERA_TSEMAC_RX_ALMOST_FULL(base)      IORD_32DIRECT(base, 0x30)
#define IOWR_ALTERA_TSEMAC_RX_ALMOST_FULL(base,data) IOWR_32DIRECT(base, 0x30, data)

/* Set TX FIFO almost empty threshold */
#define IOADDR_ALTERA_TSEMAC_TX_ALMOST_EMPTY(base)    __IO_CALC_ADDRESS_NATIVE(base,0x34)
#define IORD_ALTERA_TSEMAC_TX_ALMOST_EMPTY(base)      IORD_32DIRECT(base, 0x34)
#define IOWR_ALTERA_TSEMAC_TX_ALMOST_EMPTY(base,data) IOWR_32DIRECT(base, 0x34, data)

/* Set TX FIFO almost full threshold */
#define IOADDR_ALTERA_TSEMAC_TX_ALMOST_FULL(base)    __IO_CALC_ADDRESS_NATIVE(base,0x38)
#define IORD_ALTERA_TSEMAC_TX_ALMOST_FULL(base)      IORD_32DIRECT(base, 0x38)
#define IOWR_ALTERA_TSEMAC_TX_ALMOST_FULL(base,data) IOWR_32DIRECT(base, 0x38, data)

/* MDIO Address of PHY 0. Bits 31:5 reserved */
#define IOADDR_ALTERA_TSEMAC_MDIO_ADDR0(base)    __IO_CALC_ADDRESS_NATIVE(base,0x3c)
#define IORD_ALTERA_TSEMAC_MDIO_ADDR0(base)      IORD_32DIRECT(base, 0x3c)
#define IOWR_ALTERA_TSEMAC_MDIO_ADDR0(base,data) IOWR_32DIRECT(base, 0x3c, data)

/* MDIO Address of PHY 1. Bits 31:5 reserved */
#define IOADDR_ALTERA_TSEMAC_MDIO_ADDR1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x40)
#define IORD_ALTERA_TSEMAC_MDIO_ADDR1(base)      IORD_32DIRECT(base, 0x40)
#define IOWR_ALTERA_TSEMAC_MDIO_ADDR1(base,data) IOWR_32DIRECT(base, 0x40, data)

/* -- Register offsets 0x44 to 0x54 reserved -- */

/* Register read access status */
#define IOADDR_ALTERA_TSEMAC_REG_STAT(base)    __IO_CALC_ADDRESS_NATIVE(base,0x58)
#define IORD_ALTERA_TSEMAC_REG_STAT(base)      IORD_32DIRECT(base, 0x58)


/* Inter-packet gap. Bits 31:5 reserved/ */
#define IOADDR_ALTERA_TSEMAC_TX_IPG_LENGTH(base)     __IO_CALC_ADDRESS_NATIVE(base,0x5c)
#define IORD_ALTERA_TSEMAC_TX_IPG_LENGTH(base)      IORD_32DIRECT(base, 0x5c)
#define IOWR_ALTERA_TSEMAC_TX_IPG_LENGTH(base,data)      IOWR_32DIRECT(base, 0x5c, data)


/* IEEE802.3, RMON, and MIB-II SNMP Statistic event counters */
#define IOADDR_ALTERA_TSEMAC_A_MACID_1(base)     __IO_CALC_ADDRESS_NATIVE(base,0x60)
#define IORD_ALTERA_TSEMAC_A_MACID_1(base)      IORD_32DIRECT(base, 0x60)


#define IOADDR_ALTERA_TSEMAC_A_MACID_2(base)     __IO_CALC_ADDRESS_NATIVE(base,0x64)
#define IORD_ALTERA_TSEMAC_A_MACID_2(base)      IORD_32DIRECT(base, 0x64)


#define IOADDR_ALTERA_TSEMAC_A_FRAMES_TX_OK(base)     __IO_CALC_ADDRESS_NATIVE(base,0x68)
#define IORD_ALTERA_TSEMAC_A_FRAMES_TX_OK(base)      IORD_32DIRECT(base, 0x68)


#define IOADDR_ALTERA_TSEMAC_A_FRAMES_RX_OK(base)     __IO_CALC_ADDRESS_NATIVE(base,0x6c)
#define IORD_ALTERA_TSEMAC_A_FRAMES_RX_OK(base)      IORD_32DIRECT(base, 0x6c)


#define IOADDR_ALTERA_TSEMAC_A_FRAME_CHECK_SEQ_ERRS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x70)
#define IORD_ALTERA_TSEMAC_A_FRAME_CHECK_SEQ_ERRS(base)      IORD_32DIRECT(base, 0x70)


#define IOADDR_ALTERA_TSEMAC_A_ALIGNMENT_ERRS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x74)
#define IORD_ALTERA_TSEMAC_A_ALIGNMENT_ERRS(base)      IORD_32DIRECT(base, 0x74)


#define IOADDR_ALTERA_TSEMAC_A_OCTETS_TX_OK(base)     __IO_CALC_ADDRESS_NATIVE(base,0x78)
#define IORD_ALTERA_TSEMAC_A_OCTETS_TX_OK(base)      IORD_32DIRECT(base, 0x78)


#define IOADDR_ALTERA_TSEMAC_A_OCTETS_RX_OK(base)     __IO_CALC_ADDRESS_NATIVE(base,0x7c)
#define IORD_ALTERA_TSEMAC_A_OCTETS_RX_OK(base)      IORD_32DIRECT(base, 0x7c)


#define IOADDR_ALTERA_TSEMAC_A_TX_PAUSE_MAC_CTRL_FRAMES(base)     __IO_CALC_ADDRESS_NATIVE(base,0x80)
#define IORD_ALTERA_TSEMAC_A_TX_PAUSE_MAC_CTRL_FRAMES(base)      IORD_32DIRECT(base, 0x80)


#define IOADDR_ALTERA_TSEMAC_A_RX_PAUSE_MAC_CTRL_FRAMES(base)     __IO_CALC_ADDRESS_NATIVE(base,0x84)
#define IORD_ALTERA_TSEMAC_A_RX_PAUSE_MAC_CTRL_FRAMES(base)      IORD_32DIRECT(base, 0x84)


#define IOADDR_ALTERA_TSEMAC_IF_IN_ERRORS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x88)
#define IORD_ALTERA_TSEMAC_IF_IN_ERRORS(base)      IORD_32DIRECT(base, 0x88)


#define IOADDR_ALTERA_TSEMAC_IF_OUT_ERRORS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x8c)
#define IORD_ALTERA_TSEMAC_IF_OUT_ERRORS(base)      IORD_32DIRECT(base, 0x8c)


#define IOADDR_ALTERA_TSEMAC_IF_IN_UCAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x90)
#define IORD_ALTERA_TSEMAC_IF_IN_UCAST_PKTS(base)      IORD_32DIRECT(base, 0x90)


#define IOADDR_ALTERA_TSEMAC_IF_IN_MULTICAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x94)
#define IORD_ALTERA_TSEMAC_IF_IN_MULTICAST_PKTS(base)      IORD_32DIRECT(base, 0x94)


#define IOADDR_ALTERA_TSEMAC_IF_IN_BROADCAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x98)
#define IORD_ALTERA_TSEMAC_IF_IN_BROADCAST_PKTS(base)      IORD_32DIRECT(base, 0x98)


#define IOADDR_ALTERA_TSEMAC_IF_OUT_DISCARDS(base)     __IO_CALC_ADDRESS_NATIVE(base,0x9C)
#define IORD_ALTERA_TSEMAC_IF_OUT_DISCARDS(base)      IORD_32DIRECT(base, 0x9C)


#define IOADDR_ALTERA_TSEMAC_IF_OUT_UCAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xA0)
#define IORD_ALTERA_TSEMAC_IF_OUT_UCAST_PKTS(base)      IORD_32DIRECT(base, 0xA0)


#define IOADDR_ALTERA_TSEMAC_IF_OUT_MULTICAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xA4)
#define IORD_ALTERA_TSEMAC_IF_OUT_MULTICAST_PKTS(base)      IORD_32DIRECT(base, 0xA4)


#define IOADDR_ALTERA_TSEMAC_IF_OUT_BROADCAST_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xA8)
#define IORD_ALTERA_TSEMAC_IF_OUT_BROADCAST_PKTS(base)      IORD_32DIRECT(base, 0xA8)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_DROP_EVENTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xAC)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_DROP_EVENTS(base)      IORD_32DIRECT(base, 0xAC)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xB0)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_OCTETS(base)      IORD_32DIRECT(base, 0xB0)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xB4)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS(base)      IORD_32DIRECT(base, 0xB4)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_UNDERSIZE_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xB8)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_UNDERSIZE_PKTS(base)      IORD_32DIRECT(base, 0xB8)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_OVERSIZE_PKTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xBC)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_OVERSIZE_PKTS(base)      IORD_32DIRECT(base, 0xBC)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_64_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xC0)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_64_OCTETS(base)      IORD_32DIRECT(base, 0xC0)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_65_TO_127_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xC4)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_65_TO_127_OCTETS(base)      IORD_32DIRECT(base, 0xC4)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_128_TO_255_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xC8)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_128_TO_255_OCTETS(base)      IORD_32DIRECT(base, 0xC8)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_256_TO_511_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xCC)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_256_TO_511_OCTETS(base)      IORD_32DIRECT(base, 0xCC)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_512_TO_1023_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xD0)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_512_TO_1023_OCTETS(base)      IORD_32DIRECT(base, 0xD0)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_1024_TO_1518_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xD4)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_1024_TO_1518_OCTETS(base)      IORD_32DIRECT(base, 0xD4)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_PKTS_1519_TO_X_OCTETS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xD8)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_PKTS_1519_TO_X_OCTETS(base)      IORD_32DIRECT(base, 0xD8)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_JABBERS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xDC)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_JABBERS(base)      IORD_32DIRECT(base, 0xDC)


#define IOADDR_ALTERA_TSEMAC_ETHER_STATS_FRAGMENTS(base)     __IO_CALC_ADDRESS_NATIVE(base,0xE0)
#define IORD_ALTERA_TSEMAC_ETHER_STATS_FRAGMENTS(base)      IORD_32DIRECT(base, 0xE0)



/* Register offset 0xE4 reserved */

#define IOADDR_ALTERA_TSEMAC_TX_CMD_STAT(base)     __IO_CALC_ADDRESS_NATIVE(base,0xE8)
#define IORD_ALTERA_TSEMAC_TX_CMD_STAT(base)      IORD_32DIRECT(base, 0xE8)
#define IOWR_ALTERA_TSEMAC_TX_CMD_STAT(base,data) IOWR_32DIRECT(base, 0xE8, data)


#define IOADDR_ALTERA_TSEMAC_RX_CMD_STAT(base)     __IO_CALC_ADDRESS_NATIVE(base,0xEC)
#define IORD_ALTERA_TSEMAC_RX_CMD_STAT(base)      IORD_32DIRECT(base, 0xEC)
#define IOWR_ALTERA_TSEMAC_RX_CMD_STAT(base,data) IOWR_32DIRECT(base, 0xEC, data)


#define ALTERA_TSEMAC_TX_CMD_STAT_OMITCRC_OFST				(17)   
#define ALTERA_TSEMAC_TX_CMD_STAT_OMITCRC_MSK				(0x20000)
#define ALTERA_TSEMAC_TX_CMD_STAT_TXSHIFT16_OFST			(18)   
#define ALTERA_TSEMAC_TX_CMD_STAT_TXSHIFT16_MSK				(0x40000)

#define ALTERA_TSEMAC_RX_CMD_STAT_RXSHIFT16_OFST			(25)   
#define ALTERA_TSEMAC_RX_CMD_STAT_RXSHIFT16_MSK				(0x2000000)

/* Register offset 0xF0 to 0xFC reserved */


/*
 * Share Multi Channel FIFO 
 * 
 * ## Threshold Register Access ## - Av-MM interface 1
 */
#define IOADDR_ALTERA_MULTI_CHAN_FIFO_SEC_FULL_THRESHOLD(base)     __IO_CALC_ADDRESS_NATIVE(base,0x00)
#define IORD_ALTERA_MULTI_CHAN_FIFO_SEC_FULL_THRESHOLD(base)   IORD_32DIRECT(base, 0x00)
#define IOWR_ALTERA_MULTI_CHAN_FIFO_SEC_FULL_THRESHOLD(base,data)   IOWR_32DIRECT(base, 0x00, data)


#define IOADDR_ALTERA_MULTI_CHAN_FIFO_SEC_EMPTY_THRESHOLD(base)     __IO_CALC_ADDRESS_NATIVE(base,0x04)
#define IORD_ALTERA_MULTI_CHAN_FIFO_SEC_EMPTY_THRESHOLD(base)   IORD_32DIRECT(base, 0x04)
#define IOWR_ALTERA_MULTI_CHAN_FIFO_SEC_EMPTY_THRESHOLD(base,data)   IOWR_32DIRECT(base, 0x04, data)

#define IOADDR_ALTERA_MULTI_CHAN_FIFO_ALMOST_FULL_THRESHOLD(base)     __IO_CALC_ADDRESS_NATIVE(base,0x08)
#define IORD_ALTERA_MULTI_CHAN_FIFO_ALMOST_FULL_THRESHOLD(base)   IORD_32DIRECT(base, 0x08)
#define IOWR_ALTERA_MULTI_CHAN_FIFO_ALMOST_FULL_THRESHOLD(base,data)   IOWR_32DIRECT(base, 0x08, data)

#define IOADDR_ALTERA_MULTI_CHAN_FIFO_ALMOST_EMPTY_THRESHOLD(base)     __IO_CALC_ADDRESS_NATIVE(base,0x10)
#define IORD_ALTERA_MULTI_CHAN_FIFO_ALMOST_EMPTY_THRESHOLD(base)   IORD_32DIRECT(base, 0x10)
#define IOWR_ALTERA_MULTI_CHAN_FIFO_ALMOST_EMPTY_THRESHOLD(base,data)   IOWR_32DIRECT(base, 0x10, data)

/*
 * Share Multi Channel FIFO 
 * 
 * ## Fill Level Query Access ## - Av-MM interface 2
 */
#define IOADDR_ALTERA_MULTI_CHAN_FILL_LEVEL(base, channel)     __IO_CALC_ADDRESS_NATIVE(base,(channel * 0x04))
#define IORD_ALTERA_MULTI_CHAN_FILL_LEVEL(base, channel)   IORD_32DIRECT(base, (channel * 0x04))
 
/* 
 * Hash table occupies registers 0x100:0x1FC. Explicit register definitions
 * are not provided. If programatic access to the hash table is necessary,
 * define a region of uncached memory using alt_remap_uncached, or use the 
 * IORD/IOWR macros to access memory at the Ethernet MAC base address plus
 * offsets in the range 0x100 to 0x1Fc.
 * 
 * The hash table's purpose is to provide multicast address resolution. When
 * programming the table, only bit '0' is significant. If a '1' is written,
 * all multicast addresses represented by the hash code (Address bits 0 to 5)
 * are accepted by the controller. If a '0' is written, matching multicast
 * addresses are rejected.
 */
#define IOADDR_ALTERA_TSEMAC_HASH_TABLE(base) \
  __IO_CALC_ADDRESS_NATIVE(base,0x100)
#define IORD_ALTERA_TSEMAC_HASH_TABLE(base, offset) \
  IORD_32DIRECT(base, (0x100 + offset))
#define IOWR_ALTERA_TSEMAC_HASH_TABLE(base, offset, data) \
  IOWR_32DIRECT(base, (0x100 + offset), data)
  
 /* 
  * PHY MDIO registers 
  * 
  * For all registers, bits 15:0 are relevant. Bits 31:16 should be written
  * with 0 and ignored on read.
  */

/* Generic access macro for either MDIO port */
#define IOADDR_ALTERA_TSEMAC_MDIO(base, mdio) \
  __IO_CALC_ADDRESS_NATIVE(base, (0x200 + (mdio * 0x80)) )
  
#define IORD_ALTERA_TSEMAC_MDIO(base, mdio, reg_num) \
  IORD_16DIRECT(base, 0x200 + (mdio * 0x80) + (reg_num * sizeof(alt_u32)) )

#define IOWR_ALTERA_TSEMAC_MDIO(base, mdio, reg_num, data) \
  IOWR_16DIRECT(base, 0x200 + (mdio * 0x80) + (reg_num * sizeof(alt_u32)), data)



/* Low word (bits 31:0) of supplemental MAC address 0*/
#define IOADDR_ALTERA_TSEMAC_SMAC_0_0(base)    __IO_CALC_ADDRESS_NATIVE(base,0x300)
#define IORD_ALTERA_TSEMAC_SMAC_0_0(base)      IORD_32DIRECT(base, 0x300)
#define IOWR_ALTERA_TSEMAC_SMAC_0_0(base,data) IOWR_32DIRECT(base, 0x300, data)

/* High half-word (bits 47:32) of supplemental MAC address 0. Upper 16 bits reserved */
#define IOADDR_ALTERA_TSEMAC_SMAC_0_1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x304)
#define IORD_ALTERA_TSEMAC_SMAC_0_1(base)      IORD_32DIRECT(base, 0x304)
#define IOWR_ALTERA_TSEMAC_SMAC_0_1(base,data) IOWR_32DIRECT(base, 0x304, data)

/* Low word (bits 31:0) of supplemental MAC address 1 */
#define IOADDR_ALTERA_TSEMAC_SMAC_1_0(base)    __IO_CALC_ADDRESS_NATIVE(base,0x308)
#define IORD_ALTERA_TSEMAC_SMAC_1_0(base)      IORD_32DIRECT(base, 0x308)
#define IOWR_ALTERA_TSEMAC_SMAC_1_0(base,data) IOWR_32DIRECT(base, 0x308, data)

/* High half-word (bits 47:32) of supplemental MAC address 1. Upper 16 bits reserved */
#define IOADDR_ALTERA_TSEMAC_SMAC_1_1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x30C)
#define IORD_ALTERA_TSEMAC_SMAC_1_1(base)      IORD_32DIRECT(base, 0x30C)
#define IOWR_ALTERA_TSEMAC_SMAC_1_1(base,data) IOWR_32DIRECT(base, 0x30C, data)

/* Low word (bits 31:0) of supplemental MAC address 2 */
#define IOADDR_ALTERA_TSEMAC_SMAC_2_0(base)    __IO_CALC_ADDRESS_NATIVE(base,0x310)
#define IORD_ALTERA_TSEMAC_SMAC_2_0(base)      IORD_32DIRECT(base, 0x310)
#define IOWR_ALTERA_TSEMAC_SMAC_2_0(base,data) IOWR_32DIRECT(base, 0x310, data)

/* High half-word (bits 47:32) of supplemental MAC address 2. Upper 16 bits reserved */
#define IOADDR_ALTERA_TSEMAC_SMAC_2_1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x314)
#define IORD_ALTERA_TSEMAC_SMAC_2_1(base)      IORD_32DIRECT(base, 0x314)
#define IOWR_ALTERA_TSEMAC_SMAC_2_1(base,data) IOWR_32DIRECT(base, 0x314, data)

/* Low word (bits 31:0) of supplemental MAC address 3 */
#define IOADDR_ALTERA_TSEMAC_SMAC_3_0(base)    __IO_CALC_ADDRESS_NATIVE(base,0x318)
#define IORD_ALTERA_TSEMAC_SMAC_3_0(base)      IORD_32DIRECT(base, 0x318)
#define IOWR_ALTERA_TSEMAC_SMAC_3_0(base,data) IOWR_32DIRECT(base, 0x318, data)

/* High half-word (bits 47:32) of supplemental MAC address 3. Upper 16 bits reserved */
#define IOADDR_ALTERA_TSEMAC_SMAC_3_1(base)    __IO_CALC_ADDRESS_NATIVE(base,0x31C)
#define IORD_ALTERA_TSEMAC_SMAC_3_1(base)      IORD_32DIRECT(base, 0x31C)
#define IOWR_ALTERA_TSEMAC_SMAC_3_1(base,data) IOWR_32DIRECT(base, 0x31C, data)




/* Enumeration of commonly-used PHY registers */
#define ALTERA_TSEMAC_PHY_ADDR_CONTROL    0x0
#define ALTERA_TSEMAC_PHY_ADDR_STATUS     0x1
#define ALTERA_TSEMAC_PHY_ADDR_PHY_ID1    0x2
#define ALTERA_TSEMAC_PHY_ADDR_PHY_ID2    0x3
#define ALTERA_TSEMAC_PHY_ADDR_PHY_ADV    0x4
#define ALTERA_TSEMAC_PHY_ADDR_PHY_REMADV 0x5


/* (Original) Register bit definitions and Ethernet MAC device structure */
// COMMAND_CONFIG Register Bits
enum
{
  mmac_cc_TX_ENA_bit        = 0,
  mmac_cc_RX_ENA_bit        = 1,
  mmac_cc_XON_GEN_bit       = 2,
  mmac_cc_ETH_SPEED_bit     = 3,
  mmac_cc_PROMIS_EN_bit     = 4,
  mmac_cc_PAD_EN_bit        = 5,
  mmac_cc_CRC_FWD_bit       = 6,  
  mmac_cc_PAUSE_FWD_bit     = 7,
  mmac_cc_PAUSE_IGNORE_bit  = 8,
  mmac_cc_TX_ADDR__INS_bit  = 9,
  mmac_cc_HD_ENA_bit        = 10,
  mmac_cc_EXCESS_COL_bit    = 11,
  mmac_cc_LATE_COL_bit      = 12,
  mmac_cc_SW_RESET_bit      = 13,
  mmac_cc_MHASH_SEL_bit     = 14,
  mmac_cc_LOOPBACK_bit      = 15,
  mmac_cc_TX_ADDR_SEL_bit   = 16,   // bits 18:16 = address select
  mmac_cc_MAGIC_ENA_bit     = 19,
  mmac_cc_SLEEP_ENA_bit     = 20,
  mmac_cc_WAKEUP_bit        = 21,
  mmac_cc_XOFF_GEN_bit      = 22,
  mmac_cc_CNTL_FRM_ENA_bit  = 23,
  mmac_cc_NO_LENGTH_CHECK_bit  = 24,
  mmac_cc_ENA_10_bit        = 25,
  mmac_cc_RX_ERR_DISC_bit   = 26,
  mmac_cc_CNT_RESET_bit     = 31,
  
  mmac_cc_TX_ENA_mask           = (1 << 0), // enable TX
  mmac_cc_RX_ENA_mask           = (1 << 1), // enable RX
  mmac_cc_XON_GEN_mask          = (1 << 2), // generate Pause frame with Quanta
  mmac_cc_ETH_SPEED_mask        = (1 << 3), // Select Gigabit
  mmac_cc_PROMIS_EN_mask        = (1 << 4), // enable Promiscuous mode
  mmac_cc_PAD_EN_mask           = (1 << 5), // enable padding remove on RX
  mmac_cc_CRC_FWD_mask          = (1 << 6), // forward CRC to application on RX (as opposed to stripping it off)
  mmac_cc_PAUSE_FWD_mask        = (1 << 7), // forward Pause frames to application
  mmac_cc_PAUSE_IGNORE_mask     = (1 << 8), // ignore Pause frames
  mmac_cc_TX_ADDR_INS_mask      = (1 << 9), // MAC overwrites bytes 6 to 12 of frame with address on all transmitted frames
  mmac_cc_HD_ENA_mask           = (1 << 10),// enable half-duplex operation
  mmac_cc_EXCESS_COL_mask       = (1 << 11),// indicator
  mmac_cc_LATE_COL_mask         = (1 << 12),// indicator
  mmac_cc_SW_RESET_mask         = (1 << 13),// issue register and counter reset
  mmac_cc_MHASH_SEL_mask        = (1 << 14),// select multicast hash method
  mmac_cc_LOOPBACK_mask         = (1 << 15),// enable GMII loopback
  mmac_cc_TX_ADDR_SEL_mask      = (1 << 16),// bits 18:16 = address select
  mmac_cc_MAGIC_ENA_mask        = (1 << 19),// enable magic packet detect
  mmac_cc_SLEEP_ENA_mask        = (1 << 20),// enter sleep mode
  mmac_cc_WAKEUP_mask           = (1 << 21),
  mmac_cc_XOFF_GEN_mask         = (1 << 22),
  mmac_cc_CNTL_FRM_ENA_mask     = (1 << 23),
  mmac_cc_NO_LENGTH_CHECK_mask  = (1 << 24), // disable payload length check
  mmac_cc_ENA_10_mask           = (1 << 25),
  mmac_cc_RX_ERR_DISCARD_mask   = (1 << 26),
  mmac_cc_CNT_RESET_mask        = (1 << 31)
};

// TX_CMD_STAT Register bits
enum{
  mmac_tcs_OMIT_CRC_mask          = (1 << 17),
  mmac_tcs_TX_SHIFT16_mask        = (1 << 18)
};


// RX_CMD_STAT Register bits
enum{
  mmac_rcs_RX_SHIFT16_mask          = (1 << 25)
};



// TxConf Register Bits
enum{
  mnet_txc_TYPE_AUTO_mask    = (1 << 0),
  mnet_txc_H2N_IP_mask       = (1 << 1),
  mnet_txc_H2N_PROT_mask     = (1 << 2),
  mnet_txc_IPCHK_mask        = (1 << 3),
  mnet_txc_PROTCHK_mask      = (1 << 4)
};

// RxConf and RxStat register bits
enum{
  mnet_rxc_PADREMOVE_mask    = (1 << 0),
  mnet_rxc_IPERR_DISC_mask   = (1 << 1),
  mnet_rxc_PROTERR_DISC_mask = (1 << 2),
  mnet_rxc_TYPE_REMOVE_mask  = (1 << 3),
  mnet_rxc_N2H_IP_mask       = (1 << 4),
  mnet_rxc_N2H_PROT_mask     = (1 << 5),
  
  mnet_rxs_HDRLEN_mask       = 0x1f,    // 0..4 = header length of IP+Protocol in 32-bit words
  mnet_rxs_IP_CHKERR_mask    = (1 << 5),
  mnet_rxs_PROT_CHKERR_mask  = (1 << 6),
  mnet_rxs_T_REMOVED_mask    = (1 << 7),
  mnet_rxs_VLAN_mask         = (1 << 8),
  mnet_rxs_IPv6_mask         = (1 << 17),
  mnet_rxs_FRAGMENT_mask     = (1 << 18)       // IPv4 fragment
  
};

enum {
        PCS_CTL_speed1           = 1<<6,        // speed select
        PCS_CTL_speed0           = 1<<13,       
        PCS_CTL_fullduplex       = 1<<8,        // fullduplex mode select
        PCS_CTL_an_restart       = 1<<9,        // Autonegotiation restart command
        PCS_CTL_isolate          = 1<<10,       // isolate command
        PCS_CTL_powerdown        = 1<<11,       // powerdown command
        PCS_CTL_an_enable        = 1<<12,       // Autonegotiation enable
        PCS_CTL_rx_slpbk         = 1<<14,       // Serial Loopback enable
        PCS_CTL_sw_reset         = 1<<15        // perform soft reset
        
};

/** PCS Status Register Bits. IEEE 801.2 Clause 22.2.4.2
 */
enum {
        PCS_ST_has_extcap   = 1<<0,             // PHY has extended capabilities registers       
        PCS_ST_rx_sync      = 1<<2,             // RX is in sync (8B/10B codes o.k.)
        PCS_ST_an_ability   = 1<<3,             // PHY supports autonegotiation
        PCS_ST_rem_fault    = 1<<4,             // Autonegotiation completed
        PCS_ST_an_done      = 1<<5
        
};

/** Autonegotiation Capabilities Register Bits. IEEE 802.3 Clause 37.2.1 */

enum {
        ANCAP_NEXTPAGE  = 1 << 15,
        ANCAP_ACK       = 1 << 14,
        ANCAP_RF2       = 1 << 13,
        ANCAP_RF1       = 1 << 12,
        ANCAP_PS2       = 1 << 8,
        ANCAP_PS1       = 1 << 7,
        ANCAP_HD        = 1 << 6,
        ANCAP_FD        = 1 << 5
        // all others are reserved
};     

// MDIO registers within MAC register Space
// memory mapped access
typedef volatile struct np_tse_mdio_struct
{  
  unsigned int CONTROL;
  unsigned int STATUS;
  unsigned int PHY_ID1;
  unsigned int PHY_ID2;
  unsigned int ADV;
  unsigned int REMADV;

  unsigned int reg6;
  unsigned int reg7;
  unsigned int reg8;
  unsigned int reg9;
  unsigned int rega;
  unsigned int regb;
  unsigned int regc;
  unsigned int regd;
  unsigned int rege;
  unsigned int regf;
  unsigned int reg10;
  unsigned int reg11;
  unsigned int reg12;
  unsigned int reg13;
  unsigned int reg14;
  unsigned int reg15;
  unsigned int reg16;
  unsigned int reg17;
  unsigned int reg18;
  unsigned int reg19;
  unsigned int reg1a;
  unsigned int reg1b;
  unsigned int reg1c;
  unsigned int reg1d;
  unsigned int reg1e;
  unsigned int reg1f;

} np_tse_mdio;

typedef volatile struct np_tse_mac_struct
{
  unsigned int REV;
  unsigned int SCRATCH;
  unsigned int COMMAND_CONFIG;
  unsigned int MAC_0;
  unsigned int MAC_1;
  unsigned int FRM_LENGTH;
  unsigned int PAUSE_QUANT;
  unsigned int RX_SECTION_EMPTY;
  unsigned int RX_SECTION_FULL;
  unsigned int TX_SECTION_EMPTY;
  unsigned int TX_SECTION_FULL;
  unsigned int RX_ALMOST_EMPTY;
  unsigned int RX_ALMOST_FULL;
  unsigned int TX_ALMOST_EMPTY;
  unsigned int TX_ALMOST_FULL;
  unsigned int MDIO_ADDR0;
  unsigned int MDIO_ADDR1;
    
  unsigned int reservedx44[5];
  unsigned int REG_STAT;
  unsigned int TX_IPG_LENGTH;
    
  unsigned int aMACID_1;
  unsigned int aMACID_2;
  unsigned int aFramesTransmittedOK;
  unsigned int aFramesReceivedOK;
  unsigned int aFramesCheckSequenceErrors; 
  unsigned int aAlignmentErrors;
  unsigned int aOctetsTransmittedOK;
  unsigned int aOctetsReceivedOK;
  unsigned int aTxPAUSEMACCtrlFrames;
  unsigned int aRxPAUSEMACCtrlFrames;
  unsigned int ifInErrors;
  unsigned int ifOutErrors;
  unsigned int ifInUcastPkts;
  unsigned int ifInMulticastPkts;
  unsigned int ifInBroadcastPkts;
  unsigned int ifOutDiscards;
  unsigned int ifOutUcastPkts;
  unsigned int ifOutMulticastPkts;
  unsigned int ifOutBroadcastPkts;
  unsigned int etherStatsDropEvent;
  unsigned int etherStatsOctets;
  unsigned int etherStatsPkts;
  unsigned int etherStatsUndersizePkts;
  unsigned int etherStatsOversizePkts;
  unsigned int etherStatsPkts64Octets;
  unsigned int etherStatsPkts65to127Octets;
  unsigned int etherStatsPkts128to255Octets;
  unsigned int etherStatsPkts256to511Octets;
  unsigned int etherStatsPkts512to1023Octets;
  unsigned int etherStatsPkts1024to1518Octets;
  unsigned int etherStatsPkts1519toXOctets;
  unsigned int etherStatsJabbers;
  unsigned int etherStatsFragments;
  
  unsigned int reservedxE4;
  unsigned int TX_CMD_STAT;
  unsigned int RX_CMD_STAT;
  
  unsigned int msb_aOctetsTransmittedOK;
  unsigned int msb_aOctetsReceivedOK;
  unsigned int msb_etherStatsOctets;
  unsigned int reservedxFC;  // current frame's IP payload sum result
  
  unsigned int hashtable[64];
  
  np_tse_mdio mdio0;
  np_tse_mdio mdio1;
  
  unsigned int smac0_0;
  unsigned int smac0_1;
  unsigned int smac1_0;
  unsigned int smac1_1;
  unsigned int smac2_0;
  unsigned int smac2_1;
  unsigned int smac3_0;
  unsigned int smac3_1;
  
  unsigned int reservedx320[56];

} np_tse_mac;

#endif /* __ALTERA_ETH_TSE_REGS_H__ */
