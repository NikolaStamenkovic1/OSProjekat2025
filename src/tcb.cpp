//
// Created by os on 8/16/25.
//

#include "../h/tcb.h"
#include "../h/riscv.h"
#include "printing.hpp"

TCB *TCB::running = nullptr;
uint64 TCB::timeSliceCounter = 0;

TCB* TCB::createThread(Body body, void* args)
{
    return new TCB(body, args, DEFAULT_TIME_SLICE);
}

TCB* TCB::createThread(Body body, void* args, uint64* stack)
{
    return new TCB(body, stack, args, DEFAULT_TIME_SLICE);
}

void TCB::yield()
{
    //push registers on - all the ones that arent ra and sp
    //so we yield at the end of threat wrapper which needs to dispatch to the next nit - but ecall already used for
    //syscalls - so we make a new code of operation
    __asm__ volatile("ecall");
}

void TCB::dispatch()
{
    //timeSliceCounter=0;
    TCB* old = running;
    if(!old->isFinished() && !old->isBlocked())
    {
        //scheduler put old routine
        Scheduler::put(old);
    }
    running=Scheduler::get(); //ISSUE CAUSED HERE-----------------------------------------------------------------------!
    Riscv::setPriviledge();
    TCB::contextSwitch(&old->context, &running->context); //CONTEXT SWITCH IN
}

void TCB::threadWrapper()
{
    Riscv::popSppSpie(); // when new thread created from dispatch, it is still in sup mode - need to pop it to return
                        // to previous mode when executing from here thereafter, since it doesn't do it itself
    running->body(running->args);
    running->setFinished(true); //finish nit implicitno, dont have to explicitly release
    yield();

}

int TCB::thread_exit()
{
    if(running->body == nullptr) return -1;
    running->setFinished(true);
    dispatch();
    return 0;
}

void TCB::idle_thread()
{
    while(true) {
        dispatch();
    }
}