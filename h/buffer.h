//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_BUFFER_H
#define PROJECT_BASE_BUFFER_H

#include "MemoryAllocator.h"

static const uint64 DEFAULT_BUFFER_SIZE = 16; //set default buffer size to this

class Buffer
{
private:
    uint64 counter; //counter keeps track of how much is in buffer, cant go over cap
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

    uchar withdraw() //lower counter and withdraw from the buffer, moving its tail
    {
        counter--;
        uchar c = c_buffer[tail];
        tail = (tail + 1) % cap;
        return c;
    }
    void deposit(uchar c) //if not equal to cap, put on head and move head
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