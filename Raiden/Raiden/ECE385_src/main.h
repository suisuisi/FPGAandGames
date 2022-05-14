#ifndef MAIN_H_
#define MAIN_H_

#include "comm.h"

extern volatile int* io_led_red;
extern volatile int* io_led_green;
extern volatile int* io_hex;
extern volatile int* io_vga_sync;
extern volatile int* io_vga_background_offset;

typedef enum {
	PREPARE_GAME = 0,
	IN_GAME = 1,
	GAME_OVER = 2,
	GAME_OVER_UPLOAD_SCORE_BEGIN = 3,
	GAME_OVER_UPLOAD_SCORE_PROCESSING = 4,
	GAME_OVER_UPLOAD_SCORE_FINISH = 5,
	GAME_OVER_WAIT_ENTER_PRESS = 6,
	GAME_OVER_WAIT_ENTER_PRESS_OR_R_PRESS = 7,
	GAME_OVER_WAIT_ENTER_RELEASE_TO_SCOREBOARD = 8,
	GAME_OVER_WAIT_R_RELEASE = 9,
	MAIN_MENU_PREPARE = 10,
	MAIN_MENU = 11,
	SCOREBOARD_PREPARE = 12,
	SCOREBOARD = 13,
	GAME_OVER_WAIT_ENTER_RELEASE_TO_MENU = 14,
} game_state_t;

extern volatile game_state_t game_state;

int enter_pressed();
int r_pressed();
int esc_pressed();
int p_pressed();
int main(void);

#endif /* MAIN_H_ */
