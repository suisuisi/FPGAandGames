/*---------------------------------------------------------------------------
  --      usb.c                                                    	   --
  --      Christine Chen                                                   --
  --      Ref. DE2-115 Demonstrations by Terasic Technologies Inc.         --
  --      Fall 2014                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 7                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

#include "usb.h"

#include "system.h"
#include "alt_types.h"
#include <unistd.h>  // usleep
#include <stdio.h>
//#include <io.h>

#include "io_handler.h"
#include "cy7c67200.h"
#include "lcp_cmd.h"
#include "lcp_data.h"

//#define CY7C67200_0_BASE CY7C67200_IF_0_BASE

//-------------USB operation sub function-----------
/*****************************************************************************/
/**
 *
 * This function writes data to the internal registers of the Cypress
 * CY7C67200 USB controller.
 *
 * @param    Address is the address of the register.
 * @param    Data is the data to be written to the register.
 *
 * @return   None
 *
 * @note     None
 *
 ******************************************************************************/
void UsbWrite(alt_u16 Address, alt_u16 Data)
{
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
}

/*****************************************************************************/
/**
 *
 * This function reads data from the internal registers of the Cypress
 * CY7C67200 USB controller.
 *
 * @param    Address is the address of the register.
 *
 * @return   The data read from the specified address
 *
 * @note     None
 *
 ******************************************************************************/
alt_u16 UsbRead(alt_u16 Address)
{
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
}


/*****************************************************************************/
/**
 *
 * This function does a software reset of the Cypress CY7C67200 USB controller.
 *
 * @param    UsbBaseAddress is the starting location of the USB internal memory
 *           to which this bin file data is written.
 *
 * @return   None
 *
 * @note     None
 *
 ******************************************************************************/
void UsbSoftReset()
{
	//XIo_Out16(USB_MAILBOX, COMM_RESET);
	IO_write(HPI_MAILBOX,COMM_RESET); //COMM_JUMP2CODE
	usleep(100000);
	printf("[USB INIT]:reset finished!\n");

	usleep(500000);
	printf("[USB INIT]:Clear up the interrupt\r\n");
	IO_read(HPI_MAILBOX);
	IO_read(HPI_STATUS);

	// Had to add the write due to a bug in BIOS where they overwrite
	// the mailbox after initialization with garbage.  The read clears
	// any pending interrupts.
	UsbRead (HPI_SIE1_MSG_ADR);
	UsbWrite (HPI_SIE1_MSG_ADR, 0);
	UsbRead (HPI_SIE2_MSG_ADR);
	UsbWrite (HPI_SIE2_MSG_ADR, 0);


	UsbWrite (HOST1_STAT_REG, 0xFFFF);
	UsbWrite (HOST2_STAT_REG, 0xFFFF);
}


void UsbSetAddress()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	// TD #1: 6 writes
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	// TASK: Complete with 4 more IOWR functions
	IO_write(HPI_DATA,0x00D0);
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);
	// TD #2: 4 writes
	// TASK: Complete with 4 IOWR functions
	IO_write(HPI_DATA,0x0500);
	IO_write(HPI_DATA,0x0002);
	IO_write(HPI_DATA,0x0000);
	IO_write(HPI_DATA,0x0000);
	// TD #3: 6 writes
	// TASK: Complete with 6 IOWR functions
	IO_write(HPI_DATA,0x0000); //
	IO_write(HPI_DATA,0x0000);//
	IO_write(HPI_DATA,0x0090);//
	IO_write(HPI_DATA,0x0041);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetDeviceDesc1()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //device address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0680);//c
	IO_write(HPI_DATA,0x0100); //device 0x01
	IO_write(HPI_DATA,0x0000);
	IO_write(HPI_DATA,0x0008);

	//data phase IN
	IO_write(HPI_DATA,0x052C); //
	IO_write(HPI_DATA,0x0008);//
	IO_write(HPI_DATA,0x0290);//
	IO_write(HPI_DATA,0x0041);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0520);

	//    //status phase
	IO_write(HPI_DATA,0x0000); //don't care
	IO_write(HPI_DATA,0x0000);//port number
	IO_write(HPI_DATA,0x0210);//device address
	IO_write(HPI_DATA,0x0041);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}

void UsbGetDeviceDesc2()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //device address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0680);//c
	IO_write(HPI_DATA,0x0100);//e //device 0x01
	IO_write(HPI_DATA,0x0000);//0
	IO_write(HPI_DATA,0x0012);//2

	//data phase IN-1
	IO_write(HPI_DATA,0x0544); //514
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0520);//e

	//data phase IN-2
	IO_write(HPI_DATA,0x054c); //520
	IO_write(HPI_DATA,0x0008);//2
	IO_write(HPI_DATA,0x0290);//4
	IO_write(HPI_DATA,0x0001);//6
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x052c);//a

	//data phase IN-3
	IO_write(HPI_DATA,0x0554); //c
	IO_write(HPI_DATA,0x0002);//e
	IO_write(HPI_DATA,0x0290);//530
	IO_write(HPI_DATA,0x0041);//2
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0538);//6

	//status phase
	IO_write(HPI_DATA,0x0000); //538
	IO_write(HPI_DATA,0x0000);//a
	IO_write(HPI_DATA,0x0210);//c
	IO_write(HPI_DATA,0x0041);//e
	IO_write(HPI_DATA,0x0013);//540
	IO_write(HPI_DATA,0x0000);//2

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetConfigDesc1()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //device address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0680);//c
	IO_write(HPI_DATA,0x0200);//e //config 0x02
	IO_write(HPI_DATA,0x0000);//0
	IO_write(HPI_DATA,0x0009);//2

	//data phase IN-1
	IO_write(HPI_DATA,0x0544); //514
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0520);//e

	//data phase IN-2
	IO_write(HPI_DATA,0x054c); //520
	IO_write(HPI_DATA,0x0001);//2
	IO_write(HPI_DATA,0x0290);//4
	IO_write(HPI_DATA,0x0001);//6 //data0
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x052c);//a

	//status phase
	IO_write(HPI_DATA,0x0000); //52c
	IO_write(HPI_DATA,0x0000);//e
	IO_write(HPI_DATA,0x0210);//530
	IO_write(HPI_DATA,0x0041);//2
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0000);//6

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetConfigDesc2()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //device address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0680);//c
	IO_write(HPI_DATA,0x0200);//e //config 0x02
	IO_write(HPI_DATA,0x0000);//0
	IO_write(HPI_DATA,0x00FF);//2

	//data phase IN-1
	IO_write(HPI_DATA,0x055c); //514
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0520);//e

	//data phase IN-2
	IO_write(HPI_DATA,0x0564); //520
	IO_write(HPI_DATA,0x0008);//2
	IO_write(HPI_DATA,0x0290);//4
	IO_write(HPI_DATA,0x0001);//6 //data0
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x052c);//a

	//data phase IN-3
	IO_write(HPI_DATA,0x056c); //52c
	IO_write(HPI_DATA,0x0008);//e
	IO_write(HPI_DATA,0x0290);//530
	IO_write(HPI_DATA,0x0041);//2
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0538);//6

	//data phase IN-4
	IO_write(HPI_DATA,0x0574); //538
	IO_write(HPI_DATA,0x0008);//a
	IO_write(HPI_DATA,0x0290);//c
	IO_write(HPI_DATA,0x0001);//e //data0
	IO_write(HPI_DATA,0x0013);//540
	IO_write(HPI_DATA,0x0544);//2

	//data phase IN-5
	IO_write(HPI_DATA,0x057c); //544
	IO_write(HPI_DATA,0x0002);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a //data1
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0550);//e

	//status phase
	IO_write(HPI_DATA,0x0000); //550
	IO_write(HPI_DATA,0x0000);//2
	IO_write(HPI_DATA,0x0210);//4
	IO_write(HPI_DATA,0x0041);//6
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x0000);//a

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}

void UsbSetConfig()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //port address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0900);
	IO_write(HPI_DATA,0x0001);//device address
	IO_write(HPI_DATA,0x0000);
	IO_write(HPI_DATA,0x0000);
	//in packet
	IO_write(HPI_DATA,0x0000); //don't care
	IO_write(HPI_DATA,0x0000);//port number
	IO_write(HPI_DATA,0x0290);//device address
	IO_write(HPI_DATA,0x0041); //data 1
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}

void UsbClassRequest()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //port address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0A21);
	IO_write(HPI_DATA,0x0000);//device address
	IO_write(HPI_DATA,0x0000);
	IO_write(HPI_DATA,0x0000);
	//in packet
	IO_write(HPI_DATA,0x0000); //don't care
	IO_write(HPI_DATA,0x0000);//port number /data length
	IO_write(HPI_DATA,0x0290);//device address
	IO_write(HPI_DATA,0x0041); //data 1
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetHidDesc()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //port address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0681);//c
	IO_write(HPI_DATA,0x2100);//e //HID 0x21
	IO_write(HPI_DATA,0x0000);//0
	IO_write(HPI_DATA,0x007B);//2

	//data phase IN-1
	IO_write(HPI_DATA,0x0544); //514
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0520);//e

	//status phase
	IO_write(HPI_DATA,0x0000); //52c
	IO_write(HPI_DATA,0x0000);//e
	IO_write(HPI_DATA,0x0210);//530
	IO_write(HPI_DATA,0x0041);//2
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0000);//6

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}


void UsbGetReportDesc()
{
	//the starting address
	IO_write(HPI_ADDR,0x0500); //the start address
	IO_write(HPI_DATA,0x050C);
	IO_write(HPI_DATA,0x0008); //4 port number
	IO_write(HPI_DATA,0x02D0); //device address
	IO_write(HPI_DATA,0x0001);
	IO_write(HPI_DATA,0x0013);
	IO_write(HPI_DATA,0x0514);

	//td content 4 bytes
	IO_write(HPI_DATA,0x0681);//c
	IO_write(HPI_DATA,0x2200);//e //report 0x22
	IO_write(HPI_DATA,0x0000);//0
	IO_write(HPI_DATA,0x007B);//2

	//data phase IN-1
	IO_write(HPI_DATA,0x0580); //514
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0520);//e

	//data phase IN-2
	IO_write(HPI_DATA,0x0588); //520
	IO_write(HPI_DATA,0x0008);//2
	IO_write(HPI_DATA,0x0290);//4
	IO_write(HPI_DATA,0x0001);//6 //data0
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x052c);//a

	//data phase IN-3
	IO_write(HPI_DATA,0x0590); //52c
	IO_write(HPI_DATA,0x0008);//e
	IO_write(HPI_DATA,0x0290);//530
	IO_write(HPI_DATA,0x0041);//2
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0538);//6

	//data phase IN-4
	IO_write(HPI_DATA,0x0598); //538
	IO_write(HPI_DATA,0x0008);//a
	IO_write(HPI_DATA,0x0290);//c
	IO_write(HPI_DATA,0x0001);//e //data0
	IO_write(HPI_DATA,0x0013);//540
	IO_write(HPI_DATA,0x0544);//2

	//data phase IN-5
	IO_write(HPI_DATA,0x05a0); //544
	IO_write(HPI_DATA,0x0008);//6
	IO_write(HPI_DATA,0x0290);//8
	IO_write(HPI_DATA,0x0041);//a //data1
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0550);//e

	//data phase IN-6
	IO_write(HPI_DATA,0x05a8); //550
	IO_write(HPI_DATA,0x0008);//2
	IO_write(HPI_DATA,0x0290);//4
	IO_write(HPI_DATA,0x0001);//6 //data0
	IO_write(HPI_DATA,0x0013);//8
	IO_write(HPI_DATA,0x055c);//a

	//data phase IN-7
	IO_write(HPI_DATA,0x05b0); //c
	IO_write(HPI_DATA,0x0008);//e
	IO_write(HPI_DATA,0x0290);//560
	IO_write(HPI_DATA,0x0041);//2 //data1
	IO_write(HPI_DATA,0x0013);//4
	IO_write(HPI_DATA,0x0568);//6

	//data phase IN-8
	IO_write(HPI_DATA,0x05b8); //8
	IO_write(HPI_DATA,0x0003);//a
	IO_write(HPI_DATA,0x0290);//c
	IO_write(HPI_DATA,0x0001);//e //data0
	IO_write(HPI_DATA,0x0013);//570
	IO_write(HPI_DATA,0x0574);//2

	//status phase
	IO_write(HPI_DATA,0x0000); //574
	IO_write(HPI_DATA,0x0000);//6
	IO_write(HPI_DATA,0x0210);//8
	IO_write(HPI_DATA,0x0041);//a
	IO_write(HPI_DATA,0x0013);//c
	IO_write(HPI_DATA,0x0000);//e

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}


alt_u16 UsbWaitTDListDone()
{
	alt_u16 usb_ctl_val;

	usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR); // STEP 3 j
	UsbWrite(HPI_SIE1_MSG_ADR, 0);
	while (usb_ctl_val != HUSB_TDListDone)  // k, read sie1 msg register
	{
		if(usb_ctl_val == 0x0000)
		{
		}
		else
		{
			printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
		}
		usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
		UsbWrite(HPI_SIE1_MSG_ADR, 0);
	}

	return usb_ctl_val;
}


alt_u16 UsbGetRetryCnt()
{
	alt_u16 usb_ctl_val;

	IO_read(HPI_STATUS);
	if(UsbRead(HPI_SIE1_MSG_ADR) == HUSB_TDListDone)
	{
		UsbWrite(HPI_SIE1_MSG_ADR, 0);

		while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
		{
		}
	}
	//usleep(1000);
	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);

	return usb_ctl_val;
}


void UsbPrintMem()
{
	int i, code;
	IO_write(HPI_ADDR,0x0500); //the start address
	for (i = 0; i <= 200; i += 2)
	{
		code = IO_read(HPI_DATA);
		printf("\naddr %x = %04x\n", 0x0500+i, code);
	}
}

