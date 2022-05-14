#ifndef RESOURCES_SOUND_EXPLOSION_H_
#define RESOURCES_SOUND_EXPLOSION_H_

#include <stdint.h>
#include "resource.h"

#define EXPLOSION_LEN 16000

#ifdef NO_ACTUAL_DATA
extern uint8_t explosion_data[1];
#else
extern uint8_t explosion_data[EXPLOSION_LEN];
#endif

#endif /* RESOURCES_SOUND_EXPLOSION_H_ */
