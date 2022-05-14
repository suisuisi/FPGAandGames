#ifndef CY7C67200_H_
#define CY7C67200_H_

/* ---------------------------------------------------------------------
 * Cypress C67x00 register definitions
 */

/* Hardware Revision Register */
#define HW_REV_REG      0xC004

/* usb controller base address */
#define CY7C67200_BASE CY7C67200_IF_0_BASE
//#define CY7C67200_IF_0_IRQ CY7C67200_IF_0_IRQ

/* General USB registers */
/* ===================== */
//set for port 1A(0)(Device port 1) and 2A(1)(Host port 2)
//Note: all the register are 16-bits
/* USB Control Register */
//port 1 : 0
#define USB_CTL_REG(x)      ((x) ? 0xC0AA : 0xC08A)

//bit 0  
#define SOF_EOP_EN          (0x0001)
//bit 2 default disable
#define SUSPEND_EN          (0x0004)
//bit 3 4  default normal state
#define FORCEDSTATUS        (0x0000)     //normal state  
//bit 7 default disable
#define PORT_RES_EN         (0x0080)     //hardware not connect  
//bit 9 port mode select 
#define PORT_MODE_HOST      (0x0200)
//bit 10 default full speed        
#define LOW_SPEED_PORT      (0x0400)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* USB Device 0 only registers */  
/* ============================= */
/* USB ENDPOINTn CTL register */  //only support endpoint 0 if want to support n need to fix the value to if statement
#define  USB_DEVICE_ENDPOINTn_CTL_REG  0x0200
//bit 0
#define  DEVICE_ENDPOINTn_ARM_EN(x)  ((x) ? 0x0001 : 0x0000)    //enable arm endpoint
//bit 1
#define  DEVICE_ENDPOINTn_Enable(x)  ((x) ? 0x0002 : 0x0000)    //enable transmit to endpoint 0 from port 0
//bit 2  1 (OUT transfer Host-->Slave the bit set as 1)  (IN transfer Slave-->Host,the bit set as 0)
#define  DEVICE_ENDPOINTn_Direction_Selection(x)  ((x) ? 0x0004 : 0x0000)    //enable transmit to endpoint 0 from port 0
//bit 3
#define  DEVICE_ENDPOINTn_NAK_INT_EN(x)    ((x) ? 0x0008 : 0x0000)     //enable endpoint NAK (response to host) interrupt to port 0
//bit 4 iso transmit enable (Valid for Endpoint1-7)
#define  DEVICE_ENDPOINTn_ISO_EN(x)        ((x) ? 0x0010 : 0x0000)     //enable endpoint iso transmit to port 0
//bit 5
#define  DEVICE_ENDPOINTn_Stall_EN(x)      ((x) ? 0x0020 : 0x0000)     //enable send stall in response to the next request
//bit 6 (1:Data1 0:Data0) impact on tx only
#define  DEVICE_ENDPOINTn_Seq_Sel()        ((x) ? 0x0040 : 0x0000)     //the sequence data net data toggle
//bit 7 
#define  DEVICE_ENDPOINT0_Inout_Ignore(x)  ((x) ? 0x0080 : 0x0000)     //enable Endpoint 0 inout

/* USB ENDPOINTn  Address register */
//assign the address in the memory space for endpoint n transaction  can allocate in the user space 0x04A4- 0x3FFF
#define USB_DEVICE_ENDPOINTn_Address_REG         (x0202) 

/* USB ENDPOINTn  Count register */
//assign the OUT max packet size from PC and In max packet size to the Host   10-bit
# define USB_DEVICE_ENDPOINTn_Count_REG          (x0204)  

/* USB ENDPOINTn  Status register */   //MUST initial to 0x0000 at first,then forbidden to write to
//assign the OUT max packet size from PC and In max packet size to the Host   10-bit
# define USB_DEVICE_ENDPOINTn_Status_REG         (0x0206) 
//Note: all bits should be write to 0s for initial
//bit 0  indicate the last transaction occur or not
# define DEVICE_ENDPOINTn_ACK_FLAG               (0x0001)
//bit 1 CRC5,CRC12 or incorrect packet type received
# define DEVICE_ENDPOINTn_Error_FLAG             (0x0002)
//bit 2  last transaction Timeout or not
# define DEVICE_ENDPOINTn_Timeout_FLAG           (0x0004)
//bit 3  indicate the last data toggle received was a data1 or data0
#define  DEVICE_ENDPOINTn_Sequence_FLAG          (0x0008)
//bit 4  indicate the setup packet was received or not, for device 1 the setup packet are stored at mem location 0x0300
#define  DEVICE_ENDPOINTn_Setup_FLAG             (0x0010)
//bit 5  indicate the length in last transaction same or not to the endpoint count reg
#define  DEVICE_ENDPOINTn_Length_Exception_FLAG  (0x0020)
//bit 6  indicate the NAK flag packet was sent to the host or not
#define  DEVICE_ENDPOINTn_NAK_FLAG               (0x0040)
//bit 7 indicate the stall packet was sent to host or not
#define  DEVICE_ENDPOINTn_Stall_FLAG             (0x0080)
//bit 8 IN Exception Flag
#define  DEVICE_ENDPOINTn_IN_Exception_FLAG      (0x0100)
// 1 : Received IN when armed for OUT
// 0 : Received OUT when armed for OUT
//bit 9 OUT Exception Flag
#define  DEVICE_ENDPOINTn_OUT_Exception_FLAG     (0x0200)
// 1 : Received OUT when armed for IN
// 0 : Received IN  when armed for IN
//bit 10
#define  DEVICE_ENDPOINTn_Underflow_FLAG         (0x0400)
//bit 11
#define  DEVICE_ENDPOINTn_Overflow_FLAG          (0x0800)
              
/* USB ENDPOINTn  Count result register */   //MUST initial to 0x0000 at first,then forbidden to write to
//assign the difference of packet size between the length assigned in the count register and the actual length received (overflow/underflow)
# define USB_DEVICE_ENDPOINTn_CountResult_REG       (x0208) 
//all bits should be write to 0s

/* USB DEVICE 0 interrupt enable register */
//The Device n Interrupt Enable register provides control over
//device-related interrupts including eight different endpoint interrupts.
#define USB_DEVICE_INT_EN_REG    (0xC08C)

//bit 0
#define DEVICE_EPO_INT_EN(x)    ((x) ? 0x0001 : 0x0000)     //enable Endpoint 0 interrupt
//bit 1
#define DEVICE_EP1_INT_EN(x)    ((x) ? 0x0002 : 0x0000)     //enable Endpoint 1 interrupt
//bit 2
#define DEVICE_EP2_INT_EN(x)    ((x) ? 0x0004 : 0x0000)     //enable Endpoint 2 interrupt
//bit 3
#define DEVICE_EP3_INT_EN(x)    ((x) ? 0x0008 : 0x0000)     //enable Endpoint 3 interrupt
//bit 4
#define DEVICE_EP4_INT_EN(x)    ((x) ? 0x0010 : 0x0000)     //enable Endpoint 4 interrupt
//bit 5
#define DEVICE_EP5_INT_EN(x)    ((x) ? 0x0020 : 0x0000)     //enable Endpoint 5 interrupt
//bit 6
#define DEVICE_EP6_INT_EN(x)    ((x) ? 0x0040 : 0x0000)     //enable Endpoint 6 interrupt
//bit 7
#define DEVICE_EP7_INT_EN(x)    ((x) ? 0x0080 : 0x0000)     //enable Endpoint 7 interrupt
//bit 8 usb reset interrupt enable
#define DEVICE_USB_ResetDetect_INT_EN(x)    ((x) ? 0x0100 : 0x0000)     //enable USB device reset interrupt
//bit 9 
#define DEVICE_SOF_EOP_INT_EN(x)            ((x) ? 0x0200 : 0x0000)     //enable SOP/EOP interrupt         
//bit 11 
#define DEVICE_SOF_EOP_Timeout_INT_EN(x)    ((x) ? 0x0800 : 0x0000)     //enable SOF/EOP Timeout interrupt  
//bit 14 (OTG ID edge detection)
#define DEVICE_ID_INT_EN(x)                 ((x) ? 0x4000 : 0x0000)     //enable OTG ID interrupt  
//bit 15 (OTG VBUS interrupt enable)
#define DEVICE_VBUS_INT_EN(x)               ((x) ? 0x8000 : 0x0000)     //enable OTG VBUS interrupt  

/* USB DEVICE 0 address register */
//The Device n address register holds the address assigned by the host
//
#define USB_DEVICE_Address_REG       (0xC08E)
//the register should be write the device address assigned by host

/* USB DEVICE 0 status register */
//The Device n status register provides status information for device operation
//
#define USB_DEVICEn_Status_REG       (0xC090)
//Pending interrupts can be cleared by writing a ¡®1¡¯ to the corresponding bit. 
//bit 0
#define DEVICE_EP0_INT_Flag          (0x0001)
//bit 1
#define DEVICE_EP1_INT_Flag          (0x0002)
//bit 2
#define DEVICE_EP2_INT_Flag          (0x0004)
//bit 3
#define DEVICE_EP3_INT_Flag          (0x0008)
//bit 4
#define DEVICE_EP4_INT_Flag          (0x0010)
//bit 5
#define DEVICE_EP5_INT_Flag          (0x0020)
//bit 6
#define DEVICE_EP6_INT_Flag          (0x0040)
//bit 7
#define DEVICE_EP7_INT_Flag          (0x0080)
//bit 8
#define DEVICE_Reset_INT_Flag        (0x0100)
//bit 9
#define DEVICE_SOF_EOP_INT_Flag      (0x0200)
//bit 14
#define DEVICE_OTG_ID_INT_Flag       (0x4000)
//bit 15
#define DEVICE_VBUS_INT_Flag         (0x8000)
	
/* USB DEVICE 0 Frame Num register */
//The Device n Frame Number register is a read only register contains the Frame number of the last sof packet
//read only
#define USB_DEVICEn_FrameNum_REG            (0xC092)
//bit 10-0
#define DEVICE_FrameNum                     (0x07FF)
//bit 14-12
#define DEVICE_SOF_EOP_Timeout_INT_Count    (0x7000)
//bit 15
#define DEVICE_SOF_EOP_INT_Flag1            (0x8000)

/* USB DEVICE 0 Frame Num register */
//The Device n SOF/EOP count register is a write only register contains the time interval between SOF/EOP
//write only
#define DEVICE_SOF_EOP_COUNT_REG            (0x3FFF)
#define DEVICE_SOF_EOP_COUNT_NUM            (0x2EE0+0x0010)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
/* USB Host 1 only registers */  
/* ============================= */

/* USB Host 1 Control register */
//The Host n Control register allows high-level USB transaction control.
//read only
#define USB_HOSTn_CTL_REG     (0xC0A0)
//bit 0
#define HOST_ARM_EN                 (0x0001)
//bit 4
#define HOST_ISO_EN                 (0x0010) //for ISO transaction
//bit 5
#define HOST_SYN_EN                 (0x0020)
//	1: The next enabled packet will be transferred after the SOF
//or EOP packet is transmitted
//  0: The next enabled packet will be transferred as soon as the
//SIE is free
//bit 6
#define HOST_SEQ_SEL                (0x0040)
//bit 7
#define HOST_PRE_EN                 (0x0080)	//preamble for low speed device

/* USB Host 1 Address register */  
//The Host n Address register is used as the base pointer into memory space for the current host transactions.
//read only  16 bit
#define USB_HOSTn_Address_REG      (0xC0A2)

/* USB Host 1 Count register */
//The Host n Count register is used to hold the number of bytes (packet length) for the current transaction. The maximum
//packet length is 1023 bytes in ISO mode.
//read only  10 bit
#define USB_HOSTn_Count_REG       (0xC0A4)

#define HOST_COUNT_MASK           (0x03FF)	

/* USB Host 1 PID register */
//The Host n PID register is a write-only register that provides the PID and Endpoint information to the USB SIE to be used
//in the next transaction.
//write only  
#define USB_HOSTn_PID_REG       (0xC0A6)
//bit0-3
#define HOST_ENDPOINT_SEL       (0x000F)	
//bit4-7
#define HOST_PID_SEL            (0x00F0)

/* USB Host 1 Count Result register */
//The Host n Count Result register is a read-only register that contains the size difference in bytes between the Host Count
//Value specified in the Host n Count register and the last packet received.
//in the next transaction.
//read only  
#define USB_HOSTn_Count_Result_REG       (0xC0A8)
//bit0-15
#define HOST_Count_Result_MASK           (0xFFFF)	

/* USB Host 1 Device Address register */
//The Host n Device Address register is a write-only register that contains the USB Device Address that the host wishes to communicate with.
//read only  
#define USB_HOSTn_Device_Address_REG       (0xC0A8)
//bit0-15
#define HOST_Device_Address_MASK           (0x007F)

/* USB Host 1 Interrupt Enable register */
//The Host n Interrupt Enable register allows control over host-related interrupts.
//R/W  
#define USB_HOSTn_INT_EN_REG       (0xC0AC)
//bit0
#define HOST_DONE_INT_EN           (0x0001)
//bit4
#define HOST_CON_CHANGE_EN         (0x0010)	
//bit6
#define HOST_WAKE_INT_EN           (0x0040)	
//bit9
#define HOST_SOF_EOP_INT_EN        (0x0200)
//bit14
#define HOST_OTG_ID_INT_EN         (0x4000)
//bit15
#define HOST_VBUS_INT_EN           (0x8000)

/* USB Host 1 Status register */
//The Host n Status register provides status information for host operation.
//R/W  
#define USB_HOSTn_STATUS_REG       (0xC0B0)
//bit0
#define HOST_DONE_INT_FLAG         (0x0001)
//bit2
#define HOST_SE0_FLAG              (0x0002)	
//bit4
#define HOST_CONNECT_CHANGE_INT_FLAG  (0x0010)	
//bit6
#define HOST_WAKE_INT_FLAG        (0x0040)
//bit9
#define HOST_SOF_EOP_INT_FLAG     (0x0200)
//bit14
#define HOST_OTG_ID_INT_FLAG      (0x4000)
//bit15
#define HOST_VBUS_INT_FLAG        (0x8000)
	

/* USB Host 1 SOF EOP Count register */
//The Host n SOF/EOP Count register contains the SOF/EOP
//Count Value that is loaded into the SOF/EOP counter
//R/W  
#define USB_HOSTn_SOF_EOP_COUNT_REG       (0xC0B2)
//bit 0-13	
#define HOST_SOF_EOP_COUNT_MASK           (0x3FFF)

/* USB Host 1 SOF EOP Count register */
//The Host n SOF/EOP Counter register contains the current
//value of the SOF/EOP down counter
//R
#define USB_HOSTn_SOF_EOP_COUNT_REG1       (0xC0B4)
//bit 0-13	
#define HOST_SOF_EOP_COUNT_MASK           (0x3FFF)

/* USB Host 1 FRAME Count register */
//The Host n Frame register maintains the next frame number
//to be transmitted (current frame number + 1)
//R
#define USB_HOSTn_FRAME_COUNT_REG1       (0xC0B6)
//bit 0-13	
#define HOST_FRAME_COUNT_MASK              (0x07FF)	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
/* USB HPI registers */  
/* ============================= */

/* USB HPI breakpoint register */
//The HPI Breakpoint register is a special on-chip memory location, which the external processor can access using normal HPI
//memory read/write cycles.
//R/W for HPI
#define HPI_BreakPoint_REG   (0x0140)	

/* USB HPI interrupt routing register */
//The Interrupt Routing register allows the HPI port to take over
//some or all of the SIE interrupts that usually go to the on-chip CPU.
//R/W for HPI
#define HPI_INT_ROUTING_REG   (0x0142)	

//bit 0 & 8 not swap setting
#define HPI_SWAP_EN           (0x0000)
//bit except 1 2  
#define HPI_ROUTE_EN          (0xFECE)
	
/* USB HPI SIEmsg register */
//The SIEXmsg register allows an interrupt to be generated on the HPI port
//R/W for HPI
#define HPI_SIEmsg1_REG   (0x0144)	
#define HPI_SIEmsg2_REG   (0x0148)	
//bit 0-15
#define HPI_SIEmsg_MASK   (0xFFFF)

/* USB HPI Mailbox register */
//The HPI Mailbox register provides a common mailbox between the CY7C67200 and the external host processor.
#define HPI_Mailbox_REG   (0xC0C6)
//bit 0-15
#define HPI_Mailbox_MASK  (0xFFFF)

/* USB HPI Status register */
//The HPI Status Port provides the external host processor with
//the MailBox status bits plus several SIE status bits
#define HPI_STATUS_REG   //A1 A0 =  1 1
//bit 0
#define HPI_STATUS_Mailbox_Out_FLAG  (0x0001)
//bit 1
#define HPI_STATUS_RESET1_FLAG       (0x0002)
//bit 2
#define HPI_STATUS_DONE1_FLAG        (0x0004)
//bit 3
#define HPI_STATUS_DONE2_FLAG        (0x0008)
//bit 4
#define HPI_STATUS_SIE1msg_FLAG      (0x0010)
//bit 5
#define HPI_STATUS_SIE2msg_FLAG      (0x0020)
//bit 6
#define HPI_STATUS_Resume1_FLAG      (0x0040)
//bit 7
#define HPI_STATUS_Resume2_FLAG      (0x0080)
//bit 8
#define HPI_STATUS_Mailbox_In_FLAG   (0x0100)
//bit 9
//#define HPI_STATUS_RESET1_FLAG          (0x0200)
//bit 10
#define HPI_STATUS_SOF_EOP1_FLAG        (0x0400)
//bit 12
#define HPI_STATUS_SOF_EOP2_FLAG        (0x1000)
//bit 14
#define HPI_STATUS_SOF_OTG_ID_FLAG      (0x4000)
//bit 15
#define HPI_STATUS_VBUS_FLAG            (0x8000)





/*********************************************************/
/* FILE        : 63700.H                                 */
/*********************************************************/
/* DATE        : 06/24/02                                */
/* BY          : Barry Hatton                            */
/* VERSION     : 00.04                                   */
/*                                                       */
/* History:                                              */
/*   SBN: Update to the latest spec     July/26/02       */
/*        Change Label to start with character           */
/*                                                       */
/*   SBN: Add                           July/28/02       */
/*        New definition to work with current BIOS code  */
/*        Update HPI HW change address 0x120-0x122       */
/*                                                       */
/*   SBN: Copy SPI/HPI/IDE definition from sys_memmap.cds*/
/*   SBN: Add HSS definition from sys_memmap.cds         */
/*                                                       */
/* DESCRIPTION : This file contains the register and     */
/*               field definitions for the CY7C63700.    */
/*                                                       */
/* NOTICE      : This file is provided as-is for         */
/*               reference purposes only. No warranty is */
/*               made as to functionality or suitability */
/*               for any particular purpose or           */
/*               application.                            */
/*                                                       */
/* COPYRIGHT 2002, CYPRESS SEMICONDUCTOR CORP.           */
/*********************************************************/

/*********************************************************/
/* REGISTER/FIELD NAMING CONVENTIONS                     */
/*********************************************************/
/*                                                       */
/* Fieldss can be considered either:                     */
/* (a) BOOLEAN (1 or 0, On or Off, True or False) or     */
/* (b) BINARY (Numeric value)                            */
/*                                                       */
/* Multiple-bit fields contain numeric values only.      */
/*                                                       */
/* Boolean fields are identified by the _EN suffix?      */
/*                                                       */
/* Binary fields are defined by the field name. In       */
/* addition, all legal values for the binary field are   */
/* identified.                                           */
/*                                                       */
/* Either ALL register names should include REG as part  */
/* of the label or NO register names should include REG  */
/* as part of the label.                                 */
/*                                                       */
/* Certain nomenclature is applied universally within    */
/* this file. Commonly applied abbreviations include:    */
/*                                                       */
/*  EN      Enable                                       */
/*  DIS     Disable                                      */
/*  SEL     Select                                       */
/*  FLG     Flag                                         */
/*  STB     Strobe                                       */
/*                                                       */
/*  ADDR    Address                                      */
/*  CTL     Control                                      */
/*  CNTRL   Control                                      */
/*  CFG     Config                                       */
/*  RST     Reset                                        */
/*  BFR     Buffer                                       */
/*  REG     Register                                     */
/*  SIE     Serial Interface Engine                      */
/*  DEV     Device                                       */
/*  HOST    Host                                         */
/*  EP      Endpoint                                     */
/*  IRQ     Interrupt                                    */
/*  BKPT    Breakpoint                                   */
/*  STAT    Status                                       */
/*  CNT     Count                                        */
/*  CTR     Counter                                      */
/*  TMR     Timer                                        */
/*  MAX     Maximum                                      */
/*  MIN     Minimum                                      */
/*  POL     Polarity                                     */
/*  BLK     Block                                        */
/*  WDT     Watchdog Timer                               */
/*  RX      Receive                                      */
/*  RXD     Received                                     */
/*  TX      Transmit                                     */
/*  TXD     Transmitted                                  */
/*  ACK     Acknowledge                                  */
/*  ACKD    Acknowledged                                 */
/*  MBX     Mailbox                                      */
/*  CLR     Clear                                        */
/*  bm      Bit Mask  (prefix)                           */
/*  XRAM    External RAM                                 */
/*                                                       */
/*********************************************************/

/*********************************************************/
/* REGISTER SUMMARY                                      */
/*********************************************************/
/*                                                       */
/* PROC_FLAGS_REG                                        */
/* REG_BANK_REG                                          */
/* HW_REV_REG                                            */
/* IRQ_EN_REG                                            */
/* CPU_SPEED_REG                                         */
/* POWER_CTL_REG                                         */
/* BKPT_REG                                              */
/* USB_DIAG_REG                                          */
/* MEM_DIAG_REG                                          */
/*                                                       */
/* PGn_MAP_REG                                           */
/* DRAM_CTL_REG                                          */
/* XMEM_CTL_REG                                          */
/*                                                       */
/* WDT_REG                                               */
/* TMRn_REG                                              */
/*                                                       */
/* USBn_CTL_REG                                          */
/*                                                       */
/* HOSTn_IRQ_EN_REG                                      */
/* HOSTn_STAT_REG                                        */
/* HOSTn_CTL_REG                                         */
/* HOSTn_ADDR_REG                                        */
/* HOSTn_CNT_REG                                         */
/* HOSTn_PID_REG                                         */
/* HOSTn_EP_STAT_REG                                     */
/* HOSTn_DEV_ADDR_REG                                    */
/* HOSTn_CTR_REG                                         */
/* HOSTn_SOF_EOP_CNT_REG                                 */
/* HOSTn_SOF_EOP_CTR_REG                                 */
/* HOSTn_FRAME_REG                                       */
/*                                                       */
/* DEVn_IRQ_EN_REG                                       */
/* DEVn_STAT_REG                                         */
/* DEVn_ADDR_REG                                         */
/* DEVn_FRAME_REG                                        */
/* DEVn_EPn_CTL_REG                                      */
/* DEVn_EPn_ADDR_REG                                     */
/* DEVn_EPn_CNT_REG                                      */
/* DEVn_EPn_STAT_REG                                     */
/* DEVn_EPn_CTR_REG                                      */
/*                                                       */
/* OTG_CTL_REG                                           */
/*                                                       */
/* GPIO_CTL_REG                                          */
/* GPIOn_OUT_DATA_REG                                    */
/* GPIOn_IN_DATA_REG                                     */
/* GPIOn_DIR_REG                                         */
/*                                                       */
/* EPP_CTL_REG                                           */
/* EPP_DATA_REG                                          */
/* EPP_BFR_READ_REG                                      */
/* EPP_ADDR_REG                                          */
/*                                                       */
/* IDE_MODE_REG                                          */
/* IDE_START_ADDR_REG                                    */
/* IDE_STOP_ADDR_REG                                     */
/* IDE_CTL_REG                                           */
/* IDE_PIO_DATA_REG                                      */
/* IDE_PIO_ERR_REG                                       */
/* IDE_PIO_SECT_CNT_REG                                  */
/* IDE_PIO_SECT_NUM_REG                                  */
/* IDE_PIO_CYL_LO_REG                                    */
/* IDE_PIO_CYL_HI_REG                                    */
/* IDE_PIO_DEV_HD_REG                                    */
/* IDE_PIO_CMD_REG                                       */
/* IDE_PIO_DEV_CTL_REG                                   */
/*                                                       */
/* MDMA_MODE_REG                                         */
/* MDMA_START_ADDR_REG                                   */
/* MDMA_STOP_ADDR_REG                                    */
/* MDMA_CTL_REG                                          */
/*                                                       */
/* HSS_CTL_REG                                           */
/* HSS_BAUD_REG                                          */
/* HSS_TX_GAP_REG                                        */
/* HSS_DATA_REG                                          */
/* HSS_RX_ADDR_REG                                       */
/* HSS_RX_CTR_REG                                        */
/* HSS_TX_ADDR_REG                                       */
/* HSS_TX_CTR_REG                                        */
/*                                                       */
/* SPI_CFG_REG                                           */
/* SPI_CTL_REG                                           */
/* SPI_IRQ_EN_REG                                        */
/* SPI_STAT_REG                                          */
/* SPI_IRQ_CLR_REG                                       */
/* SPI_CRC_CTL_REG                                       */
/* SPI_CRC_VALUE_REG                                     */
/* SPI_DATA_REG                                          */
/* SPI_TX_ADDR_REG                                       */
/* SPI_TX_CNT_REG                                        */
/* SPI_RX_ADDR_REG                                       */
/* SPI_RX_CNT_REG                                        */
/*                                                       */
/* UART_CTL_REG                                          */
/* UART_STAT_REG                                         */
/* UART_DATA_REG                                         */
/*                                                       */
/* PWM_CTL_REG                                           */
/* PWM_MAX_CNT_REG                                       */
/* PWMn_START_REG                                        */
/* PWMn_STOP_REG                                         */
/* PWM_CYCLE_CNT_REG                                     */
/*                                                       */
/* HPI_MBX_REG                                           */
/* HPI_BKPT_REG                                          */
/* IRQ_ROUTING_REG                                       */
/*                                                       */
/* HPI_DATA_PORT                                         */
/* HPI_ADDR_PORT                                         */
/* HPI_MBX_PORT                                          */
/* HPI_STAT_PORT                                         */
/*                                                       */
/*********************************************************/

/*********************************************************/
/*********************************************************/
/* CPU REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* CPU FLAGS REGISTER [R]                                */
/*********************************************************/
#define CPU_FLAGS_REG                                        0xC000 /* CPU Flags Register [R] */
#define flags                                                0xC000

/* FIELDS */

#define GLOBAL_IRQ_EN                                        0x0010 /* Global Interrupt Enable */
#define NEG_FLG                                              0x0008 /* Negative Sign Flag */
#define OVF_FLG                                              0x0004 /* Overflow Flag */
#define CARRY_FLG                                            0x0002 /* Carry/Borrow Flag */
#define ZER0_FLG                                             0x0001 /* Zero Flag */

/*********************************************************/
/* BANK REGISTER [R/W]                                   */
/*********************************************************/

#define BANK_REG                                             0xC002 /* Bank Register [R/W] */
#define regbuf                                               0xC002 /* alias for BIOS code */

#define BANK                                                 0xFFE0 /* Bank */

/*********************************************************/
/* HARDWARE REVISION REGISTER [R]                        */
/*********************************************************/
/* First Silicon Revision is 0x0101. Revision number     */
/* will be incremented by one for each revision change.  */
/*********************************************************/

#define HW_REV_REG                                           0xC004 /* Hardware Revision Register [R] */

/*********************************************************/
/* INTERRUPT ENABLE REGISTER [R/W]                       */
/*********************************************************/

#define IRQ_EN_REG                                           0xC00E /* Interrupt Enable Register [R/W] */
#define intenb                                               0xC00E /* Alias for BIOS code */
#define INT_EN_REG                                           0xC00E /* BIOS Interrupt Enable Register Alias */

/* FIELDS */

#define OTG_IRQ_EN                                           0x1000 /* OTG Interrupt Enable */
#define SPI_IRQ_EN                                           0x0800 /* SPI Interrupt Enable */
#define HOST2_IRQ_EN                                         0x0200 /* Host 2 Interrupt Enable */
#define DEV2_IRQ_EN                                          0x0200 /* Device 2 Interrupt Enable */
#define HOST1_IRQ_EN                                         0x0100 /* Host 1 Interrupt Enable */
#define DEV1_IRQ_EN                                          0x0100 /* Device 1 Interrupt Enable */
#define HSS_IRQ_EN                                           0x0080 /* HSS Interrupt Enable */
#define IN_MBX_IRQ_EN                                        0x0040 /* In Mailbox Interrupt Enable */
#define OUT_MBX_IRQ_EN                                       0x0020 /* Out Mailbox Interrupt Enable */
#define DMA_IRQ_EN                                           0x0010 /* DMA Interrupt Enable */
#define UART_IRQ_EN                                          0x0008 /* UART Interrupt Enable */
#define GPIO_IRQ_EN                                          0x0004 /* GPIO Interrupt Enable */
#define TMR1_IRQ_EN                                          0x0002 /* Timer 1 Interrupt Enable */
#define TMR0_IRQ_EN                                          0x0001 /* Timer 0 Interrupt Enable */

/*  Alias bit mask definition for register IRQ_EN_REG */
#define bmINT_EN_TM0                                         0x0001
#define bmINT_EN_TM1                                         0x0002
#define bmINT_EN_GPIO                                        0x0004
#define bmINT_EN_UART                                        0x0008
#define bmINT_EN_DMA                                         0x0010
#define bmINT_EN_MBX_OUT                                     0x0020
#define bmINT_EN_MBX_IN                                      0x0040
#define bmINT_EN_HSP                                         0x0080
#define bmINT_EN_SIE1                                        0x0100
#define bmINT_EN_SIE2                                        0x0200
#define bmINT_EN_SPI                                         0x0800
#define bmINT_EN_OTG                                         0x1000

/* another define from sys_memmap */
#define GIO_IntCtl_MSK                                       0x0000
#define GIO_IntCtl_IRQ0En_BIT                                0x0000
#define GIO_IntCtl_IRQ0En_BM                                 0x0001
#define GIO_IntCtl_IRQ0Pol_BIT                               0x0001
#define GIO_IntCtl_IRQ0Pol_BM                                0x0002
#define GIO_IntCtl_IRQ1En_BIT                                0x0002
#define GIO_IntCtl_IRQ1En_BM                                 0x0004
#define GIO_IntCtl_IRQ1Pol_BIT                               0x0003
#define GIO_IntCtl_IRQ1Pol_BM                                0x0008
#define GIO_IntCtl_SX_BIT                                    0x0004
#define GIO_IntCtl_SX_BM                                     0x0010
#define GIO_IntCtl_SG_BIT                                    0x0005
#define GIO_IntCtl_SG_BM                                     0x0020
#define GIO_IntCtl_HX_BIT                                    0x0006
#define GIO_IntCtl_HX_BM                                     0x0040
#define GIO_IntCtl_HG_BIT                                    0x0007
#define GIO_IntCtl_HG_BM                                     0x0080

#define GIO_IntCtl_Mode_POS                                  0x0008
#define GIO_IntCtl_Mode_SIZ                                  0x0003
#define GIO_IntCtl_Mode_GPIO                                 0x0000
#define GIO_IntCtl_Mode_GPIObm                               0x0000
#define GIO_IntCtl_Mode_Flash                                0x0001
#define GIO_IntCtl_Mode_Flashbm                              0x0100
#define GIO_IntCtl_Mode_EPP                                  0x0002
#define GIO_IntCtl_Mode_EPPbm                                0x0200
#define GIO_IntCtl_Mode_SLV                                  0x0003
#define GIO_IntCtl_Mode_SLVbm                                0x0300
#define GIO_IntCtl_Mode_IDE                                  0x0004
#define GIO_IntCtl_Mode_IDEbm                                0x0400
#define GIO_IntCtl_Mode_HPI                                  0x0005
#define GIO_IntCtl_Mode_HPIbm                                0x0500
#define GIO_IntCtl_Mode_SCAN                                 0x0006
#define GIO_IntCtl_Mode_SCANbm                               0x0600
#define GIO_IntCtl_Mode_MDiag                                0x0007
#define GIO_IntCtl_Mode_MDiagbm                              0x0700

#define GIO_IntCtl_Bond_POS                                  0x000B
#define GIO_IntCtl_Bond_SIZ                                  0x0002
#define GIO_IntCtl_Bond_Embed                                0x0000
#define GIO_IntCtl_Bond_Embedbm                              0x0000
#define GIO_IntCtl_Bond_Flash                                0x0001
#define GIO_IntCtl_Bond_Flashbm                              0x0800
#define GIO_IntCtl_Bond_Mobile                               0x0002
#define GIO_IntCtl_Bond_Mobilebm                             0x1000

#define GIO_IntCtl_MD_BIT                                    0x000F

#define INT_Enable_T0_BIT                                    0x0000
#define INT_Enable_T0_BM                                     0x0001
#define INT_Enable_T1_BIT                                    0x0001
#define INT_Enable_T1_BM                                     0x0002
#define INT_Enable_GP_BIT                                    0x0002
#define INT_Enable_GP_BM                                     0x0004
#define INT_Enable_UART_BIT                                  0x0003
#define INT_Enable_UART_BM                                   0x0008
#define INT_Enable_FDMA_BIT                                  0x0004
#define INT_Enable_FDMA_BM                                   0x0010
#define INT_Enable_MBX_BIT                                   0x0006
#define INT_Enable_MBX_BM                                    0x0040
#define INT_Enable_HSS_BIT                                   0x0007
#define INT_Enable_HSS_BM                                    0x0080
#define INT_Enable_SIE1_BIT                                  0x0008
#define INT_Enable_SIE1_BM                                   0x0100
#define INT_Enable_SIE2_BIT                                  0x0009
#define INT_Enable_SIE2_BM                                   0x0200
#define INT_Enable_SPI_BIT                                   0x000B
#define INT_Enable_SPI_BM                                    0x0800

/*********************************************************/
/* CPU SPEED REGISTER [R/W]                              */
/*********************************************************/

#define CPU_SPEED_REG                                        0xC008 /* CPU Speed Register [R/W] */
#define P_SPEED                                              0xC008 /* Alias for BIOS code */

/* CPU SPEED REGISTER FIELDS 
**
** The Speed field in the CPU Speed Register provides a mechanism to
** divide the external clock signal down to operate the CPU at a lower 
** clock speed (presumedly for lower-power operation). The value loaded 
** into this field is a divisor and is calculated as (n+1). For instance, 
** if 3 is loaded into the field, the resulting CPU speed will be PCLK/4.
*/

#define CPU_SPEED                                            0x000F /* CPU Speed */

/*********************************************************/
/* POWER CONTROL REGISTER [R/W]                          */
/*********************************************************/

#define POWER_CTL_REG                                        0xC00A /* Power Control Register [R/W] */

/* FIELDS */

#define HOST2_WAKE_EN                                        0x4000 /* Host 2 Wake Enable */
#define DEV2_WAKE_EN                                         0x4000 /* Device 2 Wake Enable */
#define HOST1_WAKE_EN                                        0x1000 /* Host 1 Wake Enable */
#define DEV1_WAKE_EN                                         0x1000 /* Device 1 Wake Enable */
#define OTG_WAKE_EN                                          0x0800 /* OTG Wake Enable  */
#define HSS_WAKE_EN                                          0x0200 /* HSS Wake Enable  */
#define SPI_WAKE_EN                                          0x0100 /* SPI Wake Enable  */
#define HPI_WAKE_EN                                          0x0080 /* HPI Wake Enable  */
#define GPIO_WAKE_EN                                         0x0010 /* GPIO Wake Enable  */
#define SLEEP_EN                                             0x0002 /* Sleep Enable */
#define HALT_EN                                              0x0001 /* Halt Enable */

/*********************************************************/
/* BREAKPOINT REGISTER [R/W]                             */
/*********************************************************/

#define BKPT_REG                                             0xC014 /* Breakpoint Register [R/W] */

/*********************************************************/
/* USB DIAGNOSTIC REGISTER [W]                           */
/*********************************************************/

#define USB_DIAG_REG                                         0xC03C /* USB Diagnostic Register [R/W] */

/* FIELDS */

#define c2B_DIAG_EN                                          0x8000 /* Port 2B Diagnostic Enable */
#define c2A_DIAG_EN                                          0x4000 /* Port 2A Diagnostic Enable */
#define c1B_DIAG_EN                                          0x2000 /* Port 1B Diagnostic Enable */
#define c1A_DIAG_EN                                          0x1000 /* Port 1A Diagnostic Enable */
#define PULLDOWN_EN                                          0x0040 /* Pull-down resistors enable */
#define LS_PULLUP_EN                                         0x0020 /* Low-speed pull-up resistor enable */
#define FS_PULLUP_EN                                         0x0010 /* Full-speed pull-up resistor enable */
#define FORCE_SEL                                            0x0007 /* Control D+/- lines */

/* FORCE FIELD VALUES */

#define ASSERT_SE0                                           0x0004 /* Assert SE0 on selected ports */
#define TOGGLE_JK                                            0x0002 /* Toggle JK state on selected ports */
#define ASSERT_J                                             0x0001 /* Assert J state on selected ports */
#define ASSERT_K                                             0x0000 /* Assert K state on selected ports */

/*********************************************************/
/* MEMORY DIAGNOSTIC REGISTER [W]                        */
/*********************************************************/

#define MEM_DIAG_REG                                         0xC03E /* Memory Diagnostic Register [W] */

/* FIELDS */

#define FAST_REFRESH_EN                                      0x8000 /* Fast Refresh Enable (15x acceleration) */
#define MEM_ARB_SEL                                          0x0700 /* Memory Arbitration */
#define MONITOR_EN                                           0x0001 /* Monitor Enable (Echoes internal address bus externally) */

/* MEMORY ARBITRATION SELECT FIELD VALUES */
#define MEM_ARB_7                                            0x0700 /* Number of dead cycles out of 8 possible */
#define MEM_ARB_6                                            0x0600 /* Should not use any cycle >= 6 */
#define MEM_ARB_5                                            0x0500 /*  */
#define MEM_ARB_4                                            0x0400 /* */
#define MEM_ARB_3                                            0x0300 /* */
#define MEM_ARB_2                                            0x0200 /* */
#define MEM_ARB_1                                            0x0100 /*  */
#define MEM_ARB_0                                            0x0000 /* Power up default */

/*********************************************************/
/* EXTENDED PAGE n MAP REGISTER [R/W]                    */
/*********************************************************/

#define PG1_MAP_REG                                          0xC018 /* Page 1 Map Register [R/W] */
#define PG2_MAP_REG                                          0xC01A /* Page 2 Map Register [R/W] */

/*********************************************************/
/* DRAM CONTROL REGISTER [R/W]                           */
/*********************************************************/

#define DRAM_CTL_REG                                         0xC038 /* DRAM Control Register [R/W] */

/* FIELDS */

#define DRAM_DIS                                             0x0008 /* DRAM Disable */
#define TURBO_EN                                             0x0004 /* Turbo Mode */
#define PAGE_MODE_EN                                         0x0002 /* Page Mode */
#define REFRESH_EN                                           0x0001 /* Refresh  */

/*********************************************************/
/* EXTERNAL MEMORY CONTROL REGISTER [R/W]                */
/*********************************************************/

#define XMEM_CTL_REG                                         0xC03A /* External Memory Control Register [R/W] */
#define X_MEM_CNTRL                                          0xC03A /* Alias for BIOS code */

#define XRAM_BEGIN                                           0x4000 /* External SRAM begin */
#define XROM_BEGIN                                           0xC100 /* External ROM Begin */
#define IROM_BEGIN                                           0xE000 /* Internal ROM Begin */


/* FIELDS */
#define XRAM_MERGE_EN                                        0x2000 /* Overlay XRAMSEL w/ XMEMSEL */
#define XROM_MERGE_EN                                        0x1000 /* Overlay XROMSEL w/ XMEMSEL */
#define XMEM_WIDTH_SEL                                       0x0800 /* External MEM Width Select */
#define XMEM_WAIT_SEL                                        0x0700 /* Number of Extended Memory wait states (0-7) */
#define XROM_WIDTH_SEL                                       0x0080 /* External ROM Width Select */
#define XROM_WAIT_SEL                                        0x0070 /* Number of External ROM wait states (0-7) */
#define XRAM_WIDTH_SEL                                       0x0008 /* External RAM Width Select */
#define XRAM_WAIT_SEL                                        0x0007 /* Number of External RAM wait states (0-7) */

/* XMEM_WIDTH FIELD VALUES */

#define XMEM_8                                               0x0800 /*  */
#define XMEM_16                                              0x0000 /*  */

/* XRAM_WIDTH FIELD VALUES */

#define XROM_8                                               0x0080 /*  */
#define XROM_16                                              0x0000 /*  */

/* XRAM_WIDTH FIELD VALUES */

#define XRAM_8                                               0x0008 /*  */
#define XRAM_16                                              0x0000 /*  */


/*********************************************************/
/* WATCHDOG TIMER REGISTER [R/W]                         */
/*********************************************************/

#define WDT_REG                                              0xC00C /* Watchdog Timer Register [R/W] */

/* FIELDS */

#define WDT_TIMEOUT_FLG                                      0x0020 /* WDT timeout flag */
#define WDT_PERIOD_SEL                                       0x0018 /* WDT period select (options below) */
#define WDT_LOCK_EN                                          0x0004 /* WDT enable */
#define WDT_EN                                               0x0002 /* WDT lock enable */
#define WDT_RST_STB                                          0x0001 /* WDT reset Strobe */

/* WATCHDOG PERIOD FIELD VALUES */

#define WDT_64MS                                             0x0003 /* 64.38 ms */
#define WDT_21MS                                             0x0002 /* 21.68 ms */
#define WDT_5MS                                              0x0001 /* 5.67 ms */
#define WDT_1MS                                              0x0000 /* 1.67 ms */

/*********************************************************/
/* TIMER n REGISTER [R/W]                                */
/*********************************************************/

#define TMR0_REG                                             0xC010 /* Timer 0 Register [R/W] */
#define TIMER_0                                              0xC010 /* Alias for BIOS code */
#define TMR1_REG                                             0xC012 /* Timer 1 Register [R/W] */
#define TIMER_1                                              0xC012 /* Alias for BIOS code */

/*********************************************************/
/*********************************************************/
/* USB REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* USB n CONTROL REGISTERS [R/W]                         */
/*********************************************************/

#define USB1_CTL_REG                                         0xC08A /* USB 1 Control Register [R/W] */
#define SIE1_USB_CONTROL                                     0xC08A

#define USB2_CTL_REG                                         0xC0AA /* USB 2 Control Register [R/W] */
#define SIE2_USB_CONTROL                                     0xC0AA

/* FIELDS */
#define B_DP_STAT                                            0x8000 /* Port B D+ status */
#define B_DM_STAT                                            0x4000 /* Port B D- status */
#define A_DP_STAT                                            0x2000 /* Port A D+ status */
#define A_DM_STAT                                            0x1000 /* Port A D- status */
#define B_SPEED_SEL                                          0x0800 /* Port B Speed select (See below) */
#define A_SPEED_SEL                                          0x0400 /* Port A Speed select (See below) */
#define MODE_SEL                                             0x0200 /* Mode (See below) */
#define B_RES_EN                                             0x0100 /* Port B Resistors enable */
#define A_RES_EN                                             0x0080 /* Port A Resistors enable */
#define B_FORCE_SEL                                          0x0060 /* Port B Force D+/- state (See below) */
#define A_FORCE_SEL                                          0x0018 /* Port A Force D+/- state (See below) */
#define SUSP_EN                                              0x0004 /* Suspend enable */
#define B_SOF_EOP_EN                                         0x0002 /* Port B SOF/EOP enable */
#define A_SOF_EOP_EN                                         0x0001 /* Port A SOF/EOP enable */


/* USB Control Register1 (0xC08A/0xC0AA) bit mask         */
#define bmHOST_CTL1_SOF0                                     0x0001
#define bmHOST_CTL1_SOF1                                     0x0002
#define bmHOST_CTL1_SUSPEND                                  0x0004
#define bmHOST_CTL1_JKState0                                 0x0008
#define bmHOST_CTL1_USBReset0                                0x0010
#define bmHOST_CTL1_JKState1                                 0x0020
#define bmHOST_CTL1_USBReset1                                0x0040
#define bmHOST_CTL1_UD0                                      0x0080
#define bmHOST_CTL1_UD1                                      0x0100
#define bmHOST_CTL1_HOST                                     0x0200
#define bmHOST_CTL1_LOA                                      0x0400
#define bmHOST_CTL1_LOB                                      0x0800
#define bmHOST_CTL1_D0m                                      0x1000
#define bmHOST_CTL1_D0p                                      0x2000
#define bmHOST_CTL1_D1m                                      0x4000
#define bmHOST_CTL1_D1p                                      0x8000


/* MODE FIELD VALUES */

#define HOST_MODE                                            0x0200 /* Host mode */
#define DEVICE_MODE                                          0x0000 /* Device mode */

/* p_SPEED SELECT FIELD VALUES */

#define LOW_SPEED                                            0xFFFF /* Low speed */
#define FULL_SPEED                                           0x0000 /* Full speed */

#define B_SPEED_LOW                                          0x0800
#define B_SPEED_FULL                                         0x0000
#define A_SPEED_LOW                                          0x0400
#define A_SPEED_FULL                                         0x0000

/* FORCEn FIELD VALUES */

#define FORCE_K                                              0x0078 /* Force K state on associated port */
#define FORCE_SE0                                            0x0050 /* Force SE0 state on associated port */
#define FORCE_J                                              0x0028 /* Force J state on associated port */
#define FORCE_NORMAL                                         0x0000 /* Don't force associated port */

#define A_FORCE_K                                            0x0018 /* Force K state on A port */
#define A_FORCE_SE0                                          0x0010 /* Force SE0 state on associated port */
#define A_FORCE_J                                            0x0008 /* Force J state on associated port */
#define A_FORCE_NORMAL                                       0x0000 /* Don't force associated port */

#define B_FORCE_K                                            0x0060 /* Force K state on associated port */
#define B_FORCE_SE0                                          0x0040 /* Force SE0 state on associated port */
#define B_FORCE_J                                            0x0020 /* Force J state on associated port */
#define B_FORCE_NORMAL                                       0x0000 /* Don't force associated port */


/*********************************************************/
/*********************************************************/
/* HOST REGISTERS                                        */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* HOST n INTERRUPT ENABLE REGISTER [R/W]                */
/*********************************************************/

#define HOST1_IRQ_EN_REG                                     0xC08C /* Host 1 Interrupt Enable Register [R/W] */
#define SIE1_INT_EN_REG                                      0xC08C

#define HOST2_IRQ_EN_REG                                     0xC0AC /* Host 2 Interrupt Enable Register [R/W] */
#define SIE2_INT_EN_REG                                      0xC0AC

/* FIELDS */

#define VBUS_IRQ_EN                                          0x8000 /* VBUS Interrupt Enable (Available on HOST1 only)  */
#define ID_IRQ_EN                                            0x4000 /* ID Interrupt Enable (Available on HOST1 only) */
#define SOF_EOP_IRQ_EN                                       0x0200 /* SOF/EOP Interrupt Enable  */
#define B_WAKE_IRQ_EN                                        0x0080 /* Port B Wake Interrupt Enable  */
#define A_WAKE_IRQ_EN                                        0x0040 /* Port A Wake Interrupt Enable  */
#define B_CHG_IRQ_EN                                         0x0020 /* Port B Connect Change Interrupt Enable  */
#define A_CHG_IRQ_EN                                         0x0010 /* Port A Connect Change Interrupt Enable  */
#define DONE_IRQ_EN                                          0x0001 /* Done Interrupt Enable  */


/* Host Interrupt enable (0xC08C/0xC0AC)  bit mask      */
#define bmHOST_INTEN_XFERDONE                                0x0001
#define bmHOST_INTEN_INSRMV0                                 0x0010
#define bmHOST_INTEN_INSRMV1                                 0x0020
#define bmHOST_INTEN_WAKEUP0                                 0x0040
#define bmHOST_INTEN_WAKEUP1                                 0x0080
#define bmHOST_INTEN_SOFINTR                                 0x0200
#define bmHOST_INTEN_IEXP                                    0x0400
#define bmHOST_INTEN_OTG_ID                                  0x4000
#define bmHOST_INTEN_OTG_44V                                 0x8000



/*********************************************************/
/* HOST n STATUS REGISTER [R/W]                          */
/*********************************************************/
/* In order to clear status for a particular IRQ bit,    */
/* write a '1' to that bit location.                     */
/*********************************************************/

#define HOST1_STAT_REG                                       0xC090 /* Host 1 Status Register [R/W] */
#define SIE1_INT_STATUS_REG                                  0xC090

#define HOST2_STAT_REG                                       0xC0B0 /* Host 2 Status Register [R/W] */
#define SIE2_INT_STATUS_REG                                  0xC0B0

/* FIELDS */

#define VBUS_IRQ_FLG                                         0x8000 /* VBUS Interrupt Request (HOST1 only) */
#define ID_IRQ_FLG                                           0x4000 /* ID Interrupt Request (HOST1 only) */

#define SOF_EOP_IRQ_FLG                                      0x0200 /* SOF/EOP Interrupt Request  */
#define B_WAKE_IRQ_FLG                                       0x0080 /* Port B Wake Interrupt Request  */
#define A_WAKE_IRQ_FLG                                       0x0040 /* Port A Wake Interrupt Request  */
#define B_CHG_IRQ_FLG                                        0x0020 /* Port B Connect Change Interrupt Request  */
#define A_CHG_IRQ_FLG                                        0x0010 /* Port A Connect Change Interrupt Request  */
#define B_SE0_STAT                                           0x0008 /* Port B SE0 status */
#define A_SE0_STAT                                           0x0004 /* Port A SE0 status */
#define DONE_IRQ_FLG                                         0x0001 /* Done Interrupt Request  */

/* Host interrupt status register (0xC090/0xC0B0) bit mask */
#define bmHOST_INT_XFERDONE                                  0x0001
#define bmHOST_INT_USBRST0                                   0x0004
#define bmHOST_INT_USBRST1                                   0x0008
#define bmHOST_INT_INSRMV0                                   0x0010
#define bmHOST_INT_INSRMV1                                   0x0020
#define bmHOST_INT_WAKEUP0                                   0x0040
#define bmHOST_INT_WAKEUP1                                   0x0080
#define bmHOST_INT_SOFINTR                                   0x0200
#define bmHOST_INT_OTG_ID                                    0x4000
#define bmHOST_INT_OTG_44V                                   0x8000

/*********************************************************/
/* HOST n CONTROL REGISTERS [R/W]                        */
/*********************************************************/

#define HOST1_CTL_REG                                        0xC080 /* Host 1 Control Register [R/W] */
#define SIE1_USB_CTRL_REG0                                   0xC080
#define SIE1_REG_BASE                                        0xC080 /* Alias for susb.asm */


#define HOST2_CTL_REG                                        0xC0A0 /* Host 2 Control Register [R/W] */
#define SIE2_USB_CTRL_REG0                                   0xC0A0
#define SIE2_REG_BASE                                        0xC0A0 /* Alias for susb.asm */


/* FIELDS */
#define PREAMBLE_EN                                          0x0080 /* Preamble enable */
#define SEQ_SEL                                              0x0040 /* Data Toggle Sequence Bit Select (Write next/read last) */
#define SYNC_EN                                              0x0020 /* (1:Send next packet at SOF/EOP, 0: Send next packet immediately) */
#define ISO_EN                                               0x0010 /* Isochronous enable  */
#define TIMEOUT_SEL                                          0x0008 /* Timeout select (1:22 bit times, 0:18 bit times) */
#define DIR_SEL                                              0x0004 /* Transfer direction (1:OUT, 0:IN) */
#define EN                                                   0x0002 /* Enable operation */
#define ARM_EN                                               0x0001 /* Arm operation */
#define BSY_FLG                                              0x0001 /* Busy flag */

/* Use in the 0xc080 and 0xc0a0 */
#define bmHOST_HCTL_ARM                                      0x0001
#define bmHOST_HCTL_ISOCH                                    0x0010
#define bmHOST_HCTL_AFTERSOF                                 0x0020
#define bmHOST_HCTL_DT                                       0x0040
#define bmHOST_HCTL_PREAMBLE                                 0x0080


/*********************************************************/
/* HOST n ADDRESS REGISTERS [R/W]                        */
/*********************************************************/

#define HOST1_ADDR_REG                                       0xC082 /* Host 1 Address Register [R/W] */
#define SIE1_USB_BASE_ADDR                                   0xC082

#define HOST2_ADDR_REG                                       0xC0A2 /* Host 2 Address Register [R/W] */
#define SIE2_USB_BASE_ADDR                                   0xC0A2

/*********************************************************/
/* HOST n COUNT REGISTERS [R/W]                          */
/*********************************************************/

#define HOST1_CNT_REG                                        0xC084 /* Host 1 Count Register [R/W] */
#define SIE1_USB_LENGTH                                      0xC084


#define HOST2_CNT_REG                                        0xC0A4 /* Host 2 Count Register [R/W] */
#define SIE2_USB_LENGTH                                      0xC0A4

/* FIELDS */
#define PORT_SEL                                             0x4000 /* Port Select (1:PortB, 0:PortA) */
#define HOST_CNT                                             0x03FF /* Host Count */

/* Base Length register (0xC084/0xC0A4)bit mask          */
#define bmHOST_PORT_SEL                                      0x4000

/*********************************************************/
/* HOST n PID REGISTERS [W]                              */
/*********************************************************/

#define HOST1_PID_REG                                        0xC086 /* Host 1 PID Register [W] */
#define SIE1_USB_HOST_PID                                    0xC086
#define SIE1_USB_ERR_STATUS                                  0xC086 /* When read */


#define HOST2_PID_REG                                        0xC0A6 /* Host 2 PID Register [W] */
#define SIE2_USB_HOST_PID                                    0xC0A6
#define SIE2_USB_ERR_STATUS                                  0xC0A6 /* When read */

/* Packet status register (0xC086/0xC0A6)bit mask       */
#define bmHOST_STATMASK_ACK                                  0x0001
#define bmHOST_STATMASK_ERROR                                0x0002
#define bmHOST_STATMASK_TMOUT                                0x0004
#define bmHOST_STATMASK_SEQ                                  0x0008
#define bmHOST_STATMASK_SETUP                                0x0010
#define bmHOST_STATMASK_OVF                                  0x0020
#define bmHOST_STATMASK_NAK                                  0x0040
#define bmHOST_STATMASK_STALL                                0x0080

/* FIELDS */
#define PID_SEL                                              0x00F0 /* Packet ID (see below) */
#define EP_SEL                                               0x000F /* Endpoint number */

/* PID FIELD VALUES */
#define SETUP_PID                                            0x000D /* SETUP */
#define IN_PID                                               0x0009 /* IN */
#define OUT_PID                                              0x0001 /* OUT */
#define SOF_PID                                              0x0005 /* SOF */
#define PRE_PID                                              0x000C /* PRE */
#define NAK_PID                                              0x000A /* NAK */
#define STALL_PID                                            0x000E /* STALL */
#define DATA0_PID                                            0x0003 /* DATA0 */
#define DATA1_PID                                            0x000B /* DATA1 */

/*********************************************************/
/* LYBERTY HOST Define value                             */
/*********************************************************/
#define cPortA                                               0x0000
#define cPortB                                               0x0001
#define cPortC                                               0x0002
#define cPortD                                               0x0003

#define cPID_SETUP                                           0x000D
#define cPID_IN                                              0x0009
#define cPID_OUT                                             0x0001
#define cPID_SOF                                             0x0005
#define cPID_PRE                                             0x000C
#define cPID_NAK                                             0x000A
#define cPID_STALL                                           0x000E
#define cPID_DATA0                                           0x0003
#define cPID_DATA1                                           0x000B
#define cPID_ACK                                             0x0002





/*********************************************************/
/* HOST n ENDPOINT STATUS REGISTERS [R]                  */
/*********************************************************/

#define HOST1_EP_STAT_REG                                    0xC086 /* Host 1 Endpoint Status Register [R] */
#define HOST2_EP_STAT_REG                                    0xC0A6 /* Host 2 Endpoint Status Register [R] */

/* FIELDS */

#define STALL_FLG                                            0x0080 /* Device returned STALL */
#define NAK_FLG                                              0x0040 /* Device returned NAK */
#define OVERFLOW_FLG                                         0x0020 /* Receive overflow */
#define SEQ_STAT                                             0x0008 /* Data Toggle value */
#define TIMEOUT_FLG                                          0x0004 /* Timeout occurred */
#define ERROR_FLG                                            0x0002 /* Error occurred */
#define ACK_FLG                                              0x0001 /* Transfer ACK'd        */

/*********************************************************/
/* HOST n DEVICE ADDRESS REGISTERS [W]                   */
/*********************************************************/

#define HOST1_DEV_ADDR_REG                                   0xC088 /* Host 1 Device Address Register [W] */
#define SIE1_USB_HOST_DEV                                    0xC088
#define SIE1_USB_LEFT_BYTE                                   0xC088 /* When read */


#define HOST2_DEV_ADDR_REG                                   0xC0A8 /* Host 2 Device Address Register [W] */
#define SIE2_USB_HOST_DEV                                    0xC0A8
#define SIE2_USB_LEFT_BYTE                                   0xC0A8 /* When read */


/* FIELDS */

#define DEV_ADDR                                             0x007F /* Device Address */

/*********************************************************/
/* HOST n COUNT RESULT REGISTERS [R]                     */
/*********************************************************/

#define HOST1_CTR_REG                                        0xC088 /* Host 1 Counter Register [R] */
#define HOST2_CTR_REG                                        0xC0A8 /* Host 2 Counter Register [R] */

/* FIELDS*/

#define HOST_RESULT                                          0x00FF /* Host Count Result */

/*********************************************************/
/* HOST n SOF/EOP COUNT REGISTER [R/W]                   */
/*********************************************************/

#define HOST1_SOF_EOP_CNT_REG                                0xC092 /* Host 1 SOF/EOP Count Register [R/W] */
#define SIE1_USB_SOF_COUNT                                   0xC092

#define HOST2_SOF_EOP_CNT_REG                                0xC0B2 /* Host 2 SOF/EOP Count Register [R/W] */
#define SIE2_USB_SOF_COUNT                                   0xC0B2

/* FIELDS */

#define SOF_EOP_CNT                                          0x3FFF /* SOF/EOP Count */

/*********************************************************/
/* HOST n SOF/EOP COUNTER REGISTER [R]                       */
/*********************************************************/

#define HOST1_SOF_EOP_CTR_REG                                0xC094 /* Host 1 SOF/EOP Counter Register [R] */
#define SIE1_USB_SOF_TIMER                                   0xC094


#define HOST2_SOF_EOP_CTR_REG                                0xC0B4 /* Host 2 SOF/EOP Counter Register [R] */
#define SIE2_USB_SOF_TIMER                                   0xC0B4

/* FIELDS */

#define SOF_EOP_CTR                                          0x3FFF /* SOF/EOP Counter */

/*********************************************************/
/* HOST n FRAME REGISTER [R]                             */
/*********************************************************/

#define HOST1_FRAME_REG                                      0xC096 /* Host 1 Frame Register [R] */
#define SIE1_USB_FRAME_NO                                    0xC096

#define HOST2_FRAME_REG                                      0xC0B6 /* Host 2 Frame Register [R] */
#define SIE2_USB_FRAME_NO                                    0xC0B6

/* FIELDS */

#define HOST_FRAME_NUM                                       0x07FF /* Frame */


/*********************************************************/
/*********************************************************/
/* DEVICE REGISTERS                                      */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* DEVICE n PORT SELECT REGISTERS [R/W]                  */
/*********************************************************/

#define DEV1_SEL_REG                                         0xC084 /* Device 1 Port Select Register [R/W] */
#define DEV2_SEL_REG                                         0xC0A4 /* Device 2 Port Select Register [R/W] */

/* FIELDS */

/*********************************************************/
/* DEVICE n INTERRUPT ENABLE REGISTER [R/W]              */
/*********************************************************/

#define DEV1_IRQ_EN_REG                                      0xC08C /* Device 1 Interrupt Enable Register [R/W] */
#define DEV2_IRQ_EN_REG                                      0xC0AC /* Device 2 Interrupt Enable Register [R/W] */

/* FIELDS */

/* Defined in Host Interrupt Enable Register */
/*#define VBUS_IRQ_EN         0x8000  // VBUS Interrupt Enable (DEV1 only)  */
/*#define ID_IRQ_EN           0x4000  // ID Interrupt Enable (DEV1 only) */

#define WAKE_IRQ_EN                                          0x0400 /* Wake Interrupt Enable  */
#define RST_IRQ_EN                                           0x0100 /* Reset Interrupt Enable  */
#define EP7_IRQ_EN                                           0x0080 /* EP7 Interrupt Enable  */
#define EP6_IRQ_EN                                           0x0040 /* EP6 Interrupt Enable  */
#define EP5_IRQ_EN                                           0x0020 /* EP5 Interrupt Enable  */
#define EP4_IRQ_EN                                           0x0010 /* EP4 Interrupt Enable  */
#define EP3_IRQ_EN                                           0x0008 /* EP3 Interrupt Enable  */
#define EP2_IRQ_EN                                           0x0004 /* EP2 Interrupt Enable  */
#define EP1_IRQ_EN                                           0x0002 /* EP1 Interrupt Enable  */
#define EP0_IRQ_EN                                           0x0001 /* EP0 Interrupt Enable  */

/*********************************************************/
/* DEVICE n STATUS REGISTER [R/W]                        */
/*********************************************************/
/* In order to clear status for a particular IRQ bit,    */
/* write a '1' to that bit location.                     */
/*********************************************************/

#define DEV1_STAT_REG                                        0xC090 /* Device 1 Status Register [R/W] */
#define DEV2_STAT_REG                                        0xC0B0 /* Device 2 Status Register [R/W] */

/* FIELDS */

/* Defined in Host Status Register */
/*#define VBUS_IRQ_FLG        0x8000  // VBUS Interrupt Request (DEV1 only) */
/*#define ID_IRQ_FLG          0x4000  // ID Interrupt Request (DEV1 only) */
/*#define SOF_EOP_IRQ_FLG     0x0200  // SOF/EOP Interrupt Request  */

#define WAKE_IRQ_FLG                                         0x0400 /* Wakeup Interrupt Request */
#define RST_IRQ_FLG                                          0x0100 /* Reset Interrupt Request */
#define EP7_IRQ_FLG                                          0x0080 /* EP7 Interrupt Request */
#define EP6_IRQ_FLG                                          0x0040 /* EP6 Interrupt Request */
#define EP5_IRQ_FLG                                          0x0020 /* EP5 Interrupt Request */
#define EP4_IRQ_FLG                                          0x0010 /* EP4 Interrupt Request */
#define EP3_IRQ_FLG                                          0x0008 /* EP3 Interrupt Request */
#define EP2_IRQ_FLG                                          0x0004 /* EP2 Interrupt Request */
#define EP1_IRQ_FLG                                          0x0002 /* EP1 Interrupt Request */
#define EP0_IRQ_FLG                                          0x0001 /* EP0 Interrupt Request */

/*********************************************************/
/* DEVICE n ADDRESS REGISTERS [R/W]                      */
/*********************************************************/

#define DEV1_ADDR_REG                                        0xC08E /* Device 1 Address Register [R/W] */
#define DEV2_ADDR_REG                                        0xC0AE /* Device 2 Address Register [R/W] */

/* FIELDS */

#define DEV_ADDR_SEL                                         0x007F /* Device Address */

/*********************************************************/
/* DEVICE n FRAME NUMBER REGISTER [R]                    */
/*********************************************************/

#define DEV1_FRAME_REG                                       0xC092 /* Device 1 Frame Register [R] */
#define DEV2_FRAME_REG                                       0xC0B2 /* Device 2 Frame Register [R] */

/* FIELDS */

#define DEV_FRAME_STAT                                       0x07FF /* Device Frame */

/*********************************************************/
/* DEVICE n ENDPOINT n CONTROL REGISTERS [R/W]           */
/*********************************************************/

#define DEV1_EP0_CTL_REG                                     0x0200 /* Device 1 Endpoint 0 Control Register [R/W] */
#define DEV1_EP1_CTL_REG                                     0x0210 /* Device 1 Endpoint 1 Control Register [R/W]       */
#define DEV1_EP2_CTL_REG                                     0x0220 /* Device 1 Endpoint 2 Control Register [R/W] */
#define DEV1_EP3_CTL_REG                                     0x0230 /* Device 1 Endpoint 3 Control Register [R/W] */
#define DEV1_EP4_CTL_REG                                     0x0240 /* Device 1 Endpoint 4 Control Register [R/W] */
#define DEV1_EP5_CTL_REG                                     0x0250 /* Device 1 Endpoint 5 Control Register [R/W] */
#define DEV1_EP6_CTL_REG                                     0x0260 /* Device 1 Endpoint 6 Control Register [R/W] */
#define DEV1_EP7_CTL_REG                                     0x0270 /* Device 1 Endpoint 7 Control Register [R/W] */

#define DEV2_EP0_CTL_REG                                     0x0280 /* Device 2 Endpoint 0 Control Register [R/W] */
#define DEV2_EP1_CTL_REG                                     0x0290 /* Device 2 Endpoint 1 Control Register [R/W]       */
#define DEV2_EP2_CTL_REG                                     0x02A0 /* Device 2 Endpoint 2 Control Register [R/W] */
#define DEV2_EP3_CTL_REG                                     0x02B0 /* Device 2 Endpoint 3 Control Register [R/W] */
#define DEV2_EP4_CTL_REG                                     0x02C0 /* Device 2 Endpoint 4 Control Register [R/W] */
#define DEV2_EP5_CTL_REG                                     0x02D0 /* Device 2 Endpoint 5 Control Register [R/W] */
#define DEV2_EP6_CTL_REG                                     0x02E0 /* Device 2 Endpoint 6 Control Register [R/W] */
#define DEV2_EP7_CTL_REG                                     0x02F0 /* Device 2 Endpoint 7 Control Register [R/W] */

#define SIE1_DEV_REQ                                         0x0300 /* SIE1 Default Setup packet Address */
#define SIE2_DEV_REQ                                         0x0308 /* SIE2 Default Setup packet Address */


/* FIELDS */

/* Defined in Host Control Register */
#define INOUT_IGN_EN                                         0x0080 /* Ignores IN and OUT requests on EP0     */
/*#define SEQ_SEL             0x0040  // Endpoint Data Toggle Sequence Bit */
#define STALL_EN                                             0x0020 /* Endpoint Stall */
/*#define ISO_EN              0x0010  // Enpoint Isochronous enable */
#define NAK_INT_EN                                           0x0080 /* NAK Response Interrupt enable  */
/*#define DIR_SEL             0x0004  // Endpoint Direction (1:IN, 0:OUT) */
/*#define EN                  0x0002  // Endpoint enable */
/*#define ARM_EN              0x0001  // Endpoint arm */
/*#define BSY_FLG             0x0001  // Start host operation (ARM_BUSY?) */

/*********************************************************/
/* DEVICE n ENDPOINT n ADDRESS REGISTERS [R/W]           */
/*********************************************************/

#define DEV1_EP0_ADDR_REG                                    0x0202 /* Device 1 Endpoint 0 Address Register [R/W] */
#define DEV1_EP1_ADDR_REG                                    0x0212 /* Device 1 Endpoint 1 Address Register [R/W]      */
#define DEV1_EP2_ADDR_REG                                    0x0222 /* Device 1 Endpoint 2 Address Register [R/W] */
#define DEV1_EP3_ADDR_REG                                    0x0232 /* Device 1 Endpoint 3 Address Register [R/W] */
#define DEV1_EP4_ADDR_REG                                    0x0242 /* Device 1 Endpoint 4 Address Register [R/W] */
#define DEV1_EP5_ADDR_REG                                    0x0252 /* Device 1 Endpoint 5 Address Register [R/W] */
#define DEV1_EP6_ADDR_REG                                    0x0262 /* Device 1 Endpoint 6 Address Register [R/W] */
#define DEV1_EP7_ADDR_REG                                    0x0272 /* Device 1 Endpoint 7 Address Register [R/W] */

#define DEV2_EP0_ADDR_REG                                    0x0282 /* Device 2 Endpoint 0 Address Register [R/W] */
#define DEV2_EP1_ADDR_REG                                    0x0292 /* Device 2 Endpoint 1 Address Register [R/W] */
#define DEV2_EP2_ADDR_REG                                    0x02A2 /* Device 2 Endpoint 2 Address Register [R/W] */
#define DEV2_EP3_ADDR_REG                                    0x02B2 /* Device 2 Endpoint 3 Address Register [R/W] */
#define DEV2_EP4_ADDR_REG                                    0x02C2 /* Device 2 Endpoint 4 Address Register [R/W] */
#define DEV2_EP5_ADDR_REG                                    0x02D2 /* Device 2 Endpoint 5 Address Register [R/W] */
#define DEV2_EP6_ADDR_REG                                    0x02E2 /* Device 2 Endpoint 6 Address Register [R/W] */
#define DEV2_EP7_ADDR_REG                                    0x02F2 /* Device 2 Endpoint 7 Address Register [R/W] */

/*********************************************************/
/* DEVICE n ENDPOINT n COUNT REGISTERS [R/W]             */
/*********************************************************/

#define DEV1_EP0_CNT_REG                                     0x0204 /* Device 1 Endpoint 0 Count Register [R/W] */
#define DEV1_EP1_CNT_REG                                     0x0214 /* Device 1 Endpoint 1 Count Register [R/W]       */
#define DEV1_EP2_CNT_REG                                     0x0224 /* Device 1 Endpoint 2 Count Register [R/W] */
#define DEV1_EP3_CNT_REG                                     0x0234 /* Device 1 Endpoint 3 Count Register [R/W] */
#define DEV1_EP4_CNT_REG                                     0x0244 /* Device 1 Endpoint 4 Count Register [R/W] */
#define DEV1_EP5_CNT_REG                                     0x0254 /* Device 1 Endpoint 5 Count Register [R/W] */
#define DEV1_EP6_CNT_REG                                     0x0264 /* Device 1 Endpoint 6 Count Register [R/W] */
#define DEV1_EP7_CNT_REG                                     0x0274 /* Device 1 Endpoint 7 Count Register [R/W] */

#define DEV2_EP0_CNT_REG                                     0x0284 /* Device 2 Endpoint 0 Count Register [R/W] */
#define DEV2_EP1_CNT_REG                                     0x0294 /* Device 2 Endpoint 1 Count Register [R/W]      */
#define DEV2_EP2_CNT_REG                                     0x02A4 /* Device 2 Endpoint 2 Count Register [R/W] */
#define DEV2_EP3_CNT_REG                                     0x02B4 /* Device 2 Endpoint 3 Count Register [R/W] */
#define DEV2_EP4_CNT_REG                                     0x02C4 /* Device 2 Endpoint 4 Count Register [R/W] */
#define DEV2_EP5_CNT_REG                                     0x02D4 /* Device 2 Endpoint 5 Count Register [R/W] */
#define DEV2_EP6_CNT_REG                                     0x02E4 /* Device 2 Endpoint 6 Count Register [R/W] */
#define DEV2_EP7_CNT_REG                                     0x02F4 /* Device 2 Endpoint 7 Count Register [R/W] */

/* FIELDS */

#define EP_CNT                                               0x03FF /* Endpoint Count */

/*********************************************************/
/* DEVICE n ENDPOINT n STATUS REGISTERS [R/W]            */
/*********************************************************/

#define DEV1_EP0_STAT_REG                                    0x0206 /* Device 1 Endpoint 0 Status Register [R/W] */
#define DEV1_EP1_STAT_REG                                    0x0216 /* Device 1 Endpoint 1 Status Register [R/W]       */
#define DEV1_EP2_STAT_REG                                    0x0226 /* Device 1 Endpoint 2 Status Register [R/W] */
#define DEV1_EP3_STAT_REG                                    0x0236 /* Device 1 Endpoint 3 Status Register [R/W] */
#define DEV1_EP4_STAT_REG                                    0x0246 /* Device 1 Endpoint 4 Status Register [R/W] */
#define DEV1_EP5_STAT_REG                                    0x0256 /* Device 1 Endpoint 5 Status Register [R/W] */
#define DEV1_EP6_STAT_REG                                    0x0266 /* Device 1 Endpoint 6 Status Register [R/W] */
#define DEV1_EP7_STAT_REG                                    0x0276 /* Device 1 Endpoint 7 Status Register [R/W] */

#define DEV2_EP0_STAT_REG                                    0x0286 /* Device 2 Endpoint 0 Status Register [R/W] */
#define DEV2_EP1_STAT_REG                                    0x0296 /* Device 2 Endpoint 1 Status Register [R/W]      */
#define DEV2_EP2_STAT_REG                                    0x02A6 /* Device 2 Endpoint 2 Status Register [R/W] */
#define DEV2_EP3_STAT_REG                                    0x02B6 /* Device 2 Endpoint 3 Status Register [R/W] */
#define DEV2_EP4_STAT_REG                                    0x02C6 /* Device 2 Endpoint 4 Status Register [R/W] */
#define DEV2_EP5_STAT_REG                                    0x02D6 /* Device 2 Endpoint 5 Status Register [R/W] */
#define DEV2_EP6_STAT_REG                                    0x02E6 /* Device 2 Endpoint 6 Status Register [R/W] */
#define DEV2_EP7_STAT_REG                                    0x02F6 /* Device 2 Endpoint 7 Status Register [R/W] */

/* FIELDS */

#define OUT_EXCEPTION_FLG                                    0x0200 /* OUT received when armed for IN */
#define IN_EXCEPTION_FLG                                     0x0100 /* IN received when armed for OUT */
/*#define STALL_FLG            0x0080  // Stall sent */
/*#define NAK_FLG              0x0040  // NAK sent */
/*#define OVERFLOW_FLG         0x0020  // Count exceeded during receive */
#define SETUP_FLG                                            0x0010 /* SETUP packet received */
/*#define SEQ_STAT             0x0008  // Last Data Toggle Sequence bit sent or received */
/*#define TIMEOUT_FLG          0x0004  // Last transmission timed out */
/*#define ERROR_FLG            0x0002  // CRC Error detected in last reception */
/*#define ACK_FLG              0x0001  // Last transaction ACK'D (sent or received) */

/*********************************************************/
/* DEVICE n ENDPOINT n COUNT RESULT REGISTERS [R]      */
/*********************************************************/

#define DEV1_EP0_CTR_REG                                     0x0208 /* Device 1 Endpoint 0 Count Result Register [R] */
#define DEV1_EP1_CTR_REG                                     0x0218 /* Device 1 Endpoint 1 Count Result Register [R]       */
#define DEV1_EP2_CTR_REG                                     0x0228 /* Device 1 Endpoint 2 Count Result Register [R] */
#define DEV1_EP3_CTR_REG                                     0x0238 /* Device 1 Endpoint 3 Count Result Register [R] */
#define DEV1_EP4_CTR_REG                                     0x0248 /* Device 1 Endpoint 4 Count Result Register [R] */
#define DEV1_EP5_CTR_REG                                     0x0258 /* Device 1 Endpoint 5 Count Result Register [R] */
#define DEV1_EP6_CTR_REG                                     0x0268 /* Device 1 Endpoint 6 Count Result Register [R] */
#define DEV1_EP7_CTR_REG                                     0x0278 /* Device 1 Endpoint 7 Count Result Register [R] */

#define DEV2_EP0_CTR_REG                                     0x0288 /* Device 2 Endpoint 0 Count Result Register [R] */
#define DEV2_EP1_CTR_REG                                     0x0298 /* Device 2 Endpoint 1 Count Result Register [R]       */
#define DEV2_EP2_CTR_REG                                     0x02A8 /* Device 2 Endpoint 2 Count Result Register [R] */
#define DEV2_EP3_CTR_REG                                     0x02B8 /* Device 2 Endpoint 3 Count Result Register [R] */
#define DEV2_EP4_CTR_REG                                     0x02C8 /* Device 2 Endpoint 4 Count Result Register [R] */
#define DEV2_EP5_CTR_REG                                     0x02D8 /* Device 2 Endpoint 5 Count Result Register [R] */
#define DEV2_EP6_CTR_REG                                     0x02E8 /* Device 2 Endpoint 6 Count Result Register [R] */
#define DEV2_EP7_CTR_REG                                     0x02F8 /* Device 2 Endpoint 7 Count Result Register [R] */

/* FIELDS */

#define EP_RESULT                                            0x00FF /* Endpoint Count Result */


/*********************************************************/
/*********************************************************/
/* OTG REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* OTG CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define OTG_CTL_REG                                          0xC098 /* On-The-Go Control Register [R/W] */

/* FIELDS */

#define OTG_RX_DIS                                           0x1000 /* Disable OTG receiver */
#define CHG_PUMP_EN                                          0x0800 /* OTG Charge Pump enable */
#define VBUS_DISCH_EN                                        0x0400 /* VBUS discharge enable */
#define DPLUS_PULLUP_EN                                      0x200  /* DPlus Pullup enable */
#define DMINUS_PULLUP_EN                                     0x100  /* DMinus Pullup enable */
#define DPLUS_PULLDOWN_EN                                    0x80   /* DPlus Pulldown enable */
#define DMINUS_PULLDOWN_EN                                   0x40   /* DMinus Pulldown enable */
#define OTG_DATA_STAT                                        0x0004 /* TTL logic state of VBUS pin [R] */
#define OTG_ID_STAT                                          0x0002 /* Value of OTG ID pin [R] */
#define VBUS_VALID_FLG                                       0x0001 /* VBUS > 4.4V [R] */


/*********************************************************/
/*********************************************************/
/* GPIO REGISTERS                                        */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* GPIO CONTROL REGISTER [R/W]                           */
/*********************************************************/

#define GPIO_CTL_REG                                         0xC006 /* GPIO Control Register [R/W] */
#define GPIO_CONFIG                                          0xC006
#define GPIO_CNTRL                                           0xC01C /* Alias for BIOS code */

/* FIELDS */
#define GPIO_WP_EN                                           0x8000 /* GPIO Control Register Write-Protect enable (1:WP) */
#define GPIO_SAS_EN                                          0x0800 /* 1:SPI SS to GPIO[15] */
#define GPIO_MODE_SEL                                        0x0700 /* GPIO Mode       */
#define GPIO_HSS_EN                                          0x0080 /* Connect HSS to GPIO (Dependent on TQFP_PKG) */
/* TQFP: GPIO [26, 18:16] */
/* FBGA: GPIO[15:12] */
#define GPIO_HSS_XD_EN                                       0x0040 /* Connect HSS to XD[15:12] (TQFP only) */
#define GPIO_SPI_EN                                          0x0020 /* Connect SPI to GPIO[11:8] */
#define GPIO_SPI_XD_EN                                       0x0010 /* Connect SPI to XD[11:8] */
#define GPIO_IRQ1_POL_SEL                                    0x0008 /* IRQ1 polarity (1:positive, 0:negative)  */
#define GPIO_IRQ1_EN                                         0x0004 /* IRQ1 enable */
#define GPIO_IRQ0_POL_SEL                                    0x0002 /* IRQ0 polarity (1:positive, 0:negative) */
#define GPIO_IRQ0_EN                                         0x0001 /* IRQ0 enable */

/* GPIO MODE FIELD VALUES */

#define DIAG_MODE                                            0x0007 /* Memory Diagnostic mode */
#define SCAN_MODE                                            0x0006 /* Boundary Scan mode */
#define HPI_MODE                                             0x0005 /* HPI mode */
#define IDE_MODE                                             0x0004 /* IDE mode */
#define EPP_MODE                                             0x0002 /* EPP mode */
#define FLASH_MODE                                           0x0001 /* FLASH mode */
#define GPIO_MODE                                            0x0000 /* GPIO only */

/*********************************************************/
/* GPIO n REGISTERS                                      */
/*********************************************************/

#define GPIO0_OUT_DATA_REG                                   0xC01E /* GPIO 0 Output Data Register [R/W] */
#define GPIO1_OUT_DATA_REG                                   0xC024 /* GPIO 1 Output Data Register [R/W] */

#define GPIO0_IN_DATA_REG                                    0xC020 /* GPIO 0 Input Data Register [R] */
#define GPIO1_IN_DATA_REG                                    0xC026 /* GPIO 1 Input Data Register [R] */

#define GPIO0_DIR_REG                                        0xC022 /* GPIO 0 Direction Register [R/W] (1:Output, 0:Input) */
#define GPIO1_DIR_REG                                        0xC028 /* GPIO 1 Direction Register [R/W] (1:Output, 0:Input) */
#define GPIO_HI_IO                                           0xC024 /* Alias for BIOS */
#define GPIO_HI_ENB                                          0xC028 /* Alias for BIOS */


/*********************************************************/
/*********************************************************/
/* EPP REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* EPP CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define EPP_CTL_REG                                          0xC046 /* EPP Control Register [R/W] */

/* FIELDS */

#define EPP_MODE_SEL                                         0x8000 /* 1: EPP_MODE, 0: COMPATABILITY MODE [R/W] */
#define EPP_SELECT_STAT                                      0x4000 /* Returns current logic state of the SELECT pin [R] */
#define EPP_nFAULT_STAT                                      0x2000 /* Returns current logic state of the nFAULT pin [R] */
#define EPP_pERROR_STAT                                      0x1000 /* Returns current logic state of the pERROR pin [R] */

/* EPP MODE ONLY FIELDS (EPP_MODE_EN = 1) */

#define EPP_nRESET_EN                                        0x0020 /* Reads/Writes current logic state of the nRESET pin [R/W] */
#define EPP_nDSTRB_EN                                        0x0010 /* Reads/Writes current logic state of the nDSTRB pin [R/W] */
#define EPP_nASTRB_EN                                        0x0008 /* Reads/Writes current logic state of the nASTRB pin [R/W]  */
#define EPP_nWRITE_EN                                        0x0004 /* Reads/Writes current logic state of the nWRITE pin [R/W]  */
#define EPP_IRQ_STAT                                         0x0002 /* ??? [R] */
#define EPP_WAIT_STAT                                        0x0001 /* ??? [R] */

/* COMPATABILITY MODE ONLY FIELDS (EPP_MODE_EN = 0) */

#define EPP_nINIT_EN                                         0x0020 /* ??? [R/W]  */
#define EPP_nAUTOFD_EN                                       0x0010 /* ??? [R/W]  */
#define EPP_ASELECT_EN                                       0x0008 /* ??? [R/W]  */
#define EPP_nSTROBE_EN                                       0x0004 /* ??? [R/W]  */
#define EPP_nACK_STAT                                        0x0002 /* ??? [R]  */
#define EPP_BUSY_STAT                                        0x0001 /* ??? [R]  */

/*********************************************************/
/* EPP DATA REGISTER [R/W]                               */
/*********************************************************/

#define EPP_DATA_REG                                         0xC040 /* EPP Data Register [R/W] */

/* FIELDS */

#define EPP_DATA                                             0x00FF /* EPP Data */

/*********************************************************/
/* EPP BUFFER READ REGISTER [R]                          */
/*********************************************************/

#define EPP_BFR_READ_REG                                     0xC042 /* EPP Buffer Read Register [R] */

/* FIELDS */

#define EPP_BFR                                              0x00FF /* EPP Buffer */

/*********************************************************/
/* EPP ADDRESS REGISTER [R/W]                            */
/*********************************************************/

#define EPP_ADDR_REG                                         0xC044 /* EPP Address Register [R/W] */

/* FIELDS */

#define EPP_ADDR                                             0x00FF /* EPP Address */


/*********************************************************/
/*********************************************************/
/* IDE REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* IDE MODE REGISTER [R/W]                               */
/*********************************************************/

#define IDE_MODE_REG                                         0xC048 /* IDE Mode Register [R/W] */

/* FIELDS */

#define IDE_MODE_SEL                                         0x0007 /* IDE Mode (See field values below) */

/* MODE FIELD VALUES */

#define MODE_DIS                                             0x0007 /* Disabled */
#define MODE_PIO4                                            0x0004 /* PIO Mode 4 */
#define MODE_PIO3                                            0x0003 /* PIO Mode 3 */
#define MODE_PIO2                                            0x0002 /* PIO Mode 2 */
#define MODE_PIO1                                            0x0001 /* PIO Mode 1 */
#define MODE_PIO0                                            0x0000 /* PIO Mode 0 */

/*********************************************************/
/* IDE START ADDRESS REGISTER [R/W]                      */
/*********************************************************/

#define IDE_START_ADDR_REG                                   0xC04A /* IDE Start Address Register [R/W] */

/*********************************************************/
/* IDE STOP ADDRESS REGISTER [R/W]                       */
/*********************************************************/

#define IDE_STOP_ADDR_REG                                    0xC04C /* IDE Stop Address Register [R/W] */

/*********************************************************/
/* IDE CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define IDE_CTL_REG                                          0xC04E /* IDE Control Register [R/W] */

/* FIELDS */

#define IDE_DIR_SEL                                          0x0008 /* IDE Direction Select */
#define IDE_IRQ_EN                                           0x0004 /* IDE Interrupt Enable */
#define IDE_DONE_FLG                                         0x0002 /* IDE Done Flag (Set by silicon, Cleared by writing 0) */
#define IDE_EN                                               0x0001 /* IDE Enable (Set by writing 1, Cleared by silicon) */

/* DIRECTION SELECT FIELD VALUES */

#define WR_EXT                                               0x0008 /* Write to external device */
#define RD_EXT                                               0x0000 /* Read from external device */

/*********************************************************/
/* IDE PIO PORT REGISTERS [R/W]                          */
/*********************************************************/

#define IDE_PIO_DATA_REG                                     0xC050 /* IDE PIO Data Register [R/W] */
#define IDE_PIO_ERR_REG                                      0xC052 /* IDE PIO Error Register [R/W] */
#define IDE_PIO_SCT_CNT_REG                                  0xC054 /* IDE PIO Sector Count Register [R/W] */
#define IDE_PIO_SCT_NUM_REG                                  0xC056 /* IDE PIO Sector Number Register [R/W] */
#define IDE_PIO_CYL_LO_REG                                   0xC058 /* IDE PIO Cylinder Low Register [R/W] */
#define IDE_PIO_CYL_HI_REG                                   0xC05A /* IDE PIO Cylinder High Register [R/W] */
#define IDE_PIO_DEV_HD_REG                                   0xC05C /* IDE PIO Device/Head Register [R/W] */
#define IDE_PIO_CMD_REG                                      0xC05E /* IDE PIO Command Register [R/W] */
#define IDE_PIO_DEV_CTL_REG                                  0xC06C /* IDE PIO Device Control Register [R/W] */


/*********************************************************/
/*********************************************************/
/* MDMA REGISTERS                                        */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* MDMA MODE REGISTER [R/W]                              */
/*********************************************************/

#define MDMA_MODE_REG                                        0xC048 /* MDMA Mode Register [R/W] */

/* FIELDS */

#define MDMA_PROTOCOL_SEL                                    0x0008 /* 1:MDMA-B, 0:MDMA-A */
#define MDMA_MODE_SEL                                        0x0007 /* MDMA Mode (See field values below) */

/* MDMA MODE FIELD VALUES */

#define MDMA_DIS                                             0x0007 /* Disabled */
#define MDMA_16                                              0x0006 /* MDMA Mode, 16-bit */
#define MDMA_8                                               0x0005 /* MDMA Mode, 8-bit */

/*********************************************************/
/* MDMA START ADDRESS REGISTER [R/W]                     */
/*********************************************************/

#define MDMA_START_ADDR_REG                                  0xC04A /* MDMA Start Address Register [R/W] */

/*********************************************************/
/* MDMA STOP ADDRESS REGISTER [R/W]                      */
/*********************************************************/

#define MDMA_STOP_ADDR_REG                                   0xC04C /* MDMA Stop Address Register [R/W] */

/*********************************************************/
/* MDMA CONTROL REGISTER [R/W]                           */
/*********************************************************/

#define MDMA_CTL_REG                                         0xC04E /* MDMA Control Register [R/W] */

/* FIELDS */

#define MDMA_DIR_SEL                                         0x0008 /* MDMA Direction Select */
#define MDMA_IRQ_EN                                          0x0004 /* MDMA Interrupt Enable */
#define MDMA_DONE_FLG                                        0x0002 /* MDMA Done Flag (Set by silicon, Cleared by writing 0) */
#define MDMA_EN                                              0x0001 /* MDMA Enable (Set by writing 1, Cleared by silicon) */


/*********************************************************/
/*********************************************************/
/* HSS REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* HSS CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define HSS_Ctl_REG                                          0xC070 /* HSS Control Register [R/W] */

/* FIELDS */

#define HSS_EN                                               0x8000 /* HSS Enable */
#define RTS_POL_SEL                                          0x4000 /* RTS Polarity Select */
#define CTS_POL_SEL                                          0x2000 /* CTS Polarity Select */
#define XOFF                                                 0x1000 /* XOFF/XON state (1:XOFF received, 0:XON received) [R] */
#define XOFF_EN                                              0x0800 /* XOFF/XON protocol Enable */
#define CTS_EN                                               0x0400 /* CTS Enable  */
#define RX_IRQ_EN                                            0x0200 /* RxRdy/RxPktRdy Interrupt Enable */
#define HSS_DONE_IRQ_EN                                      0x0100 /* TxDone/RxDone Interrupt Enable */
#define TX_DONE_IRQ_FLG                                      0x0080 /* TxDone Interrupt (Write 1 to clear) */
#define RX_DONE_IRQ_FLG                                      0x0040 /* RxDone Interrupt (Write 1 to clear) */
#define ONE_STOP_BIT                                         0x0020 /* Number of TX Stop bits (1:one TX stop bit, 0:2 TX stop bits) */
#define HSS_TX_RDY                                           0x0010 /* Tx ready for next byte */
#define PACKET_MODE_SEL                                      0x0008 /* RxIntr Source (1:RxPktRdy, 0:RxRdy) */
#define RX_OVF_FLG                                           0x0004 /* Rx FIFO overflow (Write 1 to clear and flush RX FIFO) */
#define RX_PKT_RDY_FLG                                       0x0002 /* RX FIFO full */
#define RX_RDY_FLG                                           0x0001 /* RX FIFO not empty */

/* RTS POLARITY SELECT FIELD VALUES */

#define RTS_POL_LO                                           0x4000 /* Low-true polarity */
#define RTS_POL_HI                                           0x0000 /* High-true polarity */

/* CTS POLARITY SELECT FIELD VALUES */

#define CTS_POL_LO                                           0x2000 /* Low-true polarity */
#define CTS_POL_HI                                           0x0000 /* High-true polarity */

/*********************************************************/
/* HSS BAUD RATE REGISTER [???]                          */
/*********************************************************/
/* Baud rate is determined as follows: */
/* */
/*     48 MHz */
/* -------------- */
/* (HSS_BAUD + 1) */
/*********************************************************/

#define HSS_BAUD_REG                                         0xC072 /* HSS Baud Register [???] */

/* FIELDS */

#define HSS_BAUD_SEL                                         0x1FFF /* HSS Baud */

/*********************************************************/
/* HSS TX GAP REGISTER [???]                             */
/*********************************************************/
/* This register defines the number of stop bits used */
/* for block mode transmission ONLY. The number of stop  */
/* bits is determined as follows: */
/* */
/* (TX_GAP - 7) */
/* */
/* Valid values for TX_GAP are 8-255. */
/*********************************************************/

#define HSS_TX_GAP_REG                                       0xC074 /* HSS Transmit Gap Register [???] */

/* FIELDS */

#define TX_GAP_SEL                                           0x00FF /* HSS Transmit Gap */

/*********************************************************/
/* HSS DATA REGISTER [R/W]                               */
/*********************************************************/

#define HSS_DATA_REG                                         0xC076 /* HSS Data Register [R/W] */

/* FIELDS */

#define HSS_DATA                                             0x00FF /* HSS Data */

/*********************************************************/
/* HSS RECEIVE ADDRESS REGISTER [???]                    */
/*********************************************************/

#define HSS_RX_ADDR_REG                                      0xC078 /* HSS Receive Address Register [???] */

/*********************************************************/
/* HSS RECEIVE COUNTER REGISTER [R/W]                    */
/*********************************************************/

#define HSS_RX_CTR_REG                                       0xC07A /* HSS Receive Counter Register [R/W] */

/* FIELDS */

#define HSS_RX_CTR                                           0x03FF /* Counts from (n-1) to (0-1) */

/*********************************************************/
/* HSS TRANSMIT ADDRESS REGISTER [???]                   */
/*********************************************************/

#define HSS_TX_ADDR_REG                                      0xC07C /* HSS Transmit Address Register [???] */

/*********************************************************/
/* HSS TRANSMIT COUNTER REGISTER [R/W]                   */
/*********************************************************/

#define HSS_TX_CTR_REG                                       0xC07E /* HSS Transmit Counter Register [R/W] */

/* FIELDS */

#define HSS_TX_CTR                                           0x03FF /* Counts from (n-1) to (0-1) */

/* ------------------ HIGH SPEED SERIAL INTERFACE ADDRESS ------------------- */
/* High Speed Serial Control */

#define HSS_RGN                                              0xC070
#define HSS_STS_REG                                          0xC070
#define HSS_Ctl_ADR                                          0xC070
#define HSS_Ctl_MSK                                          0x0000
#define HSS_Ctl_RxRst_BIT                                    0x0002
#define HSS_Ctl_RxRst_BM                                     0x0004
#define HSS_Ctl_PacketMode_BIT                               0x0003
#define HSS_Ctl_PacketMode_BM                                0x0008
#define HSS_Ctl_OneStop_BIT                                  0x0005
#define HSS_Ctl_OneStop_BM                                   0x0020
#define HSS_Ctl_RBkDoneClr_BIT                               0x0006
#define HSS_Ctl_RBkDoneClr_BM                                0x0040
#define HSS_Ctl_TBkDoneClr_BIT                               0x0007
#define HSS_Ctl_TBkDoneClr_BM                                0x0080
#define HSS_Ctl_DoneIntrEnab_BIT                             0x0008
#define HSS_Ctl_DoneIntrEnab_BM                              0x0100
#define HSS_Ctl_RxIntrEnab_BIT                               0x0009
#define HSS_Ctl_RxIntrEnab_BM                                0x0200
#define HSS_Ctl_CTSenab_BIT                                  0x000A
#define HSS_Ctl_CTSenab_BM                                   0x0400
#define HSS_Ctl_XOFFenab_BIT                                 0x000B
#define HSS_Ctl_XOFFenab_BM                                  0x0800
#define HSS_Ctl_CTSpolarity_BIT                              0x000D
#define HSS_Ctl_CTSpolarity_BM                               0x2000
#define HSS_Ctl_RTSpolarity_BIT                              0x000E
#define HSS_Ctl_RTSpolarity_BM                               0x4000
#define HSS_Ctl_Enable_BIT                                   0x000F
#define HSS_Ctl_Enable_BM                                    0x8000
#define HSS_Ctl_RxRdy_BIT                                    0x0000
#define HSS_Ctl_RxRdy_BM                                     0x0001
#define HSS_Ctl_RxPktRdy_BIT                                 0x0001
#define HSS_Ctl_RxPktRdy_BM                                  0x0002
#define HSS_Ctl_RxErr_BIT                                    0x0002
#define HSS_Ctl_RxErr_BM                                     0x0004
#define HSS_Ctl_TxRdy_BIT                                    0x0004
#define HSS_Ctl_TxRdy_BM                                     0x0010
#define HSS_Ctl_RBkDone_BIT                                  0x0006
#define HSS_Ctl_RBkDone_BM                                   0x0040
#define HSS_Ctl_TBkDone_BIT                                  0x0007
#define HSS_Ctl_TBkDone_BM                                   0x0080
#define HSS_Ctl_XOFFstate_BIT                                0x000C
#define HSS_Ctl_OFFstate_BM                                  0x1000

/* High Speed Serial BAUD Rate Register */
#define HSS_BAUDRATE_REG                                     0xC072
#define HSS_BAUDRate_ADR                                     0xC072
#define HSS_BAUDRate_MSK                                     0x0000
#define HSS_BAUDRate_Rate_POS                                0x0000
#define HSS_BAUDRate_Rate_SIZ                                0x000D

/* High Speed Serial GAP Register */
#define HSS_GAP_REG                                          0xC074
#define HSS_GAP_ADR                                          0xC074
#define HSS_GAP_MSK                                          0x0000
#define HSS_GAP_GAP_POS                                      0x0000
#define HSS_GAP_GAP_SIZ                                      0x0010

/* High Speed Serial Data Register */
#define HSS_RX_DATA_REG                                      0xC076
#define HSS_TX_DATA_REG                                      0xC076
#define HSS_Data_ADR                                         0xC076
#define HSS_Data_MSK                                         0x0000
#define HSS_Data_Data_POS                                    0x0000
#define HSS_Data_Data_SIZ                                    0x0008

/* High Speed Serial Block Receive Address Register */
#define HSS_RX_BLK_ADDR_REG                                  0xC078
#define HSS_RxBlkAddr_ADR                                    0xC078
#define HSS_RxBlkAddr_MSK                                    0x0000
#define HSS_RxBlkAddr_Addr_POS                               0x0000
#define HSS_RxBlkAddr_Addr_SIZ                               0x0010

/* High Speed Serial Block Receive Length Register */
#define HSS_RX_BLK_LEN_REG                                   0xC07A
#define HSS_RxBlkLen_ADR                                     0xC07A
#define HSS_RxBlkLen_MSK                                     0x0000
#define HSS_RxBlkLen_POS                                     0x0000
#define HSS_RxBlkLen_SIZ                                     0x000A

/* High Speed Serial Block Transmit Address Register */
#define HSS_TX_BLK_ADDR_REG                                  0xC07C
#define HSS_TxBlkAddr_ADR                                    0xC07C
#define HSS_TxBlkAddr_MSK                                    0x0000
#define HSS_TxBlkAddr_Addr_POS                               0x0000
#define HSS_TxBlkAddr_Addr_SIZ                               0x0010

/* High Speed Serial Block Transmit Length Register */
#define HSS_TX_BLK_LEN_REG                                   0xC07E
#define HSS_TxBlkLen_ADR                                     0xC07E
#define HSS_TxBlkLen_MSK                                     0x0000
#define HSS_TxBlkLen_POS                                     0x0000
#define HSS_TxBlkLen_SIZ                                     0x000A

/*********************************************************/
/*********************************************************/
/* SPI REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* SPI CONFIGURATION REGISTER [R/W]                      */
/*********************************************************/

#define SPI_CFG_REG                                          0xC0C8 /* SPI Config Register [R/W] */

/* FIELDS */

#define c3WIRE_EN                                            0x8000 /* MISO/MOSI data lines common */
#define PHASE_SEL                                            0x0400 /* Advanced SCK phase */
#define SCK_POL_SEL                                          0x2000 /* Positive SCK Polarity */
#define SCALE_SEL                                            0x1E00 /* SPI Clock Frequency Scaling */
#define MSTR_ACTIVE_EN                                       0x0080 /* Master state machine active */
#define MSTR_EN                                              0x0040 /* Master/Slave select */
#define SS_EN                                                0x0020 /* SS enable */
#define SS_DLY_SEL                                           0x001F /* SS delay select */

/* SCALE VALUES */
#define SPI_SCALE_1E                                         0x1E00 /* */
#define SPI_SCALE_1C                                         0x1C00 /* */
#define SPI_SCALE_1A                                         0x1A00 /* */
#define SPI_SCALE_18                                         0x1800 /* */
#define SPI_SCALE_16                                         0x1600 /* */
#define SPI_SCALE_14                                         0x1400 /* */
#define SPI_SCALE_12                                         0x1200 /* */
#define SPI_SCALE_10                                         0x1000 /* */
#define SPI_SCALE_0E                                         0x0E00 /* */
#define SPI_SCALE_0C                                         0x0C00 /* */
#define SPI_SCALE_0A                                         0x0A00 /* */
#define SPI_SCALE_08                                         0x0800 /* */
#define SPI_SCALE_06                                         0x0600 /* */
#define SPI_SCALE_04                                         0x0400 /* */
#define SPI_SCALE_02                                         0x0200 /* */
#define SPI_SCALE_00                                         0x0000 /* */

/*********************************************************/
/* SPI CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define SPI_CTL_REG                                          0xC0CA /* SPI Control Register [R/W] */

/* FIELDS */

#define SCK_STROBE                                           0x8000 /* SCK Strobe */
#define FIFO_INIT                                            0x4000 /* FIFO Init */
#define BYTE_MODE                                            0x2000 /* Byte Mode */
#define FULL_DUPLEX                                          0x1000 /* Full Duplex */
#define SS_MANUAL                                            0x0800 /* SS Manual */
#define READ_EN                                              0x0400 /* Read Enable */
#define SPI_TX_RDY                                           0x0200 /* Transmit Ready */
#define RX_DATA_RDY                                          0x0100 /* Receive Data Ready */
#define TX_EMPTY                                             0x0080 /* Transmit Empty */
#define RX_FULL                                              0x0020 /* Receive Full */
#define TX_BIT_LEN                                           0x0031 /* Transmit Bit Length */
#define RX_BIT_LEN                                           0x0007 /* Receive Bit Length */

/*********************************************************/
/* SPI INTERRUPT ENABLE REGISTER [R/W]                   */
/*********************************************************/

#define SPI_IRQ_EN_REG                                       0xC0CC /* SPI Interrupt Enable Register [R/W] */

/* FIELDS */

#define SPI_RX_IRQ_EN                                        0x0004 /* SPI Receive Interrupt Enable */
#define SPI_TX_IRQ_EN                                        0x0002 /* SPI Transmit Interrupt Enable */
#define SPI_XFR_IRQ_EN                                       0x0001 /* SPI Transfer Interrupt Enable */

/*********************************************************/
/* SPI STATUS REGISTER [R]                               */
/*********************************************************/

#define SPI_STAT_REG                                         0xC0CE /* SPI Status Register [R] */

/* FIELDS */

#define SPI_FIFO_ERROR_FLG                                   0x0100 /* FIFO Error occurred */
#define SPI_RX_IRQ_FLG                                       0x0004 /* SPI Receive Interrupt  */
#define SPI_TX_IRQ_FLG                                       0x0002 /* SPI Transmit Interrupt */
#define SPI_XFR_IRQ_FLG                                      0x0001 /* SPI Transfer Interrupt */

/*********************************************************/
/* SPI INTERRUPT CLEAR REGISTER [W]                      */
/*********************************************************/
/* In order to clear a particular IRQ, write a '1' to    */
/* the appropriate bit location.                         */
/*********************************************************/

#define SPI_IRQ_CLR_REG                                      0xC0D0 /* SPI Interrupt Clear Register [W] */

/* FIELDS */

#define SPI_TX_IRQ_CLR                                       0x0002 /* SPI Transmit Interrupt Clear */
#define SPI_XFR_IRQ_CLR                                      0x0001 /* SPI Transfer Interrupt Clear */

/*********************************************************/
/* SPI CRC CONTROL REGISTER [R/W]                        */
/*********************************************************/

#define SPI_CRC_CTL_REG                                      0xC0D2 /* SPI CRC Control Register [R/W] */

/* FIELDS */

#define CRC_MODE                                             0xC000 /* CRC Mode */
#define CRC_EN                                               0x2000 /* CRC Enable */
#define CRC_CLR                                              0x1000 /* CRC Clear */
#define RX_CRC                                               0x0800 /* Receive CRC */
#define ONE_IN_CRC                                           0x0400 /* One in CRC [R] */
#define ZERO_IN_CRC                                          0x0200 /* Zero in CRC [R] */

/* CRC MODE VALUES */

#define POLYNOMIAL_3                                         0x0003 /* CRC POLYNOMIAL 1 */
#define POLYNOMIAL_2                                         0x0002 /* CRC POLYNOMIAL X^16+X^15+X^2+1 */
#define POLYNOMIAL_1                                         0x0001 /* CRC POLYNOMIAL X^7+X^3+1 */
#define POLYNOMIAL_0                                         0x0000 /* CRC POLYNOMIAL X^16+X^12+X^5+1 */

/*********************************************************/
/* SPI CRC VALUE REGISTER [R/W]                          */
/*********************************************************/

#define SPI_CRC_VALUE_REG                                    0xC0D4 /* SPI CRC Value Register [R/W] */

/*********************************************************/
/* SPI DATA REGISTER [R/W]                               */
/*********************************************************/

#define SPI_DATA_REG                                         0xC0D6 /* SPI Data Register [R/W] */

/* FIELDS */

#define SPI_DATA                                             0x00FF /* SPI Data */

/*********************************************************/
/* SPI TRANSMIT ADDRESS REGISTER [R/W]                   */
/*********************************************************/

#define SPI_TX_ADDR_REG                                      0xC0D8 /* SPI Transmit Address Register [R/W] */

/*********************************************************/
/* SPI TRANSMIT COUNT REGISTER [R/W]                     */
/*********************************************************/

#define SPI_TX_CNT_REG                                       0xC0DA /* SPI Transmit Count Register [R/W] */

/* FIELDS */

#define SPI_TX_CNT                                           0x07FF /* SPI Transmit Count */

/*********************************************************/
/* SPI RECEIVE ADDRESS REGISTER [R/W]                    */
/*********************************************************/

#define SPI_RX_ADDR_REG                                      0xC0DC /* SPI Receive Address Register [R/W] */

/*********************************************************/
/* SPI RECEIVE COUNT REGISTER [R/W]                      */
/*********************************************************/

#define SPI_RX_CNT_REG                                       0xC0DE /* SPI Receive Count Register [R/W] */

/* FIELDS */

#define SPI_RX_CNT                                           0x07FF /* SPI Receive Count */
#define SPI_RGN                                              0xC0C0 /* SPI memory map start */

/* SPI registers occupies 0xC0C8 to 0xC0DF. */
/* so SPI_RGN is set to 0xC0C0. The first register is at offset 0x08. */
/* The last register 0xC0DE is at offset 0x1e. */
/*   SPI register:   Lyberty Address     AFE offset from 0xC0C0 */
/*     SPI_RxLen     0xC0DE              0x1e */
/*     SPI_RxBlk     0xC0DC              0x1c */
/*     SPI_TxLen     0xC0DA              0x1a */
/*     SPI_TxBlk     0xC0D8              0x18 */
/*     SPI_TxRxData  0xC0D6              0x16 */
/*     SPI_CRCVal    0xC0D4              0x14 */
/*     SPI_CRCCtl    0xC0D2              0x12 */
/*     SPI_IntClr    0xC0D0              0x10 */
/*     SPI_IntVal    0xC0CE              0x0e */
/*     SPI_IntEnab   0xC0CC              0x0c */
/*     SPI_Ctl       0xC0CA              0x0a */
/*     SPI_Cfg       0xC0C8              0x08 */


/* SPI 16-bit Configuration Register */
/*------------------------------------ */
#define SPI_Cfg_AFE                                          0x0008
#define SPI_Cfg_ADR                                          0xC0C8

/* b i t   d e f i n i t i o n s */
#define SPI_Cfg_3WireNot4_BIT                                0x000F
#define SPI_Cfg_3WireNot4_BM                                 0x8000
#define SPI_Cfg_CPHA_BIT                                     0x000E
#define SPI_Cfg_CPHA_BM                                      0x4000
#define SPI_Cfg_CPOL_BIT                                     0x000D
#define SPI_Cfg_CPOL_BM                                      0x2000
/*      SPI_Cfg_Sel                       MSB 12 */
#define SPI_Cfg_Sel_SIZ                                      0x0004
#define SPI_Cfg_Sel_POS                                      0x0009
/* possible selections */
#define SPI_Cfg_Sel_250                                      0x000B
#define SPI_Cfg_Sel_250_BM                                   0x1600
#define SPI_Cfg_Sel_375                                      0x000A
#define SPI_Cfg_Sel_375_BM                                   0x1400
#define SPI_Cfg_Sel_500                                      0x0009
#define SPI_Cfg_Sel_500_BM                                   0x1200
#define SPI_Cfg_Sel_750                                      0x0008
#define SPI_Cfg_Sel_750_BM                                   0x1000
#define SPI_Cfg_Sel_1000                                     0x0007
#define SPI_Cfg_Sel_1000_BM                                  0x0E00
#define SPI_Cfg_Sel_1500                                     0x0006
#define SPI_Cfg_Sel_1500_BM                                  0x0C00
#define SPI_Cfg_Sel_2M                                       0x0005
#define SPI_Cfg_Sel_2M_BM                                    0x0A00
#define SPI_Cfg_Sel_3M                                       0x0004
#define SPI_Cfg_Sel_3M_BM                                    0x0800
#define SPI_Cfg_Sel_4M                                       0x0003
#define SPI_Cfg_Sel_4M_BM                                    0x0600
#define SPI_Cfg_Sel_6M                                       0x0002
#define SPI_Cfg_Sel_6M_BM                                    0x0400
#define SPI_Cfg_Sel_8M                                       0x0001
#define SPI_Cfg_Sel_8M_BM                                    0x0200
#define SPI_Cfg_Sel_12M                                      0x0000
#define SPI_Cfg_Sel_12M_BM                                   0x0000
/* end  SPI_Cfg_Sel */
#define SPI_Cfg_RedLine_BIT                                  0x0008
#define SPI_Cfg_RedLine_BM                                   0x0100

#define SPI_Cfg_MstrActive_BIT                               0x0007
#define SPI_Cfg_MstrActive_BM                                0x0080
#define SPI_Cfg_MstrNotSlv_BIT                               0x0006
#define SPI_Cfg_MstrNotSlv_BM                                0x0040
#define SPI_Cfg_SSEn_BIT                                     0x0005
#define SPI_Cfg_SSEn_BM                                      0x0020
/*      SPI_Cfg_SSDly                     MSB 4 */
#define SPI_Cfg_SSDly_SIZ                                    0x0005
#define SPI_Cfg_SSDly_POS                                    0x0000
/* assign to manual */
#define SPI_Cfg_SSDly_Manual                                 0x0000
/* one possible selection */
#define SPI_Cfg_SSDly_2                                      0x0002
#define SPI_Cfg_SSDly_2_BM                                   0x0002


/* SPI 16-bit Control Register */
/*------------------------------------ */
#define SPI_Ctl_AFE                                          0x000A
#define SPI_Ctl_ADR                                          0xC0CA

/* b i t   d e f i n i t i o n s */
#define SPI_Ctl_SCKStrobe_BIT                                0x000F
#define SPI_Ctl_SCKStrobe_BM                                 0x8000
#define SPI_Ctl_FIFOInit_BIT                                 0x000E
#define SPI_Ctl_FIFOInit_BM                                  0x4000
#define SPI_Ctl_ByteMode_BIT                                 0x000D
#define SPI_Ctl_ByteMode_BM                                  0x2000
#define SPI_Ctl_FullDuplex_BIT                               0x000C
#define SPI_Ctl_FullDuplex_BM                                0x1000
#define SPI_Ctl_SSManVal_BIT                                 0x000B
#define SPI_Ctl_SSManVal_BM                                  0x0800
#define SPI_Ctl_DoRead_BIT                                   0x000A
#define SPI_Ctl_DoRead_BM                                    0x0400
#define SPI_Ctl_TxRdy_BIT                                    0x0009
#define SPI_Ctl_TxRdy_BM                                     0x0200
#define SPI_Ctl_RxDatRdy_BIT                                 0x0008
#define SPI_Ctl_RxDatRdy_BM                                  0x0100

#define SPI_Ctl_TxEmpty_BIT                                  0x0007
#define SPI_Ctl_TxEmpty_BM                                   0x0080
#define SPI_Ctl_RxFull_BIT                                   0x0006
#define SPI_Ctl_RxFull_BM                                    0x0040
/*      SPI_Ctl_TxBitLen                  MSB 5 */
#define SPI_Ctl_TxBitLen_POS                                 0x0003
#define SPI_Ctl_TxBitLen_SIZ                                 0x0003

/* zero is full byte */
#define SPI_Ctl_TxBitLen_FullByte                            0x0000
#define SPI_Ctl_TxBitLen_FullByte_BM                         0x0000

/*      SPI_Ctl_RxBitLen                  MSB 2 */
#define SPI_Ctl_RxBitLen_POS                                 0x0000
#define SPI_Ctl_RxBitLen_SIZ                                 0x0003

/* zero is full byte */
#define SPI_Ctl_RxBitLen_FullByte                            0x0000
#define SPI_Ctl_RxBitLen_FullByte_BM                         0x0000


/* SPI Interrupt Type Bits */
/* for all Interrupt Registers */
/* ----------------------------------- */
#define SPI_Int_XfrBk_BIT                                    0x0000
#define SPI_Int_Tx_BIT                                       0x0001
#define SPI_Int_Rx_BIT                                       0x0002
#define SPI_Int_FIFOErr_BIT                                  0x0007

/* SPI 16-bit Interrupt Enable Register */
/*------------------------------------ */
#define SPI_IntEnab_AFE                                      0x000C
#define SPI_IntEnab_ADR                                      0xC0CC

/* b i t   d e f i n i t i o n s */
/* reserved BITS                              15 - 8 */

/* reserved BITS                              7 - 3 */
#define SPI_IntEnab_Rx_BM                                    0x0004
#define SPI_IntEnab_Tx_BM                                    0x0002
#define SPI_IntEnab_XfrBk_BM                                 0x0001


/* SPI 16-bit Interrupt Value Register */
/*------------------------------------ */
#define SPI_IntVal_AFE                                       0x000E
#define SPI_IntVal_ADR                                       0xC0CE

/* b i t   d e f i n i t i o n s */
/* reserved BITS                              15 - 8 */

#define SPI_IntVal_FIFOErr_BM                                0x0080

/* reserved BITS                              6 - 3 */
#define SPI_IntVal_Rx_BM                                     0x0004
#define SPI_IntVal_Tx_BM                                     0x0002
#define SPI_IntVal_XfrBk_BM                                  0x0001

/* SPI 16-bit Interrupt Clear Register */
/*------------------------------------ */
#define SPI_IntClr_AFE                                       0x0010
#define SPI_IntClr_ADR                                       0xC0D0

/* b i t   d e f i n i t i o n s */
/* reserved BITS                              15 - 8 */

/* reserved BITS                              7 - 2 */
#define SPI_IntClr_Tx_BM                                     0x0002
#define SPI_IntClr_XfrBk_BM                                  0x0001


/* SPI 16-bit CRC Control Register */
/*------------------------------------ */
#define SPI_CRCCtl_AFE                                       0x0012
#define SPI_CRCCtl_ADR                                       0xC0D2

/* b i t   d e f i n i t i o n s */
/*      SPI_CRCCtl                        MSB 15 */
#define SPI_CRCCtl_Mode_POS                                  0x000E
#define SPI_CRCCtl_Mode_SIZ                                  0x0002

/* Mode selections MMC (CCITT), */
/*  CRC-7, Memory Stick & Reserved */
#define SPI_CRCCtl_Mode_MMC                                  0x0000
#define SPI_CRCCtl_Mode_MMC_BM                               0x0000
#define SPI_CRCCtl_Mode_CRC7                                 0x0001
#define SPI_CRCCtl_Mode_CRC7_BM                              0x4000
#define SPI_CRCCtl_Mode_MS                                   0x0002
#define SPI_CRCCtl_Mode_MS_BM                                0x8000
#define SPI_CRCCtl_Mode_Res                                  0x0003
#define SPI_CRCCtl_Mode_Res_BM                               0xC000
#define SPI_CRCCtl_Active_BIT                                0x000D
#define SPI_CRCCtl_Active_BM                                 0x2000
#define SPI_CRCCtl_Clear_BIT                                 0x000C
#define SPI_CRCCtl_Clear_BM                                  0x1000
#define SPI_CRCCtl_RxNotTx_BIT                               0x000B
#define SPI_CRCCtl_RxNotTx_BM                                0x0800
#define SPI_CRCCtl_OR_BIT                                    0x000A
#define SPI_CRCCtl_OR_BM                                     0x0400
#define SPI_CRCCtl_NAND_BIT                                  0x0009
#define SPI_CRCCtl_NAND_BM                                   0x0200
/* reserved BIT                               8 */

/* reserved BITS                              7 - 0 */


/* SPI 16-bit CRC Value Register */
/*------------------------------------ */
#define SPI_CRCVal_AFE                                       0x0014
#define SPI_CRCVal_ADR                                       0xC0D4
#define SPI_CRCVal_Port_POS                                  0x0000
#define SPI_CRCVal_Port_SIZ                                  0x0010


/* SPI 8-bit transmit & receive port (PIO) */
/*------------------------------------ */
#define SPI_TxRxData_AFE                                     0x0016
#define SPI_TxRxData_ADR                                     0xC0D6
#define SPI_TxRxData_Port_POS                                0x0000
#define SPI_TxRxData_Port_SIZ                                0x0008


/* SPI 16-bit DMA transmit base address */
/*------------------------------------ */
#define SPI_TxBlk_AFE                                        0x0018
#define SPI_TxBlk_ADR                                        0xC0D8
#define SPI_TxBlk_Base_POS                                   0x0000
#define SPI_TxBlk_Base_SIZ                                   0x0010


/* SPI 11-bit DMA transmit length */
/*------------------------------------ */
#define SPI_TxLen_AFE                                        0x001A
#define SPI_TxLen_ADR                                        0xC0DA
#define SPI_TxLen_Bytes_POS                                  0x0000
#define SPI_TxLen_Bytes_SIZ                                  0x0010


/* SPI 16-bit DMA recieve base address */
/*------------------------------------ */
#define SPI_RxBlk_AFE                                        0x001C
#define SPI_RxBlk_ADR                                        0xC0DC
#define SPI_RxBlk_Base_POS                                   0x0000
#define SPI_RxBlk_Base_SIZ                                   0x0010


/* SPI 11-bit DMA recieve length */
/*------------------------------------ */
#define SPI_RxLen_AFE                                        0x001E
#define SPI_RxLen_ADR                                        0xC0DE
#define SPI_RxLen_Bytes_POS                                  0x0000
#define SPI_RxLen_Bytes_SIZ                                  0x0010

/* ------------------------- IDE PIO MODES ---------------------------------- */
/* IDE Memory Map */
/* -------------------------------------------------------------------------- */
#define IDE_RGN                                              0xC050
/* IDE 16-bit Data Register */
#define IDE_Data_ADR                                         0xC050
#define IDE_Data_MSK                                         0x0000
#define IDE_Data_Data_POS                                    0x0000
#define IDE_Data_Data_SIZ                                    0x0010

/* IDE 8-bit Features/Status Register (write) */
#define IDE_FeaturesStat_ADR                                 0xC052
#define IDE_FeaturesStat_MSK                                 0x0000
#define IDE_FeaturesStat_Data_POS                            0x0000
#define IDE_FeaturesStat_Data_SIZ                            0x0008

/* IDE Sector Count Register */
#define IDE_SectCount_ADR                                    0xC054
#define IDE_SectCount_MSK                                    0x0000
#define IDE_SectCount_Count_POS                              0x0000
#define IDE_SectCount_Count_SIZ                              0x0008

/* IDE Sector Number Register */
#define IDE_SectorNum_ADR                                    0xC056
#define IDE_SectorNum_MSK                                    0x0000
#define IDE_SectorNum_Count_POS                              0x0000
#define IDE_SectorNum_Count_SIZ                              0x0008

/* IDE Cylinder Low Register */
#define IDE_CylLow_ADR                                       0xC058
#define IDE_CylLow_MSK                                       0x0000
#define IDE_CylLow_Cyl_POS                                   0x0000
#define IDE_CylLow_Cyl_SIZ                                   0x0008

/* IDE Cylinder High Register */
#define IDE_CylHigh_ADR                                      0xC05A
#define IDE_CylHigh_MSK                                      0x0000
#define IDE_CylHigh_Cyl_POS                                  0x0000
#define IDE_CylHigh_Cyl_SIZ                                  0x0008

/* IDE Drive/Head Register */
#define IDE_DrvHead_ADR                                      0xC05C
#define IDE_DrvHead_MSK                                      0x0000
#define IDE_DrvHead_Reg_POS                                  0x0000
#define IDE_DrvHead_Reg_SIZ                                  0x0008

/* IDE Command/Status Register */
#define IDE_CmdStatus_ADR                                    0xC05E
#define IDE_CmdStatus_MSK                                    0x0000
#define IDE_CmdStatus_Reg_POS                                0x0000
#define IDE_CmdStatus_Reg_SIZ                                0x0008

/* IDE Status/Alternate Status Register */
#define IDE_AltStat_ADR                                      0xC06C
#define IDE_AltStat_MSK                                      0x0000
#define IDE_AltStat_Reg_POS                                  0x0000
#define IDE_AltStat_Reg_SIZ                                  0x0008


/*********************************************************/
/*********************************************************/
/* UART REGISTERS                                        */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* UART CONTROL REGISTER [R/W]                           */
/*********************************************************/

#define UART_CTL_REG                                         0xC0E0 /* UART Control Register [R/W] */
#define UART_CNTL                                            0xC0E0 /* Alias for BIOS code */

/*  bit mask for 0xc0e2 */
#define UART_RX_BUFF_FULL                                    0x0002

/* FIELDS */

#define UART_SCALE_SEL                                       0x0010 /* UART Scale (1:Divide by 8 prescaler for the UART Clock) */
#define UART_BAUD_SEL                                        0x000E /* UART Baud */
#define UART_EN                                              0x0001 /* UART Enable */

/* BAUD VALUES */

#define UART_7K2                                             0x000F /* 7.2K Baud (0.9K with DIV8_EN Set) */
#define UART_9K6                                             0x000E /* 9.6K Baud (1.2K with DIV8_EN Set) */
#define UART_14K4                                            0x000C /* 14.4K Baud (1.8K with DIV8_EN Set) */
#define UART_19K2                                            0x000D /* 19.2K Baud (2.4K with DIV8_EN Set) */
#define UART_28K8                                            0x000B /* 28.8K Baud (3.6K with DIV8_EN Set) */
#define UART_38K4                                            0x000A /* 38.4K Baud (4.8K with DIV8_EN Set) */
#define UART_57K6                                            0x0009 /* 57.6K Baud (7.2K with DIV8_EN Set) */
#define UART_115K2                                           0x0008 /* 115.2K Baud (14.4K with DIV8_EN Set) */

/*********************************************************/
/* UART STATUS REGISTER [R]                              */
/*********************************************************/

#define UART_STAT_REG                                        0xC0E2 /* UART Status Register [R] */
#define UART_STATUS                                          0xC0E2

/* FIELDS */

#define UART_RX_FULL                                         0x0002 /* UART Receive Full */
#define UART_TX_EMPTY                                        0x0001 /* UART Transmit Empty */

/*********************************************************/
/* UART DATA REGISTER [R/W]                              */
/*********************************************************/

#define UART_DATA_REG                                        0xC0E4 /* UART Data Register [R/W] */
#define UART_RX_REG                                          0xC0E4 /* Alias for BIOS code */
#define UART_TX_REG                                          0xC0E4 /* Alias for BIOS code */

/* FIELDS */
#define UART_DATA                                            0x00FF /* UART Data */


/*********************************************************/
/*********************************************************/
/* PWM REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* PWM CONTROL REGISTER [R/W]                            */
/*********************************************************/

#define PWM_CTL_REG                                          0xC0E6 /* PWM Control Register [R/W] */

/* FIELDS */

#define PWM_EN                                               0x8000 /* 1:Start, 0:Stop */
#define PWM_PRESCALE_SEL                                     0x0E00 /* Prescale field (See values below) */
#define PWM_MODE_SEL                                         0x0100 /* 1:Single cycle, 0:Repetitive cycle */
#define PWM3_POL_SEL                                         0x0080 /* 1:Positive polarity, 0:Negative polarity  */
#define PWM2_POL_SEL                                         0x0040 /* 1:Positive polarity, 0:Negative polarity  */
#define PWM1_POL_SEL                                         0x0020 /* 1:Positive polarity, 0:Negative polarity  */
#define PWM0_POL_SEL                                         0x0010 /* 1:Positive polarity, 0:Negative polarity  */
#define PWM3_EN                                              0x0008 /* PWM3 Enable */
#define PWM2_EN                                              0x0004 /* PWM2 Enable */
#define PWM1_EN                                              0x0002 /* PWM1 Enable */
#define PWM0_EN                                              0x0001 /* PWM0 Enable */

/* PRESCALER FIELD VALUES */

#define PWM_5K9                                              0x0007 /* 5.9 KHz  */
#define PWM_23K5                                             0x0006 /* 23.5 KHz */
#define PWM_93K8                                             0x0005 /* 93.8 KHz */
#define PWM_375K                                             0x0004 /* 375 KHz */
#define PWM_1M5                                              0x0003 /* 1.5 MHz */
#define PWM_6M                                               0x0002 /* 6.0 MHz */
#define PWM_24M                                              0x0001 /* 24.0 MHz */
#define PWM_48M                                              0x0000 /* 48.0 MHz */

/*********************************************************/
/* PWM MAXIMUM COUNT REGISTER [R/W]                      */
/*********************************************************/

#define PWM_MAX_CNT_REG                                      0xC0E8 /* PWM Maximum Count Register [R/W] */

/* FIELDS */

#define PWM_MAX_CNT                                          0x03FF /* PWM Maximum Count */

/*********************************************************/
/* PWM n START REGISTERS [R/W]                           */
/*********************************************************/

#define PWM0_START_REG                                       0xC0EA /* PWM 0 Start Register [R/W] */
#define PWM1_START_REG                                       0xC0EE /* PWM 1 Start Register [R/W] */
#define PWM2_START_REG                                       0xC0F2 /* PWM 2 Start Register [R/W] */
#define PWM3_START_REG                                       0xC0F6 /* PWM 3 Start Register [R/W] */

/* FIELDS */

#define PWM_START_CNT                                        0x03FF /* */

/*********************************************************/
/* PWM n STOP REGISTERS [R/W]                            */
/*********************************************************/

#define PWM0_STOP_REG                                        0xC0EC /* PWM 0 Stop Register [R/W] */
#define PWM1_STOP_REG                                        0xC0F0 /* PWM 1 Stop Register [R/W] */
#define PWM2_STOP_REG                                        0xC0F4 /* PWM 2 Stop Register [R/W] */
#define PWM3_STOP_REG                                        0xC0F8 /* PWM 3 Stop Register [R/W] */

/* FIELDS */

#define PWM_STOP_CNT                                         0x03FF /* PWM Stop Count */

/*********************************************************/
/* PWM CYCLE COUNT REGISTER [R/W]                        */
/*********************************************************/

#define PWM_CYCLE_CNT_REG                                    0xC0FA /* PWM Cycle Count Register [R/W] */


/*********************************************************/
/*********************************************************/
/* HPI REGISTERS                                         */
/*********************************************************/
/*********************************************************/

/*********************************************************/
/* HPI MAILBOX REGISTER [R/W]                            */
/*********************************************************/

#define HPI_MBX_REG                                          0xC0C4 /* HPI Mailbox Register [R/W] */

/*********************************************************/
/* HPI BREAKPOINT REGISTER [R]                           */
/*********************************************************/

#define HPI_BKPT_REG                                         0x0140 /* HPI Breakpoint Register [R] */
/*********************************************************/
/* INTERRUPT ROUTING REGISTER [R]                        */
/*********************************************************/
#define HPI_IRQ_ROUTING_REG                                  0x0142 /* HPI Interrupt Routing Register [R] */
#define HPI_SIE_IE                                           0x0142
#define HPI_SIE1_MSG_ADR                                     0x0144
#define HPI_RESERVED                                         0x0146
#define HPI_SIE2_MSG_ADR                                     0x0148

#define HPI_RGN                                              0xC0C0 /* base address */

/* HPI DMA Control Register */
#define HPI_DMACtl_ADR                                       0xC0C0
#define HPI_DMACtl_MSK                                       0x0000
#define HPI_DMACtl_D0_BIT                                    0x0000
#define HPI_DMACtl_D1_BIT                                    0x0001
#define HPI_DMACtl_DREQ_BIT                                  0x0002

/* HPI Mailbox Register */
#define HPI_MAILBOX_REG                                      0xC0C6
#define HPI_MailBox_ADR                                      0xC0C6
#define HPI_MailBox_MSK                                      0x0000
#define HPI_MailBox_POS                                      0x0000
#define HPI_MailBox_SIZ                                      0x0010

#define VBUS_TO_HPI_EN                                       0x8000 /* Route OTG VBUS Interrupt to HPI */
#define ID_TO_HPI_EN                                         0x4000 /* Route OTG ID Interrupt to HPI */
// cjv the following two definitions were swapped - I fixed.
#define SOFEOP2_TO_CPU_EN                                    0x1000 /* Route SIE2 SOF/EOP Interrupt to CPU */
#define SOFEOP2_TO_HPI_EN                                    0x2000 /* Route SIE2 SOF/EOP Interrupt to HPI */
#define SOFEOP1_TO_CPU_EN                                    0x0400 /* Route SIE1 SOF/EOP Interrupt to CPU */
#define SOFEOP1_TO_HPI_EN                                    0x0800 /* Route SIE1 SOF/EOP Interrupt to HPI */
#define RST2_TO_HPI_EN                                       0x0200 /* Route SIE2 Reset Interrupt to HPI */
#define HPI_SWAP_1_EN                                        0x0100 /* Swap HPI MSB/LSB */
#define RESUME2_TO_HPI_EN                                    0x0080 /* Route SIE2 Resume Interrupt to HPI */
#define RESUME1_TO_HPI_EN                                    0x0040 /* Route SIE1 Resume Interrupt to HPI */
#define DONE2_TO_HPI_EN                                      0x0008 /* Route SIE2 Done Interrupt to HPI */
#define DONE1_TO_HPI_EN                                      0x0004 /* Route SIE1 Done Interrupt to HPI */
#define RST1_TO_HPI_EN                                       0x0002 /* Route SIE1 Reset Interrupt to HPI */
#define HPI_SWAP_0_EN                                        0x0001 /* Swap HPI MSB/LSB (*MUST MATCH HPI_SWAP_1) */

/* ALIASES */

#define HOST2_SOEOP_TO_HPI_EN                                0x1000 /* Host 2 SOF/EOP Interrupt */
#define HOST1_SOFEOP_TO_HPI_EN                               0x0400 /* Host 1 SOF/EOP Interrupt */
#define DEVICE2_SOFEOP_TO_HPI_EN                             0x1000 /* Device 2 SOF/EOP Interrupt */
#define DEVICE1_SOFEOP_TO_HPI_EN                             0x0400 /* Device 1 SOF/EOP Interrupt */

#define HOST2_SOFEOP_TO_CPU_EN                               0x2000 /* Host 2 SOF/EOP Interrupt */
#define HOST1_SOFEOP_TO_CPU_EN                               0x0800 /* Host 1 SOF/EOP Interrupt */
#define DEVICE2_SOFEOP_TO_CPU_EN                             0x2000 /* Device 2 SOF/EOP Interrupt */
#define DEVICE1_SOFEOP_TO_CPU_EN                             0x0800 /* Device 1 SOF/EOP Interrupt */

#define HOST2_RESUME_TO_HPI_EN                               0x0080 /* Host 2 Resume Interrupt */
#define HOST1_RESUME_TO_HPI_EN                               0x0040 /* Host 1 Resume Interrupt */
#define DEVICE2_RESUME_TO_HPI_EN                             0x0080 /* Device 2 Resume Interrupt */
#define DEVICE1_RESUME_TO_HPI_EN                             0x0040 /* Device 1 Resume Interrupt */

#define HOST2_DONE_TO_HPI_EN                                 0x0008 /* Host 2 Done Interrupt */
#define HOST1_DONE_TO_HPI_EN                                 0x0004 /* Host 1 Done Interrupt */
#define DEVICE2_DONE_TO_HPI_EN                               0x0008 /* Device 2 Done Interrupt */
#define DEVICE1_DONE_TO_HPI_EN                               0x0004 /* Device 1 Done Interrupt */

#define HOST2_RESET_TO_HPI_EN                                0x0200 /* Host 2 Reset Interrupt */
#define HOST1_RESET_TO_HPI_EN                                0x0002 /* Host 1 Reset Interrupt */
#define DEVICE2_RESET_TO_HPI_EN                              0x0200 /* Device 2 Reset Interrupt */
#define DEVICE1_RESET_TO_HPI_EN                              0x0002 /* Device 1 Reset Interrupt */

/*********************************************************/
/*********************************************************/
/* HPI PORTS                                             */
/*********************************************************/
/*********************************************************/

//#define HPI_BASE                                             0x0000

/*********************************************************/
/* HPI DATA PORT                                         */
/*********************************************************/

#define HPI_DATA_PORT                                        0x0000 /* HPI Data Port */

/*********************************************************/
/* HPI ADDRESS PORT                                      */
/*********************************************************/

#define HPI_ADDR_PORT                                        0x0002 /* HPI Address Port */

/*********************************************************/
/* HPI MAILBOX PORT                                      */
/*********************************************************/

#define HPI_MBX_PORT                                         0x0001 /* HPI Mailbox Port */

/*********************************************************/
/* HPI STATUS PORT                                       */
/*********************************************************/

/*
** The HPI Status port is only accessible by an external host over the
** HPI interface. It is accessed by performing an HPI read at the HPI
** base address + 3.
*/

#define HPI_STAT_PORT                                        0x0003 /* HPI Status Port */

#define VBUS_FLG                                             0x8000 /* OTG VBUS Interrupt */
#define ID_FLG                                               0x4000 /* OTG ID Interrupt */
#define SOFEOP2_FLG                                          0x1000 /* Host 2 SOF/EOP Interrupt */
#define SOFEOP1_FLG                                          0x0400 /* Host 1 SOF/EOP Interrupt */
#define RST2_FLG                                             0x0200 /* Host 2 Reset Interrupt */
#define MBX_IN_FLG                                           0x0100 /* Message in pending (awaiting CPU read) */
#define RESUME2_FLG                                          0x0080 /* Host 2 Resume Interrupt */
#define RESUME1_FLG                                          0x0040 /* Host 1 Resume Interrupt */
#define DONE2_FLG                                            0x0008 /* Host 2 Done Interrupt */
#define DONE1_FLG                                            0x0004 /* Host 1 Done Interrupt */
#define RST1_FLG                                             0x0002 /* Host 1 Reset Interrupt */
#define MBX_OUT_FLG                                          0x0001 /* Message out available (awaiting external host read) */

/* Aliases */

#define HOST2_SOF_EOP_FLG                                    0x1000 /* Host 2 SOF/EOP Interrupt */
#define HOST1_SOF_EOP_FLG                                    0x0400 /* Host 1 SOF/EOP Interrupt */
#define DEV2_SOF_EOP_FLG                                     0x1000 /* Device 2 SOF/EOP Interrupt */
#define DEV1_SOF_EOP_FLG                                     0x0400 /* Device 1 SOF/EOP Interrupt */

#define HOST2_RST_FLG                                        0x0200 /* Host 2 Reset Interrupt */
#define HOST1_RST_FLG                                        0x0002 /* Host 1 Reset Interrupt */
#define DEV2_RST_FLG                                         0x0200 /* Device 2 Reset Interrupt */
#define DEV1_RST_FLG                                         0x0002 /* Device 1 Reset Interrupt */

#define HOST2_RESUME_FLG                                     0x0080 /* Host 2 Resume Interrupt */
#define HOST1_RESUME_FLG                                     0x0040 /* Host 1 Resume Interrupt */
#define DEV2_RESUME_FLG                                      0x0080 /* Device 2 Resume Interrupt */
#define DEV1_RESUME_FLG                                      0x0040 /* Device 1 Resume Interrupt */

#define HOST2_DONE_FLG                                       0x0008 /* Host 2 Done Interrupt */
#define HOST1_DONE_FLG                                       0x0004 /* Host 1 Done Interrupt */
#define DEV2_DONE_FLG                                        0x0008 /* Device 2 Done Interrupt */
#define DEV1_DONE_FLG                                        0x0004 /* Device 1 Done Interrupt */

/*===============================================================*/
/* usb.inc                                                       */
/*                                                               */
/*   A header containing the SL16R slave SIE registers           */
/*   Updated 8/16/01 For SIE1 and SIE2 New Address Assigned      */
/*===============================================================*/

#define O_SIE_CTRL0                                          0x0000
#define O_SIE_BASE                                           0x0002
#define O_SIE_LENGTH                                         0x0004
#define O_SIE_PORT_SEL                                       0x0004
#define O_SIE_PID                                            0x0006
#define O_SIE_CTRL5                                          0x000A
#define O_SIE_INT_EN                                         0x000C
#define O_SIE_USB_ADDR                                       0x000E
#define O_SIE_INT_STATUS                                     0x0010
#define O_SIE_SOF_LO                                         0x0012
#define O_SIE_PORT_SPD_SEL                                   0x0012 /* slave mode */
#define O_SIE_SOF_HI                                         0x0014

/* Endpoint Register Offsets */
#define O_EP_BANK                                            0x0010 /* to EP bank offset */

/* SIE Bases and Offsets */
#define NUM_EP_PER_SIE                                       0x0008
#define O_SIE1_EP_BASE                                       0x0000
#define O_SIE2_EP_BASE                                       0x0080

#define SIE_EP_BASE                                          0x0200
#define SIE1_EP_BASE                                         0x0200
#define SIE2_EP_BASE                                         0x0280

/* Bank Offsets wrt SIE Base */

#define O_EP0_BANK                                           0x0000
#define O_EP1_BANK                                           0x0010
#define O_EP2_BANK                                           0x0020
#define O_EP3_BANK                                           0x0030
#define O_EP4_BANK                                           0x0040
#define O_EP5_BANK                                           0x0050
#define O_EP6_BANK                                           0x0060
#define O_EP7_BANK                                           0x0070

/* SIE1 SLAVE EP Register Bank Base Addresses */
#define SIE1_EP0_BASE                                        0x0200
#define SIE1_EP1_BASE                                        0x0210
#define SIE1_EP2_BASE                                        0x0220
#define SIE1_EP3_BASE                                        0x0230
#define SIE1_EP4_BASE                                        0x0240
#define SIE1_EP5_BASE                                        0x0250
#define SIE1_EP6_BASE                                        0x0260
#define SIE1_EP7_BASE                                        0x0270

/* SIE2 SLAVE EP Register Bank Base Addresses */
#define SIE2_EP0_BASE                                        0x0280
#define SIE2_EP1_BASE                                        0x0290
#define SIE2_EP2_BASE                                        0x02A0
#define SIE2_EP3_BASE                                        0x02B0
#define SIE2_EP4_BASE                                        0x02C0
#define SIE2_EP5_BASE                                        0x02D0
#define SIE2_EP6_BASE                                        0x02E0
#define SIE2_EP7_BASE                                        0x02F0

/* Endpoint Register Offsets */
#define O_EP_CONTROL                                         0x0000
#define O_EP_BASE_ADDR                                       0x0002
#define O_EP_BASE_LENGTH                                     0x0004
#define O_EP_PACKET_STAT                                     0x0006 /* Read */
#define O_EP_XFER_COUNT                                      0x0008 /* Read */

/* Generic Processing EP data */
#define O_EP_MAX_BYTES                                       0x000A
#define O_EP_GF_BYTES_LEFT                                   0x000C
#define O_EP_P_GF                                            0x000E


/* Endpoint Control Register Bitmasks */
#define bmEP_CTRL_STICKY                                     0x0080
#define bmEP_CTRL_DATA1                                      0x0040
#define bmEP_CTRL_STALL                                      0x0020
#define bmEP_CTRL_ISO                                        0x0010
#define bmEP_CTRL_NDS_B                                      0x0008
#define bmEP_CTRL_DIR_IN                                     0x0004
#define bmEP_CTRL_ENB                                        0x0002
#define bmEP_CTRL_ARM                                        0x0001
#define bmEP_CTRL_EP                                         0x0070
#define EP_CTRL_OUT                                          0x0000

/* Endpoint Packet Status Register Bitmasks */
#define bmEP_PSR_ACK                                         0x0001
#define bmEP_PSR_ERR                                         0x0002
#define bmEP_PSR_TO                                          0x0004
#define bmEP_PSR_DAT1                                        0x0008
#define bmEP_PSR_SETUP                                       0x0010
#define bmEP_PSR_OVERFLOW                                    0x0020
#define bmEP_PSR_NAK                                         0x0040
#define bmEP_PSR_STALL                                       0x0080
#define bmEP_PSR_IN_ERR                                      0x0100
#define bmEP_PSR_OUT_ERR                                     0x0200


/* SIE Interrupt Status/Enable Register Bitmasks */
#define bmISR_EP0                                            0x0001
#define bmISR_EP1                                            0x0002
#define bmISR_EP2                                            0x0004
#define bmISR_EP3                                            0x0008
#define bmISR_EP4                                            0x0010
#define bmISR_EP5                                            0x0020
#define bmISR_EP6                                            0x0040
#define bmISR_EP7                                            0x0080

#define bmISR_USB_RESET                                      0x0100
#define bmISR_SOF                                            0x0200
#define bmISR_WAKEUP                                         0x0400


#define bmISR_USBA                                           0x0001
#define bmISR_ALL                                            0x0F6F

/* SIE#_USB_CONTROL Bitmasks   */
#define bmCTRL_USB_ENABLE                                    0x0001
#define bmCTRL_SUSPEND                                       0x0004

#define bmCTRL_STANDBY                                       0x0040
#define bmCTRL_PULLUP_AC                                     0x0080
#define bmCTRL_PULLUP_BD                                     0x0100
#define bmCTRL_HOST_MODE                                     0x0200
#define bmCTRL_PORTAC_LOWSPD                                 0x0400
#define bmCTRL_PORTBD_LOWSPD                                 0x0800
#define CTRL_SLAVE_MODE                                      0x0000

/* Force State Bits 3,4 */
#define bmCTRL_FORCE_NORMAL                                  0x0000
#define bmCTRL_FORCE_SEO                                     0x0010
#define bmCTRL_FORCE_K                                       0x0018
#define bmCTRL_FORCE_J                                       0x0008

/* Port Speed Bitmasks SIE#_USB_PORT_SPEED */
#define bmPSPD_LOW_SPEED_AC                                  0x4000
#define bmPSPD_LOW_SPEED_BD                                  0x8000
#define PSPD_FULL_SPEED                                      0x0000

/* Port Select Bitmasks */
#define bmPSEL_BD                                            0x4000
#define PSEL_AC                                              0x0000

/* generic definitions for BIOS */
#define SUSB_NUM_EPS_ALL                                     0x0010
#define SUSB_NUM_EPS_PER_SIE                                 0x0008

/*----------------------------------------- */
/* */
/*   Chapter 9 Definitions */
/*----------------------------------------- */
/*   Device Requests */
#define DR_GET_STATUS                                        0x0000
#define DR_CLEAR_FEATURE                                     0x0001
#define DR_SET_FEATURE                                       0x0003
#define DR_SET_ADDRESS                                       0x0005
#define DR_GET_DESCRIPTOR                                    0x0006
#define DR_SET_DESCRIPTOR                                    0x0007
#define DR_GET_CONFIG                                        0x0008
#define DR_SET_CONFIG                                        0x0009
#define DR_GET_INTERFACE                                     0x0010
#define DR_SET_INTERFACE                                     0x0011

/* Device Request Offsets */
#define O_DR_REQTYPE                                         0x0000
#define O_DR_REQ                                             0x0001
#define O_DR_VALUE                                           0x0002
#define O_DR_VALUE_LOBYTE                                    0x0002
#define O_DR_VALUE_HIBYTE                                    0x0003
#define O_DR_INDEX                                           0x0004
#define O_DR_LEN                                             0x0006

/*   Descriptor Types */
#define DEVICE                                               0x0001
#define CONFIGURATION                                        0x0002
#define STRING                                               0x0003
#define INTERFACE                                            0x0004
#define ENDPOINT                                             0x0005


/* Request Type Bitmasks */
#define bmRT_DEVICE2HOST                                     0x0080
#define bmRT_VENDOR_REQ                                      0x0040 /*Request Type */
#define bmRT_CLASS_REQ                                       0x0020
#define bmRT_INTERFACE                                       0x0001
#define bmRT_ENDPOINT                                        0x0002
#define bmRT_RECIPIENT_BITS                                  0x000F
#define RT_DEVICE                                            0x0000

/*   Endpoint Types */
#define EP_TYPE_CONTROL                                      0x0000
#define EP_TYPE_ISO                                          0x0001
#define EP_TYPE_BULK                                         0x0002
#define EP_TYPE_INT                                          0x0003

/* BIOS Specific Default Configuration Definitions */
#define EP0_BUFFER_LEN                                       0x0040
#define EP1_BUFFER_LEN                                       0x0040
#define EP2_BUFFER_LEN                                       0x0040

/*   SUSB ERROR CODES */
#define SUSB_ERR_NONE                                        0x0000
#define SUSB_ERR_OUT_OF_RANGE                                0x0001
#define SUSB_ERR_WRONG_DIR                                   0x0002
#define SUSB_ERR_NULL_FRAME                                  0x0003
#define SUSB_ERR_BAD_TRANS_TYPE                              0x0004
#define SUSB_ERR_OVERFLOW                                    0x0005
#define SUSB_ERR_SETUP_TERMINATION                           0x0006
#define SUSB_ERR_EP_Q_FULL                                   0x0007
#define SUSB_ERR_EP_STALLED                                  0x0008
#define SUSB_ERR_EP_NOT_ENABLED                              0x0009
#define SUSB_ERR_BAD_STATE_REQ                               0x000A

/* Generic Ep - endpoint bitmask to indicate */
/*   internal call to Generic EP where */
/*   regs are already loaded */
#define bmGENEP_REGS_LOADED                                  0x8000

/*   Device Descriptor Offsets */
#define O_DD_LENGTH                                          0x0000
#define O_DD_TYPE                                            0x0001
#define O_DD_USB_VERSION                                     0x0002
#define O_DD_CLASS                                           0x0004
#define O_DD_SUBCLASS                                        0x0005
#define O_DD_PROTOCOL                                        0x0006
#define O_DD_EP0_MAX_BYTES                                   0x0007
#define O_DD_VID                                             0x0008
#define O_DD_PID                                             0x000A
#define O_DD_DEVICE_VERSION                                  0x000C
#define O_DD_MFR_STRING_IDX                                  0x000E
#define O_DD_PRODUCT_STRING_IDX                              0x000F
#define O_DD_SN                                              0x0010
#define O_DD_NUM_CONFIGS                                     0x0011

/*   Configuration Descriptor Byte Offsets */
#define O_CD_LENGTH                                          0x0000
#define O_CD_TYPE                                            0x0001
#define O_CD_TOTAL_LENGTH                                    0x0002
#define O_CD_NUM_IFS                                         0x0004
#define O_CD_CONFIG_NUM                                      0x0005
#define O_CD_STRING_IDX                                      0x0006
#define O_CD_ATTRIBUTES                                      0x0007
#define O_CD_MAX_POWER                                       0x0008

/*   Configuration Descriptor Attribute Bitmasks */
#define bmCDATTR_RSVD                                        0x001F
#define bmCDATTR_RWAKEUP                                     0x0020
#define bmCDATTR_SELF_PWR                                    0x0040
#define bmCDATTR_BUS_PWR                                     0x0080

/*   Interface Descriptor Byte Offsets */
#define O_ID_LENGTH                                          0x0000
#define O_ID_TYPE                                            0x0001
#define O_ID_IF_NUM                                          0x0002
#define O_ID_ALT_SETTING                                     0x0003
#define O_ID_NUM_EPS                                         0x0004
#define O_ID_IF_CLASS                                        0x0005
#define O_ID_IF_SUBCLASS                                     0x0006
#define O_ID_IF_PROTO                                        0x0007
#define O_ID_STRING_IDX                                      0x0008

/*   Endpoint Descriptor Byte Offsets */
#define O_ED_LENGTH                                          0x0000
#define O_ED_TYPE                                            0x0001
#define O_ED_ADDRESS                                         0x0002
#define O_ED_ATTRIBUTES                                      0x0003
#define O_ED_MAX_BYTES                                       0x0004
#define O_ED_ITERVAL                                         0x0006

#define O_SD_LENGTH                                          0x0000
#define O_SD_TYPE                                            0x0001

/*   EP Descriptor Address Bitmasks */
#define bmEDADDR_EP_NUM                                      0x0007
#define bmEDADDR_UNUSED                                      0x0070
#define bmEDADDR_DIR_IN                                      0x0080

/*   EP Descriptor Attribute Bitmasks */
#define bmEDATTR_CONTROL                                     0x0000
#define bmEDATTR_ISO                                         0x0001
#define bmEDATTR_BULK                                        0x0010
#define bmEDATTR_INT                                         0x0011
#define bmEDATTR_UNUSED                                      0x00FC

/* GetStatus Bitmasks */
#define bmGS_REMOTE_WAKEUP                                   0x0002
#define bmGS_SELF_POWERED                                    0x0001
#define bmGS_EP_HALT                                         0x0001

/* Feature Selectors */
#define F_SEL_EP_HALT                                        0x0000
#define F_SEL_RMT_WAKEUP                                     0x0001
#define F_SEL_TEST_MODE                                      0x0002

/* SUSB Device States */
#define SUSB_STATE_DEFAULT                                   0x0000
#define SUSB_STATE_ADDRESSED                                 0x000C
#define SUSB_STATE_CONFIGD                                   0x0018

/*********************************************************/
/*  Hardware/Software Interrupt vectors                  */
/*********************************************************/
/* ========= HARWDARE INTERRUPTS ===========             */
#define TIMER0_INT                                           0x0000
#define TIMER0_VEC                                           0x0000 /* Vector location */
#define TIMER1_INT                                           0x0001
#define TIMER1_VEC                                           0x0002

#define GP_IRQ0_INT                                          0x0002
#define GP_IRQ0_VEC                                          0x0004
#define GP_IRQ1_INT                                          0x0003
#define GP_IRQ1_VEC                                          0x0006

#define UART_TX_INT                                          0x0004
#define UART_TX_VEC                                          0x0008
#define UART_RX_INT                                          0x0005
#define UART_RX_VEC                                          0x000A


#define HSS_BLK_DONE_INT                                     0x0006
#define HSS_BLK_DONE_VEC                                     0x000C
#define HSS_RX_FULL_INT                                      0x0007
#define HSS_RX_FULL_VEC                                      0x000E

#define IDE_DMA_DONE_INT                                     0x0008
#define IDE_DMA_DONE_VEC                                     0x0010

#define Reserved9                                            0x0009

#define HPI_MBOX_RX_FULL_INT                                 0x000A
#define HPI_MBOX_RX_FULL_VEC                                 0x0014
#define HPI_MBOX_TX_EMPTY_INT                                0x000B
#define HPI_MBOX_TX_EMPTY_VEC                                0x0016

#define SPI_TX_INT                                           0x000C
#define SPI_TX_VEC                                           0x0018
#define SPI_RX_INT                                           0x000D
#define SPI_RX_VEC                                           0x001A
#define SPI_DMA_DONE_INT                                     0x000E
#define SPI_DMA_DONE_VEC                                     0x001C

#define OTG_ID_VBUS_VALID_INT                                0x000F
#define OTG_ID_VBUS_VALID_VEC                                0x001E

#define SIE1_HOST_DONE_INT                                   0x0010
#define SIE1_HOST_DONE_VEC                                   0x0020
#define SIE1_HOST_SOF_INT                                    0x0011
#define SIE1_HOST_SOF_VEC                                    0x0022
#define SIE1_HOST_INS_REM_INT                                0x0012
#define SIE1_HOST_INS_REM_VEC                                0x0024

#define Reserved19                                           0x0013

#define SIE1_SLAVE_RESET_INT                                 0x0014
#define SIE1_SLAVE_RESET_VEC                                 0x0028
#define SIE1_SLAVE_SOF_INT                                   0x0015
#define SIE1_SLAVE_SOF_VEC                                   0x002A

#define Reserved22                                           0x0016
#define Reserved23                                           0x0017

#define SIE2_HOST_DONE_INT                                   0x0018
#define SIE2_HOST_DONE_VEC                                   0x0030
#define SIE2_HOST_SOF_INT                                    0x0019
#define SIE2_HOST_SOF_VEC                                    0x0032
#define SIE2_HOST_INS_REM_INT                                0x001A
#define SIE2_HOST_INS_REM_VEC                                0x0034

#define Reserved27                                           0x001B

#define SIE2_SLAVE_RESET_INT                                 0x001C
#define SIE2_SLAVE_RESET_VEC                                 0x0038
#define SIE2_SLAVE_SOF_INT                                   0x001D
#define SIE2_SLAVE_SOF_VEC                                   0x003A

#define Reserved30                                           0x001E
#define Reserved31                                           0x001F

#define SIE1_EP0_INT                                         0x0020
#define SIE1_EP0_VEC                                         0x0040
#define SIE1_EP1_INT                                         0x0021
#define SIE1_EP1_VEC                                         0x0042
#define SIE1_EP2_INT                                         0x0022
#define SIE1_EP2_VEC                                         0x0044
#define SIE1_EP3_INT                                         0x0023
#define SIE1_EP3_VEC                                         0x0046
#define SIE1_EP4_INT                                         0x0024
#define SIE1_EP4_VEC                                         0x0048
#define SIE1_EP5_INT                                         0x0025
#define SIE1_EP5_VEC                                         0x004A
#define SIE1_EP6_INT                                         0x0026
#define SIE1_EP6_VEC                                         0x004C
#define SIE1_EP7_INT                                         0x0027
#define SIE1_EP7_VEC                                         0x004E

#define SIE2_EP0_INT                                         0x0028
#define SIE2_EP0_VEC                                         0x0050
#define SIE2_EP1_INT                                         0x0029
#define SIE2_EP1_VEC                                         0x0052
#define SIE2_EP2_INT                                         0x002A
#define SIE2_EP2_VEC                                         0x0054
#define SIE2_EP3_INT                                         0x002B
#define SIE2_EP3_VEC                                         0x0056
#define SIE2_EP4_INT                                         0x002C
#define SIE2_EP4_VEC                                         0x0058
#define SIE2_EP5_INT                                         0x002D
#define SIE2_EP5_VEC                                         0x005A
#define SIE2_EP6_INT                                         0x002E
#define SIE2_EP6_VEC                                         0x005C
#define SIE2_EP7_INT                                         0x002F
#define SIE2_EP7_VEC                                         0x005E

/*********************************************************/
/*  Interrupts 48 - 63 are reserved for future HW        */
/*********************************************************/
/* ========= SOFTWARE INTERRUPTS ===========             */

#define I2C_INT                                              0x0040
#define LI2C_INT                                             0x0041
#define UART_INT                                             0x0042
#define SCAN_INT                                             0x0043
#define ALLOC_INT                                            0x0044
#define IDLE_INT                                             0x0046
#define IDLER_INT                                            0x0047
#define INSERT_IDLE_INT                                      0x0048
#define PUSHALL_INT                                          0x0049
#define POPALL_INT                                           0x004A
#define FREE_INT                                             0x004B
#define REDO_ARENA                                           0x004C
#define HW_SWAP_REG                                          0x004D
#define HW_REST_REG                                          0x004E
#define SCAN_DECODE_INT                                      0x004F

/*********************************************************/
/* -- INTs 80 to 115 for SUSB ---                        */
/*********************************************************/
#define SUSB1_SEND_INT                                       0x0050
#define SUSB1_RECEIVE_INT                                    0x0051
#define SUSB1_STALL_INT                                      0x0052
#define SUSB1_STANDARD_INT                                   0x0053
#define SUSB1_STANDARD_LOADER_VEC                            0x00A8
#define SUSB1_VENDOR_INT                                     0x0055
#define SUSB1_VENDOR_LOADER_VEC                              0x00AC
#define SUSB1_CLASS_INT                                      0x0057
#define SUSB1_CLASS_LOADER_VEC                               0x00B0
#define SUSB1_FINISH_INT                                     0x0059
#define SUSB1_DEV_DESC_VEC                                   0x00B4
#define SUSB1_CONFIG_DESC_VEC                                0x00B6
#define SUSB1_STRING_DESC_VEC                                0x00B8
#define SUSB1_PARSE_CONFIG_INT                               0x005D
#define SUSB1_LOADER_INT                                     0x005E
#define SUSB1_DELTA_CONFIG_INT                               0x005F

#define SUSB2_SEND_INT                                       0x0060
#define SUSB2_RECEIVE_INT                                    0x0061
#define SUSB2_STALL_INT                                      0x0062
#define SUSB2_STANDARD_INT                                   0x0063
#define SUSB2_STANDARD_LOADER_VEC                            0x00C8
#define SUSB2_VENDOR_INT                                     0x0065
#define SUSB2_VENDOR_LOADER_VEC                              0x00CC
#define SUSB2_CLASS_INT                                      0x0067
#define SUSB2_CLASS_LOADER_VEC                               0x00D0
#define SUSB2_FINISH_INT                                     0x0069
#define SUSB2_DEV_DESC_VEC                                   0x00D4
#define SUSB2_CONFIG_DESC_VEC                                0x00D6
#define SUSB2_STRING_DESC_VEC                                0x00D8
#define SUSB2_PARSE_CONFIG_INT                               0x006D
#define SUSB2_LOADER_INT                                     0x006E
#define SUSB2_DELTA_CONFIG_INT                               0x006F
#define USB_INIT_INT                                         0x0070
#define SUSB_INIT_INT                                        0x0071
#define REMOTE_WAKEUP_INT                                    0x0077
#define START_SRP_INT                                        0x0078

/* SW INT OFFSETS */
/* _VEC suffix indicates value is an address */
/* _INT suffix indicates the sw INT value (1/2 of address) */
#define SUSB2_SWINT_BASE                                     0x00C0
#define SUSB1_SWINT_BASE                                     0x00A0
#define SUSB_SWINT_BASE                                      0x00A0
#define O_SWINT_SUSB1                                        0x0000
#define O_SWINT_SUSB2                                        0x0020

#define O_SWINT_SEND                                         0x0000
#define O_SWINT_RECEIVE                                      0x0002
#define O_SWINT_STALL                                        0x0004
#define O_SWINT_STANDARD                                     0x0006
#define O_SWINT_STD_LDR                                      0x0008
#define O_SWINT_VENDOR_INT                                   0x000A
#define O_SWINT_VENDOR_LDR                                   0x000C
#define O_SWINT_CLASS                                        0x000E
#define O_SWINT_CLASS_LDR                                    0x0010
#define O_SWINT_FINISH                                       0x0012
#define O_SWINT_DEV_DESC                                     0x0014
#define O_SWINT_CONFIG_DESC                                  0x0016
#define O_SWINT_STRING_DESC                                  0x0018
#define O_SWINT_PARSE_CONFIG                                 0x001A
#define O_SWINT_LDR                                          0x001C
#define O_SWINT_DELTA_CONFIG                                 0x001E

/*********************************************************/
/* --- 114 - 117 for Host SW INT's ---                   */
/*********************************************************/
#define HUSB_SIE1_INIT_INT                                   0x0072
#define HUSB_SIE2_INIT_INT                                   0x0073
#define HUSB_RESET_INT                                       0x0074

#define SUSB1_OTG_DESC_VEC                                   0x00EE
#define PWR_DOWN_INT                                         0x0078

/*********************************************************/
/* -- CMD Processor INTs ---                             */
/*********************************************************/
#define SEND_HOST_CMD_INT                                    0x0079
#define PROCESS_PORT_CMD_INT                                 0x007A
#define PROCESS_CRB_INT                                      0x007B

/*********************************************************/
/*--- INT 125, 126 and 127 for Debugger ----             */
/*********************************************************/



#endif

