/*---------------------------------------------------------------------------
  --      usb.h                                                    	   --
  --      Christine Chen                                                   --
  --      Ref. DE2-115 Demonstrations by Terasic Technologies Inc.         --
  --      Fall 2014                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 7                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

#ifndef USB_H_
#define USB_H_

#include "alt_types.h"

/* -----------------------------------------------------------------------
 * HPI implementation
 *
 * The c67x00 chip also support control via SPI or HSS serial
 * interfaces.  However, this driver assumes that register access can
 * be performed from IRQ context.  While this is a safe assuption with
 * the HPI interface, it is not true for the serial interfaces.
 */

/* HPI registers */
#define HPI_DATA    0
#define HPI_MAILBOX 1
#define HPI_ADDR    2
#define HPI_STATUS  3

#define CY7C67200_0_BASE CY7C67200_IF_0_BASE


//------------------------------ function declaration ----------------------------//
//-------------USB operation -----------
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
void UsbWrite(alt_u16 Address, alt_u16 Data);

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
alt_u16 UsbRead(alt_u16 Address);

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
void UsbSoftReset();

void UsbSetAddress();		// Set Address
void UsbGetDeviceDesc1(); 	// Get Device Descriptor -1
void UsbGetDeviceDesc2(); 	// Get Device Descriptor -2
void UsbGetConfigDesc1(); 	// Get Configuration Descriptor -1
void UsbGetConfigDesc2(); 	// Get Configuration Descriptor -2
void UsbSetConfig();		// Set Configuration
void UsbClassRequest();		// Class Request
void UsbGetHidDesc();		// Get HID Descriptor
void UsbGetReportDesc();	// Get Report Descriptor

alt_u16 UsbWaitTDListDone();	// Check and wait until HUSB_TDListDone is read from HPI Data
alt_u16 UsbGetRetryCnt();		// Get RetryCnt for sending the TD

void UsbPrintMem();			// Print the memory contents of EZ-OTG

#endif /* USB_H_ */
