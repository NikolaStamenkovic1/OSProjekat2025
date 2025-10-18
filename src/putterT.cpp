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
            jezgroSem->wait(); //wait's here until there is something sent from the putc function
            mutex->wait(); //mutex da nemoze put da salje stvari istovremeno
            char *recieve_reg = (char*)CONSOLE_TX_DATA;
            *recieve_reg = outputBuffer->withdraw();
            if(recieve_reg) {} //recieve reg baca error ako ne uradim ovo, jer nije koriscen (in an official capacity)
            mutex->signal();
            putSem->signal(); //salje putSemaforu da oznaci da bafer nije pun, u slucaju da je put blokiran zbog toga
        }
    }
}