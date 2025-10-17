//
// Created by os on 9/17/25.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_H
#define PROJECT_BASE_SYSCALL_CPP_H

#include "syscall_c.h"
#include "../lib/console.h"

void* operator new (size_t);
void operator delete (void*) noexcept;

class Thread {
public:
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}

private:
    thread_t myHandle;
    void (*body)(void*); void* arg;
    static void runWrapper(void* thr);
};

class Semaphore {
public:
    Semaphore (unsigned init = 1); //explicit?
    virtual ~Semaphore ();
    int wait ();
    int signal ();
private:
    sem_t myHandle;
};

class PeriodicThread : public Thread {
public:
    void terminate ();
    static void runWrapper(void* thr);
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
private:
    time_t period;
};

class Console {
public:
    static char getc ();
    static void putc (char);
};

#endif //PROJECT_BASE_SYSCALL_CPP_H