/* SpriteParser.c - Parses the t files from matlab into an MIF file format
 */

#include <stdio.h>
#include <stdlib.h>

#define INPUT_FILE "sprite_bytes/FinalGameBackground.txt"			// Input filename
#define OUTPUT_FILE "backgroundSeperate.ram"		// Name of file to output to
#define NUM_COLORS 	4								// Total number of different colors
#define WIDTH		8								
#define DEPTH		3072

// Use this to define value of each color in the palette
const long Palette_Colors []= {426715, 0, 182960, 255255255};
int addr = 0;

int main()
{
	char line[21];
	FILE *in = fopen(INPUT_FILE, "r");
	FILE *out = fopen(OUTPUT_FILE, "w");
	size_t num_chars = 20;
	long value = 0;
	int i;
	int *p;

	if(!in)
	{
		printf("Unable to open input file!");
		return -1;
	}
                    
	// Get a line, convert it to an integer, and compare it to the palette values.
	while(fgets(line, num_chars, in) != NULL)
	{
		value = (char)strtol(line, NULL, 10);
		p = (int *)&value;
		fwrite(p, 2, 1, out);
	}

	fclose(out);
	fclose(in);
	return 0;
}
