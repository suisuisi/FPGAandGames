#ifndef MAIN_MENU_H_
#define MAIN_MENU_H_

typedef enum {
	MENU_PLAY = 0,
	MENU_SCOREBOARD = 1
} main_menu_options;

void main_menu_init();
void main_menu_loop();
void main_menu_select_option(main_menu_options option);

#endif /* MAIN_MENU_H_ */
