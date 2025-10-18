//
// Created by os on 8/10/25.
//
#ifndef MEMORYALLOCATOR_H
#define MEMORYALLOCATOR_H

#include "../lib/hw.h"

struct mem_header{
    mem_header *next;
	mem_header *prev;
    size_t size;
};
//static since singleton
class MemoryAllocator {
public:
    static void* mem_alloc(size_t size);
    static int mem_free(void* ptr);
	static void init_block(){
        free_mem_head = (mem_header*)((uint64)HEAP_START_ADDR);
        free_mem_head->next = free_mem_head->prev = nullptr;
        free_mem_head->size = ((uint64)HEAP_END_ADDR) - ((uint64)HEAP_START_ADDR) - sizeof(mem_header); //also sizeof header since starting before it
		used_mem_head = nullptr;
    }
    static size_t mem_get_free_space();
    static size_t mem_get_largest_free_block();
private:
    static mem_header* free_mem_head;
    static mem_header* used_mem_head;
    friend class Riscv;
};

#endif //MEMORYALLOCATOR_H
