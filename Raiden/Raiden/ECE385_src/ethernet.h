#ifndef ETHERNET_H_
#define ETHERNET_H_

#include "lwip/netif.h"

void eth_init();
void eth_loop();
uint32_t eth_ip_reverse(uint32_t addr);

err_t eth0_init(struct netif *netif);
//void eth0_rx_interrupt(void *context);
void eth0_rx_start();
err_t eth0_tx(struct netif *netif, struct pbuf *p);
uint32_t eth0_ip();

//err_t eth1_init(struct netif *netif);
////void eth1_rx_interrupt(void *context);
//void eth1_rx_start();
//err_t eth1_tx(struct netif *netif, struct pbuf *p);
//uint32_t eth1_ip();

extern volatile int eth0_rx_done;
//extern volatile int eth1_rx_done;
extern uint8_t eth0_rx_frame[2048];
//extern uint8_t eth1_rx_frame[2048];

#endif /* ETHERNET_H_ */
