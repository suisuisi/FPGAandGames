#include "rng.h"

uint32_t rng_num = 0;  // Previous generated random number

uint32_t rng_generate() {
    return rng_num = RNG_MASK & (RNG_MULTIPLIER * rng_num + RNG_INCREMENT);
}
