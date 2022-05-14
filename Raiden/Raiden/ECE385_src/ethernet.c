#include "ethernet.h"
#include "system.h"

#include "sys/alt_irq.h"

#include "altera_avalon_sgdma.h"
#include "altera_avalon_sgdma_descriptor.h"
#include "altera_avalon_sgdma_regs.h"

#include "lwip/inet.h"
#include "lwip/init.h"
#include "lwip/dhcp.h"
#include "lwip/ethip6.h"
#include "lwip/timeouts.h"
#include "netif/etharp.h"

// Create sgdma transmit and receive devices
alt_sgdma_dev* eth0_dma_tx_dev;
alt_sgdma_dev* eth0_dma_rx_dev;
//alt_sgdma_dev* eth1_dma_tx_dev;
//alt_sgdma_dev* eth1_dma_rx_dev;

// Ethernet MDIOs
volatile int* eth0_mdio = (int*) ETH0_MDIO_BASE;
//volatile int* eth1_mdio = (int*) ETH1_MDIO_BASE;

// Allocate descriptors in the descriptor_memory (onchip memory)
alt_sgdma_descriptor eth0_tx_descriptor 	__attribute__((section(".onchip")));
alt_sgdma_descriptor eth0_tx_descriptor_end __attribute__((section(".onchip")));

alt_sgdma_descriptor eth0_rx_descriptor 	__attribute__((section(".onchip")));
alt_sgdma_descriptor eth0_rx_descriptor_end __attribute__((section(".onchip")));

//alt_sgdma_descriptor eth1_tx_descriptor 	__attribute__((section(".onchip")));
//alt_sgdma_descriptor eth1_tx_descriptor_end __attribute__((section(".onchip")));
//
//alt_sgdma_descriptor eth1_rx_descriptor 	__attribute__((section(".onchip")));
//alt_sgdma_descriptor eth1_rx_descriptor_end __attribute__((section(".onchip")));

uint8_t tx_frame[2048] __attribute__((section(".onchip"))) = { 0 };
//volatile int eth0_rx_len = 0;
//volatile int eth1_rx_len = 0;
uint8_t eth0_rx_frame[2048] __attribute__((section(".onchip"))) = { 0 };
//uint8_t eth1_rx_frame[2048] __attribute__((section(".onchip"))) = { 0 };

struct netif eth0_if, eth1_if;

void eth_init() {
	lwip_init();

	netif_add(&eth0_if, IP4_ADDR_ANY4, IP4_ADDR_ANY4, IP4_ADDR_ANY4, NULL, eth0_init, netif_input);
	eth0_if.name[0] = 'e';
	eth0_if.name[1] = '0';
	netif_create_ip6_linklocal_address(&eth0_if, 1);
	eth0_if.ip6_autoconfig_enabled = 1;
	netif_set_default(&eth0_if);
	netif_set_up(&eth0_if);
	dhcp_start(&eth0_if);

//	netif_add(&eth1_if, IP4_ADDR_ANY4, IP4_ADDR_ANY4, IP4_ADDR_ANY4, NULL, eth1_init, netif_input);
//	eth1_if.name[0] = 'e';
//	eth1_if.name[1] = '1';
//	netif_create_ip6_linklocal_address(&eth1_if, 1);
//	eth1_if.ip6_autoconfig_enabled = 1;
//	netif_set_up(&eth1_if);
//	dhcp_start(&eth1_if);
}

void eth_loop() {
	static int eth0_prev_state = 0;
	int eth0_state = eth0_mdio[0x01] & 0x04;
	if(eth0_state && !eth0_prev_state) {
//		printf("eth0 up\n");
		netif_set_link_up(&eth0_if);
	} else if(!eth0_state && eth0_prev_state) {
//		printf("eth0 down\n");
		netif_set_link_down(&eth0_if);
	}
	eth0_prev_state = eth0_state;

	if(!alt_avalon_sgdma_check_descriptor_status(&eth0_rx_descriptor)) {
		do {
			int eth0_rx_len = eth0_rx_descriptor.actual_bytes_transferred;
			struct pbuf* p = pbuf_alloc(PBUF_RAW, eth0_rx_len, PBUF_POOL);
			if(p == NULL) break;

			pbuf_take(p, (void*) eth0_rx_frame, eth0_rx_len);
			if(eth0_if.input(p, &eth0_if) != ERR_OK) {
				pbuf_free(p);
			}
		} while(0);

		eth0_rx_start();
	}

//	static int eth1_prev_state = 0;
//	int eth1_state = eth1_mdio[0x01] & 0x04;
//	if(eth1_state && !eth1_prev_state) {
////	printf("eth1 up\n");
//		netif_set_link_up(&eth1_if);
//	} else if(!eth1_state && eth1_prev_state) {
////	printf("eth1 down\n");
//		netif_set_link_down(&eth1_if);
//	}
//	eth1_prev_state = eth1_state;
//
//	if(!alt_avalon_sgdma_check_descriptor_status(&eth1_rx_descriptor)) {
//		do {
//			int eth1_rx_len = eth1_rx_descriptor.actual_bytes_transferred;
//			struct pbuf* p = pbuf_alloc(PBUF_RAW, eth1_rx_len, PBUF_POOL);
//			if(p == NULL) break;
//
//			pbuf_take(p, (void*) eth1_rx_frame, eth1_rx_len);
//			if(eth1_if.input(p, &eth1_if) != ERR_OK) {
//				pbuf_free(p);
//			}
//		} while(0);
//
//		eth1_rx_start();
//	}

	sys_check_timeouts();
}

uint32_t eth_ip_reverse(uint32_t addr) {
	return ((addr & 0xff) << 24)
			| ((addr & 0xff00) << 8)
			| ((addr & 0xff0000) >> 8)
			| ((addr & 0xff000000) >> 24);
}

err_t eth0_init(struct netif *netif) {
	eth0_dma_tx_dev = alt_avalon_sgdma_open ("/dev/eth0_tx_dma");
	eth0_dma_rx_dev = alt_avalon_sgdma_open ("/dev/eth0_rx_dma");
	do {
//		printf("Initializing eth0\n");
//		eth0_mdio[0x09] &= 0xfcff;
		eth0_mdio[0x10] |= 0x0060;
		eth0_mdio[0x14] |= 0x0082;
		eth0_mdio[0x00] |= 0x8000;
		while(eth0_mdio[0x00] & 0x8000);
	} while(0);

	netif->linkoutput = eth0_tx;
	netif->output     = etharp_output;
	netif->output_ip6 = ethip6_output;
	netif->mtu        = 1500;
	netif->flags      = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_ETHERNET | NETIF_FLAG_IGMP | NETIF_FLAG_MLD6;
	netif->hwaddr[0]  = 0x01;
	netif->hwaddr[1]  = 0x60;
	netif->hwaddr[2]  = 0x6e;
	netif->hwaddr[3]  = 0x11;
	netif->hwaddr[4]  = 0x02;
	netif->hwaddr[5]  = 0x0f;
	netif->hwaddr_len = ETH_HWADDR_LEN;

	eth0_rx_start();
	return ERR_OK;
}

void eth0_rx_start() {
	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth0_rx_descriptor, &eth0_rx_descriptor_end, (alt_u32 *)eth0_rx_frame, 0, 0 );
	alt_avalon_sgdma_do_async_transfer(eth0_dma_rx_dev, &eth0_rx_descriptor );
}

uint32_t eth0_ip() {
	return eth_ip_reverse(netif_ip4_addr(&eth0_if)->addr);
}

err_t eth0_tx(struct netif *netif, struct pbuf *p) {
	pbuf_copy_partial(p, (void*) tx_frame, p->tot_len, 0);
	alt_avalon_sgdma_construct_mem_to_stream_desc(&eth0_tx_descriptor, &eth0_tx_descriptor_end, (alt_u32 *)tx_frame, p->tot_len, 0, 1, 1, 0 );
	alt_avalon_sgdma_do_sync_transfer(eth0_dma_tx_dev, &eth0_tx_descriptor);
	return ERR_OK;
}

//err_t eth1_init(struct netif *netif) {
//	eth1_dma_tx_dev = alt_avalon_sgdma_open ("/dev/eth1_tx_dma");
//	eth1_dma_rx_dev = alt_avalon_sgdma_open ("/dev/eth1_rx_dma");
//	do {
////		printf("Initializing eth1\n");
////		eth1_mdio[0x09] &= 0xfcff;
//		eth1_mdio[0x10] |= 0x0060;
//		eth1_mdio[0x14] |= 0x0082;
//		eth1_mdio[0x00] |= 0x8000;
//		while(eth1_mdio[0x00] & 0x8000);
//	} while(0);
//
//	netif->linkoutput = eth1_tx;
//	netif->output     = etharp_output;
//	netif->output_ip6 = ethip6_output;
//	netif->mtu        = 1500;
//	netif->flags      = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_ETHERNET | NETIF_FLAG_IGMP | NETIF_FLAG_MLD6;
//	netif->hwaddr[0]  = 0x01;
//	netif->hwaddr[1]  = 0x60;
//	netif->hwaddr[2]  = 0x6e;
//	netif->hwaddr[3]  = 0x11;
//	netif->hwaddr[4]  = 0x03;
//	netif->hwaddr[5]  = 0x0f;
//	netif->hwaddr_len = ETH_HWADDR_LEN;
//
//	eth1_rx_start();
//	return ERR_OK;
//}
//
//void eth1_rx_start() {
//	alt_avalon_sgdma_construct_stream_to_mem_desc(&eth1_rx_descriptor, &eth1_rx_descriptor_end, (alt_u32 *)eth1_rx_frame, 0, 0 );
//	alt_avalon_sgdma_do_async_transfer(eth1_dma_rx_dev, &eth1_rx_descriptor );
//}
//
//err_t eth1_tx(struct netif *netif, struct pbuf *p) {
//	pbuf_copy_partial(p, (void*) tx_frame, p->tot_len, 0);
//	alt_avalon_sgdma_construct_mem_to_stream_desc(&eth1_tx_descriptor, &eth1_tx_descriptor_end, (alt_u32 *)tx_frame, p->tot_len, 0, 1, 1, 0 );
//	alt_avalon_sgdma_do_sync_transfer(eth1_dma_tx_dev, &eth1_tx_descriptor);
//	return ERR_OK;
//}
//
//uint32_t eth1_ip() {
//	return eth_ip_reverse(netif_ip4_addr(&eth1_if)->addr);
//}
