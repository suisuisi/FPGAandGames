#ifndef GAMELOGIC_H_
#define GAMELOGIC_H_

#define PLAYER_SCORE_PER_KILL 10
#define PLAYER_SCORE_PER_HIT 1
#define PLAYER_SCORE_PER_CRASH 8

#define PLAYER_PLANE_HP 18
#define PLAYER_PLANE_ACCELERATION 12
#define PLAYER_PLANE_DEACCELERATION 12
#define PLAYER_PLANE_SPEED_MAX 80
#define PLAYER_PLANE_IMG_UPDATE_INTERVAL 6

#define PLAYER_BULLET_INTERVAL 12
#define PLAYER_BULLET_VX 4
#define PLAYER_BULLET_VY 10
#define PLAYER_BULLET_AX 1
#define PLAYER_BULLET_AY 5
#define PLAYER_BULLET_RADIUS 2
#define PLAYER_BULLET_COLOR 0xe738

#define ENEMY_PLANE_SPAWN_INTERVAL_MIN 20
#define ENEMY_PLANE_SPAWN_INTERVAL_MAX 60
#define ENEMY_PLANE_HP 2
#define ENEMY_PLANE_VX 64
#define ENEMY_PLANE_VY 64
#define ENEMY_PLANE_AX 1
#define ENEMY_PLANE_AY 1

#define ENEMY_BULLET_INTERVAL 50
#define ENEMY_BULLET_VX 0
#define ENEMY_BULLET_VY 16
#define ENEMY_BULLET_AX 0
#define ENEMY_BULLET_AY 1
#define ENEMY_BULLET_VMAX 64
#define ENEMY_BULLET_RADIUS 4

#define GAME_DIFFICULTY (8 + (frame_count > 4096 ? 4096 : frame_count) / 512) / 8
#define GAME_DIFFICULTY_INV 8 / (8 + (frame_count > 4096 ? 4096 : frame_count) / 512)

#include "sprites.h"
#include <stdint.h>

extern int player_plane_id;
extern volatile uint32_t frame_count;
extern volatile int player_score;

void game_init();
void game_loop();
void game_over();

void handle_player_plane_keyboard(int player_plane_id, volatile vga_sprite_info_t* player_plane_info);
void handle_enemy_planes_spawn();
void handle_enemy_planes_firing();

#endif /* GAMELOGIC_H_ */
