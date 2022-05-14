//io_handler.c
#include "io_handler.h"
#include <stdio.h>

void IO_init(void)
{
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
	*otg_hpi_r = 1;
	*otg_hpi_w = 1;
	*otg_hpi_address = 0;
	*otg_hpi_data = 0;
	// Reset OTG chip
	*otg_hpi_cs = 0;
	*otg_hpi_reset = 0;
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
}

// details are described in the CY7C67200 data sheet


// write data to the memory location specified by the address
// the address should be 2 bits wide
// the data should be 16 bits wide
void IO_write(alt_u8 Address, alt_u16 Data)
{
//*************************************************************************//
//									TASK								   //
//*************************************************************************//

	*otg_hpi_address = Address;
	*otg_hpi_data = Data;
	*otg_hpi_cs = 0;
	*otg_hpi_w = 0;
	*otg_hpi_w = 1;
	*otg_hpi_cs = 1;
}


// read and return data from the memory location specified by the address
// the address should be 2 bits wide
alt_u16 IO_read(alt_u8 Address)
{
	alt_u16 temp;
//*************************************************************************//
//									TASK								   //
//*************************************************************************//

	*otg_hpi_address = Address;
	*otg_hpi_cs = 0;
	*otg_hpi_r = 0;
	temp = *otg_hpi_data;
	*otg_hpi_r = 1;
	*otg_hpi_cs = 1;

	//printf("%x\n",temp);
	return temp;
}
