#include "audio.h"
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer_regs.h"
#include <stdio.h>

#include "resources/sound_explosion.h"
#include "resources/sound_hit.h"

volatile uint32_t* audio_pio = (uint32_t*) AUDIO_PIO_BASE;
volatile uint32_t audio_pos = 0;
volatile uint32_t audio_len = 0;
volatile int16_t* audio_src = NULL;
volatile int* audio_timer_ptr = (int*) AUDIO_TIMER_BASE;

volatile uint32_t explosion_pos = EXPLOSION_LEN / 2;
volatile int16_t* explosion_src = (int16_t*) explosion_data;

volatile uint32_t sound_hit_pos = SOUND_HIT_LEN / 2;
volatile int16_t* sound_hit_src = (int16_t*) sound_hit_data;


void audio_init() {
	IOWR_ALTERA_AVALON_TIMER_CONTROL(audio_timer_ptr,
			ALTERA_AVALON_TIMER_CONTROL_ITO_MSK | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
	);
	IOWR_ALTERA_AVALON_TIMER_STATUS(audio_timer_ptr, 0);
	alt_ic_isr_register(
			AUDIO_TIMER_IRQ_INTERRUPT_CONTROLLER_ID,
			AUDIO_TIMER_IRQ,
			audio_interrupt,
			(int*) audio_timer_ptr,
			NULL
	);
}

void audio_interrupt(void *context) {
	// ACK interrupt
	IOWR_ALTERA_AVALON_TIMER_STATUS(audio_timer_ptr, 0);

	if(!audio_src) return;
	if(++audio_pos >= audio_len) {
		audio_pos = 0;
	}
	uint16_t sound_hi, sound_lo;

	if(sound_hit_pos < SOUND_HIT_LEN / 2) {
		sound_hi = sound_hit_src[sound_hit_pos++];
		sound_lo = audio_src[audio_pos];
//		sound_lo = audio_src[audio_pos] >> 1;
	} else if(explosion_pos < EXPLOSION_LEN / 2) {
		sound_hi = explosion_src[explosion_pos++];
		sound_lo = audio_src[audio_pos];
//		sound_lo = audio_src[audio_pos] >> 1;
	} else {
		sound_hi = audio_src[audio_pos];
		sound_lo = audio_src[audio_pos];
	}

	*audio_pio = (((uint32_t) sound_hi) << 16) | sound_lo;
}
