/*
 * httpc.h
 *
 *  Created on: Jun 4, 2019
 *      Author: xuyh0
 */

#ifndef HTTPC_H_
#define HTTPC_H_

#include "lwip/apps/http_client.h"
#include <stdint.h>

#define HTTPC_TIMEOUT 10

typedef struct {
	uint32_t processing;
	err_t error;
	uint32_t request_start;
	uint32_t len;
	char data[4096];
} httpc_request;

err_t httpc_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err);
void httpc_request_finish(void *arg, httpc_result_t httpc_result, u32_t rx_content_len, u32_t srv_res, err_t err);
void httpc_send_request(const char* server, uint16_t port, const char* uri, httpc_request* req);
int httpc_processing(httpc_request* req);
int httpc_success(httpc_request* req);

#endif /* HTTPC_H_ */
