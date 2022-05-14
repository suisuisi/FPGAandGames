#include "compat.h"

#include <time.h>

uint32_t sys_now() {
	return clock();
}

int fflush(FILE* ignored) {
	return 0;
}
