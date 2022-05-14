// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	volatile unsigned int *LED_PIO = (unsigned int*)0x70; //make a pointer to access the PIO block
	volatile unsigned int *SWITCH = (unsigned int*)0x60;
	volatile unsigned int *RUN = (unsigned int*)0x50;

	*LED_PIO = 0; //clear all LEDs
//	while ( (1+1) != 3) //infinite loop
//	{
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO &= ~0x1; //clear LSB
//	}
//	return 1; //never gets here

	volatile unsigned int value = 0;
	volatile unsigned int halt = 0;

	while ((1+1) != 3){
		if (*RUN == 1 && halt == 0){
			value += *SWITCH;
			*LED_PIO = value;
			halt = 1;
		}
		if (*RUN == 0 && halt == 1){
			halt = 0;
		}

	}

	return 1;
}

