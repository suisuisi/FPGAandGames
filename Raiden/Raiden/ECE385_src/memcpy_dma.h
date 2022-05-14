#ifndef MEMCPY_DMA_H_
#define MEMCPY_DMA_H_

#include <stdint.h>

uint32_t memcpy_dma(volatile void* to, void* from, uint16_t size);
uint32_t memset_dma(volatile void* to, uint32_t val, uint16_t size);
uint32_t memset32_dma(volatile void* to, uint32_t val, uint16_t size);
uint32_t memset16_dma(volatile void* to, uint16_t val, uint16_t size);
uint32_t memset8_dma(volatile void* to, uint8_t val, uint16_t size);

#endif /* MEMCPY_DMA_H_ */
