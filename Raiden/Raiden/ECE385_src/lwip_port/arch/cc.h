/*
 * cc.h
 *
 *  Created on: May 31, 2019
 *      Author: xuyh0
 */

#ifndef LWIP_PORT_CC_H_
#define LWIP_PORT_CC_H_

#include <stdint.h>
#include "sys_arch.h"

typedef uint8_t u8_t;
typedef int8_t s8_t;
typedef uint16_t u16_t;
typedef int16_t s16_t;
typedef uint32_t u32_t;
typedef int32_t s32_t;

#define PACK_STRUCT_FIELD(x) x
#define PACK_STRUCT_STRUCT __attribute__((packed))
#define PACK_STRUCT_BEGIN
#define PACK_STRUCT_END

#endif /* LWIP_PORT_CC_H_ */
