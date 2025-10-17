//
// Created by os on 8/16/25.
//

#ifndef PROJECT_BASE_SEMAPHORE_H
#define PROJECT_BASE_SEMAPHORE_H

#include "list.h"
#include "tcb.h"

class SemaphoreC
{
public:

    static SemaphoreC* sem_open(int init = 0);
    ~SemaphoreC() { close(); }
    int wait();
    int signal();

    int get_val() const { return val; }
    bool isClosed() const { return closed; }

    int close();

    void* operator new(size_t size)
     {
         return MemoryAllocator::mem_alloc(size);
     }
    void* operator new[](size_t size)
    {
        return MemoryAllocator::mem_alloc(size);
    }
    void operator delete(void* ptr)
    {
        MemoryAllocator::mem_free(ptr);
        return;
    }
    void operator delete[] (void* ptr)
    {
        MemoryAllocator::mem_free(ptr);
        return;
    }
private:
    SemaphoreC(int init = 0) : val(init), closed(false)  {}
    int val;
    bool closed;
    List<TCB> blocked;
};

#endif //PROJECT_BASE_SEMAPHORE_H