#ifndef SPRITES_H_
#define SPRITES_H_

#include <stdint.h>
#include <unistd.h>

typedef struct {
	int32_t x;
	int32_t y;
	union {
		// For airplane
		struct {
			int32_t width;
			int32_t height;
		};
		// For bullet
		struct {
			int32_t bullet_radius;
			int32_t bullet_color;
		};
	};
} vga_entity_t;

// Data structure for software handling of sprite.
typedef struct {
	// Pointer to physical entity, exposed as vga_sprite_params in Platform Designer.
	// NULL means this sprite is not visible on the screen
	volatile vga_entity_t* physical;
	volatile uint16_t* sprite_data;
	int32_t used;
	int32_t vx;
	int32_t vx_max;
	int32_t vx_min;
	int32_t vy;
	int32_t vy_max;
	int32_t vy_min;
	int32_t ax;
	int32_t ay;
	int32_t type;
	// 0: entity of player
	// 1: entity of enemy
	// 2: explo~sion
	int32_t hp;
	// for planes of player & enemy, times of collisions until death
	// for explo~sion, frame ticks until death
	int32_t frame_created;	// frame at which sprite is created
	uint16_t bullet_color;
} vga_sprite_info_t;

// Data structure for operations against different types of sprites.
typedef struct {
	uint8_t max_size;
	uint16_t** mmap_sprite_data;
	volatile vga_entity_t* mmap_addr;
	volatile vga_sprite_info_t* info_arr;
} vga_entity_manage_t;

#define N_PLANES 8
#define N_BULLETS 56

extern vga_entity_manage_t vga_planes;
extern vga_entity_manage_t vga_bullets;

#define VGA_SPRITE_PLANE &vga_planes
#define VGA_SPRITE_BULLET &vga_bullets

#define VGA_SPRITE_HW_SHIFT_BITS 4
#define VGA_SPRITE_WIDTH (VGA_WIDTH << VGA_SPRITE_HW_SHIFT_BITS)
#define VGA_SPRITE_HEIGHT (VGA_HEIGHT << VGA_SPRITE_HW_SHIFT_BITS)

#define PLAYER_PLANE_EXPLOSION_SLOWDOWN_RATIO 8
#define ENEMY_PLANE_EXPLOSION_SLOWDOWN_RATIO 2

void sprites_init(vga_entity_manage_t* vga_entity_type);
uint8_t sprites_allocate(vga_entity_manage_t* vga_entity_type);
volatile vga_sprite_info_t* sprites_get(vga_entity_manage_t* vga_entity_type, uint8_t id);
uint8_t sprites_deallocate(vga_entity_manage_t* vga_entity_type, uint8_t id);
uint8_t sprites_visible(vga_entity_manage_t* vga_entity_type, uint8_t id);
uint8_t sprites_load_data(vga_entity_manage_t* vga_entity_type, uint8_t id, const uint16_t* src, int32_t pixel_count);
uint8_t sprites_limit_speed(vga_entity_manage_t* vga_entity_type, uint8_t id);
uint8_t sprites_tick(vga_entity_manage_t* vga_entity_type);
int32_t sprites_collision_detect();

#endif
