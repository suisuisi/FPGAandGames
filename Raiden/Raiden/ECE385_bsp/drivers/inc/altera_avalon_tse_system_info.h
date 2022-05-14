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

#ifndef __ALTERA_AVALON_TSE_SYSTEM_INFO_H__
#define __ALTERA_AVALON_TSE_SYSTEM_INFO_H__

#include "altera_avalon_tse.h"

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

/* Define whole TSE system (dedicated descriptor memory, no shared fifo) */
#define TSE_SYSTEM_EXT_MEM_NO_SHARED_FIFO(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, desc_mem_name) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    tse_name##_MDIO_SHARED,               \
    tse_name##_NUMBER_OF_MAC_MDIO_SHARED, \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_EXT_DESC_MEM,                     \
	desc_mem_name##_BASE,                 \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (program memory as descriptor memory, no shared fifo) */
#define TSE_SYSTEM_INT_MEM_NO_SHARED_FIFO(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    tse_name##_MDIO_SHARED,               \
    tse_name##_NUMBER_OF_MAC_MDIO_SHARED, \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_INT_DESC_MEM,                     \
	TSE_INT_DESC_MEM,                     \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (dedicated descriptor memory, use shared fifo) */
#define TSE_SYSTEM_EXT_MEM_WITH_SHARED_FIFO(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, desc_mem_name, shared_fifo_tx_name, shared_fifo_rx_name) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    tse_name##_MDIO_SHARED,               \
    tse_name##_NUMBER_OF_MAC_MDIO_SHARED, \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_EXT_DESC_MEM,                     \
	desc_mem_name##_BASE,                 \
	TSE_USE_SHARED_FIFO,                  \
	shared_fifo_tx_name##_CONTROL_BASE,      \
    shared_fifo_tx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT,   \
	shared_fifo_rx_name##_CONTROL_BASE,      \
    shared_fifo_rx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT,   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (program memory as descriptor memory, use shared fifo) */
#define TSE_SYSTEM_INT_MEM_WITH_SHARED_FIFO(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, shared_fifo_tx_name, shared_fifo_rx_name) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    tse_name##_MDIO_SHARED,               \
    tse_name##_NUMBER_OF_MAC_MDIO_SHARED, \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_INT_DESC_MEM,                     \
	TSE_INT_DESC_MEM,                     \
	TSE_USE_SHARED_FIFO,                  \
	shared_fifo_tx_name##_CONTROL_BASE,      \
    shared_fifo_tx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT,   \
	shared_fifo_rx_name##_CONTROL_BASE,      \
    shared_fifo_rx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT,   \
	phy_addres,                           \
    phy_cfg_fp                            \
},



/* Define whole TSE system (dedicated descriptor memory, no shared fifo, enable MDIO sharing on first MAC) */
/* MDIO sharing not supported for Multi-channel MAC */
#define TSE_SYSTEM_EXT_MEM_NO_SHARED_FIFO_ENABLE_MDIO_SHARING(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, desc_mem_name, number_of_mac_mdio_sharing) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    TSE_ENABLE_MDIO_SHARING,              \
    number_of_mac_mdio_sharing,           \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_EXT_DESC_MEM,                     \
	desc_mem_name##_BASE,                 \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (program memory as descriptor memory, no shared fifo, enable MDIO sharing on first MAC) */
/* MDIO sharing not supported for Multi-channel MAC */
#define TSE_SYSTEM_INT_MEM_NO_SHARED_FIFO_ENABLE_MDIO_SHARING(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, number_of_mac_mdio_sharing) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    TSE_ENABLE_MDIO_SHARING,              \
    number_of_mac_mdio_sharing,           \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_INT_DESC_MEM,                     \
	TSE_INT_DESC_MEM,                     \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	TSE_NO_SHARED_FIFO,                   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (dedicated descriptor memory, use shared fifo, enable MDIO sharing on first MAC) */
/* MDIO sharing not supported for Multi-channel MAC */
#define TSE_SYSTEM_EXT_MEM_WITH_SHARED_FIFO_ENABLE_MDIO_SHARING(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, desc_mem_name, shared_fifo_tx_name, shared_fifo_rx_name, number_of_mac_mdio_sharing) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    TSE_ENABLE_MDIO_SHARING,              \
    number_of_mac_mdio_sharing,           \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_EXT_DESC_MEM,                     \
	desc_mem_name##_BASE,                 \
	TSE_USE_SHARED_FIFO,                  \
	shared_fifo_tx_name##_CONTROL_BASE,      \
    shared_fifo_tx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT,   \
	shared_fifo_rx_name##_CONTROL_BASE,      \
    shared_fifo_rx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT,   \
	phy_addres,                           \
    phy_cfg_fp                            \
},

/* Define whole TSE system (program memory as descriptor memory, use shared fifo, enable MDIO sharing on first MAC) */
/* MDIO sharing not supported for Multi-channel MAC */
#define TSE_SYSTEM_INT_MEM_WITH_SHARED_FIFO_ENABLE_MDIO_SHARING(tse_name, offset, msgdma_tx_name, msgdma_rx_name, phy_addres, phy_cfg_fp, shared_fifo_tx_name, shared_fifo_rx_name, number_of_mac_mdio_sharing) {  \
    tse_name##_BASE + offset,             \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    TSE_ENABLE_MDIO_SHARING,              \
    number_of_mac_mdio_sharing,           \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII,                 \
    msgdma_tx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_NAME,            \
    msgdma_rx_name##_CSR_IRQ,             \
    TSE_INT_DESC_MEM,                     \
	TSE_INT_DESC_MEM,                     \
	TSE_USE_SHARED_FIFO,                  \
	shared_fifo_tx_name##_CONTROL_BASE,      \
    shared_fifo_tx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT,   \
	shared_fifo_rx_name##_CONTROL_BASE,      \
    shared_fifo_rx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT,   \
	phy_addres,                           \
    phy_cfg_fp                            \
},
	
	
	
	
/* Macro to define single component used by alt_tse_system_add_sys() */	
/* Define MAC of TSE system */
#define TSE_SYSTEM_MAC(tse_name)	      \
	tse_name##_BASE,       			      \
    tse_name##_TRANSMIT_FIFO_DEPTH,       \
    tse_name##_RECEIVE_FIFO_DEPTH,        \
    tse_name##_USE_MDIO,                  \
    tse_name##_ENABLE_MACLITE,            \
    tse_name##_MACLITE_GIGE,              \
    tse_name##_IS_MULTICHANNEL_MAC,       \
    tse_name##_NUMBER_OF_CHANNEL,         \
    tse_name##_MDIO_SHARED,               \
    tse_name##_NUMBER_OF_MAC_MDIO_SHARED, \
    tse_name##_PCS,                       \
    tse_name##_PCS_SGMII

/* Define MSGDMA of TSE system */
#define TSE_SYSTEM_MSGDMA(msgdma_tx_name, msgdma_rx_name)	\
	msgdma_tx_name##_CSR_NAME,           \
    msgdma_rx_name##_CSR_NAME,           \
    msgdma_rx_name##_CSR_IRQ

/* Define descriptor memory of TSE system (dedicated descriptor memory) */
#define TSE_SYSTEM_DESC_MEM(desc_mem_name)	\
    TSE_EXT_DESC_MEM,               \
	desc_mem_name##_BASE

/* Define descriptor memory of TSE system (program memory as descriptor memory) */
#define TSE_SYSTEM_NO_DESC_MEM()	\
    TSE_INT_DESC_MEM,               \
    TSE_INT_DESC_MEM

/* Define shared fifo of TSE system (use shared fifo) */
#define TSE_SYSTEM_SHARED_FIFO(shared_fifo_tx_name, shared_fifo_rx_name)	\
    TSE_USE_SHARED_FIFO,               \
    shared_fifo_tx_name##_CONTROL_BASE,      \
    shared_fifo_tx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT,   \
	shared_fifo_rx_name##_CONTROL_BASE,      \
    shared_fifo_rx_name##_FILL_LEVEL_BASE,   \
	ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT

/* Define shared fifo of TSE system (no shared fifo) */
#define TSE_SYSTEM_NO_SHARED_FIFO()	  \
	TSE_NO_SHARED_FIFO,               \
	TSE_NO_SHARED_FIFO,               \
	TSE_NO_SHARED_FIFO,               \
	TSE_NO_SHARED_FIFO,               \
    TSE_NO_SHARED_FIFO,               \
	TSE_NO_SHARED_FIFO,               \
	TSE_NO_SHARED_FIFO
	
/* Define PHY of TSE system */
#define TSE_SYSTEM_PHY(phy_addres, phy_cfg_fp)	\
	phy_addres,           			\
    phy_cfg_fp

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __ALTERA_AVALON_TSE_SYSTEM_INFO_H__ */

