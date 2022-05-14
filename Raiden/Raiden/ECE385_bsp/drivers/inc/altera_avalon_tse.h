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

#ifndef __ALTERA_AVALON_TSE_H__
#define __ALTERA_AVALON_TSE_H__

#include "altera_eth_tse_regs.h"
#include "system.h"     /* check if SGDMA is used */

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */



/* TSE DEBUG Message Level */
/* Level 6 : Info
 * Level 5 : Debug Info
 * Level 4 : Warning
 * Level 3 : Critical Warning
 * Level 2 : Error
 * Level 1 : Critical Error, eg: malloc() failed
 */
 
#ifndef TSE_DEBUG_LEVEL
    #define TSE_DEBUG_LEVEL 6
#endif

/* definition without InterNiche */
#ifndef ALT_INICHE
#define SUCCESS            0  /* whatever the call was, it worked. */
#define ENP_RESOURCE     -22  /* ran out of other queue-able resource */
#define ENP_PARAM        -10  /* bad parameter */

#define MAXNETS            8  /* max ifaces to support at one time */

#ifdef ALT_DEBUG
#define tse_dprintf(level, fmt, rest...)        \
    if(level <= TSE_DEBUG_LEVEL) {              \
        printf (fmt, ## rest);                  \
    }                                           \
    else {                                      \
        no_printf (fmt, ## rest);               \
    }
#else
#define tse_dprintf(level, fmt, rest...) no_printf (fmt, ## rest)
#endif /* ALT_DEBUG */
    
#else /* ALT_INICHE */
#include "ipport.h"

#define tse_dprintf(level, fmt, rest...)        \
    if(level <= TSE_DEBUG_LEVEL) {              \
        dprintf (fmt, ## rest);                 \
    }                                           \
    else {                                      \
        no_printf (fmt, ## rest);               \
    }
#endif /* ALT_INICHE */


void no_printf (char *fmt, ...);



/* MSGDMA dependent */
#ifdef __ALTERA_MSGDMA
#include "altera_msgdma.h"

/* Device addressing struct for all hardware TSE MAC depends on */
typedef struct tse_mac_trans_info_struct {
  np_tse_mac    *base;
  alt_msgdma_dev *tx_msgdma;
  alt_msgdma_dev *rx_msgdma;
  alt_u32       *rx_msgdma_desc_ram;
  alt_u32       cfgflags;  // flags or'ed during initialization of COMMAND_CONFIG
} tse_mac_trans_info;


/** @Function Description - Perform initialization steps on transaction info structure to prepare it for .
  *                        use by the library functions with two MSGDMAs and extra initialization Flags
  * @API Type:          Internal
  * @param mi           Main Device Structure.
  * @param mac_base     Base Address of the Control interface for the TSE MAC
  * @param tx_msgdma     MSGDMA device handle for TSE transmit data path 
  * @param rx_msgdma     MSGDMA device handle for TSE receive data path
  * @param cfgflags     initialization flags for the device
  * @return SUCCESS 
  */

alt_32 tse_mac_initTransInfo2( tse_mac_trans_info *mi,
                                        alt_u32 mac_base,
                                        alt_32 tx_msgdma,
                                        alt_32 rx_msgdma,
                                        alt_32 cfgflags);

/** @Function Description - Synchronous MSGDMA copy from buffer memory into transmit FIFO. Waits until 
  *                         MSGDMA has completed.  Raw function without any error checks.
  * @API Type:              Internal
  * @param mi               Main Device Structure.
  * @param txDesc           Pointer to the transmit MSGDMA descriptor
  * @return actual bytes transferred if ok else ENP_RESOURCE if error
  */
alt_32 tse_mac_sTxWrite( tse_mac_trans_info *mi,  
                       alt_msgdma_standard_descriptor *txDesc);
                       
                       
                       
/** @Function Description - Asynchronous MSGDMA copy from buffer memory into rxFIFO.
  *                         Raw function without any transfer error checks.
  *
  * @API Type:    Internal
  * @param mi     Main Device Structure.
  * @param rxDesc Pointer to the receive MSGDMA descriptor
  * @return SUCCESS if ok  else -1 if error
 */                       
alt_32 tse_mac_aTxWrite( tse_mac_trans_info *mi,  
                       alt_msgdma_prefetcher_standard_descriptor *txDesc);                       



/** @Function Description - Asynchronous MSGDMA copy from rxFIFO into given buffer memory area.
  *                         Raw function without any error checks.
  *
  * @API Type:    Internal
  * @param mi     Main Device Structure.
  * @param rxDesc Pointer to the receive MSGDMA descriptor
  * @return SUCCESS if ok  else ENP_RESOURCE if error
  *
  * Note:  At the point of this function call return, 
  *        the MSGDMA asynchronous operation may not have been
  *        completed yet, so the function does not return
  *        the actual bytes transferred for current descriptor
  */
alt_32 tse_mac_aRxRead(tse_mac_trans_info *mi, alt_msgdma_prefetcher_standard_descriptor *rxDesc);

#endif /* __ALTERA_MSGDMA */






/*** Debug Definition *********/
/* change ENABLE_PHY_LOOPBACK to 1 to enable PHY loopback for debug purpose */ 
#ifndef ENABLE_PHY_LOOPBACK
    #define ENABLE_PHY_LOOPBACK     0
#endif

#ifndef pnull
#define pnull ((void *)0)
#endif

/* Constant definition for tse_system_info.h */
#define TSE_EXT_DESC_MEM                        1
#define TSE_INT_DESC_MEM                        0

#define TSE_USE_SHARED_FIFO                     1
#define TSE_NO_SHARED_FIFO                      0

#define TSE_ENABLE_MDIO_SHARING                 1

/* Multi-channel Shared FIFO Depth Settings */
#ifndef ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT
    #define ALTERA_TSE_SHARED_FIFO_TX_DEPTH_DEFAULT        2040
#endif

#ifndef ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT
    #define ALTERA_TSE_SHARED_FIFO_RX_DEPTH_DEFAULT        2040
#endif


/* PHY Status definition */
#define TSE_PHY_AUTO_ADDRESS        -1
#define TSE_PHY_MAP_SUCCESS         0
#define TSE_PHY_MAP_ERROR           -1

#define TSE_PHY_AN_NOT_COMPLETE     -1
#define TSE_PHY_AN_NOT_CAPABLE      -2
#define TSE_PHY_AN_COMPLETE         0
#define TSE_PHY_SPEED_INVALID       3
#define TSE_PHY_SPEED_1000          2
#define TSE_PHY_SPEED_100           1
#define TSE_PHY_SPEED_10            0
#define TSE_PHY_SPEED_NO_COMMON     -1
#define TSE_PHY_DUPLEX_FULL         1
#define TSE_PHY_DUPLEX_HALF         0

/* getPHYSpeed return error */
enum {
    ALT_TSE_E_NO_PMAC_FOUND             = (1 << 23),
    ALT_TSE_E_NO_MDIO                   = (1 << 22),
    ALT_TSE_E_NO_PHY                    = (1 << 21),
    ALT_TSE_E_NO_COMMON_SPEED           = (1 << 20),
    ALT_TSE_E_AN_NOT_COMPLETE           = (1 << 19),
    ALT_TSE_E_NO_PHY_PROFILE            = (1 << 18),
    ALT_TSE_E_PROFILE_INCORRECT_DEFINED = (1 << 17),
    ALT_TSE_E_INVALID_SPEED             = (1 << 16)
};

/* Maximum number of PHY that can be registered into PHY profile */
#define TSE_MAX_PHY_PROFILE     8   

/* Maximum MAC in system */
#define TSE_MAX_MAC_IN_SYSTEM   MAXNETS
#define TSE_MAX_CHANNEL         MAXNETS


/* System Constant Definition Used in the TSE Driver Code */


#define ALTERA_TSE_SW_RESET_TIME_OUT_CNT         10000
#define ALTERA_TSE_MSGDMA_BUSY_TIME_OUT_CNT      1000000 

//These values reflect useable chain size plus 1 for ending descriptor
#define ALTERA_TSE_MSGDMA_RX_DESC_CHAIN_SIZE     9   
#define ALTERA_TSE_MSGDMA_TX_DESC_CHAIN_SIZE     2   /* currently only a value of 2 is supported */

#define ALTERA_TSE_MAC_MAX_FRAME_LENGTH         1518


#define ALTERA_TSE_FULL_MAC                     0
#define ALTERA_TSE_MACLITE_10_100               1
#define ALTERA_TSE_MACLITE_1000                 2

#define ALTERA_TSE_NO_INDEX_FOUND               -1
#define ALTERA_TSE_SYSTEM_DEF_ERROR             -1
#define ALTERA_TSE_MALLOC_FAILED                -1

#define ALTERA_TSE_DUPLEX_MODE_DEFAULT          TSE_PHY_DUPLEX_FULL
#define ALTERA_TSE_MAC_SPEED_DEFAULT            TSE_PHY_SPEED_100
/* added as bsp public makefile settings
#define ALTERA_AUTONEG_TIMEOUT_THRESHOLD        2500
#define ALTERA_CHECKLINK_TIMEOUT_THRESHOLD      10000
#define ALTERA_NOMDIO_TIMEOUT_THRESHOLD         1000000
#define ALTERA_DISGIGA_TIMEOUT_THRESHOLD        5000000
*/

#define ALTERA_TSE_PCS_IF_MODE                  0x14        /* 0x14th register of ALTERA PCS */

/* PHY ID, backward compatible */
#define NTL848PHY_ID    0x20005c90  /* National 83848, 10/100 */
#define MTIPPCS_ID      0x00010000  /* MTIP 1000 Base-X PCS */
#define TDKPHY_ID       0x0300e540  /* TDK 78Q2120 10/100 */
#define NTLPHY_ID       0x20005c7a  /* National DP83865 */
#define MVLPHY_ID       0x0141      /* Marvell 88E1111 */



/* PHY ID */
/* Marvell PHY on PHYWORKX board */
enum {
    MV88E1111_OUI       = 0x005043,
    MV88E1111_MODEL     = 0x0c,
    MV88E1111_REV       = 0x2
};

/* Marvell Quad PHY on PHYWORKX board */
enum {
    MV88E1145_OUI       = 0x005043,
    MV88E1145_MODEL     = 0x0d,
    MV88E1145_REV       = 0x2
};

/* National PHY on PHYWORKX board */
enum {
    DP83865_OUI       = 0x080017,
    DP83865_MODEL     = 0x07,
    DP83865_REV       = 0xa
};

/* National 10/100 PHY on PHYWORKX board */
enum {
    DP83848C_OUI       = 0x080017,
    DP83848C_MODEL     = 0x09,
    DP83848C_REV       = 0x0
};

/* Intel PEF7071 Phy on C10 Devkit */
enum {
    PEF7071_OUI       = ((0xd565 << 6) | ((0xa401 >> 10) & 0x3f)),
    PEF7071_MODEL     = ((0xa401 >> 4) & 0x3f),
    PEF7071_REV       = (0xa401 & 0x0f)
};



/* PHY register definition */
enum {
    TSE_PHY_MDIO_CONTROL    = 0,
    TSE_PHY_MDIO_STATUS     = 1,
    TSE_PHY_MDIO_PHY_ID1    = 2,
    TSE_PHY_MDIO_PHY_ID2    = 3,
    TSE_PHY_MDIO_ADV        = 4,
    TSE_PHY_MDIO_REMADV     = 5,
    
    TSE_PHY_MDIO_AN_EXT             = 6,
    TSE_PHY_MDIO_1000BASE_T_CTRL    = 9,
    TSE_PHY_MDIO_1000BASE_T_STATUS  = 10,
    TSE_PHY_MDIO_EXT_STATUS         = 15    
};

/* MDIO CONTROL bit number */
enum {
    TSE_PHY_MDIO_CONTROL_RESET      = 15,
    TSE_PHY_MDIO_CONTROL_LOOPBACK   = 14,
    TSE_PHY_MDIO_CONTROL_SPEED_LSB  = 13,
    TSE_PHY_MDIO_CONTROL_AN_ENA     = 12,
    TSE_PHY_MDIO_CONTROL_POWER_DOWN = 11,
    TSE_PHY_MDIO_CONTROL_ISOLATE    = 10,
    TSE_PHY_MDIO_CONTROL_RESTART_AN = 9,
    TSE_PHY_MDIO_CONTROL_DUPLEX     = 8,
    TSE_PHY_MDIO_CONTROL_SPEED_MSB  = 6
};

/* MDIO STATUS bit number */
enum {
    TSE_PHY_MDIO_STATUS_100BASE_T4      = 15,
    TSE_PHY_MDIO_STATUS_100BASE_X_FULL  = 14,
    TSE_PHY_MDIO_STATUS_100BASE_X_HALF  = 13,
    TSE_PHY_MDIO_STATUS_10BASE_T_FULL   = 12,
    TSE_PHY_MDIO_STATUS_10BASE_T_HALF   = 11,
    TSE_PHY_MDIO_STATUS_100BASE_T2_FULL = 10,
    TSE_PHY_MDIO_STATUS_100BASE_T2_HALF = 9,
    TSE_PHY_MDIO_STATUS_EXT_STATUS      = 8,
    TSE_PHY_MDIO_STATUS_AN_COMPLETE     = 5,
    TSE_PHY_MDIO_STATUS_AN_ABILITY      = 3,
    TSE_PHY_MDIO_STATUS_LINK_STATUS     = 2
};

/* AN Advertisement bit number */
/* and also */
/* Link Partner Ability bit number */
enum {
    TSE_PHY_MDIO_ADV_100BASE_T4       = 9,
    TSE_PHY_MDIO_ADV_100BASE_TX_FULL  = 8,
    TSE_PHY_MDIO_ADV_100BASE_TX_HALF  = 7,
    TSE_PHY_MDIO_ADV_10BASE_TX_FULL   = 6,
    TSE_PHY_MDIO_ADV_10BASE_TX_HALF   = 5
};

/* AN Expansion bit number */
enum {
    TSE_PHY_MDIO_LP_AN_ABLE     = 0
};

/* 1000BASE-T Control bit number */
enum {
    TSE_PHY_MDIO_1000BASE_T_CTRL_FULL_ADV   = 9,
    TSE_PHY_MDIO_1000BASE_T_CTRL_HALF_ADV   = 8
};

/* 1000BASE-T Status bit number */
enum {
    TSE_PHY_MDIO_1000BASE_T_STATUS_LP_FULL_ADV   = 11,
    TSE_PHY_MDIO_1000BASE_T_STATUS_LP_HALF_ADV   = 10
};

/* Extended Status bit number */
enum {
    TSE_PHY_MDIO_EXT_STATUS_1000BASE_X_FULL = 15,
    TSE_PHY_MDIO_EXT_STATUS_1000BASE_X_HALF = 14,
    TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_FULL = 13,
    TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_HALF = 12
};





/* 
 * macros to access MSGDMA prefetcher standard Descriptors used in the TSE driver 
 * - use the macros to assure cache coherancy 
 */
#define IORD_ALTERA_TSE_MSGDMA_DESC_READ_ADDR(base)                      (IORD(base, 0x0) & 0xFFFFFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_READ_ADDR(base, data)                IOWR(base, 0x0, data)
#define IORD_ALTERA_TSE_MSGDMA_DESC_WRITE_ADDR(base)                     (IORD(base, 0x1) & 0xFFFFFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_WRITE_ADDR(base, data)               IOWR(base, 0x1, data)
#define IORD_ALTERA_TSE_MSGDMA_DESC_NEXT(base)                           (IORD(base, 0x3) & 0xFFFFFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_NEXT(base, data)                     IOWR(base, 0x3, data)

#define IORD_ALTERA_TSE_MSGDMA_DESC_BYTES_TO_TRANSFER(base)              (IORD(base, 0x2) & 0xFFFFFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_BYTES_TO_TRANSFER(base, data)        IOWR(base, 0x2,  data))

#define IORD_ALTERA_TSE_MSGDMA_DESC_ACTUAL_BYTES_TRANSFERRED(base)       (IORD(base, 0x4) & 0xFFFFFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_ACTUAL_BYTES_TRANSFERRED(base, data) IOWR(base, 0x4,  data))
#define IORD_ALTERA_TSE_MSGDMA_DESC_STATUS(base)                         (((IORD(base, 0x5)) >> 16) & 0xFFFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_STATUS(base, data)                   IOWR(base, 0x5, (data & 0xffff))
#define IORD_ALTERA_TSE_MSGDMA_DESC_CONTROL(base)                        (((IORD(base, 0x7) >> 24) & 0xFF)
#define IOWR_ALTERA_TSE_MSGDMA_DESC_CONTROL(base, data)                  IOWR(base, 0x7, data)

/* TSE System Component Structure */
typedef struct alt_tse_system_mac_struct {
    alt_u32        tse_mac_base;                     /* Base address of TSE MAC                               */
    alt_u16        tse_tx_depth;                     /* TX Receive FIFO depth                                 */
    alt_u16        tse_rx_depth;                     /* RX Receive FIFO depth                                 */
    alt_u8        tse_use_mdio;                     /* is MDIO enabled                                       */
    alt_u8        tse_en_maclite;                   /* is Small MAC                                          */
    alt_u8        tse_maclite_gige;                 /* is Small MAC 1000 Mbps                                */
    alt_u8        tse_multichannel_mac;             /* MAC group together for MDIO block sharing             */
    alt_u8        tse_num_of_channel;               /* Number of channel for Multi-channel MAC               */
    alt_u8        tse_mdio_shared;                  /* is MDIO block shared                                  */
    alt_u8        tse_number_of_mac_mdio_shared;    /* Number of MAC sharing the MDIO block                  */
    alt_u8        tse_pcs_ena;                      /* is MAC+PCS combination                                */
    alt_u8        tse_pcs_sgmii;                    /* is SGMII mode of PCS enabled                          */
} alt_tse_system_mac;

typedef struct alt_tse_system_msgdma_struct {
    char *        tse_msgdma_tx;                      /* MSGDMA TX name                                         */
    char *        tse_msgdma_rx;                      /* MSGDMA RX name                                         */
    alt_u16        tse_msgdma_rx_irq;                  /* MSGDMA RX IRQ                                          */
} alt_tse_system_msgdma;

typedef struct alt_tse_system_desc_mem_struct {
    alt_u8        ext_desc_mem;                     /* is dedicated memory used for descriptor               */
    alt_u32        desc_mem_base;                      /* Base address of Descriptor Memory if ext_desc_mem = 1 */
} alt_tse_system_desc_mem;

typedef struct alt_tse_system_shared_fifo_struct {
    alt_u8        use_shared_fifo;                  /* is Shared FIFO used in the system                     */
    
    alt_u32        tse_shared_fifo_tx_ctrl_base;     /* Base address of TX Shared FIFO Ctrl                   */
    alt_u32        tse_shared_fifo_tx_stat_base;     /* Base address of TX Shared FIFO Fill Level             */
    alt_u32        tse_shared_fifo_tx_depth;         /* Depth of TX Shared FIFO                               */
    
    alt_u32        tse_shared_fifo_rx_ctrl_base;     /* Base address of RX Shared FIFO Ctrl                   */
    alt_u32        tse_shared_fifo_rx_stat_base;     /* Base address of RX Shared FIFO Fill Level             */
    alt_u32        tse_shared_fifo_rx_depth;         /* Depth of RX Shared FIFO                               */
    
} alt_tse_system_shared_fifo;

typedef struct alt_tse_system_phy_struct {
    alt_32        tse_phy_mdio_address;              /* PHY's MDIO address                                    */
    alt_32        (*tse_phy_cfg)(np_tse_mac *pmac); /* Function pointer to execute additional initialization */
} alt_tse_system_phy;

/* System Parameters for TSE System */
typedef struct alt_tse_system_info_struct {
    alt_u32        tse_mac_base;                     /* Base address of TSE MAC                               */
    alt_u32        tse_tx_depth;                     /* TX Receive FIFO depth                                 */
    alt_u32        tse_rx_depth;                     /* RX Receive FIFO depth                                 */
    alt_u8        tse_use_mdio;                     /* is MDIO enabled                                       */
    alt_u8        tse_en_maclite;                   /* is Small MAC                                          */
    alt_u8        tse_maclite_gige;                 /* is Small MAC 1000 Mbps                                */
    alt_u8        tse_multichannel_mac;             /* MAC group together for MDIO block sharing             */
    alt_u8        tse_num_of_channel;               /* Number of channel for Multi-channel MAC               */
    alt_u8        tse_mdio_shared;                  /* is MDIO block shared                                  */
    alt_u8        tse_number_of_mac_mdio_shared;    /* Number of MAC sharing the MDIO block                  */
    alt_u8        tse_pcs_ena;                      /* is MAC+PCS combination                                */
    alt_u8        tse_pcs_sgmii;                    /* is SGMII mode of PCS enabled                          */
        
    char *        tse_msgdma_tx;                     /* MSGDMA TX name                                         */
    char *        tse_msgdma_rx;                     /* MSGDMA RX name                                         */
    alt_u16        tse_msgdma_rx_irq;                 /* MSGDMA TX IRQ                                          */
    
    alt_u8        ext_desc_mem;                     /* is dedicated memory used for descriptor               */
    alt_u32        desc_mem_base;                    /* Base address of Descriptor Memory if ext_desc_mem = 1 */
    
    alt_u8        use_shared_fifo;                  /* is Shared FIFO used in the system                     */
    alt_u32        tse_shared_fifo_tx_ctrl_base;     /* Base address of TX Shared FIFO Ctrl                   */
    alt_u32        tse_shared_fifo_tx_stat_base;     /* Base address of TX Shared FIFO Fill Level             */
    alt_u32        tse_shared_fifo_tx_depth;         /* Depth of TX Shared FIFO                               */
    
    alt_u32        tse_shared_fifo_rx_ctrl_base;     /* Base address of RX Shared FIFO Ctrl                   */
    alt_u32        tse_shared_fifo_rx_stat_base;     /* Base address of RX Shared FIFO Fill Level             */
    alt_u32        tse_shared_fifo_rx_depth;         /* Depth of RX Shared FIFO                               */
    
    alt_32        tse_phy_mdio_address;             /* PHY's MDIO address                                    */
    alt_32        (*tse_phy_cfg)(np_tse_mac *pmac); /* Function pointer to execute additional initialization */
    
} alt_tse_system_info;


 

/* PHY structure for PHY detection */
typedef struct alt_tse_phy_profile_struct{

    /* PHY name */
    char name[80];

    /* PHY OUI (Organizationally Unique Identififier) */
    alt_u32 oui;
    
    /* PHY model number */
    alt_u8 model_number;
    
    /* PHY revision number */
    alt_u8 revision_number;
    
    /* Location of PHY Specific Status Register */
    alt_u8 status_reg_location;
    
    /* Location of Speed Status bit in PHY Specific Status Register */
    alt_u8 speed_lsb_location;
    
    /* Location of Duplex Status bit in PHY Specific Status Register */
    alt_u8 duplex_bit_location;
    
    /* Location of Link Status bit in PHY Specific Status Register */
    alt_u8 link_bit_location;
    
    /* Function pointer to execute additional initialization */
    /* Profile specific */
    alt_32 (*phy_cfg)(np_tse_mac *pmac);
    
    /** Function pointer to read the link status from the PHY specific status register 
      * Use this function pointer if the PHY is using different format to store link information in PHY specific status register
      * The above _location variable will not be used if this function pointer is not NULL
      * Table below show the format of the return value required by TSE driver PHY detection
      * ----------------------------------------------------------------------------------
      * |  BIT  | Value: Description                                                     |
      * ----------------------------------------------------------------------------------
      * | 31-17 | Reserved                                                               |
      * |   16  | 1: Error:Invalid speed read from PHY                                   |
      * | 15- 4 | Reserved                                                               |
      * |    3  | 1: 10 Mbps link                                                        |
      * |    2  | 1: 100 Mbps link                                                       |
      * |    1  | 1: 1000 Mbps link                                                      |
      * |    0  | 1: Full Duplex                    0: Half Duplex                       |
      * ----------------------------------------------------------------------------------
      */
    alt_u32 (*link_status_read)(np_tse_mac *pmac);
    
} alt_tse_phy_profile;


/* TSE Multi-Channel PHY detection */
typedef struct alt_tse_phy_link_cap_struct {
    /* connected PHY capabilities */
    alt_u8 cap_1000_base_x_full;
    alt_u8 cap_1000_base_x_half;
    alt_u8 cap_1000_base_t_full;
    alt_u8 cap_1000_base_t_half;
    
    alt_u8 cap_100_base_t4;
    alt_u8 cap_100_base_x_full;
    alt_u8 cap_100_base_x_half;
    alt_u8 cap_100_base_t2_full;
    alt_u8 cap_100_base_t2_half;
    alt_u8 cap_10_base_t_full;
    alt_u8 cap_10_base_t_half;
    
    /* link partner capabilities */
    alt_u8 lp_1000_base_t_full;
    alt_u8 lp_1000_base_t_half;
    
    alt_u8 lp_100_base_t4;
    alt_u8 lp_100_base_tx_full;
    alt_u8 lp_100_base_tx_half;
    alt_u8 lp_10_base_tx_full;
    alt_u8 lp_10_base_tx_half;    
} alt_tse_phy_link_cap;


struct alt_tse_phy_info_struct;
struct alt_tse_mac_info_struct;
struct alt_tse_mac_group_struct;

struct alt_tse_phy_info_struct {
    alt_u8 mdio_address;                       /* Actual PHY MDIO address detected                           */
    alt_tse_phy_link_cap link_capability;       /* structure to store link capability of PHY and link partner */
    alt_tse_phy_profile *pphy_profile;          /* Pointer to type of PHY profile                             */
    struct alt_tse_mac_info_struct *pmac_info;  /* Pointer to MAC info structure which connected to this PHY  */
    
};

struct alt_tse_mac_info_struct {
    alt_u8 mac_type;                               /* ALTERA_TSE_FULL_MAC, ALTERA_TSE_MACLITE_10_100, or ALTERA_TSE_MACLITE_1000 */
    struct alt_tse_phy_info_struct *pphy_info;      /* Pointer to PHY info structure which connected to this MAC */
    alt_tse_system_info *psys_info;                      /* Pointer to alt_tse_system_info structure in alt_tse_system_info.h */
    struct alt_tse_mac_group_struct *pmac_group;    /* Pointer to the MAC group this MAC belongs to, all multi-channel MAC form a group */
    
};

struct alt_tse_mac_group_struct {
    alt_u8 channel;                                            /* Number of channel the MAC group has */
    struct alt_tse_mac_info_struct *pmac_info[TSE_MAX_CHANNEL]; /* Pointer to hold MACs in the same group */
};

typedef struct alt_tse_phy_info_struct alt_tse_phy_info;
typedef struct alt_tse_mac_info_struct alt_tse_mac_info;
typedef struct alt_tse_mac_group_struct alt_tse_mac_group;



/*******************************
 *
 * Public API for TSE Driver 
 *
 *******************************/

/* @Function Description: Perform a software Reset. Reset operation will ocur with some latency.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
 * @return SUCCESS if ok, else if error return ENP_RESOURCE, ENP_LOGIC
*/
alt_32 tse_mac_SwReset( np_tse_mac *pmac);




/* @Function Description: Perform switching of the TSE MAC into MII (10/100) mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
 * @return SUCCESS
*/
alt_32 tse_mac_setMIImode(np_tse_mac *pmac);




/* @Function Description: Perform switching of the TSE MAC into GMII (Gigabit) mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
 * @return SUCCESS
*/
alt_32 tse_mac_setGMIImode(np_tse_mac *pmac);


/* @Function Description - Add additional PHYs which are not supported by default into PHY profile for PHY detection and auto negotiation
 * 
 * @API TYPE - Public
 * @param  phy  pointer to alt_tse_phy_profile structure describing PHY registers
 * @return      index of PHY added in PHY profile on success, else return ALTERA_TSE_MALLOC_FAILED if memory allocation failed
 * PHY which are currently supported by default :  Marvell 88E1111, Marvell Quad PHY 88E1145, National DP83865, and National DP83848C
 */
alt_32 alt_tse_phy_add_profile(alt_tse_phy_profile *phy);


/* @Function Description - Add TSE System to tse_mac_device[] array to customize TSE System
 * 
 * @API TYPE - Public
 * @param        psys_mac  pointer to alt_tse_system_mac structure describing MAC of the system
 * @param        psys_msgdma  pointer to alt_tse_system_msgdma structure describing SGDMA of the system
 * @param        psys_mem  pointer to alt_tse_system_desc_mem structure describing Descriptor Memory of the system
 * @param        psys_phy  pointer to alt_tse_system_phy structure describing PHY of the system
 * @return      SUCCESS on success
 *                 ALTERA_TSE_MALLOC_FAILED if memory allocation failed
 *                 ALTERA_TSE_SYSTEM_DEF_ERROR if definition of system incorrect or pointer == NULL
 */
alt_32 alt_tse_system_add_sys(
    alt_tse_system_mac                    *psys_mac,
    alt_tse_system_msgdma                *psys_msgdma,
    alt_tse_system_desc_mem                *psys_mem,
    alt_tse_system_shared_fifo            *psys_shared_fifo,
    alt_tse_system_phy                     *psys_phy );


/* @Function Description - Enable MDIO sharing for multiple single channel MAC
 * 
 * @API TYPE - Public
 * @param        psys_mac_list  pointer to array of alt_tse_system_mac structure sharing MDIO block
 * @param        number_of_mac  number of MAC sharing MDIO block
 * @return      SUCCESS on success
 *                 ALTERA_TSE_SYSTEM_DEF_ERROR if definition of system incorrect or pointer == NULL
 * Multi-channel MAC not supported
 */
alt_32 alt_tse_sys_enable_mdio_sharing(alt_tse_system_mac **psys_mac_list, alt_u8 number_of_mac);

/* @Function Description: Get the common speed supported by all PHYs connected to the MAC within the same group
 * @API Type:           Public
 * @param pmac          Pointer to the TSE MAC Control Interface Base address
 * @return              common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if no common speed found
 */
alt_32 alt_tse_mac_get_common_speed(np_tse_mac *pmac);

/* @Function Description: Set the common speed to all PHYs connected to the MAC within the same group
 * @API Type:               Public
 * @param pmac              Pointer to the TSE MAC Control Interface Base address
 *        common_speed      common speed supported by all PHYs
 * @return                  common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if invalid common speed specified
 */
alt_32 alt_tse_mac_set_common_speed(np_tse_mac *pmac, alt_32 common_speed);

/********************************
 *
 * Internal API for TSE Driver 
 *
 *******************************/

/* @Function Description: Get the index of alt_tse_system_info structure in tse_mac_device[]
 * @API Type:        Internal
 * @param psys_info  Pointer to the alt_tse_system_info structure
 * @return           Index of TSE system structure in tse_mac_device[]
 */
alt_32 alt_tse_get_system_index(alt_tse_system_info *psys_info);


/* @Function Description: Get the index of alt_tse_mac_group structure in pmac_groups[]
 * @API Type:         Internal
 * @param pmac_group  Pointer to the alt_tse_mac_group structure
 * @return            Index of alt_tse_mac_group structure in pmac_groups[]
 */
alt_32 alt_tse_get_mac_group_index(alt_tse_mac_group *pmac_group);


/* @Function Description: Get the index of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 * @API Type:         Internal
 * @param pmac_group  Pointer to the alt_tse_mac_info structure
 * @return            Index of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 */
alt_32 alt_tse_get_mac_info_index(alt_tse_mac_info *pmac_info);

/* @Function Description: Get the pointer of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 * @API Type:         Internal
 * @param pmac        Pointer to the TSE MAC Control Interface Base address
 * @return            Pointer to alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 */
alt_tse_mac_info *alt_tse_get_mac_info(np_tse_mac *pmac);

/* @Function Description: Perform switching of the TSE MAC speed.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Internal
 * @param pmac  Pointer to the TSE MAC Control Interface Base address
 * @param speed 2 = 1000 Mbps, 1 = 100 Mbps, 0 = 10 Mbps
 */
alt_32 alt_tse_mac_set_speed(np_tse_mac *pmac, alt_u8 speed);


/* @Function Description: Perform switching of the TSE MAC duplex mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Internal
 * @param pmac  Pointer to the TSE MAC Control Interface Base address
 * @param duplex 1 = Full Duplex, 0 = Half Duplex
 */
alt_32 alt_tse_mac_set_duplex(np_tse_mac *pmac, alt_u8 duplex);


/** @Function Description -  Determine link speed our PHY negotiated with our link partner.
  *                          This is fully vendor specific depending on the PHY you are using.
  * 
  * @API TYPE - Internal
  * @param  tse.mi.base MAC register map.
  * @return 
  * ----------------------------------------------------------------------------------
  * |  BIT  | Value: Description                                                     |
  * ----------------------------------------------------------------------------------
  * | 31-23 | Reserved                                                               |
  * |   23  | 1: Argument *pmac not found from the list of MAC detected during init  |
  * |   22  | 1: No MDIO used by the MAC                                             |
  * |   21  | 1: No PHY detected                                                     |
  * |   20  | 1: No common speed found for Multi-port MAC                            |
  * |   19  | 1: PHY auto-negotiation not completed                                  |
  * |   18  | 1: No PHY profile match the detected PHY                               |
  * |   17  | 1: PHY Profile not defined correctly                                   |
  * |   16  | 1: Invalid speed read from PHY                                         |
  * |  4-15 | Reserved                                                               |
  * |    3  | 1: 10 Mbps link                                                        |
  * |    2  | 1: 100 Mbps link                                                       |
  * |    1  | 1: 1000 Mbps link                                                      |
  * |    0  | 1: Full Duplex                    0: Half Duplex                       |
  * ----------------------------------------------------------------------------------
  * 
  * If the link speed cannot be determined, it is fall back to 100 Mbps (customizable by changing ALTERA_TSE_MAC_SPEED_DEFAULT)
  *                                         Full duplex (customizable by changing ALTERA_TSE_DUPLEX_MODE_DEFAULT)
  */
alt_32 getPHYSpeed(np_tse_mac *pmac);

/* @Function Description: Read MDIO address from the MDIO address1 register of first MAC within MAC group
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_rd_mdio_addr(alt_tse_phy_info *pphy);

/* @Function Description: Write MDIO address to the MDIO address1 register of first MAC within MAC group
 * @API Type:           Internal
 * @param pmac          Pointer to the alt_tse_phy_info structure
 * @param mdio_address  MDIO address to be written
 * @return              return SUCCESS
 */
alt_32 alt_tse_phy_wr_mdio_addr(alt_tse_phy_info *pphy, alt_u8 mdio_address);

/** @Function Description -  Write value of data with bit_length number of bits to mdio register based on register location reg_num
  *                          and start from bit location lsb_num.
  * 
  * @API TYPE - Internal
  * @param  pphy             pointer to alt_tse_phy_info structure
  * @param  reg_num          location of mdio register to be written.
  * @param  lsb_num          least significant bit location of mdio register to be written.
  * @param  bit_length       number of bits to be written to the register.
  * @param  data             data to be written to the register at specific bit location of register.
  * @return SUCCESS 
  */
alt_32 alt_tse_phy_wr_mdio_reg(alt_tse_phy_info *pphy, alt_u8 reg_num, alt_u8 lsb_num, alt_u8 bit_length, alt_u16 data);



/** @Function Description -  Read bit_length number of bits from mdio register based on register location reg_num
  *                          and start from bit location lsb_num.
  * 
  * @API TYPE - Internal
  * @param  pphy             pointer to alt_tse_phy_info structure
  * @param  reg_num          location of mdio register to be read.
  * @param  lsb_num          least significant bit location of mdio register to be read.
  * @param  bit_length       number of bits to be read from the register.
  * @return data read from mdio register 
  */
alt_u32 alt_tse_phy_rd_mdio_reg(alt_tse_phy_info *pphy, alt_u8 reg_num, alt_u8 lsb_num, alt_u8 bit_length);


/* @Function Description: Add supported PHY to profile
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      Number of PHY in profile
 * 
 * User might add their own PHY by calling alt_tse_phy_add_profile()
 */
alt_32 alt_tse_phy_add_profile_default();



/* @Function Description: Display PHYs available in profile
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      Number of PHY in profile
 */
alt_32 alt_tse_phy_print_profile();


/* @Function Description: Store information of all the MAC available in the system
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      return SUCCESS
 *              return ALTERA_TSE_SYSTEM_DEF_ERROR if alt_tse_system_info structure definition error
 */
alt_32 alt_tse_mac_group_init();

/* @Function Description: Store information of all the PHYs connected to MAC to phy_list
 * @API Type:         Internal
 * @param pmac_group  Pointer to the TSE MAC grouping structure
 * @return            Number of PHY not in profile
 */
alt_32 alt_tse_mac_get_phy(alt_tse_mac_group *pmac_group);


/* @Function Description: Associate the PHYs connected to the structure in alt_tse_system_info.h
 * @API Type:         Internal
 * @param pmac_group  Pointer to the TSE MAC grouping structure
 * @param pphy        Pointer to the TSE PHY info structure which hold information of PHY
 * @return            return TSE_PHY_MAP_ERROR if mapping error
 *                    return TSE_PHY_MAP_SUCCESS otherwise
 */
alt_32 alt_tse_mac_associate_phy(alt_tse_mac_group *pmac_group, alt_tse_phy_info *pphy);

/* @Function Description: Configure operating mode of Altera PCS if available
 * @API Type:           Internal
 * @param pmac_info     pointer to MAC info variable
 * @return              return SUCCESS
 */
alt_32 alt_tse_phy_cfg_pcs(alt_tse_mac_info *pmac_info);

/* @Function Description: Detect and initialize all the PHYs connected
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      SUCCESS
 */
alt_32 alt_tse_phy_init();



/* @Function Description: Restart Auto-Negotiation for the PHY
 * @API Type:                   Internal
 * @param pphy                  Pointer to the alt_tse_phy_info structure
 *        timeout_threshold     timeout value of Auto-Negotiation
 * @return                      return TSE_PHY_AN_COMPLETE if success
 *                              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 *                              return TSE_PHY_AN_NOT_CAPABLE if the PHY not capable for AN
 */
alt_32 alt_tse_phy_restart_an(alt_tse_phy_info *pphy, alt_u32 timeout_threshold);


/* @Function Description: Check link status of PHY and start Auto-Negotiation if it has not yet done
 * @API Type:                   Internal
 * @param pphy                  Pointer to the alt_tse_phy_info structure
 *        timeout_threshold     timeout value of Auto-Negotiation
 * @return                      return TSE_PHY_AN_COMPLETE if success
 *                              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 */
alt_32 alt_tse_phy_check_link(alt_tse_phy_info *pphy, alt_u32 timeout_threshold);


/* @Function Description: Get link capability of PHY and link partner
 * @API Type:   Internal
 * @param pmac  Pointer to the alt_tse_phy_info structure
 * @return      return TSE_PHY_AN_COMPLETE if success
 *              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 *              return TSE_PHY_AN_NOT_CAPABLE if the PHY not capable for AN
 */
alt_32 alt_tse_phy_get_cap(alt_tse_phy_info *pphy);


/* @Function Description: Set the advertisement of PHY for 1000 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_1000(alt_tse_phy_info *pphy, alt_u8 enable);


/* @Function Description: Set the advertisement of PHY for 100 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_100(alt_tse_phy_info *pphy, alt_u8 enable);


/* @Function Description: Set the advertisement of PHY for 10 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_10(alt_tse_phy_info *pphy, alt_u8 enable);



/* @Function Description: Get the common speed supported by all PHYs connected to the MAC within the same group
 * @API Type:           Internal
 * @param pmac_group    Pointer to the TSE MAC Group structure which group all the MACs that should use the same speed
 * @return              common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if no common speed found
 */
alt_32 alt_tse_phy_get_common_speed(alt_tse_mac_group *pmac_group);



/* @Function Description: Set the common speed to all PHYs connected to the MAC within the same group
 * @API Type:               Internal
 * @param pmac_group        Pointer to the TSE MAC Group structure which group all the MACs that should use the same speed
 *        common_speed      common speed supported by all PHYs
 * @return      common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if invalid common speed specified
 */
alt_32 alt_tse_phy_set_common_speed(alt_tse_mac_group *pmac_group, alt_32 common_speed);



/* @Function Description: Additional configuration for Marvell PHY
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address of MAC group
 */
alt_32 marvell_phy_cfg(np_tse_mac *pmac);

/* @Function Description: Additional configuration for PEF7071 PHY
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address of MAC group
 */
alt_32 PEF7071_config(np_tse_mac *pmac);

/* @Function Description: Change operating mode of Marvell PHY to GMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_gmii(np_tse_mac *pmac);

/* @Function Description: Change operating mode of Marvell PHY to SGMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_sgmii(np_tse_mac *pmac);

/* @Function Description: Change operating mode of Marvell PHY to RGMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_rgmii(np_tse_mac *pmac);

/* @Function Description: Read link status from PHY specific status register of DP83848C
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_u32 DP83848C_link_status_read(np_tse_mac *pmac);

/* @Function Description: Read link status from PHY specific status register of PEF7071
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_u32 PEF7071_link_status_read(np_tse_mac *pmac);


#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __ALTERA_AVALON_TSE_H__ */

