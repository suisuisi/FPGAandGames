/*
 * comm.h
 *
 *  Created on: May 20, 2019
 *      Author: xuyh0
 */

#ifndef COMM_H_
#define COMM_H_

#include "alt_types.h"

typedef struct {
	alt_u32 keyboard_present;
	alt_u8 keycode[6];
} keycode_comm_t;

extern volatile keycode_comm_t* keycode_comm;

#endif /* COMM_H_ */
