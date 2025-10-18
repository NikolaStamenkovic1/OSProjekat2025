//
// Created by os on 8/16/25.
//

//remove first add last

#include "../h/Semaphore.h"

SemaphoreC* SemaphoreC::sem_open(int init)
{
    return new SemaphoreC(init);
}

int SemaphoreC::wait()
{
    if(this->isClosed()) return -1;

    if((int)(--this->val) < 0){ // if the value of sem ispod 0, zuastavi i blokiraj
        if(!TCB::running->isFinished() || !(TCB::running == nullptr)){
            TCB *tcb = TCB::running;
            tcb->t_blocked = true;
            this->blocked.addLast(tcb);
            TCB::timeSliceCounter=0;
            TCB::dispatch(); //dispatch
        }
        if(this->closed) return -1;
    }

    return 0;
}

int SemaphoreC::signal()
{
    if(this->isClosed()) return -1;

    if((int)(++this->val) <= 0){ //if there is any thread waiting, unblock it if val is below or equal to 0
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
        Scheduler::put(tcb);
    }
    return 0;
}

int SemaphoreC::close()
{
    if(this->isClosed()) return -1;
    while(this->blocked.peekLast()){ //while there is sometihng at the back of the list, keep removing any threads and unblocking them
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
        Scheduler::put(tcb);
    }
    closed = true; //then, call destructor and close sem
    return 0;

}