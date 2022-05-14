#include "gamelogic.h"

#include <stdio.h>

#include "main.h"
#include "vga.h"
#include "resources/resource.h"
#include "comm.h"
#include "rng.h"
#include "resources/plane_player.h"
#include "resources/scoreboard_bg.h"

volatile uint32_t frame_count = 0;
int player_plane_id = 0;
volatile vga_sprite_info_t* player_plane_info = NULL;
volatile int player_score = 0;
int next_frame_count = 0;

void game_init() {
	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, background);
	vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);
	sprites_init(VGA_SPRITE_PLANE);
	sprites_init(VGA_SPRITE_BULLET);

//	printf("Wait for keyboard ready\n");
//	while(!keycode_comm->keyboard_present);
//	printf("Keyboard ready\n");

	frame_count = 0;
	next_frame_count = 0;
	player_score = 0;
	vga_statusbar_string(0, (uint8_t*) "生命 18/18 积分 0");

	// Create player's plane
	do {
		int id;
		const sprite_data_t* plane_data = plane_player_seq + (frame_count / PLAYER_PLANE_IMG_UPDATE_INTERVAL) % PLANE_PLAYER_SEQ_LEN;
		int width = plane_data->width;
		int height = plane_data->height;
		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
//			printf("ERR sprites_allocate\n");
			break;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id,
				plane_data->data,
				plane_data->width * plane_data->height)) {
//			printf("ERR sprites_load_data\n");
			break;
		}
		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
		if(NULL == sprite_info) {
//			printf("ERR sprites_get\n");
			break;
		}
		sprite_info->physical->x = (VGA_SPRITE_WIDTH - (75 << VGA_SPRITE_HW_SHIFT_BITS)) / 2;
		sprite_info->physical->y = VGA_SPRITE_HEIGHT - (100 << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->type = 0;
		sprite_info->hp = PLAYER_PLANE_HP;
		sprite_info->vx = 0;
		sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
		sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->vy = 0;
		sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
		sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
		sprite_info->ax = 0;
		sprite_info->ay = 0;
		sprite_info->physical->width = width;
		sprite_info->physical->height = height;
		sprite_info->bullet_color = PLAYER_BULLET_COLOR;

		// Set plane as player's plane
		player_plane_id = id;
		player_plane_info = sprite_info;
	} while(0);

	game_state = IN_GAME;
}

void game_loop() {
	if(game_state != IN_GAME) return;

	if(esc_pressed()) {
		// Quit game immediately
		game_state = GAME_OVER;
		return;
	}

	static int io_vga_sync_prev = 0;
	if((!io_vga_sync_prev) && (*io_vga_sync)) {
		// New frame occured, do job
		frame_count++;

		if(p_pressed()) {
			// Cheat code: set HP max
			player_plane_info->hp = PLAYER_PLANE_HP;
			if(player_score >= 10) {
				player_score -= 10;
			} else {
				player_score = 0;
			}
		}

		// Update statusbar
		static int prev_hp = 0;
		static int prev_score = 0;
		if(prev_hp != player_plane_info->hp || prev_score != player_score) {
			vga_statusbar_english(5, '0' + player_plane_info->hp / 10);
			vga_statusbar_english(6, '0' + player_plane_info->hp % 10);

			char buf[256];
			snprintf(buf, 255, "%d ", player_score);
			vga_statusbar_string(16, (uint8_t*) buf);
		}
		prev_hp = player_plane_info->hp;
		prev_score = player_score;

		if(player_plane_info->type == 0) {
			// Player alive, allow moving
			handle_player_plane_keyboard(player_plane_id, player_plane_info);

			if(frame_count % PLAYER_PLANE_IMG_UPDATE_INTERVAL == 0) {
				const sprite_data_t* plane_data = plane_player_seq + (frame_count / PLAYER_PLANE_IMG_UPDATE_INTERVAL) % PLANE_PLAYER_SEQ_LEN;
				// Update player plane image every few frames
				if(255 == sprites_load_data(VGA_SPRITE_PLANE, player_plane_id,
						plane_data->data,
						plane_data->width * plane_data->height)) {
//					printf("ERR sprites_load_data\n");
				}
			}
		} else {
			// Disallow moving when exploding
			player_plane_info->vx = 0;
			player_plane_info->vy = 0;
			player_plane_info->ax = 0;
			player_plane_info->ay = 0;
		}

		handle_enemy_planes_spawn();
		handle_enemy_planes_firing();

		// Sprites manager job
		sprites_tick(VGA_SPRITE_PLANE);
		sprites_tick(VGA_SPRITE_BULLET);
		sprites_collision_detect();

		// Update player HP
		*io_led_red = 0xffffffff << (18 - player_plane_info->hp);
	}
	io_vga_sync_prev = *io_vga_sync;
}

void handle_player_plane_keyboard(int player_plane_id, volatile vga_sprite_info_t* player_plane_info) {
	uint8_t pressed_up = 0, pressed_left = 0, pressed_down = 0, pressed_right = 0;
	for(int i = 0; i < 2; i++) {
		int keycode = keycode_comm->keycode[i];
//		if(i == 0) *io_hex = keycode;
		switch(keycode) {
		case 0x1A:	// W
		case 0x52:	// Up
			pressed_up = 1;
			break;
		case 0x04:	// A
		case 0x50:	// Left
			pressed_left = 1;
			break;
		case 0x16:	// S
		case 0x51:	// Down
			pressed_down = 1;
			break;
		case 0x07:	// D
		case 0x4F:	// Right
			pressed_right = 1;
			break;
		}
	}

	// Y input & resistance
	if(pressed_up && pressed_down) {
		// Player went crazy, do nothing
	} else if(pressed_up) {
		player_plane_info->vy -= PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vy < -PLAYER_PLANE_SPEED_MAX) player_plane_info->vy = -PLAYER_PLANE_SPEED_MAX;
	} else if(pressed_down) {
		player_plane_info->vy += PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vy > PLAYER_PLANE_SPEED_MAX) player_plane_info->vy = PLAYER_PLANE_SPEED_MAX;
	} else if(player_plane_info->vy > 0) {
		player_plane_info->vy -= PLAYER_PLANE_DEACCELERATION;
	} else if(player_plane_info->vy < 0) {
		player_plane_info->vy += PLAYER_PLANE_DEACCELERATION;
	}

	// X input & resistance
	if(pressed_left && pressed_right) {
		// Player went crazy, do nothing
	} else if(pressed_left) {
		player_plane_info->vx -= PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vx < -PLAYER_PLANE_SPEED_MAX) player_plane_info->vx = -PLAYER_PLANE_SPEED_MAX;
	} else if(pressed_right) {
		player_plane_info->vx += PLAYER_PLANE_ACCELERATION;
		if(player_plane_info->vx > PLAYER_PLANE_SPEED_MAX) player_plane_info->vx = PLAYER_PLANE_SPEED_MAX;
	} else if(player_plane_info->vx > 0) {
		player_plane_info->vx -= PLAYER_PLANE_DEACCELERATION;
	} else if(player_plane_info->vx< 0) {
		player_plane_info->vx += PLAYER_PLANE_DEACCELERATION;
	}

	// Prevent plane from flying out of screen
	sprites_limit_speed(VGA_SPRITE_PLANE, player_plane_id);

	if(frame_count % PLAYER_BULLET_INTERVAL == 0) {
		for(int i = 0; i < 3; i++) {
			int id;
			if(255 == (id = sprites_allocate(VGA_SPRITE_BULLET))) {
//				printf("ERR sprites_allocate\n");
				break;
			}
			volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_BULLET, id);
			if(NULL == sprite_info) {
//				printf("ERR sprites_get\n");
				break;
			}
			sprite_info->physical->x = player_plane_info->physical->x
					+ (player_plane_info->physical->width << VGA_SPRITE_HW_SHIFT_BITS) / 2;
			sprite_info->physical->y = player_plane_info->physical->y;
			sprite_info->physical->bullet_radius = PLAYER_BULLET_RADIUS;
			sprite_info->physical->bullet_color = player_plane_info->bullet_color;
			sprite_info->type = 0;
			sprite_info->vx = PLAYER_BULLET_VX * (i - 1) + player_plane_info->vx;
			sprite_info->vx_max = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vx_min = -(VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->vy = -PLAYER_BULLET_VY + player_plane_info->vy;
			sprite_info->vy_max = VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->vy_min = -(VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->ax = PLAYER_BULLET_AX * (i - 1);
			sprite_info->ay = -PLAYER_BULLET_AY;
		};
	}
}

void handle_enemy_planes_spawn() {
	if(frame_count > next_frame_count) {
		int res_id = rng_generate() % ENEMY_RESOURCE_NUM;
		const uint16_t* resource = enemies[res_id].data;
		int width = enemies[res_id].width;
		int height = enemies[res_id].height;

		int id;
		if(255 == (id = sprites_allocate(VGA_SPRITE_PLANE))) {
//			printf("ERR sprites_allocate\n");
			return;
		}
		if(255 == sprites_load_data(VGA_SPRITE_PLANE, id, resource, width * height)) {
//			printf("ERR sprites_load_data\n");
			return;
		}
		volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_PLANE, id);
		if(NULL == sprite_info) {
//			printf("ERR sprites_get\n");
			return;
		}

		int generate_pos = rng_generate() % (VGA_WIDTH + VGA_HEIGHT);
		if(generate_pos < VGA_HEIGHT / 2) {
			// Left top side of screen
			sprite_info->physical->x = ((-width) << VGA_SPRITE_HW_SHIFT_BITS) + 1;
			sprite_info->physical->y = generate_pos << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;

			sprite_info->vx = rng_generate() % ENEMY_PLANE_VX;
			if(sprite_info->ax < 0) {
				sprite_info->vx_min = ENEMY_PLANE_VX / 2;
			} else {
				sprite_info->vx_min = 0;
			}
			sprite_info->vx_max = ENEMY_PLANE_VX * 2;
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			if(generate_pos < VGA_HEIGHT / 4) {
				sprite_info->vy_min = 0;
			} else {
				sprite_info->vy_min = -ENEMY_PLANE_VY / 4;
			}
			sprite_info->vy_max = ENEMY_PLANE_VY * 2;
		} else if(generate_pos < VGA_HEIGHT) {
			// Right top side of screen
			sprite_info->physical->x = VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->physical->y = (generate_pos - VGA_HEIGHT / 2) << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;

			sprite_info->vx = -(rng_generate() % ENEMY_PLANE_VX);
			sprite_info->vx_min = -ENEMY_PLANE_VX * 2;
			if(sprite_info->ax > 0) {
				sprite_info->vx_max = -ENEMY_PLANE_VX / 2;
			} else {
				sprite_info->vx_max = 0;
			}
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			if(generate_pos < VGA_HEIGHT * 3 / 4) {
				sprite_info->vy_min = 0;
			} else {
				sprite_info->vy_min = -ENEMY_PLANE_VY / 4;
			}
			sprite_info->vy_max = ENEMY_PLANE_VY * 2;
		} else {
			// Top side of screen
			sprite_info->physical->x = (generate_pos - VGA_HEIGHT) << VGA_SPRITE_HW_SHIFT_BITS;
			sprite_info->physical->y = 0;
			sprite_info->vx = rng_generate() % (2 * ENEMY_PLANE_VX) - ENEMY_PLANE_VX;
			if(generate_pos - VGA_HEIGHT < VGA_WIDTH / 4) {
				sprite_info->vx_min = 0;
			} else {
				sprite_info->vx_min = -ENEMY_PLANE_VX;
			}
			if(generate_pos - VGA_HEIGHT > VGA_WIDTH * 3 / 4) {
				sprite_info->vx_max = 0;
			} else {
				sprite_info->vx_max = ENEMY_PLANE_VX;
			}
			// BE CAREFUL WHEN USING GAME_DIFFICULTY!!! See definition
			sprite_info->vx_max = ENEMY_PLANE_VX * GAME_DIFFICULTY;
			sprite_info->vy = rng_generate() % ENEMY_PLANE_VY;
			sprite_info->vy_min = ENEMY_PLANE_VY * GAME_DIFFICULTY / 2;
			sprite_info->vy_max = ENEMY_PLANE_VY * GAME_DIFFICULTY * 4;
			sprite_info->ax = rng_generate() % (2 * ENEMY_PLANE_AX) - ENEMY_PLANE_AX;
			sprite_info->ay = rng_generate() % (2 * ENEMY_PLANE_AY) - ENEMY_PLANE_AY;
		}
		sprite_info->type = 1;
		sprite_info->hp = ENEMY_PLANE_HP * GAME_DIFFICULTY;
		sprite_info->bullet_color = enemies[res_id].bullet_color;

		sprite_info->physical->width = width;
		sprite_info->physical->height = height;

		// Add difficulty as game progress
		int interval_min = ENEMY_PLANE_SPAWN_INTERVAL_MIN - frame_count / 512;
		if(interval_min < ENEMY_PLANE_SPAWN_INTERVAL_MIN / 2) {
			interval_min = ENEMY_PLANE_SPAWN_INTERVAL_MIN;
		}
		next_frame_count = frame_count + interval_min
				+ rng_generate() % (ENEMY_PLANE_SPAWN_INTERVAL_MAX - ENEMY_PLANE_SPAWN_INTERVAL_MIN);
	}
}

void handle_enemy_planes_firing() {
	vga_entity_manage_t* planes = VGA_SPRITE_PLANE;
	for(int i = 0; i < planes->max_size; i++) {
		volatile vga_sprite_info_t* plane_info = planes->info_arr + i;
		if(!plane_info->used) continue;
		if(plane_info->type != 1) continue;

		int enemy_bullet_interval = ENEMY_BULLET_INTERVAL * GAME_DIFFICULTY_INV;
		if((frame_count - plane_info->frame_created) % enemy_bullet_interval == 0) {
			int id;
			if(255 == (id = sprites_allocate(VGA_SPRITE_BULLET))) {
//				printf("ERR sprites_allocate\n");
				break;
			}
			volatile vga_sprite_info_t* sprite_info = sprites_get(VGA_SPRITE_BULLET, id);
			if(NULL == sprite_info) {
//				printf("ERR sprites_get\n");
				break;
			}
			sprite_info->physical->x = plane_info->physical->x
					+ (plane_info->physical->width << VGA_SPRITE_HW_SHIFT_BITS) / 2;
			sprite_info->physical->y = plane_info->physical->y
					+ (plane_info->physical->height << VGA_SPRITE_HW_SHIFT_BITS);
			sprite_info->physical->bullet_radius = ENEMY_BULLET_RADIUS;
			sprite_info->physical->bullet_color = plane_info->bullet_color;
			sprite_info->type = 1;
			sprite_info->vx = plane_info->vx + ENEMY_BULLET_VX * GAME_DIFFICULTY;
			sprite_info->vy = plane_info->vy + ENEMY_BULLET_VY * GAME_DIFFICULTY;
			sprite_info->vx_max = ENEMY_BULLET_VMAX * GAME_DIFFICULTY;
			sprite_info->vx_min = -(ENEMY_BULLET_VMAX * GAME_DIFFICULTY);
			sprite_info->vy_max = ENEMY_BULLET_VMAX * GAME_DIFFICULTY;
			sprite_info->vy_min = -(ENEMY_BULLET_VMAX * GAME_DIFFICULTY);
			sprite_info->ax = ENEMY_BULLET_AX;
			sprite_info->ay = ENEMY_BULLET_AY;
		}
	}
}

void game_over() {
	*io_vga_background_offset = 0;
	vga_set(0, 0, VGA_WIDTH, VGA_HEIGHT, scoreboard_bg);
	vga_fill(0, VGA_HEIGHT, VGA_WIDTH, VGA_STATUSBAR_HEIGHT, 0x0000);

	sprites_init(VGA_SPRITE_PLANE);
	sprites_init(VGA_SPRITE_BULLET);

	char buf[256];
	snprintf(buf, 255, "游戏结束 积分 %d 正在上传积分榜", player_score);
	vga_statusbar_string(0, (uint8_t*) buf);
}
