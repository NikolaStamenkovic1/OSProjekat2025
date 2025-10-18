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
    getSem->wait(); //get sem ceka u slucaju da input bufer je prazan
    return inputBuffer->withdraw();
}

void ConsoleC::putc(uchar c)
{
    putSem->wait(); //put sem ceka u slucaju da je bafer pun
    mutex->wait(); //mutex da odrzava atomicnost
    outputBuffer->deposit(c);
    mutex->signal();
    jezgroSem->signal();
}

void ConsoleC::init_console()
{

    getSem = SemaphoreC::sem_open(); //get sem at 0, semaphore that checks if there is any input from the user in the input buffer
    putSem = SemaphoreC::sem_open(DEFAULT_BUFFER_SIZE);//put Sem at Buffer's size, proverava da bafer nije pun i time ne moze vise da salje
    jezgroSem = SemaphoreC::sem_open(); //jezgro sem at 0, proverava da li bafer prazan u suprotnosti od put sem
    mutex = SemaphoreC::sem_open(1); //mutex da odrzimo atomicnost operacija console

    inputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
    outputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
}