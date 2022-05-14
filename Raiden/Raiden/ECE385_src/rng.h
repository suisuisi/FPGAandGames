#ifndef RNG_H_
#define RNG_H_

#include <stdint.h>

#define RNG_MULTIPLIER 1103515245
#define RNG_INCREMENT 12345
#define RNG_MASK 0x7fffffff

#define LWIP_RAND rng_generate

extern uint32_t rng_num;
uint32_t rng_generate();

#endif /* RNG_H_ */
