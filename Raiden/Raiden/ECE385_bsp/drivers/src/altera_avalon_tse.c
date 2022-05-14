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

#include "altera_avalon_tse.h"
#include "sys/alt_cache.h" 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void no_printf (char *fmt, ...) {}

#ifdef __ALTERA_MSGDMA


/** @Function Description - Perform initialization steps on transaction info structure to prepare it for .
  *                        use by the library functions with two MSGDMAs and extra initialization Flags
  * @API Type:          Internal
  * @param mi           Main Device Structure.
  * @param mac_base     Base Address of the Control interface for the TSE MAC
  * @param tx_msgdma     MSGDMA device handle for TSE transmit data path 
  * @param rx_msgdma     MSGDMA device handle for TSE receive data path
  * @param cfgflags     initialization flags for the device
  * @return 0 
  */

alt_32 tse_mac_initTransInfo2( tse_mac_trans_info *mi,
                                        alt_u32 mac_base,
                                        alt_32 tx_msgdma,
                                        alt_32 rx_msgdma,
                                        alt_32 cfgflags) {
                                              
        mi->base     = (np_tse_mac*)mac_base;
        mi->tx_msgdma = (alt_msgdma_dev *)tx_msgdma;
        mi->rx_msgdma = (alt_msgdma_dev *)rx_msgdma;
        mi->cfgflags = cfgflags;     
        return SUCCESS;
}

/** @Function Description - Synchronous MSGDMA copy from buffer memory into transmit FIFO. Waits until 
  *                         SGDMA has completed.  Raw function without any error checks.
  * @API Type:              Internal
  * @param mi               Main Device Structure.
  * @param txDesc           Pointer to the transmit MSGDMA descriptor
  * @return actual bytes transferred if ok, else error (-1)
  */
alt_32 tse_mac_sTxWrite( tse_mac_trans_info *mi, 
                       alt_msgdma_standard_descriptor *txDesc)   
{ 

  alt_32 timeout;
  alt_u8 result = 0;
  
  // Make sure DMA controller is not busy from a former command
  // and TX is able to accept data
  timeout = 0;
  while ( (IORD_ALTERA_MSGDMA_CSR_STATUS(mi->tx_msgdma->csr_base) & 
           ALTERA_MSGDMA_CSR_BUSY_MASK) ) {
           if(timeout++ == ALTERA_TSE_MSGDMA_BUSY_TIME_OUT_CNT) {
            tse_dprintf(4, "WARNING : TX MSGDMA Timeout\n");
            return ENP_RESOURCE;  // avoid being stuck here
           }
  }
  
  // Start MSGDMA (blocking call)
  alt_dcache_flush(txDesc,sizeof(alt_msgdma_standard_descriptor));
  result = alt_msgdma_standard_descriptor_sync_transfer(
                mi->tx_msgdma, 
                txDesc);
  
  if (result != 0) {
    tse_dprintf(4, "WARNING :alt_msgdma_standard_descriptor_sync_transfer Error code 0x%x\n",result);
    return -1;
  }

  return 0;
}


/** @Function Description - Asynchronous MSGDMA copy from rxFIFO into given buffer memory area.
  *                         Raw function without any error checks.
  *
  * @API Type:    Internal
  * @param mi     Main Device Structure.
  * @param rxDesc Pointer to the receive MSGDMA descriptor list
  * @return 0 if ok, else error (-1)
  *
  * Note:  At the point of this function call return, 
  *        the MSGDMA asynchronous operation may not have been
  *        completed yet, so the function does not return
  *        the actual bytes transferred for current descriptor
  */
alt_32 tse_mac_aRxRead( 
  tse_mac_trans_info *mi,       
  alt_msgdma_prefetcher_standard_descriptor *rxDesc)  
{
  alt_u8 result;
           
  result = alt_msgdma_start_prefetcher_with_std_desc_list(
                mi->rx_msgdma, 
                rxDesc,0,0,1,1);
  
  if (result != 0) { return -1; }
 
  return SUCCESS;
}

/** @Function Description - Asynchronous MSGDMA transfer from buffer to txFIFO 
  *               
  *
  * @API Type:    Internal
  * @param mi     Main Device Structure.
  * @param rxDesc Pointer to the transmit MSGDMA descriptor list
  * @return 0 if ok, or (-1) if error
  *
  */
alt_32 tse_mac_aTxWrite( 
  tse_mac_trans_info *mi,       
  alt_msgdma_prefetcher_standard_descriptor *txDesc)  
{
  alt_u8 result;
  
  result = alt_msgdma_start_prefetcher_with_std_desc_list(
                mi->tx_msgdma, 
                txDesc,0,0,1,1);

  if (result != 0) { return -1; }
 
  return SUCCESS;
}


#endif /* __ALTERA_MSGDMA */

/* Definition of TSE system */
extern alt_tse_system_info tse_mac_device[MAXNETS];

/* PHY profile*/
alt_tse_phy_profile *pphy_profiles[TSE_MAX_PHY_PROFILE];
alt_u8 phy_profile_count = 0;

/* MAC in TSE system */
alt_tse_mac_group *pmac_groups[TSE_MAX_MAC_IN_SYSTEM];
alt_u8 mac_group_count = 0;
alt_u8 max_mac_system = MAXNETS;

/*******************************
 *
 * Public API for TSE Driver 
 *
 *******************************/
 
/* @Function Description: Perform a software Reset. Reset operation will ocur with some latency.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
*/
alt_32 tse_mac_SwReset(np_tse_mac *pmac) 
{
    alt_32 timeout;
    alt_32 cc;
        
    cc = IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac);
    
    // set reset and Gig-Speed bits to make sure we have an incoming clock on
    // tx side. If there is a 10/100 PHY, we will still have a valid clock on
    // tx_clk no matter what setting we have here, but on a Gig phy the
    // MII clock may be missing.
    IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac,(ALTERA_TSEMAC_CMD_SW_RESET_MSK | ALTERA_TSEMAC_CMD_ETH_SPEED_MSK));

    
    // wait for completion with fallback in case there is no PHY or it is
    // not connected and hence might not provide any clocks at all.
    timeout=0;
    while( (IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac) & ALTERA_TSEMAC_CMD_SW_RESET_MSK) != 0 && timeout < ALTERA_TSE_SW_RESET_TIME_OUT_CNT) timeout++;
   
    IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac,cc); // Restore
    return SUCCESS;
}



/* @Function Description: Perform switching of the TSE MAC into MII (10/100) mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
*/
alt_32 tse_mac_setMIImode(np_tse_mac *pmac)
{
  alt_32 helpvar;
  
  helpvar = IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac);
  helpvar &= ~ALTERA_TSEMAC_CMD_ETH_SPEED_MSK; 
  
  IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac,helpvar);
  return SUCCESS;
}


/* @Function Description: Perform switching of the TSE MAC into GMII (Gigabit) mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Public
 * @param pmac  Pointer to the TSE MAC Control Interface Base address 
 */
alt_32 tse_mac_setGMIImode(np_tse_mac *pmac)
{
  alt_32 helpvar;
  
  helpvar = IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac);
  helpvar |= ALTERA_TSEMAC_CMD_ETH_SPEED_MSK;

  IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac,helpvar);
  return SUCCESS;
}



/* @Function Description - Add additional PHYs which are not supported by default into PHY profile for PHY detection and auto negotiation
 * 
 * @API TYPE - Public
 * @param  phy  pointer to alt_tse_phy_profile structure describing PHY registers
 * @return      index of PHY added in PHY profile on success, else return ALTERA_TSE_MALLOC_FAILED if memory allocation failed
 * PHY which are currently supported by default :  Marvell 88E1111, Marvell Quad PHY 88E1145, National DP83865, and National DP83848C
 */
alt_32 alt_tse_phy_add_profile(alt_tse_phy_profile *phy)
{
    alt_32 i;
    
    /* search PHY profile for same ID */
    for(i = 0; i < phy_profile_count; i++)
    {
        if(pphy_profiles[i]->oui == phy->oui && pphy_profiles[i]->model_number == phy->model_number)
        {
            tse_dprintf(4, "WARNING : PHY OUI 0x%06x, PHY Model Number 0x%02x already exist in PHY profile\n", (int) phy->oui, phy->model_number);
            tse_dprintf(4, "In case of same PHY OUI and PHY Model Number in profile, first added PHY setting will be used\n");
        }
    }

    /* Allocate memory space to store the profile */    
    pphy_profiles[phy_profile_count] = (alt_tse_phy_profile *) malloc(sizeof(alt_tse_phy_profile));
    if(!pphy_profiles[phy_profile_count]) {
        tse_dprintf(1, "ERROR   : Unable to allocate memory for pphy_profile[%d]\n", phy_profile_count);
        return ALTERA_TSE_MALLOC_FAILED;
    }

    /* Store PHY information */
    *pphy_profiles[phy_profile_count] = *phy;
    strcpy(pphy_profiles[phy_profile_count]->name, phy->name);
    
    phy_profile_count++;
    
    return phy_profile_count - 1;
}

/* @Function Description - Add TSE System to tse_mac_device[] array to customize TSE System
 * 
 * @API TYPE - Public
 * @param        psys_mac  pointer to alt_tse_system_mac structure describing MAC of the system
 * @param        psys_msgdma  pointer to alt_tse_system_msgdma structure describing MSGDMA of the system
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
    alt_tse_system_phy                     *psys_phy ) {

    int i;
    int loop_end;
    
    alt_tse_system_mac                    *pmac    = psys_mac;
    alt_tse_system_msgdma                *pmsgdma    = psys_msgdma;
    alt_tse_system_desc_mem                *pmem    = psys_mem;
    alt_tse_system_shared_fifo            *pfifo    = psys_shared_fifo;
    alt_tse_system_phy                     *pphy    = psys_phy;
    
    static alt_8 tse_system_count = 0;
    
    /* Determine number of loop */
    /* Run at least one for non-multi-channel MAC */
    if(pmac->tse_num_of_channel == 0) {
        loop_end = 1;
    }
    else if(pmac->tse_num_of_channel > 0) {
        loop_end = pmac->tse_num_of_channel; 
    }
    else {
        tse_dprintf(2, "ERROR   : Invalid number of channel specified!\n");
        return ALTERA_TSE_SYSTEM_DEF_ERROR;
    }

    for(i = 0; i < loop_end; i++) {
        
        /* Make sure the boundary of array is not exceeded */
        if(tse_system_count >= MAXNETS) {
            tse_dprintf(2, "ERROR   : Number of TSE System added exceed the size of array!\n");
            tse_dprintf(2, "ERROR   : Size of array = %d, Number of TSE System = %d\n", MAXNETS, tse_system_count);
        }

        /* Add MAC info to alt_tse_system_info structure */
        if(pmac == 0) {
            tse_dprintf(2, "ERROR   : MAC system structure == NULL\n");
            tse_dprintf(2, "ERROR   : Please pass in correct pointer to alt_tse_system_add_sys()\n");
            return ALTERA_TSE_SYSTEM_DEF_ERROR;
        }        
        
        tse_mac_device[tse_system_count].tse_mac_base                     = pmac->tse_mac_base + (i * 0x400);
        tse_mac_device[tse_system_count].tse_tx_depth                     = pmac->tse_tx_depth;
        tse_mac_device[tse_system_count].tse_rx_depth                     = pmac->tse_rx_depth;
        tse_mac_device[tse_system_count].tse_use_mdio                     = pmac->tse_use_mdio;
        tse_mac_device[tse_system_count].tse_en_maclite                 = pmac->tse_en_maclite;
        tse_mac_device[tse_system_count].tse_maclite_gige                 = pmac->tse_maclite_gige;
        tse_mac_device[tse_system_count].tse_multichannel_mac             = pmac->tse_multichannel_mac;
        tse_mac_device[tse_system_count].tse_num_of_channel             = pmac->tse_num_of_channel;
        tse_mac_device[tse_system_count].tse_mdio_shared                 = pmac->tse_mdio_shared;
        tse_mac_device[tse_system_count].tse_number_of_mac_mdio_shared    = pmac->tse_number_of_mac_mdio_shared;
        tse_mac_device[tse_system_count].tse_pcs_ena                     = pmac->tse_pcs_ena;
        tse_mac_device[tse_system_count].tse_pcs_sgmii                     = pmac->tse_pcs_sgmii;
        
        /* Add MSGDMA info to alt_tse_system_info structure */
        if(pmsgdma == 0) {
            tse_dprintf(2, "ERROR   : MSGDMA system structure == NULL\n");
            tse_dprintf(2, "ERROR   : Please pass in correct pointer to alt_tse_system_add_sys() for tse_mac_device[%d]\n", tse_system_count);
            return ALTERA_TSE_SYSTEM_DEF_ERROR;
        }
        
        tse_mac_device[tse_system_count].tse_msgdma_tx = (char *) malloc(strlen(pmsgdma->tse_msgdma_tx) + 1);
        if(!tse_mac_device[tse_system_count].tse_msgdma_tx) {
            tse_dprintf(1, "ERROR   : Unable to allocate memory for tse_mac_device[%d].tse_msgdma_tx\n", tse_system_count);
            return ALTERA_TSE_MALLOC_FAILED;
        }   
        strcpy(tse_mac_device[tse_system_count].tse_msgdma_tx, pmsgdma->tse_msgdma_tx);
        
        tse_mac_device[tse_system_count].tse_msgdma_rx = (char *) malloc(strlen(pmsgdma->tse_msgdma_rx) + 1);
        if(!tse_mac_device[tse_system_count].tse_msgdma_rx) {
            tse_dprintf(1, "ERROR   : Unable to allocate memory for tse_mac_device[%d].tse_msgdma_rx\n", tse_system_count);
            return ALTERA_TSE_MALLOC_FAILED;
        }
        strcpy(tse_mac_device[tse_system_count].tse_msgdma_rx, pmsgdma->tse_msgdma_rx);
        
        tse_mac_device[tse_system_count].tse_msgdma_rx_irq = pmsgdma->tse_msgdma_rx_irq;
        
        /* Add descriptor memory info to alt_tse_system_info structure */
        if(pmem == 0) {
            tse_mac_device[tse_system_count].ext_desc_mem    = TSE_INT_DESC_MEM;
            tse_mac_device[tse_system_count].desc_mem_base    = TSE_INT_DESC_MEM;
        }
        else {
            tse_mac_device[tse_system_count].ext_desc_mem    = pmem->ext_desc_mem;
            tse_mac_device[tse_system_count].desc_mem_base    = pmem->desc_mem_base;
        }
        
        /* Add shared fifo info to alt_tse_system_info structure */
        if(pfifo == 0) {
            tse_mac_device[tse_system_count].use_shared_fifo                = TSE_NO_SHARED_FIFO;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_ctrl_base    = TSE_NO_SHARED_FIFO;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_stat_base    = TSE_NO_SHARED_FIFO;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_depth       = TSE_NO_SHARED_FIFO;
            
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_ctrl_base    = TSE_NO_SHARED_FIFO;
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_stat_base    = TSE_NO_SHARED_FIFO;
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_depth       = TSE_NO_SHARED_FIFO;
        }
        else {
            tse_mac_device[tse_system_count].use_shared_fifo                = pfifo->use_shared_fifo;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_ctrl_base    = pfifo->tse_shared_fifo_tx_ctrl_base;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_stat_base    = pfifo->tse_shared_fifo_tx_stat_base;
            tse_mac_device[tse_system_count].tse_shared_fifo_tx_depth       = pfifo->tse_shared_fifo_tx_depth;
            
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_ctrl_base    = pfifo->tse_shared_fifo_rx_ctrl_base;
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_stat_base    = pfifo->tse_shared_fifo_rx_stat_base;
            tse_mac_device[tse_system_count].tse_shared_fifo_rx_depth       = pfifo->tse_shared_fifo_rx_depth;
        }
        
        /* Add PHY info to alt_tse_system_info structure */
        if(pphy == 0) {
            tse_mac_device[tse_system_count].tse_phy_mdio_address    = TSE_PHY_AUTO_ADDRESS;
            tse_mac_device[tse_system_count].tse_phy_cfg             = 0;
        }
        else {
            tse_mac_device[tse_system_count].tse_phy_mdio_address    = pphy->tse_phy_mdio_address;
            tse_mac_device[tse_system_count].tse_phy_cfg             = pphy->tse_phy_cfg;
        }
        
        /* Point to next structure */
        pmsgdma++;
        if(pmem) pmem++;
        if(pfifo) pfifo++;
        if(pphy) pphy++;
        
        tse_system_count++;
        max_mac_system = tse_system_count;
    }
    
    return SUCCESS;
    
}

/* @Function Description - Enable MDIO sharing for multiple single channel MAC
 * 
 * @API TYPE - Public
 * @param        psys_mac_list  pointer to array of alt_tse_system_mac structure sharing MDIO block
 * @param        number_of_mac  number of MAC sharing MDIO block
 * @return      SUCCESS on success
 *                 ALTERA_TSE_SYSTEM_DEF_ERROR if definition of system incorrect or pointer == NULL
 * Multi-channel MAC not supported
 */
alt_32 alt_tse_sys_enable_mdio_sharing(alt_tse_system_mac **psys_mac_list, alt_u8 number_of_mac) {
    alt_32 i;
    alt_32 j;
    
    alt_tse_system_mac *psys_mac;
    
    for(i = 0; i < number_of_mac; i++) {
        psys_mac = psys_mac_list[i];
        
        if(psys_mac == 0) {
            tse_dprintf(2, "ERROR   : MAC system structure == NULL\n");
            tse_dprintf(2, "ERROR   : Please pass in correct pointer to alt_tse_sys_enable_mdio_sharing()\n");
            return ALTERA_TSE_SYSTEM_DEF_ERROR;
        }
        
        for(j = 0; j < max_mac_system; j++) {
            
            if(psys_mac->tse_mac_base == tse_mac_device[j].tse_mac_base) {
                if(tse_mac_device[j].tse_multichannel_mac) {
                    tse_dprintf(2, "ERROR   : MDIO sharing supported by default for Multi-channel MAC\n");
                    tse_dprintf(2, "ERROR   : Do not include Multi-channel MAC in the MAC List\n");
                    return ALTERA_TSE_SYSTEM_DEF_ERROR;
                }
                
                tse_mac_device[j].tse_mdio_shared = 1;
                tse_mac_device[j].tse_number_of_mac_mdio_shared = number_of_mac;
            }
        }    
    }
    
    return SUCCESS;
}

/* @Function Description: Get the common speed supported by all PHYs connected to the MAC within the same group
 * @API Type:           Public
 * @param pmac          Pointer to the TSE MAC Control Interface Base address
 * @return              common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if no common speed found
 */
alt_32 alt_tse_mac_get_common_speed(np_tse_mac *pmac) {
    alt_tse_mac_group *pmac_group = alt_tse_get_mac_info(pmac)->pmac_group;
    return alt_tse_phy_get_common_speed(pmac_group);
}

/* @Function Description: Set the common speed to all PHYs connected to the MAC within the same group
 * @API Type:               Public
 * @param pmac              Pointer to the TSE MAC Control Interface Base address
 *        common_speed      common speed supported by all PHYs
 * @return                  common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if invalid common speed specified
 */
alt_32 alt_tse_mac_set_common_speed(np_tse_mac *pmac, alt_32 common_speed) {
    alt_tse_mac_group *pmac_group = alt_tse_get_mac_info(pmac)->pmac_group;
    return alt_tse_phy_set_common_speed(pmac_group, common_speed);
}


/********************************
 *
 * Internal API for TSE Driver 
 *
 *******************************/

/* @Function Description: Get the index of alt_tse_system_info structure in tse_mac_device[]
 * @API Type:        Internal
 * @param psys_info  Pointer to the alt_tse_system_info structure
 * @return           Index of alt_tse_system_info structure in tse_mac_device[]
 */
alt_32 alt_tse_get_system_index(alt_tse_system_info *psys_info) {
    alt_32 i;
    
    for(i = 0; i < max_mac_system; i++) {
        if(psys_info == &tse_mac_device[i]) {
            return i;
        }
    }
    return ALTERA_TSE_NO_INDEX_FOUND;
}

/* @Function Description: Get the index of alt_tse_mac_group structure in pmac_groups[]
 * @API Type:         Internal
 * @param pmac_group  Pointer to the alt_tse_mac_group structure
 * @return            Index of alt_tse_mac_group structure in pmac_groups[]
 */
alt_32 alt_tse_get_mac_group_index(alt_tse_mac_group *pmac_group) {
    alt_32 i;
    
    for(i = 0; i < mac_group_count; i++) {
        if(pmac_group == pmac_groups[i]) {
            return i;
        }
    }
    return ALTERA_TSE_NO_INDEX_FOUND;
}


/* @Function Description: Get the index of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 * @API Type:         Internal
 * @param pmac_group  Pointer to the alt_tse_mac_info structure
 * @return            Index of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 */
alt_32 alt_tse_get_mac_info_index(alt_tse_mac_info *pmac_info) {
    alt_32 i;
    
    for(i = 0; i < pmac_info->pmac_group->channel; i++) {
        if(pmac_info == pmac_info->pmac_group->pmac_info[i]) {
            return i;
        }
    }
    
    return ALTERA_TSE_NO_INDEX_FOUND;
}

/* @Function Description: Get the pointer of alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 * @API Type:         Internal
 * @param pmac        Pointer to the TSE MAC Control Interface Base address
 * @return            Pointer to alt_tse_mac_info structure in pmac_groups[]->pmac_info[]
 */
alt_tse_mac_info *alt_tse_get_mac_info(np_tse_mac *pmac) {
    alt_32 i;
    alt_32 j;
    alt_tse_mac_group *pmac_group = 0;
    alt_tse_mac_info *pmac_info = 0;
    
    for(i = 0; i < mac_group_count; i++) {
        pmac_group = pmac_groups[i];
        for(j = 0; j < pmac_group->channel; j++) {
            pmac_info = pmac_group->pmac_info[j];
            if(((np_tse_mac *) pmac_info->psys_info->tse_mac_base) == pmac) {
                return pmac_info;
            }
        }        
    }
    
    return 0;
}
    
/* @Function Description: Perform switching of the TSE MAC speed.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Internal
 * @param pmac  Pointer to the TSE MAC Control Interface Base address
 * @param speed 2 = 1000 Mbps, 1 = 100 Mbps, 0 = 10 Mbps
 * @return ENP_PARAM if invalid speed specified, else return SUCCESS
 */
alt_32 alt_tse_mac_set_speed(np_tse_mac *pmac, alt_u8 speed)
{
  alt_32 helpvar;
  
  helpvar = IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac);
  
  /* 1000 Mbps */
  if(speed == TSE_PHY_SPEED_1000) {
    helpvar |= ALTERA_TSEMAC_CMD_ETH_SPEED_MSK;
    helpvar &= ~ALTERA_TSEMAC_CMD_ENA_10_MSK;
  }
  /* 100 Mbps */
  else if(speed == TSE_PHY_SPEED_100) {
    helpvar &= ~ALTERA_TSEMAC_CMD_ETH_SPEED_MSK;
    helpvar &= ~ALTERA_TSEMAC_CMD_ENA_10_MSK;
  }
  /* 10 Mbps */
  else if(speed == TSE_PHY_SPEED_10) {
    helpvar &= ~ALTERA_TSEMAC_CMD_ETH_SPEED_MSK;
    helpvar |= ALTERA_TSEMAC_CMD_ENA_10_MSK;
  }  
  else {
    return ENP_PARAM;
  }
  
  IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac, helpvar);
  return SUCCESS;
}

/* @Function Description: Perform switching of the TSE MAC duplex mode.
 *                        COMMAND_CONFIG register is restored after reset.
 * @API Type:   Internal
 * @param pmac  Pointer to the TSE MAC Control Interface Base address
 * @param duplex 1 = Full Duplex, 0 = Half Duplex
 * @return ENP_PARAM if invalid duplex specified, else return SUCCESS
 */
alt_32 alt_tse_mac_set_duplex(np_tse_mac *pmac, alt_u8 duplex)
{
  alt_32 helpvar;
  
  helpvar = IORD_ALTERA_TSEMAC_CMD_CONFIG(pmac);
  
  /* Half Duplex */
  if(duplex == TSE_PHY_DUPLEX_HALF) {
    helpvar |= ALTERA_TSEMAC_CMD_HD_ENA_MSK;
  } 
  /* Full Duplex */
  else if(duplex == TSE_PHY_DUPLEX_FULL) {
    helpvar &= ~ALTERA_TSEMAC_CMD_HD_ENA_MSK;
  }
  else {
    return ENP_PARAM;
  }
  
  IOWR_ALTERA_TSEMAC_CMD_CONFIG(pmac, helpvar);
  return SUCCESS;

}



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

#define ALT_TSE_SPEED_DUPLEX(speed, duplex) ((duplex & 0x01) |\
      (((speed == TSE_PHY_SPEED_1000) ? 1 : 0) << 1) |   \
    (((speed == TSE_PHY_SPEED_100) ? 1 : 0) << 2) |     \
    (((speed == TSE_PHY_SPEED_10) ? 1 : 0) << 3) |      \
    ((speed == TSE_PHY_SPEED_INVALID) ? ALT_TSE_E_INVALID_SPEED : 0))
  
alt_32 getPHYSpeed(np_tse_mac *pmac) {

    alt_u8 speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
    alt_u8 duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;     /* 1 = full ; 0 = half*/
    alt_32 result = ALT_TSE_SPEED_DUPLEX(speed, duplex);
    
    alt_tse_phy_info *pphy = 0;
    alt_tse_mac_info *pmac_info = 0;
    alt_tse_mac_group *pmac_group = 0;
    alt_tse_system_info *psys = 0;
    
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = 0;
    alt_8 mac_group_index = 0;
    
    /* initialized PHYs only once */
    static alt_u8 is_init = 0;
    if(is_init == 0) {
        alt_tse_phy_init();
        is_init = 1;
    }
    
    /* Look for pmac_group and pmac_info structure based on pmac or iface */
    pmac_info = alt_tse_get_mac_info(pmac);
    
    if(pmac_info == 0) {
        speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
        duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
        result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_NO_PMAC_FOUND;
        tse_dprintf(2, "ERROR   : [getPHYSpeed] pmac not found from list of pmac_info[]! Speed = %s Mbps, Duplex = %s\n", speed == TSE_PHY_SPEED_1000 ? "1000" :
                                                                                 speed == TSE_PHY_SPEED_100 ? "100" :
                                                                                 speed == TSE_PHY_SPEED_10 ? "10" : "Unknown",
                                                                                 duplex == 1 ? "Full" : "Half");
        tse_dprintf(2, "ERROR   : [getPHYSpeed] Please define tse_mac_device[] correctly\n");
        return result;
    }
    
    pphy = pmac_info->pphy_info;
    pmac_group = pmac_info->pmac_group;
    psys = pmac_info->psys_info;
    
    mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    mac_group_index = alt_tse_get_mac_group_index(pmac_group);
         
    /* MDIO is not used */
    if (pmac_group->pmac_info[0]->psys_info->tse_use_mdio == 0)
    {
        speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
        duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
        result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_NO_MDIO;
        usleep(ALTERA_NOMDIO_TIMEOUT_THRESHOLD);
        if(psys->tse_phy_cfg) {
            tse_dprintf(4, "WARNING : PHY[%d.%d] - MDIO not enabled! Running user configuration...\n", mac_group_index, mac_info_index);
            result = psys->tse_phy_cfg(pmac);
        }
        else {
            tse_dprintf(4, "WARNING : MAC Group[%d] - MDIO not enabled! Speed = %s, Duplex = %s\n", mac_group_index, speed == TSE_PHY_SPEED_1000 ? "1000" :
                                                                                 speed == TSE_PHY_SPEED_100 ? "100" :
                                                                                 speed == TSE_PHY_SPEED_10 ? "10" : "Unknown",
                                                                                 duplex == 1 ? "Full" : "Half");
        }
        return result;
    }

    /* Not running simulation */
    #ifndef ALT_SIM_OPTIMIZE
    
        /* These variables declaration are here to avoid "warning: unused variable" message when compile for simulation */
        np_tse_mac *pmac_group_base = (np_tse_mac *) pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    
        /* if no PHY connected to the MAC */
        if(pphy == 0) {
            speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
            duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
            result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_NO_PHY;
            tse_dprintf(2, "ERROR   : PHY[%d.%d] - No PHY connected! Speed = %s, Duplex = %s\n", mac_group_index, mac_info_index, speed == TSE_PHY_SPEED_1000 ? "1000" :
                                                                                 speed == TSE_PHY_SPEED_100 ? "100" :
                                                                                 speed == TSE_PHY_SPEED_10 ? "10" : "Unknown",
                                                                                 duplex == 1 ? "Full" : "Half");
            return result;
        }

        /* Small MAC */
        if(pmac_info->mac_type == ALTERA_TSE_MACLITE_10_100) {
            alt_tse_phy_set_adv_1000(pphy, 0);
            alt_tse_phy_restart_an(pphy, ALTERA_AUTONEG_TIMEOUT_THRESHOLD);
        }
        else if(pmac_info->mac_type == ALTERA_TSE_MACLITE_1000) {
            alt_tse_phy_set_adv_100(pphy, 0);
            alt_tse_phy_set_adv_10(pphy, 0);
            alt_tse_phy_restart_an(pphy, ALTERA_AUTONEG_TIMEOUT_THRESHOLD);
        }
        
        /* check link connection for this PHY */
        if(alt_tse_phy_check_link(pphy, ALTERA_AUTONEG_TIMEOUT_THRESHOLD) == TSE_PHY_AN_NOT_COMPLETE) {
            speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
            duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
            result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_AN_NOT_COMPLETE;
            tse_dprintf(3, "WARNING : PHY[%d.%d] - Auto-Negotiation not completed! Speed = %s, Duplex = %s\n", mac_group_index, mac_info_index, speed == TSE_PHY_SPEED_1000 ? "1000" :
                                                                             speed == TSE_PHY_SPEED_100 ? "100" :
                                                                             speed == TSE_PHY_SPEED_10 ? "10" : "Unknown",
                                                                             duplex == 1 ? "Full" : "Half");
            return result;
        }

        IOWR(&pmac_group_base->MDIO_ADDR1, 0, pphy->mdio_address);

        /* To enable PHY loopback */
        #if ENABLE_PHY_LOOPBACK
            tse_dprintf(5, "INFO    : PHY[%d.%d] - Putting PHY in loopback\n", mac_group_index, mac_info_index);
            alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_LOOPBACK, 1, 1);   // enable PHY loopback
        #else
            alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_LOOPBACK, 1, 0);   // disable PHY loopback
        #endif
       
        /* if PHY not found in profile */
        if(pphy->pphy_profile == 0) {
            tse_dprintf(3, "WARNING : PHY[%d.%d] - PHY not found in PHY profile\n", mac_group_index, mac_info_index);
            speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
            duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
            result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_NO_PHY_PROFILE;
        }
        // retrieve duplex information from PHY
        else
        {
            if(pphy->pphy_profile->link_status_read)
            {
                result = pphy->pphy_profile->link_status_read(pmac_group_base);
                speed = (result & 0x02) ? TSE_PHY_SPEED_1000 :
                        (result & 0x04) ? TSE_PHY_SPEED_100  :
                        (result & 0x08) ? TSE_PHY_SPEED_10  : TSE_PHY_SPEED_INVALID;
                duplex = (result & 0x01) ? TSE_PHY_DUPLEX_FULL : TSE_PHY_DUPLEX_HALF;
                
                if(result & ALT_TSE_E_INVALID_SPEED)
                {
                    tse_dprintf(3, "WARNING : PHY[%d.%d] - Invalid speed read from PHY\n", mac_group_index, mac_info_index);
                }
            }
            else if(pphy->pphy_profile->status_reg_location == 0)
            {
                tse_dprintf(3, "WARNING : PHY[%d.%d] - PHY Specific Status register information not provided in profile\n", mac_group_index, mac_info_index);
                speed = ALTERA_TSE_MAC_SPEED_DEFAULT;
                duplex = ALTERA_TSE_DUPLEX_MODE_DEFAULT;
                result = ALT_TSE_SPEED_DUPLEX(speed, duplex) | ALT_TSE_E_PROFILE_INCORRECT_DEFINED;
            }
            else
            {
                /* extract connection speed and duplex information */
                speed = alt_tse_phy_rd_mdio_reg(pphy, pphy->pphy_profile->status_reg_location, pphy->pphy_profile->speed_lsb_location, 2);
                duplex = alt_tse_phy_rd_mdio_reg(pphy, pphy->pphy_profile->status_reg_location, pphy->pphy_profile->duplex_bit_location, 1);
                
                result = ALT_TSE_SPEED_DUPLEX(speed, duplex);
            }
        }

    #else
        /* for simulation purpose, default to gigabit mode */
        speed = 1;
        duplex = 1;
    #endif

    tse_dprintf(5, "INFO    : PHY[%d.%d] - Speed = %s, Duplex = %s\n",  mac_group_index, mac_info_index, speed == TSE_PHY_SPEED_1000 ? "1000" :
                                                                                 speed == TSE_PHY_SPEED_100 ? "100" :
                                                                                 speed == TSE_PHY_SPEED_10 ? "10" : "Unknown",
                                                                                 duplex == 1 ? "Full" : "Half");

    return result;
}


/* @Function Description: Read MDIO address from the MDIO address1 register of first MAC within MAC group
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_rd_mdio_addr(alt_tse_phy_info *pphy) {
    np_tse_mac *pmac_group_base = (np_tse_mac *) pphy->pmac_info->pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    return IORD(&pmac_group_base->MDIO_ADDR1, 0);
}


/* @Function Description: Write MDIO address to the MDIO address1 register of first MAC within MAC group
 * @API Type:           Internal
 * @param pmac          Pointer to the alt_tse_phy_info structure
 * @param mdio_address  MDIO address to be written
 * @return              return SUCCESS
 */
alt_32 alt_tse_phy_wr_mdio_addr(alt_tse_phy_info *pphy, alt_u8 mdio_address) {
    np_tse_mac *pmac_group_base = (np_tse_mac *) pphy->pmac_info->pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    IOWR(&pmac_group_base->MDIO_ADDR1, 0, mdio_address);
    
    return SUCCESS;
}

/** @Function Description -  Write value of data with bit_length number of bits to MDIO register based on register location reg_num
  *                          and start from bit location lsb_num.
  * 
  * @API TYPE - Internal
  * @param  pphy             pointer to alt_tse_phy_info structure
  * @param  reg_num          location of MDIO register to be written.
  * @param  lsb_num          least significant bit location of MDIO register to be written.
  * @param  bit_length       number of bits to be written to the register.
  * @param  data             data to be written to the register at specific bit location of register.
  * @return SUCCESS 
  */
alt_32 alt_tse_phy_wr_mdio_reg(alt_tse_phy_info *pphy, alt_u8 reg_num, alt_u8 lsb_num, alt_u8 bit_length, alt_u16 data)
{
    
    alt_u16 temp_data;
    alt_u16 bit_mask;
    alt_32 i;
    np_tse_mac *pmac = (np_tse_mac *) pphy->pmac_info->pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    
    bit_mask = 0x00;
    /* generate mask consist of bit_length number of 1
     * eg: bit_length = 3, bit_mask = 0b0000 0000 0000 0111
     */
    for(i = 0; i < bit_length; i++)
    {
        bit_mask <<= 1;
        bit_mask |= 0x01;        
    }
    
    /* shifting mask to left by bit_num */
    bit_mask <<= lsb_num;

    /* read register data */
    temp_data = IORD(&pmac->mdio1, reg_num);
    
    /* clear bits to be written */
    temp_data &= ~bit_mask;
    
    /* OR-ed together corresponding bits data */
    temp_data |= ((data << lsb_num) & bit_mask);    
    
    /* write data to MDIO register */
    IOWR(&pmac->mdio1, reg_num, temp_data);
    
    return SUCCESS;
    
}



/* @Function Description -  Read bit_length number of bits from MDIO register based on register location reg_num
 *                          and start from bit location lsb_num.
 * 
 * @API TYPE - Internal
 * @param  pphy             pointer to alt_tse_phy_info structure
 * @param  reg_num          location of MDIO register to be read.
 * @param  lsb_num          least significant bit location of MDIO register to be read.
 * @param  bit_length       number of bits to be read from the register.
 * @return data read from MDIO register 
 */

alt_u32 alt_tse_phy_rd_mdio_reg(alt_tse_phy_info *pphy, alt_u8 reg_num, alt_u8 lsb_num, alt_u8 bit_length)
{
    alt_u16 temp_data;
    alt_u32 bit_mask;
    alt_32 i;
    np_tse_mac *pmac = (np_tse_mac *) pphy->pmac_info->pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    
    bit_mask = 0x00;
    /* generate mask consist of bit_length number of 1
     * eg: bit_length = 3, bit_mask = 0b0000 0000 0000 0111
     */
    for(i = 0; i < bit_length; i++)
    {
        bit_mask <<= 1;
        bit_mask |= 0x01;        
    }
    
    /* read register data */
    temp_data = IORD(&pmac->mdio1, reg_num);
    
    /* shifting read data */
    temp_data >>= lsb_num;
    
    return (temp_data & bit_mask);
}



/* @Function Description: Add supported PHY to profile
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      Number of PHY in profile
 * 
 * User might add their own PHY by calling alt_tse_phy_add_profile()
 */
alt_32 alt_tse_phy_add_profile_default() {
    
    /* supported PHY definition */
        
    /* ------------------------------ */
    /* Marvell PHY on PHYWORKX board  */
    /* ------------------------------ */
    
    alt_tse_phy_profile MV88E1111 = {"Marvell 88E1111",      /* Marvell 88E1111                                  */
                            MV88E1111_OUI,          /* OUI                                                           */
                            MV88E1111_MODEL,        /* Vender Model Number                                           */
                            MV88E1111_REV,          /* Model Revision Number                                         */
                            0x11,                   /* Location of Status Register                                   */
                            14,                     /* Location of Speed Status                                      */
                            13,                     /* Location of Duplex Status                                     */
                            10,                     /* Location of Link Status                                       */
                            &marvell_phy_cfg        /* Function pointer to configure Marvell PHY                     */
                           };

    
    /* ---------------------------------- */
    /* Marvell Quad PHY on PHYWORKX board */
    /* ---------------------------------- */
    
    alt_tse_phy_profile MV88E1145 = {"Marvell Quad PHY 88E1145",      /* Marvell 88E1145                                  */
                            MV88E1145_OUI,                   /* OUI                                                           */
                            MV88E1145_MODEL,                 /* Vender Model Number                                           */
                            MV88E1145_REV,                   /* Model Revision Number                                         */
                            0x11,                            /* Location of Status Register                                   */
                            14,                              /* Location of Speed Status                                      */
                            13,                              /* Location of Duplex Status                                     */
                            10,                              /* Location of Link Status                                       */
                            &marvell_phy_cfg                 /* Function pointer to configure Marvell PHY                     */
                           };
                      
    /* ------------------------------ */
    /* National PHY on PHYWORKX board */
    /* ------------------------------ */  
    
    alt_tse_phy_profile DP83865 = {"National DP83865",     /* National DP83865                                 */
                          DP83865_OUI,            /* OUI                                              */
                          DP83865_MODEL,          /* Vender Model Number                              */
                          DP83865_REV,            /* Model Revision Number                            */
                          0x11,                   /* Location of Status Register                      */
                          3,                      /* Location of Speed Status                         */
                          1,                      /* Location of Duplex Status                        */
                          2                       /* Location of Link Status                          */
                         };
                      
    /* -------------------------------------- */
    /* National 10/100 PHY on PHYWORKX board  */
    /* -------------------------------------- */ 
                      
    alt_tse_phy_profile DP83848C = {"National DP83848C",  /* National DP83848C                                          */
                           DP83848C_OUI,                   /* OUI                                                        */
                           DP83848C_MODEL,                 /* Vender Model Number                                        */
                           DP83848C_REV,                   /* Model Revision Number                                      */
                           0,                              /* Location of Status Register (ignored)                      */
                           0,                              /* Location of Speed Status    (ignored)                      */
                           0,                              /* Location of Duplex Status   (ignored)                      */
                           0,                              /* Location of Link Status     (ignored)                      */
                           0,                              /* No function pointer configure National DP83848C            */
                           &DP83848C_link_status_read      /* Function pointer to read from PHY specific status register */           
                          };

    /* -------------------------------------- */
    /* Intel PHY on C10LP EVA board  */
    /* -------------------------------------- */ 
                      
    alt_tse_phy_profile PEF7071 = {"Intel PEF7071",       /* National DP83848C                                          */
                           PEF7071_OUI,                   /* OUI                                                        */
                           PEF7071_MODEL,                 /* Vender Model Number                                        */
                           PEF7071_REV,                   /* Model Revision Number                                      */
                           0,                             /* Location of Status Register                                */
                           0,                             /* Location of Speed Status                                   */
                           0,                             /* Location of Duplex Status                                  */
                           0,                             /* Location of Link Status                                    */
                           &PEF7071_config,               /* configure PEF7071                                          */
                           &PEF7071_link_status_read      /* Function pointer to read from PHY specific status register */           
                          };
                      
    /* add supported PHY to profile */                          
    alt_tse_phy_add_profile(&MV88E1111);
    alt_tse_phy_add_profile(&MV88E1145);
    alt_tse_phy_add_profile(&DP83865);
    alt_tse_phy_add_profile(&DP83848C);
    alt_tse_phy_add_profile(&PEF7071);
    
    
    return phy_profile_count;
}

/* @Function Description: Display PHYs available in profile
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      Number of PHY in profile
 */
alt_32 alt_tse_phy_print_profile() {
   
    alt_8 i;
    /* display PHY in profile */
    tse_dprintf(6, "List of PHY profiles supported (Total profiles = %d)...\n", phy_profile_count);
    
    for(i = 0; i < phy_profile_count; i++)
    {
        tse_dprintf(6, "Profile No.%2d   :\n", i);
        tse_dprintf(6, "PHY Name        : %s\n", pphy_profiles[i]->name);
   
        tse_dprintf(6, "PHY OUI         : 0x%06x\n", (int)pphy_profiles[i]->oui);
        tse_dprintf(6, "PHY Model Num.  : 0x%02x\n", pphy_profiles[i]->model_number);
        tse_dprintf(6, "PHY Rev. Num.   : 0x%02x\n", pphy_profiles[i]->revision_number);
        
        tse_dprintf(6, "Status Register : 0x%02x\n", pphy_profiles[i]->status_reg_location); 
        
        tse_dprintf(6, "Speed Bit       : %d\n", pphy_profiles[i]->speed_lsb_location);
        
        tse_dprintf(6, "Duplex Bit      : %d\n", pphy_profiles[i]->duplex_bit_location);
        
        tse_dprintf(6, "Link Bit        : %d\n\n", pphy_profiles[i]->link_bit_location);
 
    }
    
    return phy_profile_count;
}



/* @Function Description: Store information of all the MAC available in the system
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      return SUCCESS
 *              return ALTERA_TSE_SYSTEM_DEF_ERROR if alt_tse_system_info structure definition error
 */
alt_32 alt_tse_mac_group_init() {
    
    alt_8 i;
    alt_8 j;
    
    alt_tse_mac_group *pmac_group = 0;
    alt_tse_mac_info *pmac_info = 0;
    alt_tse_system_info *psys = 0;

    /* reset number of MAC group */
    mac_group_count = 0;
    
    /* loop through every alt_tse_system_info structure */
    for(i = 0; i < max_mac_system; i++) {
        psys = &tse_mac_device[i];

        if((psys->tse_msgdma_tx != 0) && (psys->tse_msgdma_rx != 0)) {        
            tse_dprintf(5, "INFO    : TSE MAC %d found at address 0x%08x\n", mac_group_count, (int) psys->tse_mac_base);
            
            /* Allocate memory for the structure */
            pmac_group = (alt_tse_mac_group *) malloc(sizeof(alt_tse_mac_group));
            if(!pmac_group) {
                tse_dprintf(1, "ERROR   : Unable to allocate memory for MAC Group[%d]\n", mac_group_count);
                return ALTERA_TSE_MALLOC_FAILED;
            }
           
            /* Non-multi-channel MAC considered as 1 channel */
            if(psys->tse_multichannel_mac) {
                pmac_group->channel = psys->tse_num_of_channel;
                tse_dprintf(6, "INFO    : Multi Channel            = Yes\n");
                tse_dprintf(6, "INFO    : Number of channel        = %d\n", pmac_group->channel);
                tse_dprintf(6, "INFO    : MDIO Shared              = Yes\n");
            }
            else if(psys->tse_mdio_shared) {
                pmac_group->channel = psys->tse_number_of_mac_mdio_shared;
                tse_dprintf(6, "INFO    : Multi Channel            = No\n");
                tse_dprintf(6, "INFO    : MDIO Shared              = Yes\n");
                tse_dprintf(6, "INFO    : Number of MAC Share MDIO = %d\n", pmac_group->channel);
            }
            else {
                pmac_group->channel = 1;
                tse_dprintf(6, "INFO    : Multi Channel            = No\n");
                tse_dprintf(6, "INFO    : MDIO Shared              = No\n");
            }
            
            for(j = 0; j < pmac_group->channel; j++) {
                /* Allocate memory for the structure */
                pmac_info = (alt_tse_mac_info *) malloc(sizeof(alt_tse_mac_info));
                if(!pmac_info) {
                    tse_dprintf(1, "ERROR   : Unable to allocate memory for MAC Group[%d]->pmac_info[%d]\n", mac_group_count, j);
                    return ALTERA_TSE_MALLOC_FAILED;
                }
                
                pmac_info->pmac_group = pmac_group;
                
                pmac_info->pphy_info = 0;
                
                pmac_info->psys_info = &tse_mac_device[i + j];
                
                /* check to make sure the alt_tse_system_info defined correctly or has been defined */
                if((pmac_info->psys_info->tse_msgdma_tx == 0) || (pmac_info->psys_info->tse_msgdma_rx == 0)){                    
                    tse_dprintf(2, "ERROR   : tse_mac_device[%d] does not defined correctly!\n", i + j);
                    return ALTERA_TSE_SYSTEM_DEF_ERROR;
                }
                
                /* MAC type detection */
                if(pmac_info->psys_info->tse_en_maclite) {
                    if(pmac_info->psys_info->tse_maclite_gige) {
                        pmac_info->mac_type = ALTERA_TSE_MACLITE_1000;
                    }
                    else {
                        pmac_info->mac_type = ALTERA_TSE_MACLITE_10_100;
                    }
                }
                else {
                    pmac_info->mac_type = ALTERA_TSE_FULL_MAC;                    
                }
                
                if((pmac_info->psys_info->tse_mdio_shared) && (!pmac_info->psys_info->tse_multichannel_mac)){
                    tse_dprintf(6, "INFO    : MAC %2d Address           = 0x%08x\n", j, (int) pmac_info->psys_info->tse_mac_base);
                    tse_dprintf(6, "INFO    : MAC %2d Device            = tse_mac_device[%d]\n", j, i + j);
                    
                    switch(pmac_info->mac_type) {
                        case ALTERA_TSE_MACLITE_1000:
                            tse_dprintf(6, "INFO    : MAC %2d Type              = %s\n", j, "1000 Mbps Small MAC");
                            break;
                        case ALTERA_TSE_MACLITE_10_100:
                            tse_dprintf(6, "INFO    : MAC %2d Type              = %s\n", j, "10/100 Mbps Small MAC");
                            break;
                        case ALTERA_TSE_FULL_MAC:
                            tse_dprintf(6, "INFO    : MAC %2d Type              = %s\n", j, "10/100/1000 Ethernet MAC");
                            break;
                        default :
                            tse_dprintf(6, "INFO    : MAC %2d Type              = %s\n", j, "Unknown");
                            break;
                    }
                    
                    if(pmac_info->psys_info->tse_pcs_ena) {
                        tse_dprintf(6, "INFO    : PCS %2d Enable            = %s\n", j, pmac_info->psys_info->tse_pcs_ena ? "Yes" : "No");
                        tse_dprintf(6, "INFO    : PCS %2d SGMII Enable      = %s\n", j, pmac_info->psys_info->tse_pcs_sgmii ? "Yes" : "No");                        
                    }
                }
                else {
                    /* display only once for all MAC, except shared MDIO MACs */
                    if(j == 0) {
                        switch(pmac_info->mac_type) {
                            case ALTERA_TSE_MACLITE_1000:
                                tse_dprintf(6, "INFO    : MAC Type                 = %s\n", "1000 Mbps Small MAC");
                                break;
                            case ALTERA_TSE_MACLITE_10_100:
                                tse_dprintf(6, "INFO    : MAC Type                 = %s\n", "10/100 Mbps Small MAC");
                                break;
                            case ALTERA_TSE_FULL_MAC:
                                tse_dprintf(6, "INFO    : MAC Type                 = %s\n", "10/100/1000 Ethernet MAC");
                                break;
                            default :
                                tse_dprintf(6, "INFO    : MAC Type                 = %s\n", "Unknown");
                                    break;
                }
                        
                        if(pmac_info->psys_info->tse_pcs_ena) {
                            tse_dprintf(6, "INFO    : PCS Enable               = %s\n", pmac_info->psys_info->tse_pcs_ena ? "Yes" : "No");
                            tse_dprintf(6, "INFO    : PCS SGMII Enable         = %s\n", pmac_info->psys_info->tse_pcs_sgmii ? "Yes" : "No");                            
                        }
                    }
                    
                    if(pmac_info->psys_info->tse_multichannel_mac) {
                        tse_dprintf(6, "INFO    : Channel %2d Address       = 0x%08x\n", j, (int) pmac_info->psys_info->tse_mac_base);
                        tse_dprintf(6, "INFO    : Channel %2d Device        = tse_mac_device[%d]\n", j, i + j);
                    }                
                    else {
                        tse_dprintf(6, "INFO    : MAC Address              = 0x%08x\n", (int) pmac_info->psys_info->tse_mac_base);
                        tse_dprintf(6, "INFO    : MAC Device               = tse_mac_device[%d]\n", i + j);
                    }
                }
                
                /* store the pointer in MAC group variable for the detected channel */
                pmac_group->pmac_info[j] = pmac_info;
            }
            
            /* store the pointer in global variable */
            pmac_groups[mac_group_count] = pmac_group;
            
            mac_group_count++;

            /* skip for subsequent Multi-channel MAC */
            i += (pmac_group->channel - 1);
                        
        }
    }
    return SUCCESS;
}


/* @Function Description: Store information of all the PHYs connected to MAC to phy_list
 * @API Type:         Internal
 * @param pmac_group  Pointer to the TSE MAC grouping structure
 * @return            Number of PHY not in profile, return ALTERA_TSE_MALLOC_FAILED if memory allocation failed
 */
alt_32 alt_tse_mac_get_phy(alt_tse_mac_group *pmac_group) {
    
    alt_32 phyid; 
    alt_32 phyid2 = 0;
    alt_u8 phyadd;
    
    alt_u32 oui;
    alt_u8 model_number;
    alt_u8 revision_number;

    alt_32 i;

    alt_u8 is_phy_in_profile;
    alt_32 return_value = 0;
    
    alt_8 phy_info_count = 0;
    
    alt_tse_phy_info *pphy = 0;
    alt_tse_mac_info *pmac_info = 0;
    alt_tse_system_info *psys = 0;
    
    np_tse_mac *pmac_group_base = (np_tse_mac *) pmac_group->pmac_info[0]->psys_info->tse_mac_base;
            
    /* Record previous MDIO address, to be restored at the end of function */
    alt_32 mdioadd_prev = IORD(&pmac_group_base->MDIO_ADDR1, 0);
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* loop all valid PHY address to look for connected PHY */
    for (phyadd = 0x00; phyadd < 0x20; phyadd++)
    {        
        IOWR(&pmac_group_base->MDIO_ADDR1, 0, phyadd);
        phyid = IORD(&pmac_group_base->mdio1.PHY_ID1,0);     // read PHY ID
        phyid2 = IORD(&pmac_group_base->mdio1.PHY_ID2,0);     // read PHY ID
        
        /* PHY found */
        if (phyid != phyid2)
        {
            pphy = (alt_tse_phy_info *) malloc(sizeof(alt_tse_phy_info));
            if(!pphy) {
                tse_dprintf(1, "ERROR   : Unable to allocate memory for phy_info[%d.%d]\n", mac_group_index, phy_info_count);
                return ALTERA_TSE_MALLOC_FAILED;
            }
            
            /* store PHY address */
            pphy->mdio_address = phyadd;

            /* get oui, model number, and revision number from PHYID and PHYID2 */
            oui = (phyid << 6) | ((phyid2 >> 10) & 0x3f);
            model_number = (phyid2 >> 4) & 0x3f;
            revision_number = phyid2 & 0x0f;
            
            /* map the PHY with PHY in profile */
            is_phy_in_profile = 0;
            for(i = 0; i < phy_profile_count; i++) {
                
                /* if PHY match with PHY in profile */
                if((pphy_profiles[i]->oui == oui) && (pphy_profiles[i]->model_number == model_number))
                {
                    pphy->pphy_profile = pphy_profiles[i];
                    
                    /* PHY found, add it to phy_list */
                    tse_dprintf(5, "INFO    : PHY %s found at PHY address 0x%02x of MAC Group[%d]\n", pphy_profiles[i]->name, phyadd, mac_group_index);
                    is_phy_in_profile = 1;
                    break;
                }
            }
            /* PHY not found in PHY profile */
            if(is_phy_in_profile == 0) {
                pphy->pphy_profile = 0;
                tse_dprintf(3, "WARNING : Unknown PHY found at PHY address 0x%02x of MAC Group[%d]\n", phyadd, mac_group_index);
                tse_dprintf(3, "WARNING : Please add PHY information to PHY profile\n");
                return_value++;
            }
            
            tse_dprintf(6, "INFO    : PHY OUI             =  0x%06x\n", (int) oui);
            tse_dprintf(6, "INFO    : PHY Model Number    =  0x%02x\n", model_number);
            tse_dprintf(6, "INFO    : PHY Revision Number =  0x%01x\n", revision_number);
            
            /* map the detected PHY to connected MAC */
            if(alt_tse_mac_associate_phy(pmac_group, pphy) == TSE_PHY_MAP_SUCCESS) {
                
                pmac_info = pphy->pmac_info;
                psys = pmac_info->psys_info;
                
                /* Disable PHY loopback to allow Auto-Negotiation completed */
                alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_LOOPBACK, 1, 0);   // disable PHY loopback
                
                /* Reset auto-negotiation advertisement */
                alt_tse_phy_set_adv_1000(pphy, 1);
                alt_tse_phy_set_adv_100(pphy, 1);
                alt_tse_phy_set_adv_10(pphy, 1);
                                
                /* check link connection for this PHY */
                alt_tse_phy_restart_an(pphy, ALTERA_CHECKLINK_TIMEOUT_THRESHOLD);
                
                /* Perform additional setting if there is any */
                /* Profile specific */
                if(pphy->pphy_profile) {
                    if(pphy->pphy_profile->phy_cfg) {
                        tse_dprintf(6, "INFO    : Applying additional PHY configuration of %s\n", pphy->pphy_profile->name);
                        pphy->pphy_profile->phy_cfg(pmac_group_base);
                    }
                }
                
                /* Initialize PHY, call user's function pointer in alt_tse_system_info structure */
                /* Individual PHY specific */
                if(psys->tse_phy_cfg) {
                    tse_dprintf(6, "INFO    : Applying additional user PHY configuration\n");
                    psys->tse_phy_cfg(pmac_group_base);
                }
            }
            
            tse_dprintf(6, "\n");
                
            phy_info_count++;
        }
    }
    
    /* check to verify the number of connected PHY match the number of channel */
    if(pmac_group->channel != phy_info_count) {
        if(phy_info_count == 0) {
            tse_dprintf(2, "ERROR   : MAC Group[%d] - No PHY connected!\n", mac_group_index);
        }
        else {
            tse_dprintf(3, "WARNING : MAC Group[%d] - Number of PHY connected is not equal to the number of channel, Number of PHY : %d, Channel : %d\n", mac_group_index, phy_info_count, pmac_group->channel);
        }
    }
    
    /* Restore previous MDIO address */
    IOWR(&pmac_group_base->MDIO_ADDR1, 0, mdioadd_prev);
    
    return return_value;
}




/* @Function Description: Associate the PHYs connected to the structure in alt_tse_system_info.h
 * @API Type:         Internal
 * @param pmac_group  Pointer to the TSE MAC grouping structure
 * @param pphy        Pointer to the TSE PHY info structure which hold information of PHY
 * @return            return TSE_PHY_MAP_ERROR if mapping error
 *                    return TSE_PHY_MAP_SUCCESS otherwise
 */
alt_32 alt_tse_mac_associate_phy(alt_tse_mac_group *pmac_group, alt_tse_phy_info *pphy) {
    
    alt_32 i;
    alt_32 return_value = TSE_PHY_MAP_SUCCESS;
    
    alt_u8 is_mapped;

    alt_tse_system_info *psys = 0;
    alt_tse_mac_info *pmac_info = 0;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = 0;
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    alt_8 sys_info_index = 0;
    
    is_mapped = 0;
    
    for(i = 0; i < pmac_group->channel; i++) {
        pmac_info = pmac_group->pmac_info[i];
        psys = pmac_info->psys_info;
       
        /* map according to the PHY address in alt_tse_system_info.h */
        if(psys->tse_phy_mdio_address == pphy->mdio_address) {
            mac_info_index = alt_tse_get_mac_info_index(pmac_info);
            sys_info_index = alt_tse_get_system_index(psys);
            
            pmac_info->pphy_info = pphy;
            pphy->pmac_info = pmac_info;
            tse_dprintf(5, "INFO    : PHY[%d.%d] - Explicitly mapped to tse_mac_device[%d]\n", mac_group_index, mac_info_index, sys_info_index);
            is_mapped = 1;
            break;
        }
    }
    
    /* if not yet map, it will automatically mapped to the first TSE device encountered with tse_phy_mdio_address = TSE_PHY_AUTO_ADDRESS */
    if(is_mapped == 0) {
        for(i = 0; i < pmac_group->channel; i++) {
            pmac_info = pmac_group->pmac_info[i];
            psys = pmac_info->psys_info;
            
            /* alt_tse_system_info structure definition error */
            if((psys->tse_msgdma_tx == 0) || (psys->tse_msgdma_rx == 0)){
                continue;
            }
            
            if(psys->tse_phy_mdio_address == TSE_PHY_AUTO_ADDRESS) {
                mac_info_index = alt_tse_get_mac_info_index(pmac_info);
                sys_info_index = alt_tse_get_system_index(psys);
                
                pmac_info->pphy_info = pphy;
                pphy->pmac_info = pmac_info;
                psys->tse_phy_mdio_address = pphy->mdio_address;
                tse_dprintf(5, "INFO    : PHY[%d.%d] - Automatically mapped to tse_mac_device[%d]\n", mac_group_index, mac_info_index, sys_info_index);
                is_mapped = 1;
                break;
            }
        }
    }
    
    /* Still cannot find any matched MAC-PHY */
    if(is_mapped == 0) {
        pphy->pmac_info = 0;
        tse_dprintf(2, "WARNING : PHY[%d.X] - Mapping of PHY to MAC failed! Make sure the PHY address is defined correctly in tse_mac_device[] structure, and number of PHYs connected is equivalent to number of channel\n", mac_group_index);
        return_value = TSE_PHY_MAP_ERROR;
    }
    
    return return_value;
}




/* @Function Description: Configure operating mode of Altera PCS if available
 * @API Type:           Internal
 * @param pmac_info     pointer to MAC info variable
 * @return              return SUCCESS
 */
alt_32 alt_tse_phy_cfg_pcs(alt_tse_mac_info *pmac_info) {
    
    alt_tse_system_info *psys = pmac_info->psys_info;
    np_tse_mac *pmac = (np_tse_mac *) psys->tse_mac_base;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);

    if(psys->tse_pcs_ena) {
        tse_dprintf(5, "INFO    : PCS[%d.%d] - Configuring PCS operating mode\n", mac_group_index, mac_info_index);
        
        alt_32 data = IORD(&pmac->mdio0.CONTROL, ALTERA_TSE_PCS_IF_MODE); 
        
        if(psys->tse_pcs_sgmii) {
            tse_dprintf(5, "INFO    : PCS[%d.%d] - PCS SGMII mode enabled\n", mac_group_index, mac_info_index);
            IOWR(&pmac->mdio0.CONTROL, ALTERA_TSE_PCS_IF_MODE, data | 0x03);
            }
        else {
            tse_dprintf(5, "INFO    : PCS[%d.%d] - PCS SGMII mode disabled\n", mac_group_index, mac_info_index);
            IOWR(&pmac->mdio0.CONTROL, ALTERA_TSE_PCS_IF_MODE, data & ~0x03);
        }
    }
    
    return SUCCESS;
}



/* @Function Description: Detect and initialize all the PHYs connected
 * @API Type:   Internal
 * @param pmac  N/A
 * @return      SUCCESS
 */
alt_32 alt_tse_phy_init() {
    alt_8 i = 0;
    alt_8 j = 0;
    
    alt_tse_mac_group *pmac_group = 0;
    alt_tse_mac_info *pmac_info = 0;
    
    /* add supported PHYs */
    alt_tse_phy_add_profile_default();
    
    /* display PHY in profile */
    alt_tse_phy_print_profile();
    
    alt_tse_mac_group_init();
        
    /* initialize for each TSE MAC */
    /* run once only for multi-channel MAC */
    for(i = 0; i < mac_group_count; i++) {
        pmac_group = pmac_groups[i];
        
        if(pmac_group->pmac_info[0]->psys_info->tse_use_mdio) {
            
            /* get connected PHYs */
            alt_tse_mac_get_phy(pmac_group);
        }
        else {
            tse_dprintf(3, "WARNING : MAC Groups[%d]->pmac_info[%d] MDIO is not used, unable to run PHY detection\n", i, j);
        }
        
        /* Configure PCS mode if MAC+PCS system is used */
        for(j = 0; j < pmac_group->channel; j++) {
            pmac_info = pmac_group->pmac_info[j];
            
            alt_tse_phy_cfg_pcs(pmac_info);
        }
    }
                
    return SUCCESS;
}


/* @Function Description: Restart Auto-Negotiation for the PHY
 * @API Type:                   Internal
 * @param pphy                  Pointer to the alt_tse_phy_info structure
 *        timeout_threshold     timeout value of Auto-Negotiation
 * @return                      return TSE_PHY_AN_COMPLETE if success
 *                              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 *                              return TSE_PHY_AN_NOT_CAPABLE if the PHY not capable for AN
 */
alt_32 alt_tse_phy_restart_an(alt_tse_phy_info *pphy, alt_u32 timeout_threshold) {
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* Record previous MDIO address, to be restored at the end of function */
    alt_u8 mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
    
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
    
    if(!alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_ABILITY, 1)) {
        tse_dprintf(3, "WARNING : PHY[%d.%d] - PHY not capable for Auto-Negotiation\n", mac_group_index, mac_info_index);
        
        /* Restore previous MDIO address */
        alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
        
        return TSE_PHY_AN_NOT_CAPABLE;
    }
    
    /* enable Auto-Negotiation */    
    alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_AN_ENA, 1, 1);
    
    /* send PHY reset command */
    alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_RESTART_AN, 1, 1);
    tse_dprintf(5, "INFO    : PHY[%d.%d] - Restart Auto-Negotiation, checking PHY link...\n", mac_group_index, mac_info_index);
    
    alt_32 timeout = 0;
    while(alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_COMPLETE, 1) == 0 ){ 
        if(timeout++ > timeout_threshold) {
           tse_dprintf(4, "WARNING : PHY[%d.%d] - Auto-Negotiation FAILED\n", mac_group_index, mac_info_index);
           
           /* Restore previous MDIO address */
           alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
           
           return TSE_PHY_AN_NOT_COMPLETE;
        }
        usleep(1000);
    }
    tse_dprintf(5, "INFO    : PHY[%d.%d] - Auto-Negotiation PASSED\n", mac_group_index, mac_info_index);
    
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
    
    return TSE_PHY_AN_COMPLETE;
}


/* @Function Description: Check link status of PHY and start Auto-Negotiation if it has not yet done
 * @API Type:                   Internal
 * @param pphy                  Pointer to the alt_tse_phy_info structure
 *        timeout_threshold     timeout value of Auto-Negotiation
 * @return                      return TSE_PHY_AN_COMPLETE if success
 *                              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 */
alt_32 alt_tse_phy_check_link(alt_tse_phy_info *pphy, alt_u32 timeout_threshold)
{
    alt_32 timeout=0;
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group); 
    
    /* Record previous MDIO address, to be restored at the end of function */
    alt_u8 mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
    
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
            
    /* if Auto-Negotiation not complete yet, then restart Auto-Negotiation */
    /* Issue a PHY reset here and wait for the link
     * autonegotiation complete again... this takes several SECONDS(!)
     * so be very careful not to do it frequently
     * perform this when PHY is configured in loopback or has no link yet.
     */
    tse_dprintf(5, "INFO    : PHY[%d.%d] - Checking link...\n", mac_group_index, mac_info_index);
    while( ((alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_LOOPBACK, 1)) != 0) ||
        ((alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_COMPLETE, 1)) == 0) )
    {                 
        if (timeout++ > timeout_threshold) 
        {    
          tse_dprintf(5, "INFO    : PHY[%d.%d] - Link not yet established, restart auto-negotiation...\n", mac_group_index, mac_info_index);
          /* restart Auto-Negotiation */
          /* if Auto-Negotiation still cannot complete, then go to next PHY */
          if(alt_tse_phy_restart_an(pphy, timeout_threshold) == TSE_PHY_AN_NOT_COMPLETE)
          {
            tse_dprintf(3, "WARNING : PHY[%d.%d] - Link could not established\n", mac_group_index, mac_info_index);
            
            /* Restore previous MDIO address */
            alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
    
            return TSE_PHY_AN_NOT_COMPLETE;
          } 
        }   
        usleep(1000);        
    }
    tse_dprintf(5, "INFO    : PHY[%d.%d] - Link established\n", mac_group_index, mac_info_index);
            
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
    
    return TSE_PHY_AN_COMPLETE; 
}

/* @Function Description: Get link capability of PHY and link partner
 * @API Type:   Internal
 * @param pmac  Pointer to the alt_tse_phy_info structure
 * @return      return TSE_PHY_AN_COMPLETE if success
 *              return TSE_PHY_AN_NOT_COMPLETE if auto-negotiation not completed
 *              return TSE_PHY_AN_NOT_CAPABLE if the PHY not capable for AN
 */
alt_32 alt_tse_phy_get_cap(alt_tse_phy_info *pphy) {
    alt_32 return_value = TSE_PHY_AN_COMPLETE;
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);    
        
    /* Record previous MDIO address, to be restored at the end of function */
    alt_u8 mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
       
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
            
    if(!alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_ABILITY, 1)) {
        tse_dprintf(3, "WARNING : PHY[%d.%d] - PHY not capable for Auto-Negotiation\n", mac_group_index, mac_info_index);
        
        /* Restore previous MDIO address */
        alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
        
        return TSE_PHY_AN_NOT_CAPABLE;
    }
    
    /* check whether link has been established */
    alt_tse_phy_restart_an(pphy, ALTERA_AUTONEG_TIMEOUT_THRESHOLD);
    
    if(alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_COMPLETE, 1) == 0) {
        return_value = TSE_PHY_AN_NOT_COMPLETE;
    }
    
    /* get PHY capabilities */
    pphy->link_capability.cap_1000_base_x_full = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_X_FULL, 1);
    pphy->link_capability.cap_1000_base_x_half = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_X_HALF, 1);
    pphy->link_capability.cap_1000_base_t_full = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_FULL, 1);
    pphy->link_capability.cap_1000_base_t_half = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_HALF, 1);
    
    pphy->link_capability.cap_100_base_t4      = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_T4, 1);
    pphy->link_capability.cap_100_base_x_full  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_X_FULL, 1);
    pphy->link_capability.cap_100_base_x_half  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_X_HALF, 1);
    pphy->link_capability.cap_100_base_t2_full = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_T2_FULL, 1);
    pphy->link_capability.cap_100_base_t2_half = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_T2_HALF, 1);
    pphy->link_capability.cap_10_base_t_full   = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_10BASE_T_FULL, 1);
    pphy->link_capability.cap_10_base_t_half   = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_10BASE_T_HALF, 1);
    
    /* get link partner capability */
    pphy->link_capability.lp_1000_base_t_full  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_STATUS, TSE_PHY_MDIO_1000BASE_T_STATUS_LP_FULL_ADV, 1);
    pphy->link_capability.lp_1000_base_t_half  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_STATUS, TSE_PHY_MDIO_1000BASE_T_STATUS_LP_HALF_ADV, 1);
    
    pphy->link_capability.lp_100_base_t4       = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_REMADV, TSE_PHY_MDIO_ADV_100BASE_T4, 1);
    pphy->link_capability.lp_100_base_tx_full  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_REMADV, TSE_PHY_MDIO_ADV_100BASE_TX_FULL, 1);
    pphy->link_capability.lp_100_base_tx_half  = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_REMADV, TSE_PHY_MDIO_ADV_100BASE_TX_HALF, 1);
    pphy->link_capability.lp_10_base_tx_full   = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_REMADV, TSE_PHY_MDIO_ADV_10BASE_TX_FULL, 1);
    pphy->link_capability.lp_10_base_tx_half   = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_REMADV, TSE_PHY_MDIO_ADV_10BASE_TX_HALF, 1);
    
    tse_dprintf(6, "INFO    : PHY[%d.%d] - Capability of PHY :\n", mac_group_index, mac_info_index);
    tse_dprintf(6, "INFO    : 1000 Base-X Full Duplex = %d\n", pphy->link_capability.cap_1000_base_x_full);
    tse_dprintf(6, "INFO    : 1000 Base-X Half Duplex = %d\n", pphy->link_capability.cap_1000_base_x_half);
    tse_dprintf(6, "INFO    : 1000 Base-T Full Duplex = %d\n", pphy->link_capability.cap_1000_base_t_full);
    tse_dprintf(6, "INFO    : 1000 Base-T Half Duplex = %d\n", pphy->link_capability.cap_1000_base_t_half);
    tse_dprintf(6, "INFO    : 100 Base-T4             = %d\n", pphy->link_capability.cap_100_base_t4);
    tse_dprintf(6, "INFO    : 100 Base-X Full Duplex  = %d\n", pphy->link_capability.cap_100_base_x_full);
    tse_dprintf(6, "INFO    : 100 Base-X Half Duplex  = %d\n", pphy->link_capability.cap_100_base_x_half);
    tse_dprintf(6, "INFO    : 100 Base-T2 Full Duplex = %d\n", pphy->link_capability.cap_100_base_t2_full);
    tse_dprintf(6, "INFO    : 100 Base-T2 Half Duplex = %d\n", pphy->link_capability.cap_100_base_t2_half);
    tse_dprintf(6, "INFO    : 10 Base-T Full Duplex   = %d\n", pphy->link_capability.cap_10_base_t_full);
    tse_dprintf(6, "INFO    : 10 Base-T Half Duplex   = %d\n", pphy->link_capability.cap_10_base_t_half);
    tse_dprintf(6, "\n");
    
    tse_dprintf(6, "INFO    : PHY[%d.%d] - Link Partner Capability :\n", mac_group_index, mac_info_index);
    tse_dprintf(6, "INFO    : 1000 Base-T Full Duplex = %d\n", pphy->link_capability.lp_1000_base_t_full);
    tse_dprintf(6, "INFO    : 1000 Base-T Half Duplex = %d\n", pphy->link_capability.lp_1000_base_t_half);
    tse_dprintf(6, "INFO    : 100 Base-T4             = %d\n", pphy->link_capability.lp_100_base_t4);
    tse_dprintf(6, "INFO    : 100 Base-TX Full Duplex = %d\n", pphy->link_capability.lp_100_base_tx_full);
    tse_dprintf(6, "INFO    : 100 Base-TX Half Duplex = %d\n", pphy->link_capability.lp_100_base_tx_half);
    tse_dprintf(6, "INFO    : 10 Base-TX Full Duplex  = %d\n", pphy->link_capability.lp_10_base_tx_full);
    tse_dprintf(6, "INFO    : 10 Base-TX Half Duplex  = %d\n", pphy->link_capability.lp_10_base_tx_half);
    tse_dprintf(6, "\n");
    
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
    
    return return_value;
    
}


/* @Function Description: Set the advertisement of PHY for 1000 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_1000(alt_tse_phy_info *pphy, alt_u8 enable) {
    alt_u8 cap;
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* Record previous MDIO address, to be restored at the end of function */
    alt_u8 mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
       
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
    
    /* if enable = 1, set advertisement based on PHY capability */
    if(enable) {
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_FULL, 1); 
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_CTRL, TSE_PHY_MDIO_1000BASE_T_CTRL_FULL_ADV, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 1000 Base-T Full Duplex set to %d\n", mac_group_index, mac_info_index, cap);
        
        /* 1000 Mbps Half duplex not supported by TSE MAC */
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_EXT_STATUS, TSE_PHY_MDIO_EXT_STATUS_1000BASE_T_HALF, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_CTRL, TSE_PHY_MDIO_1000BASE_T_CTRL_HALF_ADV, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 1000 Base-T Half Duplex set to %d\n", mac_group_index, mac_info_index, cap);
    }
    /* else disable advertisement of this speed */
    else {
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_CTRL, TSE_PHY_MDIO_1000BASE_T_CTRL_FULL_ADV, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 1000 Base-T Full Duplex set to %d\n", mac_group_index, mac_info_index, 0);
        
        /* 1000 Mbps Half duplex not supported by TSE MAC */
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_1000BASE_T_CTRL, TSE_PHY_MDIO_1000BASE_T_CTRL_HALF_ADV, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement 1000 Base-T half Duplex set to %d\n", mac_group_index, mac_info_index, 0);
    }
    
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);    

    return SUCCESS;
}


/* @Function Description: Set the advertisement of PHY for 100 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_100(alt_tse_phy_info *pphy, alt_u8 enable) {
    alt_u8 cap;
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* Record previous MDIO address, to be restored at the end of function */
    alt_u8 mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
       
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
    
    /* if enable = 1, set advertisement based on PHY capability */
    if(enable) {
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_T4, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_T4, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-T4 set to %d\n", mac_group_index, mac_info_index, cap);
        
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_X_FULL, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_TX_FULL, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-TX Full Duplex set to %d\n", mac_group_index, mac_info_index, cap);
        
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_100BASE_X_HALF, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_TX_HALF, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-TX Half Duplex set to %d\n", mac_group_index, mac_info_index, cap);
    }
    /* else disable advertisement of this speed */
    else {
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_T4, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-T4 set to %d\n", mac_group_index, mac_info_index, 0);
        
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_TX_FULL, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-TX Full Duplex set to %d\n", mac_group_index, mac_info_index, 0);
        
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_100BASE_TX_HALF, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 100 Base-TX Half Duplex set to %d\n", mac_group_index, mac_info_index, 0);
    }
    
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);  
    
    return SUCCESS;
}


/* @Function Description: Set the advertisement of PHY for 10 Mbps
 * @API Type:    Internal
 * @param pmac   Pointer to the alt_tse_phy_info structure
 *        enable set Enable = 1 to advertise this speed if the PHY capable
 *               set Enable = 0 to disable advertise of this speed
 * @return       return SUCCESS
 */
alt_32 alt_tse_phy_set_adv_10(alt_tse_phy_info *pphy, alt_u8 enable) {
    alt_u8 cap;
    
    /* pointer to MAC associated and MAC group */
    alt_tse_mac_info *pmac_info = pphy->pmac_info;
    alt_tse_mac_group *pmac_group = pmac_info->pmac_group;
    
    /* get index of the pointers in pointer array list */
    int mac_info_index = alt_tse_get_mac_info_index(pmac_info);
    int mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* Record previous MDIO address, to be restored at the end of function */
    int mdioadd_prev = alt_tse_phy_rd_mdio_addr(pphy); 
       
    /* write PHY address to MDIO to access the i-th PHY */
    alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);
    
    /* if enable = 1, set advertisement based on PHY capability */
    if(enable) {
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_10BASE_T_FULL, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_10BASE_TX_FULL, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 10 Base-TX Full Duplex set to %d\n", mac_group_index, mac_info_index, cap);
    
        cap = alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_10BASE_T_HALF, 1);
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_10BASE_TX_HALF, 1, cap);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 10 Base-TX Half Duplex set to %d\n", mac_group_index, mac_info_index, cap);
    }
    /* else disable advertisement of this speed */
    else {
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_10BASE_TX_FULL, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 10 Base-TX Full Duplex set to %d\n", mac_group_index, mac_info_index, 0);
    
        alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_ADV, TSE_PHY_MDIO_ADV_10BASE_TX_HALF, 1, 0);
        tse_dprintf(6, "INFO    : PHY[%d.%d] - Advertisement of 10 Base-TX Half Duplex set to %d\n", mac_group_index, mac_info_index, 0);
    }
    
    /* Restore previous MDIO address */
    alt_tse_phy_wr_mdio_addr(pphy, mdioadd_prev);
    
    return SUCCESS;
}




/* @Function Description: Get the common speed supported by all PHYs connected to the MAC within the same group
 * @API Type:           Internal
 * @param pmac_group    Pointer to the TSE MAC Group structure which group all the MACs that should use the same speed
 * @return              common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if no common speed found
 */
alt_32 alt_tse_phy_get_common_speed(alt_tse_mac_group *pmac_group) {
    
    alt_32 i;
    alt_u8 common_1000 = 1;
    alt_u8 common_100 = 1;
    alt_u8 common_10 = 1;
    
    alt_32 common_speed;
    
    alt_u8 none_an_complete = 1;
    
    alt_tse_mac_info *pmac_info = 0;
    alt_tse_phy_info *pphy = 0;
    
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
    
    /* reset Auto-Negotiation advertisement */
    for(i = 0; i < pmac_group->channel; i++) {
        pmac_info = pmac_group->pmac_info[i];
        pphy = pmac_info->pphy_info;
        
        /* run only if PHY connected */
        if(pphy) {
            alt_tse_phy_set_adv_1000(pphy, 1);
            alt_tse_phy_set_adv_100(pphy, 1);
            alt_tse_phy_set_adv_10(pphy, 1);
        }
        tse_dprintf(6, "\n");
    }
    
    /* loop through every PHY connected */
    for(i = 0; i < pmac_group->channel; i++) {

        pmac_info = pmac_group->pmac_info[i];
        pphy = pmac_info->pphy_info;
        
        /* if no PHY connected */
        if(!pphy) {
            continue;
        }
        
        /* get PHY capability */
        /* skip for PHY with Auto-Negotiation not completed */
        if(alt_tse_phy_get_cap(pphy) != TSE_PHY_AN_COMPLETE) {
            continue;
        }
        
        none_an_complete = 0;
        
        /* Small MAC */
        if(pmac_info->mac_type == ALTERA_TSE_MACLITE_10_100) {
            common_1000 = 0;
        }
        else if(pmac_info->mac_type == ALTERA_TSE_MACLITE_1000) {
            common_100 = 0;
            common_10 = 0;            
        }
        
        /* get common capabilities for all PHYs and link partners */
        common_1000 &= ((pphy->link_capability.cap_1000_base_t_full & pphy->link_capability.lp_1000_base_t_full));
                        //(pphy->link_capability.cap_1000_base_t_half & pphy->link_capability.lp_1000_base_t_half));
        common_100 &= ((pphy->link_capability.cap_100_base_x_full & pphy->link_capability.lp_100_base_tx_full) |
                        (pphy->link_capability.cap_100_base_x_half & pphy->link_capability.lp_100_base_tx_half) |
                        (pphy->link_capability.cap_100_base_t4 & pphy->link_capability.lp_100_base_t4));
        common_10 &= ((pphy->link_capability.cap_10_base_t_full & pphy->link_capability.lp_10_base_tx_full) |
                        (pphy->link_capability.cap_10_base_t_half & pphy->link_capability.lp_10_base_tx_half));

    }
    
    /* get common speed based on capabilities */
    if(none_an_complete == 1) {
        common_speed = TSE_PHY_SPEED_NO_COMMON;
        tse_dprintf(2, "ERROR   : MAC Group[%d] - None of the PHYs Auto-Negotiation completed!\n", mac_group_index);
    }
    else if(common_1000) {
        common_speed = TSE_PHY_SPEED_1000;
        tse_dprintf(5, "INFO    : MAC Group[%d] - Common Speed : %d Mbps\n", mac_group_index, 1000);
    }
    else if(common_100) {
        common_speed = TSE_PHY_SPEED_100;
        tse_dprintf(5, "INFO    : MAC Group[%d] - Common Speed : %d Mbps\n", mac_group_index, 100);
    }
    else if(common_10) {
        common_speed = TSE_PHY_SPEED_10;
        tse_dprintf(5, "INFO    : MAC Group[%d] - Common Speed : %d Mbps\n", mac_group_index, 10);
    }
    else {
        common_speed = TSE_PHY_SPEED_NO_COMMON;
        tse_dprintf(2, "ERROR   : MAC Group[%d] - No common speed at all!\n", mac_group_index);    }

    return common_speed;
}


/* @Function Description: Set the common speed to all PHYs connected to the MAC within the same group
 * @API Type:               Internal
 * @param pmac_group        Pointer to the TSE MAC Group structure which group all the MACs that should use the same speed
 *        common_speed      common speed supported by all PHYs
 * @return      common speed supported by all PHYs connected to the MAC, return TSE_PHY_SPEED_NO_COMMON if invalid common speed specified
 */
alt_32 alt_tse_phy_set_common_speed(alt_tse_mac_group *pmac_group, alt_32 common_speed) {
    
    alt_32 i;

    alt_u8 speed;
    alt_u8 duplex;
    
    alt_u8 gb_capable;
    
    alt_tse_phy_info *pphy = 0;
    alt_tse_mac_info *pmac_info = 0;
    alt_tse_system_info *psys = 0;
    
    /* get index of the pointers in pointer array list */
    alt_8 mac_info_index = 0;
    alt_8 mac_group_index = alt_tse_get_mac_group_index(pmac_group);
         
    /* Record previous MDIO address, to be restored at the end of function */
    np_tse_mac *pmac_group_base = (np_tse_mac *)pmac_group->pmac_info[0]->psys_info->tse_mac_base;
    alt_32 mdioadd_prev = IORD(&pmac_group_base->MDIO_ADDR1, 0);
    
    if((common_speed < TSE_PHY_SPEED_10) || (common_speed > TSE_PHY_SPEED_1000)) {
        tse_dprintf(2, "ERROR   : MAC Group[%d] - Invalid common speed specified! common speed = %d\n", mac_group_index, (int)common_speed);
        /* Restore previous MDIO address */
        IOWR(&pmac_group_base->MDIO_ADDR1, 0, mdioadd_prev);
        return TSE_PHY_SPEED_NO_COMMON;
    }
    
    /* loop through every PHY connected */
    for(i = 0; i < pmac_group->channel; i++) {
        pmac_info = pmac_group->pmac_info[i];
        mac_info_index = alt_tse_get_mac_info_index(pmac_info);

        pphy = pmac_info->pphy_info;
        
        /* if no PHY connected */
        if(!pphy) {
            continue;
        }
        
        psys = pmac_info->psys_info; 
            
        /* write PHY address to MDIO to access the i-th PHY */
        alt_tse_phy_wr_mdio_addr(pphy, pphy->mdio_address);

        /* capability of PHY supports 1000 Mbps */
        gb_capable = pphy->link_capability.cap_1000_base_t_full || pphy->link_capability.cap_1000_base_t_half || 
                 pphy->link_capability.cap_1000_base_x_full || pphy->link_capability.cap_1000_base_x_half;
        
        /* if PHY does not supports 1000 Mbps, and common speed is 1000 Mbps */
        if((!gb_capable) && (common_speed == TSE_PHY_SPEED_1000)) {
            tse_dprintf(2, "ERROR   : PHY[%d.%d] - PHY does not support 1000 Mbps, please specify valid common speed\n", mac_group_index, mac_info_index);
            /* Restore previous MDIO address */
            IOWR(&pmac_group_base->MDIO_ADDR1, 0, mdioadd_prev);
            return TSE_PHY_SPEED_NO_COMMON;
        }
        
        /* if PHY is not Auto-Negotiation capable */
        if(!alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_ABILITY, 1)) {
            
            /* if PHY supports 1000 Mbps, write msb of speed */
            if(gb_capable) {
                alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_SPEED_MSB, 1, common_speed >> 1);
            }
            /* write lsb of speed */
            alt_tse_phy_wr_mdio_reg(pphy, TSE_PHY_MDIO_CONTROL, TSE_PHY_MDIO_CONTROL_SPEED_LSB, 1, common_speed);
            
            /* continue to next PHY */
            continue;
        }
        
        /* set Auto-Negotiation advertisement based on common speed */
        if(common_speed == TSE_PHY_SPEED_1000) {
            alt_tse_phy_set_adv_1000(pphy, 1);
            alt_tse_phy_set_adv_100(pphy, 1);
            alt_tse_phy_set_adv_10(pphy, 1);
        }
        else if(common_speed == TSE_PHY_SPEED_100) {
            alt_tse_phy_set_adv_1000(pphy, 0);
            alt_tse_phy_set_adv_100(pphy, 1);
            alt_tse_phy_set_adv_10(pphy, 1);
        }    
        else if(common_speed == TSE_PHY_SPEED_10) {
            alt_tse_phy_set_adv_1000(pphy, 0);
            alt_tse_phy_set_adv_100(pphy, 0);
            alt_tse_phy_set_adv_10(pphy, 1);
        }
        else {
            alt_tse_phy_set_adv_1000(pphy, 0);
            alt_tse_phy_set_adv_100(pphy, 0);
            alt_tse_phy_set_adv_10(pphy, 0);
        }
        
        /* if PHY Auto-Negotiation is completed */
        if(alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, TSE_PHY_MDIO_STATUS_AN_COMPLETE, 1) == 1) {
            
            /* read both msb and lsb of speed bits if PHY support 1000 Mbps */
            if(gb_capable) {
        
                /* get speed information after Auto-Negotiation */
                speed = alt_tse_phy_rd_mdio_reg(pphy, pphy->pphy_profile->status_reg_location, pphy->pphy_profile->speed_lsb_location, 2);
            }
            
            /* read lsb of speed only if PHY support only 10/100 Mbps */
            else {
                /* get speed and link information after Auto-Negotiation */
                speed = alt_tse_phy_rd_mdio_reg(pphy, pphy->pphy_profile->status_reg_location, pphy->pphy_profile->speed_lsb_location, 1);
            }
            
            /* if current speed != common speed, then restart Auto-Negotiation */
            if(speed != common_speed) {
                alt_tse_phy_restart_an(pphy, ALTERA_AUTONEG_TIMEOUT_THRESHOLD);
            }
            
            /* get speed information after Auto-Negotiation */
            duplex = alt_tse_phy_rd_mdio_reg(pphy, pphy->pphy_profile->status_reg_location, pphy->pphy_profile->duplex_bit_location, 1);
            
            /* Set MAC duplex register */
            alt_tse_mac_set_duplex((np_tse_mac *)psys->tse_mac_base, duplex);
            
        }
        tse_dprintf(5, "INFO    : PHY[%d.%d] - PHY STATUS = 0x%04x\n\n", mac_group_index, mac_info_index, (int) alt_tse_phy_rd_mdio_reg(pphy, TSE_PHY_MDIO_STATUS, 0, 16));        
    }
    tse_dprintf(5, "INFO    : MAC Group[%d] - All PHYs set to common speed : %d Mbps\n", mac_group_index, (common_speed == TSE_PHY_SPEED_1000) ? 1000 : ((common_speed == TSE_PHY_SPEED_100) ? 100 : 10));

    /* Set MAC speed register */
    alt_tse_mac_set_speed(pmac_group_base, common_speed);
    
    /* Restore previous MDIO address */
    IOWR(&pmac_group_base->MDIO_ADDR1, 0, mdioadd_prev);
        
    return common_speed;
}



/* @Function Description: Additional configuration for Marvell PHY
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address of MAC group
 */
alt_32 marvell_phy_cfg(np_tse_mac *pmac) {
    
    alt_u16 dat;
    
    /* If there is no link yet, we enable auto crossover and reset the PHY */
    if((IORD(&pmac->mdio1.STATUS, 0) & PCS_ST_an_done) == 0) {
        tse_dprintf(5, "MARVELL : Enabling auto crossover\n");
        IOWR(&pmac->mdio1.CONTROL, 16, 0x0078);
        tse_dprintf(5, "MARVELL : PHY reset\n");
        dat = IORD(&pmac->mdio1.CONTROL, 0); 
        IOWR(&pmac->mdio1.CONTROL, 0, dat | PCS_CTL_sw_reset);        
    }
    
    return 0;
}


/* @Function Description: Change operating mode of Marvell PHY to GMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_gmii(np_tse_mac *pmac) {
    
    alt_u16 dat = IORD(&pmac->mdio1.reg1b, 0);
    dat &= 0xfff0;

    tse_dprintf(5, "MARVELL : Mode changed to GMII to copper mode\n");
    IOWR(&pmac->mdio1.reg1b, 0, dat | 0xf);
    
    tse_dprintf(5, "MARVELL : Disable RGMII Timing Control\n");
    dat = IORD(&pmac->mdio1.reg14, 0); 
    dat &= ~0x82;
    IOWR(&pmac->mdio1.reg14, 0, dat);
    
    tse_dprintf(5, "MARVELL : PHY reset\n");
    dat = IORD(&pmac->mdio1.CONTROL, 0); 
    IOWR(&pmac->mdio1.CONTROL, 0, dat | PCS_CTL_sw_reset);
    
    return 1;
}

/* @Function Description: Change operating mode of Marvell PHY to SGMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_sgmii(np_tse_mac *pmac) {
    
    alt_u16 dat = IORD(&pmac->mdio1.reg1b, 0);
    dat &= 0xfff0;

    tse_dprintf(5, "MARVELL : Mode changed to SGMII without clock with SGMII Auto-Neg to copper mode\n");
    IOWR(&pmac->mdio1.reg1b, 0, dat | 0x4);
    
    tse_dprintf(5, "MARVELL : Disable RGMII Timing Control\n");
    dat = IORD(&pmac->mdio1.reg14, 0); 
    dat &= ~0x82;
    IOWR(&pmac->mdio1.reg14, 0, dat);

    tse_dprintf(5, "MARVELL : PHY reset\n");
    dat = IORD(&pmac->mdio1.CONTROL, 0); 
    IOWR(&pmac->mdio1.CONTROL, 0, dat | PCS_CTL_sw_reset);
    
    return 1;
}

/* @Function Description: Change operating mode of Marvell PHY to RGMII
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 marvell_cfg_rgmii(np_tse_mac *pmac) {
    
    alt_u16 dat = IORD(&pmac->mdio1.reg1b, 0);
    dat &= 0xfff0;
    
    tse_dprintf(5, "MARVELL : Mode changed to RGMII/Modified MII to Copper mode\n");
    IOWR(&pmac->mdio1.reg1b, 0, dat | 0xb);
    
    tse_dprintf(5, "MARVELL : Enable RGMII Timing Control\n");
    dat = IORD(&pmac->mdio1.reg14, 0);
    dat &= ~0x82;
    dat |= 0x82;
    IOWR(&pmac->mdio1.reg14, 0, dat);    
    
    tse_dprintf(5, "MARVELL : PHY reset\n");
    dat = IORD(&pmac->mdio1.CONTROL, 0); 
    IOWR(&pmac->mdio1.CONTROL, 0, dat | PCS_CTL_sw_reset);
    
    return 1;
    
}

/* @Function Description: Read link status from PHY specific status register of DP83848C
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_u32 DP83848C_link_status_read(np_tse_mac *pmac) {
    alt_u32 link_status = 0;
    alt_u32 reg_status = IORD(&pmac->mdio1.reg10, 0);
    
    /* If speed == 10 Mbps */
    if(reg_status & 0x2) {
        link_status |= 0x8;
    }
    /* Else speed = 100 Mbps */
    else {
        link_status |= 0x4;
    }
    
    /* If duplex == Full */
    if(reg_status & 0x4) {
        link_status |= 0x1;
    }
    
    return link_status;
}

/* @Function Description: Additional configuration for PEF7071 Phy
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_32 PEF7071_config(np_tse_mac *pmac)
{  
    alt_u16 dat;
        
    dat = IORD(&pmac->mdio1.reg14, 0);
    dat &= 0x3FFF;
    dat |= 0x0100;
    IOWR(&pmac->mdio1.reg14, 0, dat);
    
    return 0;
    
}

/* @Function Description: Read link status from PHY specific status register of PEF7071
 * @API Type:   Internal
 * @param pmac  Pointer to the first TSE MAC Control Interface Base address within MAC group
 */
alt_u32 PEF7071_link_status_read(np_tse_mac *pmac)
{
    alt_u32 link_status = 0;
    alt_u32 reg18 = IORD(&pmac->mdio1.reg18, 0);
        
    if ((reg18 & 0x3)==0) { link_status |= 0x8; }  /* If speed == 10 Mbps */
    if ((reg18 & 0x3)==1) { link_status |= 0x4; }  /* Else speed = 100 Mbps */
    if ((reg18 & 0x3)==2) { link_status |= 0x2; }  /* Else speed = 1000 Mbps */    
        
    /* If duplex == Full */
    if(reg18 & 0x8) {
        link_status |= 0x1;
    }
    
    return link_status;
}
