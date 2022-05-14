#include "vga.h"
#include "main.h"
#include "memcpy_dma.h"
#include "resources/vga_fonts.h"
#include "resources/chinese.h"

void vga_erase(int x, int y, int width, int height) {
	vga_fill(x, y, width, height, 0x0);
}

void vga_fill(int x, int y, int width, int height, uint16_t color) {
	int y_max = y + height;
//	int x_max = x + width;
	for(int dy = y; dy < y_max; dy++) {
		uint16_t* vga_ptr = ((uint16_t*) VGA_FRAMEBUFFER) + dy * VGA_WIDTH;
//		for(int dx = x; dx < x_max; dx++) {
//			vga_ptr[dx] = color;
//		}
		memset16_dma(vga_ptr + x, color, width * sizeof(uint16_t));
	}
}

void vga_set(int x, int y, int width, int height, const uint16_t* src) {
	int y_max = y + height;
//	int x_max = x + width;
	for(int dy = y; dy < y_max; dy++) {
		uint16_t* vga_ptr = ((uint16_t*) VGA_FRAMEBUFFER) + dy * VGA_WIDTH;
//		const uint16_t* src_ptr = src + (dy-y) * width;
//		for(int dx = x; dx < x_max; dx++) {
//			vga_ptr[dx] = src[(dy-y) * width + dx-x];
//		}
		memcpy_dma(vga_ptr + x, src + (dy-y) * width, width * sizeof(uint16_t));
	}
}

////////////////////////////////////////
// Background scrolling
////////////////////////////////////////

volatile int bg_offset = 0;
volatile int bg_scanline = 0;

void vga_scroll_init() {
	bg_offset = 0;
	bg_scanline = 0;
}

void vga_scroll(int height, const uint16_t* src) {
	static int io_vga_sync_prev = 0;
	if((!io_vga_sync_prev) && (*io_vga_sync)) {
		// Move image upwards by 1
		bg_offset--;
		if(bg_offset < 0) bg_offset += VGA_HEIGHT;
		*io_vga_background_offset = bg_offset;

		// Replace the line
//		uint16_t* fb_end = VGA_FRAMEBUFFER + (bg_offset+1) * VGA_WIDTH;
//		const uint16_t* bg_pos = src + bg_scanline * VGA_WIDTH;
//		for(uint16_t* fb = VGA_FRAMEBUFFER + bg_offset * VGA_WIDTH; fb < fb_end; fb++) {
//			*fb = *(bg_pos++);
//		}

		memcpy_dma(((uint16_t*) VGA_FRAMEBUFFER) + bg_offset * VGA_WIDTH, src + bg_scanline * VGA_WIDTH, VGA_WIDTH * sizeof(uint16_t));

		// Move scanline by 1
		bg_scanline--;
		if(bg_scanline < 0) bg_scanline += height;

	}
	io_vga_sync_prev = *io_vga_sync;
}

////////////////////////////////////////
// Statusbar text
////////////////////////////////////////

uint16_t utf8_to_code(const uint8_t* c) {
	if(!((*c) & UTF8_MASK)) return *c;

    if(UTF8_3BYTE_MASK == ((*c) & UTF8_3BYTE_MASK)) {
        // Detected the beginning of a 3 byte UTF-8 code
    	return (((*c) & UTF8_DATA_4BITS) << 12)
    			| (((*(c+1)) & UTF8_DATA_6BITS) << 6)
				| ((*(c+2)) & UTF8_DATA_6BITS);
    } else if(UTF8_2BYTE_MASK == ((*(c+1)) & UTF8_2BYTE_MASK)) {
        // Detected the beginning of a 2 byte UTF-8 code
    	return (((*c) & UTF8_DATA_5BITS) << 6)
    			| ((*(c+1)) & UTF8_DATA_6BITS);
    } else {
    	return *c;
    }
}

uint16_t utf8_len(const uint8_t* c) {
	if(!((*c) & UTF8_MASK)) return 1;

    if(UTF8_3BYTE_MASK == ((*c) & UTF8_3BYTE_MASK)) {
        // Detected the beginning of a 3 byte UTF-8 code
    	return 3;
    } else if(UTF8_2BYTE_MASK == ((*(c+1)) & UTF8_2BYTE_MASK)) {
        // Detected the beginning of a 2 byte UTF-8 code
    	return 2;
    } else {
    	return 1;
    }
}

void vga_english(int x, int y, uint8_t c) {
	for(int dy = 0; dy < 16; dy++) {
		uint8_t d = font_data[(uint8_t) c][dy];
		for(int dx = 0; dx < 8; dx++) {
			uint16_t* target = ((uint16_t*) VGA_FRAMEBUFFER) + (y + dy) * VGA_WIDTH + x + dx;
			if(d & (1 << (7 - dx))) {
				*target = 0xffff;
			} else {
				*target = 0x0000;
			}
		}
	}
}

void vga_english_transparent(int x, int y, uint8_t c) {
	for(int dy = 0; dy < 16; dy++) {
		uint8_t d = font_data[(uint8_t) c][dy];
		for(int dx = 0; dx < 8; dx++) {
			uint16_t* target = ((uint16_t*) VGA_FRAMEBUFFER) + (y + dy) * VGA_WIDTH + x + dx;
			if(d & (1 << (7 - dx))) {
				*target = 0xffff;
			}
		}
	}
}

void vga_chinese(int x, int y, const uint8_t* c) {
	uint16_t code = utf8_to_code(c);
	if(code >= CHINESE_ENCODE_START && code <= CHINESE_ENCODE_END) {
		for(int dy = 0; dy < 16; dy++) {
			int chinese_pos = ((code - CHINESE_ENCODE_START) * 16 + dy) * 2;
			uint16_t d = (((uint16_t) chinese_font[chinese_pos]) << 8) | chinese_font[chinese_pos+1];
			for(int dx = 0; dx < 16; dx++) {
				uint16_t* target = ((uint16_t*) VGA_FRAMEBUFFER) + (y + dy) * VGA_WIDTH + x + dx;
				if(d & (1 << (15 - dx))) {
					*target = 0xffff;
				} else {
					*target = 0x0000;
				}
			}
		}
	}
}

void vga_chinese_transparent(int x, int y, const uint8_t* c) {
	uint16_t code = utf8_to_code(c);
	if(code >= CHINESE_ENCODE_START && code <= CHINESE_ENCODE_END) {
		for(int dy = 0; dy < 16; dy++) {
			int chinese_pos = ((code - CHINESE_ENCODE_START) * 16 + dy) * 2;
			uint16_t d = (((uint16_t) chinese_font[chinese_pos]) << 8) | chinese_font[chinese_pos+1];
			for(int dx = 0; dx < 16; dx++) {
				uint16_t* target = ((uint16_t*) VGA_FRAMEBUFFER) + (y + dy) * VGA_WIDTH + x + dx;
				if(d & (1 << (15 - dx))) {
					*target = 0xffff;
				}
			}
		}
	}
}

void vga_string(int x, int y, const uint8_t* c) {
	const uint8_t* ptr = c;
	int pos_x = 0, pos_y = 0;
	while(*ptr) {
		if(*ptr == '\n') {
			pos_y++;
			pos_x = 0;
			ptr += 1;
			continue;
		} else if(*ptr == '\r') {
			ptr += 1;
			continue;
		}
		uint16_t len = utf8_len(ptr);
		if(len > 1) {
			if(x + pos_x * 8 + 16 >= VGA_WIDTH) {
				pos_y++;
				pos_x = 0;
			}
			vga_chinese(x + pos_x * 8, y + pos_y * 16, ptr);
			pos_x += 2;
		} else {
			if(x + pos_x * 8 + 8 >= VGA_WIDTH) {
				pos_y++;
				pos_x = 0;
			}
			vga_english(x + pos_x * 8, y + pos_y * 16, *ptr);
			pos_x += 1;
		}
		ptr += len;
	}
}

void vga_string_transparent(int x, int y, const uint8_t* c) {
	const uint8_t* ptr = c;
	int pos_x = 0, pos_y = 0;
	while(*ptr) {
		if(*ptr == '\n') {
			pos_y++;
			pos_x = 0;
			ptr += 1;
			continue;
		} else if(*ptr == '\r') {
			ptr += 1;
			continue;
		}
		uint16_t len = utf8_len(ptr);
		if(len > 1) {
			if(x + pos_x * 8 + 16 >= VGA_WIDTH) {
				pos_y++;
				pos_x = 0;
			}
			vga_chinese_transparent(x + pos_x * 8, y + pos_y * 16, ptr);
			pos_x += 2;
		} else {
			if(x + pos_x * 8 + 8 >= VGA_WIDTH) {
				pos_y++;
				pos_x = 0;
			}
			vga_english_transparent(x + pos_x * 8, y + pos_y * 16, *ptr);
			pos_x += 1;
		}
		ptr += len;
	}
}

void vga_statusbar_english(int pos, uint8_t c) {
	vga_english(pos * 8, VGA_HEIGHT, c);
}

void vga_statusbar_chinese(int pos, const uint8_t* c) {
	vga_chinese(pos * 8, VGA_HEIGHT, c);
}

void vga_statusbar_string(int pos, const uint8_t* c) {
	const uint8_t* ptr = c;
	while(*ptr) {
		uint16_t len = utf8_len(ptr);
		if(len > 1) {
			vga_chinese(pos * 8, VGA_HEIGHT, ptr);
			pos += 2;
		} else {
			vga_english(pos * 8, VGA_HEIGHT, *ptr);
			pos += 1;
		}
		ptr += len;
	}
}
