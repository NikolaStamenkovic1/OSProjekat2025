//
// Created by os on 8/16/25.
//

#ifndef PROJECT_BASE_SCHEDULER_H
#define PROJECT_BASE_SCHEDULER_H

#include "list.h"
class TCB;

class Scheduler{
private:
    static List<TCB> readyThreadQueue;
public:
    static TCB *get();

    static void put(TCB *tcb);
};

#endif //PROJECT_BASE_SCHEDULER_H