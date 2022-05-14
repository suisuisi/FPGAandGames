#ifndef AUDIO_H_
#define AUDIO_H_

#include <stdint.h>
#include "system.h"

//#define AUDIO_BUFFER_UNIT (AUDIO_MEM_SIZE_VALUE >> 1)
//
//void audio_send(uint8_t* src, int pos, int len);
//int audio_sending();

extern volatile uint32_t audio_pos;
extern volatile uint32_t audio_len;
extern volatile int16_t* audio_src;

extern volatile uint32_t explosion_pos;
extern volatile uint32_t sound_hit_pos;

void audio_init();
void audio_interrupt(void *context);

#endif /* AUDIO_H_ */
