//
// Created by os on 8/16/25.
//

//remove first add last

#include "../h/Semaphore.h"
#include "printing.hpp"
#include "../lib/console.h"

SemaphoreC* SemaphoreC::sem_open(int init)
{
    //printString("NEW SEMAPHORE---\n");
    return new SemaphoreC(init);
}

int SemaphoreC::wait()
{
    if(this->isClosed()) return -1;

    if((int)(--this->val) < 0){
        if(!TCB::running->isFinished() || !(TCB::running == nullptr)){
            TCB *tcb = TCB::running;
            tcb->t_blocked = true;
            this->blocked.addLast(tcb);
            TCB::timeSliceCounter=0;
            TCB::dispatch();
        }
        if(this->closed) return -1;
    }

    return 0;
}

int SemaphoreC::signal()
{
    if(this->isClosed()) return -1;

    if((int)(++this->val) <= 0){
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
        Scheduler::put(tcb);
    }
    return 0;
}

int SemaphoreC::close()
{
    if(this->isClosed()) return -1;
    while(this->blocked.peekLast()){ //peek first?
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
        Scheduler::put(tcb);
    }
    closed = true;
    return 0;

}