#ifndef RESOURCES_MUSIC_H_
#define RESOURCES_MUSIC_H_

#include <stdint.h>
#include "resource.h"

#define MUSIC_LEN 5040018

#ifdef NO_ACTUAL_DATA
extern uint8_t music_data[1];
#else
extern uint8_t music_data[MUSIC_LEN];
#endif

#endif /* RESOURCES_MUSIC_H_ */
