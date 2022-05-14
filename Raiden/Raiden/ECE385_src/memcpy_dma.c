#include "memcpy_dma.h"

#include "altera_avalon_sgdma.h"
#include "altera_avalon_sgdma_descriptor.h"
#include "altera_avalon_sgdma_regs.h"

// Allocate descriptors in the descriptor_memory (onchip memory)
alt_sgdma_descriptor dma_descriptor 	__attribute__((section(".onchip")));
alt_sgdma_descriptor dma_descriptor_end	__attribute__((section(".onchip")));
alt_sgdma_dev* dma_device = NULL;

uint32_t memcpy_dma(volatile void* to, void* from, uint16_t size) {
	if(!dma_device) {
		dma_device = alt_avalon_sgdma_open("/dev/nios2_dma");
	}

	alt_avalon_sgdma_construct_mem_to_mem_desc(
			&dma_descriptor,
			&dma_descriptor_end,
			from,
			(void*) to,
			size,
			0,
			0
	);
	alt_avalon_sgdma_do_sync_transfer(dma_device, &dma_descriptor);
	return dma_descriptor.actual_bytes_transferred;
}

uint32_t memset_dma(volatile void* to, uint32_t val, uint16_t size) {
	if(!dma_device) {
		dma_device = alt_avalon_sgdma_open("/dev/nios2_dma");
	}

	alt_avalon_sgdma_construct_mem_to_mem_desc(
			&dma_descriptor,
			&dma_descriptor_end,
			&val,
			(void*) to,
			size,
			1,
			0
	);
	alt_avalon_sgdma_do_sync_transfer(dma_device, &dma_descriptor);
	return dma_descriptor.actual_bytes_transferred;
}

uint32_t memset32_dma(volatile void* to, uint32_t val, uint16_t size) {
	return memset_dma(to, val, size);
}

uint32_t memset16_dma(volatile void* to, uint16_t val, uint16_t size) {
	uint32_t v32 = (((uint32_t) val) << 16) | val;
	return memset_dma(to, v32, size);
}
uint32_t memset8_dma(volatile void* to, uint8_t val, uint16_t size) {
	uint32_t v32 = (((uint32_t) val) << 24) | (((uint32_t) val) << 16) | (((uint32_t) val) << 8) | val;
	return memset_dma(to, v32, size);
}
