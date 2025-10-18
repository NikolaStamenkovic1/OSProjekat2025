//
// Created by os on 8/16/25.
//

#include "../h/tcb.h"
#include "../h/riscv.h"

TCB *TCB::running = nullptr;
uint64 TCB::timeSliceCounter = 0;

TCB* TCB::createThread(Body body, void* args) //create thread default, with default stack size
{
    return new TCB(body, args, DEFAULT_TIME_SLICE);
}

TCB* TCB::createThread(Body body, void* args, uint64* stack)
{
    return new TCB(body, stack, args, DEFAULT_TIME_SLICE); //thread created by also giving stack
}

void TCB::yield()
{
    //yield so that it goes through ecall, i tako ima privelege
    __asm__ volatile("ecall");
}

void TCB::dispatch()
{
    TCB* old = running;
    if(!old->isFinished() && !old->isBlocked())
    {
        //scheduler put old routine, if its not done or blocked
        Scheduler::put(old);
    }
    running=Scheduler::get(); //get new thread to run
    Riscv::setPriviledge(); //give appropriate priveledge to thread
    TCB::contextSwitch(&old->context, &running->context); //Switch context with threads
}

void TCB::threadWrapper()
{
    Riscv::popSppSpie(); // when new thread created from dispatch, it is still in sup mode - need to pop it to return
                        // to previous mode when executing from here thereafter, since it doesn't do it itself
    running->body(running->args);
    running->setFinished(true); //finish nit implicitno, dont have to explicitly release
    yield(); // yield so it has privledge

}

int TCB::thread_exit()
{
    if(running->body == nullptr) return -1;
    running->setFinished(true);
    dispatch(); //set so that is finished and then dispatch, which then releases thread since it is finished
    return 0;
}

void TCB::idle_thread()
{
    while(true) {
        dispatch();
    }
}