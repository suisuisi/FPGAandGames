#ifndef __Generatedlcp_cmd_
#define __Generatedlcp_cmd_

/*
 * This file is machine generated as part of CDS.
 *
 * DO NOT EDIT!
 *
 * Generated on 01/31/2003, 13:41:00
 * by program "cds2inc" version 1.15 Beta
 * from source file "lcp_cmd.cds".
 *
 */

/************************************************************ */
/* LCP COMMUNICATION EQUATES - Common for HPI, HSS and SPI    */
/************************************************************ */
/* THESE DEFINITIONS DEFINE THE LYBERTY CONTROL PROTOCOL (LCP) */
/* SBN: Jan/28/03 Update Host/Slave SIEx Message codde handle */
/* SBN: Jan/26/03 Remove CRB code */


/* ====== Default DTL Ports and CMDS ====== */
#define PORT_CMD_PROC                                        0x0000

/* --- CMDS --- */
#define CP_GET_PORT_LIST                                     0x0000
#define CP_SINGLE_PORT_MODE                                  0x0001 /*-- One port at a time access */
#define CP_MULTI_PORT_MODE                                   0x0002 /*-- Multiple Ports Active at a time */

#define PORT_HUSB                                            0x0001 /* SIE1/SIE2 and USB_A-USB_D controlled via CMDs */

#define PORT_SUSB                                            0x0002 /* SIE1/SIE2 and USB_A-USB_D controlled via CMDs */

#define PORT_SPI                                             0x0003

#define PORT_HSS                                             0x0004

#define PORT_IDE                                             0x0005

#define PORT_HPI                                             0x0006 /* HPI Master Mode DMA and MailBox control */

#define PORT_DRAM                                            0x0007


/* ====== HOST TO LYBERTY PORT COMMAND EQUATES ====== */

/* -- CMDs common to all ports -- */
#define COMM_RESET                                           0xFA50
#define COMM_JUMP2CODE                                       0xCE00 /* CE = CMD Equate */
#define COMM_EXEC_INT                                        0xCE01
#define COMM_READ_CTRL_REG                                   0xCE02
#define COMM_WRITE_CTRL_REG                                  0xCE03
#define COMM_CALL_CODE                                       0xCE04
#define COMM_READ_XMEM                                       0xCE05 /* Can access IRAM too but uses a small buffer */
#define COMM_WRITE_XMEM                                      0xCE06 /*   compared to READ_MEM and WRITE_MEM */
#define COMM_CONFIG                                          0xCE07 /* Uses COMM_BAUD_RATE to change HSS BaudRate etc */

/* -- CMDs for HSS and SPI  -- */
#define COMM_READ_MEM                                        0xCE08 /* Addr and Len sent as part of CMD  packet  */
#define COMM_WRITE_MEM                                       0xCE09 /* Addr and Len sent as part of CMD packet  */

/* ====== LYBERTY TO HOST RESPONSE AND COMMAND EQUATES ====== */
/* ----- Response Equates should Use 0xCxxx, 0xDxxx, 0xExxx, 0xFxxx --- */
/* General Responses */
#define COMM_ACK                                             0x0FED /* I ate it just fine. */
#define COMM_NAK                                             0xDEAD /* Sorry I'm not feeling well. */

/* Message for SIE1 and SIE2 in register 0x144 and 0x148 */
#define SUSB_EP0_MSG                                         0x0001
#define SUSB_EP1_MSG                                         0x0002
#define SUSB_EP2_MSG                                         0x0004
#define SUSB_EP3_MSG                                         0x0008
#define SUSB_EP4_MSG                                         0x0010
#define SUSB_EP5_MSG                                         0x0020
#define SUSB_EP6_MSG                                         0x0040
#define SUSB_EP7_MSG                                         0x0080
#define SUSB_RST_MSG                                         0x0100
#define SUSB_SOF_MSG                                         0x0200
#define SUSB_CFG_MSG                                         0x0400 /* send these flags to external processor */
#define SUSB_SUS_MSG                                         0x0800
#define SUSB_VBUS_MSG                                        0x8000
#define SUSB_ID_MSG                                          0x4000

/* ----- Commands To Host (HPI Only) ----- (use -0x00xx - 0x0Fxx) where top byte is Port Num) */
/* NDX new bit map for Host in both register 0x144 and 0x148 */
#define HUSB_TDListDone                                      0x1000 /*TDListDone message */

/* Sharing bits */
#define HUSB_SOF                                             0x2000 /*SOF message */
#define HUSB_ARMV                                            0x0001 /*Device Remove message */
#define HUSB_AINS_FS                                         0x0002 /*Full Speed Device Insert message */
#define HUSB_AINS_LS                                         0x0004 /*Low Speed Device Insert message */
#define HUSB_AWakeUp                                         0x0008 /*WakeUp message */
#define HUSB_BRMV                                            0x0010 /*Device Remove message */
#define HUSB_BINS_FS                                         0x0020 /*Full Speed Device Insert message */
#define HUSB_BINS_LS                                         0x0040 /*Low Speed Device Insert message */
#define HUSB_BWakeUp                                         0x0080 /*WakeUp message */


#endif /* __Generatedlcp_cmd_ */
