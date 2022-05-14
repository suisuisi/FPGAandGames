#ifndef RESOURCE_H_
#define RESOURCE_H_

#include <stdint.h>

//#define NO_ACTUAL_DATA

typedef struct {
	const uint16_t width;
	const uint16_t height;
	const uint16_t* data;
	const uint16_t bullet_color;
} sprite_data_t;

#ifdef NO_ACTUAL_DATA

extern const uint16_t enemy0[1];
extern const uint16_t enemy1[1];
extern const uint16_t enemy2[1];
extern const uint16_t enemy3[1];
extern const uint16_t enemy4[1];
extern const uint16_t enemy5[1];
extern const uint16_t explosion0[1];
extern const uint16_t explosion1[1];
extern const uint16_t explosion2[1];
extern const uint16_t explosion3[1];
extern const uint16_t explosion4[1];
extern const uint16_t explosion5[1];
extern const uint16_t explosion6[1];
extern const uint16_t explosion7[1];
extern const uint16_t explosion8[1];
extern const uint16_t explosion9[1];
extern const uint16_t explosion10[1];
extern const uint16_t explosion11[1];
extern const uint16_t explosion12[1];
extern const uint16_t explosion13[1];
extern const uint16_t explosion14[1];
extern const uint16_t explosion15[1];
extern const uint16_t explosion16[1];
extern const uint16_t explosion17[1];
extern const uint16_t explosion18[1];
extern const uint16_t explosion19[1];
extern const uint16_t explosion20[1];
extern const uint16_t background[1];

#else

extern const uint16_t enemy0[48 * 32];
extern const uint16_t enemy1[48 * 32];
extern const uint16_t enemy2[48 * 32];
extern const uint16_t enemy3[48 * 32];
extern const uint16_t enemy4[48 * 32];
extern const uint16_t enemy5[48 * 32];
extern const uint16_t explosion0[32 * 32];
extern const uint16_t explosion1[32 * 32];
extern const uint16_t explosion2[32 * 32];
extern const uint16_t explosion3[32 * 32];
extern const uint16_t explosion4[32 * 32];
extern const uint16_t explosion5[32 * 32];
extern const uint16_t explosion6[32 * 32];
extern const uint16_t explosion7[32 * 32];
extern const uint16_t explosion8[32 * 32];
extern const uint16_t explosion9[32 * 32];
extern const uint16_t explosion10[32 * 32];
extern const uint16_t explosion11[32 * 32];
extern const uint16_t explosion12[32 * 32];
extern const uint16_t explosion13[32 * 32];
extern const uint16_t explosion14[32 * 32];
extern const uint16_t explosion15[32 * 32];
extern const uint16_t explosion16[32 * 32];
extern const uint16_t explosion17[32 * 32];
extern const uint16_t explosion18[32 * 32];
extern const uint16_t explosion19[32 * 32];
extern const uint16_t explosion20[32 * 32];
extern const uint16_t background[640 * 1125];

#endif

extern const sprite_data_t enemies[];
extern const uint16_t* explosion_sequence[];

#define ENEMY_RESOURCE_NUM 6

#endif
