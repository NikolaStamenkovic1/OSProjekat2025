//
// Created by os on 9/15/25.
//

#include "../h/sleeper.h"

Sleep_list Sleeper::sleep;

int Sleeper::time_sleep(time_t time)
{
    if(time <= 0) return -1;
    TCB *tcb = TCB::running;
    if(tcb == nullptr) return -2;
    if(tcb->isBlocked() || tcb->isFinished()) return -3; //cant take thread if time < 0, or its blocked or finished or null
    tcb->t_blocked = true; //block thread while sleeping and add to sleeping list
    sleep.add(tcb, time);
    //dispatch here
    TCB::timeSliceCounter=0;
    TCB::dispatch();
    return 0;
}

void Sleeper::awaken()
{
    if(sleep.peekFirst() != 0) //if there is even a sleep list, because if check otherwise baci ce gresku
    {
        sleep.head->time -= 1; //vreme -1
        while(sleep.head && sleep.head->time == 0) // keep removing everything what is 0
        {
            TCB* tcb = sleep.removeFirst();
            tcb->t_blocked = false; //unblock and put in scheduler
            Scheduler::put(tcb);
        }
    }
    return;
}