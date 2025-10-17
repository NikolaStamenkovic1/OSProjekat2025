//
// Created by os on 8/16/25.
//

#include "../h/scheduler.h"
#include "printing.hpp"

List<TCB> Scheduler::readyThreadQueue;

TCB* Scheduler::get()
{
	//printString("READY THREAD QUEUE REMOVE----\n");
    return readyThreadQueue.removeFirst();
}

void Scheduler::put(TCB *tcb)
{
    //printString("READY THREAD QUEUE ADD---\n");
    readyThreadQueue.addLast(tcb);
}