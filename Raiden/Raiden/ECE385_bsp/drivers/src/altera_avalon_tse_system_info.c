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

#ifdef ALT_INICHE
    #include "ipport.h"
#endif

#include "altera_avalon_tse.h"
#include "altera_avalon_tse_system_info.h"
#include "system.h"
 
#ifdef TSE_MY_SYSTEM
/* define TSE_MY_SYSTEM to customize tse_mac_device[] structure using global array initialization */
	extern alt_tse_system_info tse_mac_device[MAXNETS];
#else

/* use tse_mac_device[] structure as defined in this file
 * or
 * customize tse_mac_device[] structure using API alt_tse_system_add_sys() and alt_tse_sys_enable_mdio_sharing() */
alt_tse_system_info tse_mac_device[MAXNETS] = {
              
        /************************************************************************************/
        #if ( defined(TSE_0_TSE_BASE) && defined(TSE_0_DMA_TX_CSR_NAME) && defined(TSE_0_DMA_RX_CSR_NAME) )
			#ifdef DESCRIPTOR_MEMORY_BASE
                TSE_SYSTEM_EXT_MEM_NO_SHARED_FIFO(TSE_0_TSE, 0, TSE_0_DMA_TX, TSE_0_DMA_RX, TSE_PHY_AUTO_ADDRESS, 0, DESCRIPTOR_MEMORY)
			#else
                TSE_SYSTEM_INT_MEM_NO_SHARED_FIFO(TSE_0_TSE, 0, TSE_0_DMA_TX, TSE_0_DMA_RX, TSE_PHY_AUTO_ADDRESS, 0)
			#endif
        #endif
        /************************************************************************************/		
};

#endif /* TSE_MY_SYSTEM */

