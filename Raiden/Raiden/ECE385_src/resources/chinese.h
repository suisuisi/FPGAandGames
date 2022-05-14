#ifndef RESOURCES_CHINESE_H_
#define RESOURCES_CHINESE_H_

#include <stdint.h>

extern uint8_t chinese_font[] __attribute__((section(".resources")));

#define CHINESE_ENCODE_START 0x4e00
#define CHINESE_ENCODE_END 0x9fa5

#endif /* RESOURCES_CHINESE_H_ */
