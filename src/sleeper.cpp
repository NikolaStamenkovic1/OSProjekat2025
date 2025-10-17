//
// Created by os on 9/15/25.
//

#include "../h/sleeper.h"
#include "../lib/console.h"

Sleep_list Sleeper::sleep;

int Sleeper::time_sleep(time_t time)
{
    if(time <= 0) return -1;
    TCB *tcb = TCB::running;
    if(tcb == nullptr) return -2;
    if(tcb->isBlocked() || tcb->isFinished()) return -3;
    tcb->t_blocked = true;
    sleep.add(tcb, time);
    //dispatch here
    TCB::timeSliceCounter=0;
    TCB::dispatch();
    return 0;
}

void Sleeper::awaken()
{
    if(sleep.peekFirst() != 0)
    {
        //__putc('-');
        sleep.head->time -= 1;
        while(sleep.head && sleep.head->time == 0)
        {

            TCB* tcb = sleep.removeFirst();
            tcb->t_blocked = false;
            //__putc('t');
            Scheduler::put(tcb);

        }
    }

    return;
}