//
// Created by os on 9/16/25.
//
#include "../h/Semaphore.h"
#include "../h/console.h"
#include "../h/tcb.h"


void ConsoleC:: putterT()
{
    //nit jezgra koja treba da kontrolise slanje do kontrolera console
    //prvo proveri da li je spreman kontroler tako sto proveri console status register (bit 5 ovde)
    //ako jeste, salji iz bafera sve dok bafer ima nesto i bit idalje postavljen tacno
    //blokira se ako je bafer prazan
    while(1)
    {
        while( ( *((char *)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT ) )
        {
            jezgroSem->wait();
            mutex->wait();
            char *recieve_reg = (char*)CONSOLE_TX_DATA;
            *recieve_reg = outputBuffer->withdraw();
            if(recieve_reg) {} //check this later---------------------------------------------------------------------------- !
            mutex->signal();
            putSem->signal();
        }
    }
}