#ifndef _VGA_H_
#define _VGA_H_

#include "system.h"
#include <stdint.h>

#define VGA_WIDTH 640
#define VGA_HEIGHT 464
#define VGA_STATUSBAR_HEIGHT 16
#define VGA_FRAMEBUFFER ((int*) SRAM_MULTIPLEXER_BASE)

void vga_erase(int x, int y, int width, int height);
void vga_fill(int x, int y, int width, int height, uint16_t color);
void vga_set(int x, int y, int width, int height, const uint16_t* src);
void vga_scroll_init();
void vga_scroll(int height, const uint16_t* src);

#define UTF8_3BYTE_MASK 0xe0
#define UTF8_2BYTE_MASK 0xc0
#define UTF8_MASK 0x80

#define UTF8_DATA_4BITS 0x0f
#define UTF8_DATA_5BITS 0x1f
#define UTF8_DATA_6BITS 0x3f

uint16_t utf8_to_code(const uint8_t* c);
uint16_t utf8_len(const uint8_t* c);

void vga_english(int x, int y, uint8_t c);
void vga_english_transparent(int x, int y, uint8_t c);
void vga_chinese(int x, int y, const uint8_t* c);
void vga_chinese_transparent(int x, int y, const uint8_t* c);
void vga_string(int x, int y, const uint8_t* c);
void vga_string_transparent(int x, int y, const uint8_t* c);
void vga_statusbar_english(int pos, uint8_t c);
void vga_statusbar_chinese(int pos, const uint8_t* c);
void vga_statusbar_string(int pos, const uint8_t* c);
#endif
