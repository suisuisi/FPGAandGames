#include "main_menu.h"
#include "main.h"
#include "vga.h"
#include "sprites.h"
#include "resources/main_menu_bg.h"

#include <stdio.h>

volatile vga_sprite_info_t* main_menu_pointer = NULL;
main_menu_options menu_current_option = MENU_PLAY;

void main_menu_init() {
//	printf("main_menu_init\n");
	*io_vga_background_offset = 0;
	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, main_menu_bg);
	vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);

	vga_statusbar_string(0, (uint8_t*) "ECE385 Final Project 徐钰辉 & 刘柯");

	sprites_init(VGA_SPRITE_BULLET);
	do {
		int id;
		if(255 == (id = sprites_allocate(VGA_SPRITE_BULLET))) {
//			printf("ERR sprites_allocate\n");
			break;
		}
		main_menu_pointer = sprites_get(VGA_SPRITE_BULLET, id);
		if(NULL == main_menu_pointer) {
//			printf("ERR sprites_get\n");
			break;
		}
		main_menu_pointer->physical->x = 0;
		main_menu_pointer->physical->y = 0;
		main_menu_pointer->physical->bullet_radius = 5;
		main_menu_pointer->physical->bullet_color = 0xffff;
	} while(0);

	vga_string_transparent(160, 440, (uint8_t*) "开始游戏");
	vga_string_transparent(340, 440, (uint8_t*) "积分榜");

	main_menu_select_option(MENU_PLAY);
}

void main_menu_select_option(main_menu_options option) {
	if(!main_menu_pointer) return;
	switch(option) {
	case MENU_PLAY:
		main_menu_pointer->physical->x = 150 << VGA_SPRITE_HW_SHIFT_BITS;
		main_menu_pointer->physical->y = 448 << VGA_SPRITE_HW_SHIFT_BITS;
		break;
	case MENU_SCOREBOARD:
		main_menu_pointer->physical->x = 330 << VGA_SPRITE_HW_SHIFT_BITS;
		main_menu_pointer->physical->y = 448 << VGA_SPRITE_HW_SHIFT_BITS;
		break;
	}
	menu_current_option = option;
}

void main_menu_loop() {
	static int prev_keycode = 0;
	int keycode = keycode_comm->keycode[0];
	if(keycode != prev_keycode) {
		switch(prev_keycode) {
		case 0x07:	// D
		case 0x4F:	// Right
			if(menu_current_option == MENU_PLAY) {
				main_menu_select_option(MENU_SCOREBOARD);
			}
			break;
		case 0x04:	// A
		case 0x50:	// Left
			if(menu_current_option == MENU_SCOREBOARD) {
				main_menu_select_option(MENU_PLAY);
			}
			break;
		case 0x28:  // Enter
			if(menu_current_option == MENU_PLAY) {
				sprites_init(VGA_SPRITE_BULLET);
				game_state = PREPARE_GAME;
			} else if(menu_current_option == MENU_SCOREBOARD) {
				sprites_init(VGA_SPRITE_BULLET);
				game_state = SCOREBOARD_PREPARE;
			}
			break;
		}
	}
	prev_keycode = keycode;
}
