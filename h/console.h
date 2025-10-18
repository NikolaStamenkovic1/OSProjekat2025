//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_CONSOLE_H
#define PROJECT_BASE_CONSOLE_H

#include "Semaphore.h"
#include "buffer.h"
//singleton so want stuff to be static
class ConsoleC
{
private:
    static SemaphoreC *getSem;
    static SemaphoreC *putSem;
    static SemaphoreC *jezgroSem;
    static SemaphoreC *mutex;

    static Buffer *inputBuffer;
    static Buffer *outputBuffer;
public:
    static uchar getc();
    static void putc(uchar c);
    static void init_console();
    static void putterT();

    friend class Riscv;
};

#endif //PROJECT_BASE_CONSOLE_H