//
// Created by os on 9/16/25.
//

#ifndef PROJECT_BASE_SYSCALL_C_H
#define PROJECT_BASE_SYSCALL_C_H

#include "../lib/hw.h"
#include "tcb.h"
#include "Semaphore.h"

void* mem_alloc(size_t size);
int mem_free(void* p);
size_t mem_get_free_space();
size_t mem_get_largest_free_block();

typedef TCB* thread_t;
int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);
int thread_exit();
void thread_dispatch();

typedef SemaphoreC* sem_t;
int sem_open(sem_t* handle, unsigned init);
int sem_close(sem_t handle);
int sem_wait(sem_t id);
int sem_signal(sem_t id);

int time_sleep(time_t time);

const int EOF = -1;
char getc();
void putc(char c);

#endif //PROJECT_BASE_SYSCALL_C_H