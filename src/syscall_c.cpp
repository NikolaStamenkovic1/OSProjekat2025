//
// Created by os on 9/16/25.
//

#include "../h/syscall_c.h"
#include "printing.hpp"
#include "../lib/console.h"

void* mem_alloc(size_t size)
{
    /*
    int64 rsize = size/MEM_BLOCK_SIZE;
    if(size % MEM_BLOCK_SIZE > 0)rsize++;
    abiCall(0x01, (uint64)rsize);
    */
    /*
    if(size < MEM_BLOCK_SIZE) { newSize = 1;} else {
        size /= MEM_BLOCK_SIZE;
        newSize = (size % MEM_BLOCK_SIZE != 0) ? size + 1 : size;
    }
    */
    size_t rsize = size * MEM_BLOCK_SIZE;
    __asm__ volatile("mv a1, %0" : : "r"(rsize));
    __asm__ volatile("li a0, 0x01");
    __asm__ volatile("ecall");

    void* retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
int mem_free(void* p)
{
    __asm__ volatile("mv a1, %0" : : "r"(p));
    __asm__ volatile("li a0, 0x02");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
size_t mem_get_free_space()
{
    __asm__ volatile("li a0, 0x03");
    __asm__ volatile("ecall");

    size_t retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
size_t mem_get_largest_free_block()
{
    __asm__ volatile("li a0, 0x04");
    __asm__ volatile("ecall");

    size_t retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg)
{
    /*
    void* volatile stack= nullptr;
    if(start_routine)stack = mem_alloc(DEFAULT_STACK_SIZE);
    */
    void* volatile stack = nullptr;
    if(start_routine) stack = MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE);
    __asm__ volatile ("mv a4, %0" :: "r" (stack));
    __asm__ volatile ("mv a3, %0" :: "r" (arg));
    __asm__ volatile ("mv a2, %0" :: "r" (start_routine));
    __asm__ volatile ("mv a1, %0" :: "r" (handle));

    //printString("Syscall correclty starting\n");
    __asm__ volatile("li a0, 0x11");
    __asm__ volatile("ecall");
    //printString("Syscall correclty finished\n");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
int thread_exit()
{
    __asm__ volatile("li a0, 0x12");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
void thread_dispatch()
{
    __asm__ volatile("li a0, 0x13");
    __asm__ volatile("ecall");
    return;
}

int sem_open(sem_t* handle, unsigned init)
{
    __asm__ volatile ("mv a2, %0" :: "r" (init));
    __asm__ volatile ("mv a1, %0":: "r" (handle));

    __asm__ volatile("li a0, 0x21");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
int sem_close(sem_t handle)
{
    __asm__ volatile ("mv a1, %0":: "r" (handle));

    __asm__ volatile("li a0, 0x22");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
int sem_wait(sem_t id)
{
    __asm__ volatile ("mv a1, %0":: "r" (id));

    __asm__ volatile("li a0, 0x23");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
int sem_signal(sem_t id)
{
    __asm__ volatile ("mv a1, %0":: "r" (id));

    __asm__ volatile("li a0, 0x24");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}

int time_sleep(time_t time)
{
    __asm__ volatile ("mv a1, %0":: "r" (time));

    __asm__ volatile("li a0, 0x31");
    __asm__ volatile("ecall");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}

char getc()
{
    __asm__ volatile("li a0, 0x41");
    __asm__ volatile("ecall");

    char retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    return retVal;
}
void putc(char c)
{
    __asm__ volatile ("mv a1, %0":: "r" (c));

    __asm__ volatile("li a0, 0x42");
    __asm__ volatile("ecall");

    return;
}