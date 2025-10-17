//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_SLEEPER_H
#define PROJECT_BASE_SLEEPER_H

#include "sleep_list.h"
#include "tcb.h"

class Sleeper
{
private:
    static Sleep_list sleep;
public:
    static int time_sleep(time_t time);
    static void awaken();
};
#endif //PROJECT_BASE_SLEEPER_H