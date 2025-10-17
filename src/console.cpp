//
// Created by os on 9/15/25.
//

#include "../h/console.h"
#include "../h/Semaphore.h"

SemaphoreC* ConsoleC::getSem = nullptr;
SemaphoreC* ConsoleC::putSem = nullptr;
SemaphoreC* ConsoleC::jezgroSem = nullptr;
SemaphoreC* ConsoleC::mutex = nullptr;

Buffer* ConsoleC:: inputBuffer = nullptr;
Buffer* ConsoleC:: outputBuffer = nullptr;

uchar ConsoleC::getc()
{

    getSem->wait();
    return inputBuffer->withdraw();
}

void ConsoleC::putc(uchar c)
{
    //if(outputBuffer->isFull())
    putSem->wait();
    mutex->wait();
    outputBuffer->deposit(c);
    //if(jezgroSem->get_val() < 0)
    mutex->signal();
    jezgroSem->signal();
}

void ConsoleC::init_console()
{

    getSem = SemaphoreC::sem_open();
    putSem = SemaphoreC::sem_open(DEFAULT_BUFFER_SIZE);
    jezgroSem = SemaphoreC::sem_open();
    mutex = SemaphoreC::sem_open(1);

    inputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
    outputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
}