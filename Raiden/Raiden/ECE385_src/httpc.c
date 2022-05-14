#include "httpc.h"
#include <string.h>
#include <time.h>
#include "ethernet.h"

httpc_connection_t httpc_connection_settings;

err_t httpc_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
	struct pbuf* ptr = p;
	httpc_request* result = (httpc_request*) arg;
	while(ptr) {
//		printf("\nPacket len: %d/%d\n", ptr->len, ptr->tot_len);
//		for(int i = 0; i < ptr->len; i++) {
//			printf("%x ", ((char*) ptr->payload)[i]);
//		}
		if(arg) {
			// Copy result to storage
			memcpy(result->data + result->len, ptr->payload, ptr->len);
			result->len += ptr->len;
		}
		ptr = ptr->next;
	}
	result->data[result->len] = 0x00;

	return ERR_OK;
}

void httpc_request_finish(void *arg, httpc_result_t httpc_result, u32_t rx_content_len, u32_t srv_res, err_t err) {
	if(!arg) return;
	httpc_request* result = (httpc_request*) arg;
	result->processing = 0;
	if(rx_content_len != -1 && rx_content_len != result->len) {
//		printf("RX Content-Length mismatch: expect %lu, actual %lu\n", rx_content_len, result->len);
		result->error = 1;
	} else {
		result->error = err;
	}
}

void httpc_send_request(const char* server, uint16_t port, const char* uri, httpc_request* req) {
	httpc_connection_settings.use_proxy = 0;
	httpc_connection_settings.result_fn = httpc_request_finish;
	httpc_connection_settings.headers_done_fn = NULL;

	req->len = 0;
	req->request_start = clock();
	if(eth0_ip() == 0) {
		req->error = 1;
		req->processing = 0;
		return;
	}

	err_t err;
	if(ERR_OK != (err = httpc_get_file_dns(server, port, uri, &httpc_connection_settings, httpc_callback, req, NULL))) {
		req->error = err;
		req->processing = 0;
	} else {
		req->processing = 1;
	}
}

int httpc_processing(httpc_request* req) {
	if(clock() - req->request_start >= CLOCKS_PER_SEC * HTTPC_TIMEOUT) {
		req->error = 1;
		req->processing = 0;
	}

	return req->processing;
}

int httpc_success(httpc_request* req) {
	return req->error == ERR_OK;
}
