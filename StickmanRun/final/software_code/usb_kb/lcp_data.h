#ifndef __Generatedlcp_data_
#define __Generatedlcp_data_

/*
 * This file is machine generated as part of CDS.
 *
 * DO NOT EDIT!
 *
 * Generated on 01/31/2003, 13:41:14
 * by program "cds2inc" version 1.15 Beta
 * from source file "lcp_data.cds".
 *
 */

/************************************************************ */
/* Lyberty Data Pointers for Common Data Area */
/************************************************************ */
/* SBN: Jan/27/03 update for new LCP code */

#define _start_of_comm                                       0x019A
#define lcp_table                                            0x019A /* COMM_TRANSPORT */
#define snd_msg                                              0x019C /* common send msg routine */
#define lcp_sema                                             0x019E /* lcp_semaphore */
#define lcp_chain                                            0x01A0 /* chain for lcp idle loop */
#define lcp_rsp                                              0x01A2 /* CommConfig: location 0x1a4-0x1ae are free */


/* -----Memory adress for send the TD list pointer and Semaphore in USB HOST */
/* -----OWNER: NDX.  */
#define HUSB_SIE1_pCurrentTDPtr                              0x01B0 /* Address to SIE1 current TD pointer */
#define HUSB_SIE2_pCurrentTDPtr                              0x01B2 /* Address to SIE2 current TD pointer */
#define HUSB_pEOT                                            0x01B4 /* Address to End Of Transfer  */
#define HUSB_SIE1_pTDListDone_Sem                            0x01B6 /* Address to SIE1 TD List Done semaphore */
#define HUSB_SIE2_pTDListDone_Sem                            0x01B8 /* Address to SIE2 TD List Done semaphore */

/* ===== CMD DATA AREA - UNION for ALL COMMANDS ============   */
/* --- 8 byte HSS/SPI FIFO Data goes in here --- */
#define COMM_PORT_CMD                                        0x01BA
#define COMM_PORT_DATA                                       0x01BC /* Generic Ptr to CMD data in HSS FIFO */

/* -- DATA UNION FOR SIMPLE PORT CMDS -- */
#define COMM_MEM_ADDR                                        0x01BC /* -- For COMM_RD/WR_MEM */
#define COMM_MEM_LEN                                         0x01BE /* -- For COMM_RD/WR_MEM */
#define COMM_LAST_DATA                                       0x01C0 /* -- UNUSED but HSS FiFo can handle this last data */

#define COMM_CTRL_REG_ADDR                                   0x01BC /* -- For COMM_RD/WR_CTRL_REG */
#define COMM_CTRL_REG_DATA                                   0x01BE /* -- For COMM_RD/WR_CTRL_REG */
#define COMM_CTRL_REG_LOGIC                                  0x01C0 /* -- User to AND/OR Reg */
#define REG_WRITE_FLG                                        0x0000
#define REG_AND_FLG                                          0x0001
#define REG_OR_FLG                                           0x0002

#define COMM_BAUD_RATE                                       0x01BC /* -- For COMM_SET_BAUD in scalar units for the given I/F */
#define COMM_TIMEOUT                                         0x01BE /* -- For using Timerout on Sending Response to host. */
#define COMM_CODE_ADDR                                       0x01BC /* -- For COMM_CALL_CODE and COMM_JUMP2CODE */

/* !!! NOTE: For HSS/SPI all of the above are sent in FIFO */
/*           For HPI done with HW Access. */
/* --- Register Buffers for EXEC_INT Commands */
#define COMM_INT_NUM                                         0x01C2 /* -- For COMM_EXEC_INT */
#define COMM_R0                                              0x01C4 /* This data struct must be written via MEM_WRITE commands for HSS and SPI */
#define COMM_R1                                              0x01C6
#define COMM_R2                                              0x01C8
#define COMM_R3                                              0x01CA
#define COMM_R4                                              0x01CC
#define COMM_R5                                              0x01CE
#define COMM_R6                                              0x01D0
#define COMM_R7                                              0x01D2
#define COMM_R8                                              0x01D4
#define COMM_R9                                              0x01D6
#define COMM_R10                                             0x01D8
#define COMM_R11                                             0x01DA
#define COMM_R12                                             0x01DC
#define COMM_R13                                             0x01DE

/*============================================================= */
/* BIOS free memory area: 0x1E0 - 0x1FE */

#endif /* __Generatedlcp_data_ */
