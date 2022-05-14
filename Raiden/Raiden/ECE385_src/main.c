#include "main.h"

#include "system.h"
#include "ethernet.h"
#include "gamelogic.h"
#include "resources/resource.h"
#include "vga.h"
#include "comm.h"
#include "audio.h"
#include "resources/music.h"
#include "httpc.h"
#include "main_menu.h"
#include "scoreboard.h"

volatile int* io_led_red = (int*) IO_LED_RED_BASE;
volatile int* io_led_green = (int*) IO_LED_GREEN_BASE;
volatile int* io_hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;
volatile int* io_vga_background_offset = (int*) VGA_BACKGROUND_OFFSET_BASE;
volatile game_state_t game_state = MAIN_MENU_PREPARE;

httpc_request http_score_upload __attribute__((section(".resources")));

int enter_pressed() {
	for(int i = 0; i < 6; i++) {
		if(keycode_comm->keycode[i] == 0x28) {
			return 1;
		}
	}
	return 0;
}

int r_pressed() {
	for(int i = 0; i < 6; i++) {
		if(keycode_comm->keycode[i] == 0x15) {
			return 1;
		}
	}
	return 0;
}

int esc_pressed() {
	for(int i = 0; i < 6; i++) {
		if(keycode_comm->keycode[i] == 0x29) {
			return 1;
		}
	}
	return 0;
}

int p_pressed() {
	for(int i = 0; i < 6; i++) {
		if(keycode_comm->keycode[i] == 0x13) {
			return 1;
		}
	}
	return 0;
}

int main(void) {

	eth_init();

	audio_init();
	audio_len = MUSIC_LEN / 2;
	audio_src = (uint16_t*) music_data;

	while(1) {
		eth_loop();
		*io_hex = keycode_comm->keycode[0];

		switch(game_state) {
		case PREPARE_GAME:
			vga_scroll_init();
			game_init();
			break;
		case IN_GAME:
			vga_scroll(1125, background);
			game_loop();
			break;
		case GAME_OVER:
			game_over();
			game_state = GAME_OVER_UPLOAD_SCORE_BEGIN;
			break;
		case GAME_OVER_UPLOAD_SCORE_BEGIN:
			do {
				http_score_upload.processing = 0;
				http_score_upload.error = 0;
				char buf[256];
				snprintf(buf, 60, "/zjui-ece385-scoreboard/index.php?score=%d", player_score);
				httpc_send_request("lab.lantian.pub", 80, (const char*) buf, &http_score_upload);
			} while(0);
			game_state = GAME_OVER_UPLOAD_SCORE_PROCESSING;
			break;
		case GAME_OVER_UPLOAD_SCORE_PROCESSING:
			if(!httpc_processing(&http_score_upload)) {
				game_state = GAME_OVER_UPLOAD_SCORE_FINISH;
			}
			break;
		case GAME_OVER_UPLOAD_SCORE_FINISH:
			do {
				char buf[256];
				if(httpc_success(&http_score_upload)) {
					snprintf(buf, 255, "游戏结束 积分 %d 上传成功 按 Enter 继续", player_score);
					game_state = GAME_OVER_WAIT_ENTER_PRESS;
				} else {
					snprintf(buf, 255, "游戏结束 积分 %d 上传失败 按 Enter 继续 按 R 重试", player_score);
					game_state = GAME_OVER_WAIT_ENTER_PRESS_OR_R_PRESS;
				}
				vga_statusbar_string(0, (uint8_t*) buf);
			} while(0);
			break;
		case GAME_OVER_WAIT_ENTER_PRESS:
			if(enter_pressed()) {
				game_state = GAME_OVER_WAIT_ENTER_RELEASE_TO_SCOREBOARD;
			}
			break;
		case GAME_OVER_WAIT_ENTER_PRESS_OR_R_PRESS:
			if(enter_pressed()) {
				game_state = GAME_OVER_WAIT_ENTER_RELEASE_TO_MENU;
			} else if(r_pressed()) {
				game_state = GAME_OVER_WAIT_R_RELEASE;
			}
			break;
		case GAME_OVER_WAIT_ENTER_RELEASE_TO_SCOREBOARD:
			if(!enter_pressed()) {
				game_state = SCOREBOARD_PREPARE;
			}
			break;
		case GAME_OVER_WAIT_ENTER_RELEASE_TO_MENU:
			if(!enter_pressed()) {
				game_state = MAIN_MENU_PREPARE;
			}
			break;
		case GAME_OVER_WAIT_R_RELEASE:
			if(!r_pressed()) {
				game_state = GAME_OVER_UPLOAD_SCORE_BEGIN;
			}
			break;
		case MAIN_MENU_PREPARE:
			main_menu_init();
			game_state = MAIN_MENU;
			break;
		case MAIN_MENU:
			main_menu_loop();
			break;
		case SCOREBOARD_PREPARE:
			scoreboard_init();
			game_state = SCOREBOARD;
			break;
		case SCOREBOARD:
			scoreboard_loop();
			break;
		}
	}

	return 0;
}
