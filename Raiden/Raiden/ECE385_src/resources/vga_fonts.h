#ifndef _VGA_FONTS_H_
#define _VGA_FONTS_H_

#include <stdint.h>

#define FONT_DATA_WIDTH 8
#define FONT_DATA_HEIGHT 16

extern uint8_t font_data[256][FONT_DATA_HEIGHT];

#endif
