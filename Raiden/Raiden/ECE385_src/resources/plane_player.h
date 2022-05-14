#ifndef RESOURCES_PLANE_PLAYER_H_
#define RESOURCES_PLANE_PLAYER_H_

#include <stdint.h>
#include "resource.h"

extern const uint16_t plane_player0[48 * 32];
extern const uint16_t plane_player1[48 * 32];
extern const uint16_t plane_player2[48 * 32];

#define PLANE_PLAYER_SEQ_LEN 4
extern const sprite_data_t plane_player_seq[];

#endif /* RESOURCES_PLANE_PLAYER_H_ */
