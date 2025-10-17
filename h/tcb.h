//
// Created by os on 8/16/25.
//

#ifndef PROJECT_BASE_TCB_H
#define PROJECT_BASE_TCB_H

#include "MemoryAllocator.h"
#include "scheduler.h"
#include "../lib/hw.h"
#include "../lib/console.h"
//#include "../src/printing.hpp"

class TCB
{
public:

    ~TCB() { delete[] stack; } //delete the whole stack??? might have issue here with mem leaks-----------------------------------------

    bool isFinished() const { return finished; }

    void setFinished(bool value) { finished = value; }

    uint64 getTimeSlice() const { return timeSlice; }

    bool isBlocked() const { return t_blocked; }

    bool isSysThread() const { return sysThread; }

    void setSysThread(bool value) { sysThread = value; } // PRIVATE THIS LATER-------------------------------------------!

    using Body = void(*)(void*);

    static void yield();

    static TCB* running;

    static TCB* createThread(Body body, void* args);
    static TCB* createThread(Body body, void* args, uint64* stack);
	static int thread_exit();

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

    static void idle_thread();


private: //time slice can nullpoint
    explicit TCB(Body body, void* args, uint64 timeSlice): body(body),
        stack( body != nullptr ? ( (uint64*) MemoryAllocator::mem_alloc( DEFAULT_STACK_SIZE * sizeof(uint64) ) ) : 0), args(args),
        context(
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0 }
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    {
        //if(body != nullptr) Scheduler::put(this);
        Scheduler::put(this);
    }
    explicit TCB(Body body, uint64* stack, void* args, uint64 timeSlice): body(body),
        stack( stack != nullptr ? stack : 0), args(args),
        context(
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE/sizeof(uint64)] : 0 }
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    {
        //if(body != nullptr) Scheduler::put(this);
        Scheduler::put(this);
    }

    struct Context {
        uint64 ra;
        uint64 sp;
    };

    Body body;
    uint64 *stack;
	void* args;
    Context context;
    bool finished;
    bool t_blocked;

    uint64 timeSlice;
    bool sysThread;

    static uint64 timeSliceCounter;

    static void dispatch();

    static void contextSwitch(Context *oldContext, Context *newContext);

    friend class Riscv;

    friend class SemaphoreC;

    friend class Sleeper;

    static void threadWrapper();

};

#endif //PROJECT_BASE_TCB_H