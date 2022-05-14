#include "scoreboard.h"
#include "vga.h"
#include "httpc.h"
#include "main.h"
#include "resources/resource.h"
#include "resources/scoreboard_bg.h"

httpc_request scoreboard_request __attribute__((section(".resources")));
int scoreboard_shown = 0;

void scoreboard_init() {
//	printf("scoreboard_init\n");
	*io_vga_background_offset = 0;
	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, scoreboard_bg);
	vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);

	scoreboard_sendrequest();
}

void scoreboard_sendrequest() {
	vga_statusbar_string(0, (uint8_t*) "正在加载积分榜，请稍候");

	scoreboard_request.processing = 0;
	scoreboard_request.error = 0;
	scoreboard_shown = 0;
	httpc_send_request("lab.lantian.pub", 80, "/zjui-ece385-scoreboard/index.php", &scoreboard_request);
}

void scoreboard_loop() {
	if(!scoreboard_shown && !httpc_processing(&scoreboard_request)) {
		if(httpc_success(&scoreboard_request)) {
			vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, scoreboard_bg);
			vga_string_transparent(16, 160, (uint8_t*) scoreboard_request.data);
			vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);
			vga_statusbar_string(0, (uint8_t*) "加载成功 按 R 刷新 Esc 返回");
		} else {
			vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);
			vga_statusbar_string(0, (uint8_t*) "加载失败 按 R 刷新 Esc 返回");
		}
		scoreboard_shown = 1;
	}

	static int prev_keycode = 0;
	int keycode = keycode_comm->keycode[0];
	if(keycode != prev_keycode) {
		switch(prev_keycode) {
		case 0x15:	// R
			if(!scoreboard_request.processing) {
				scoreboard_sendrequest();
			}
			break;
		case 0x29:	// Esc
			game_state = MAIN_MENU_PREPARE;
			break;
		}
	}
	prev_keycode = keycode;
}
