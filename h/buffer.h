//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_BUFFER_H
#define PROJECT_BASE_BUFFER_H


#include "../lib/console.h"
#include "../src/printing.hpp"
#include "MemoryAllocator.h"

static const uint64 DEFAULT_BUFFER_SIZE = 16;

class Buffer
{
private:
    uint64 counter;
    uint64 cap;

    uint64 head;
    uint64 tail;
    char* c_buffer;


public:

    Buffer(uint64 cap) : counter(0), cap(cap), head(0), tail(0),
        c_buffer( (char*) MemoryAllocator::mem_alloc(cap * sizeof(char)))
    {

    }
    ~Buffer() { mem_free(c_buffer); }

    uchar withdraw()
    {
        counter--;
        uchar c = c_buffer[tail];
        tail = (tail + 1) % cap;
        return c;
    }
    void deposit(uchar c)
    {

        if (counter < cap) {
            c_buffer[head] = c;
            head = (head + 1) % cap;
            counter++;
        }
    }

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

    bool isFull() const { return counter == cap; }
    bool isEmpty() const { return counter == 0; }
};
#endif //PROJECT_BASE_BUFFER_H