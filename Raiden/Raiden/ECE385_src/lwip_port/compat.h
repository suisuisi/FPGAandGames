#ifndef LWIP_PORT_COMPAT_H_
#define LWIP_PORT_COMPAT_H_

#include <stdint.h>
#include <stdio.h>

uint32_t sys_now();
int fflush(FILE* ignored);

#endif /* LWIP_PORT_COMPAT_H_ */
