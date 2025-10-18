//
// Created by os on 9/17/25.
//

#include "../h/syscall_cpp.hpp"

void* operator new (size_t size) //new and delete assossciated with c api mem alloc and mem free
{
    return mem_alloc(size);
}
void* operator new[] (size_t size)
{
    return mem_alloc(size);
}
void operator delete (void* p) noexcept
{
    mem_free(p);
}
void operator delete[] (void* p) noexcept
{
    mem_free(p);
}

Thread::Thread (void (*body)(void*), void* arg) // when thread called, set its body and args, but only create it when run
{ //this way can replace run and ignore it
    this->body = body;
    this->arg = arg;
}
Thread::~Thread ()
{
    myHandle->setFinished(true); //free thread by setting that its finished and then letting it dispatch
}
int Thread::start ()
{
    thread_create(&myHandle, body, arg); //create thread, and if its not handler empty it is created
    if(myHandle!= nullptr)return 0;
    return -1;
}
void Thread::dispatch ()
{
    thread_dispatch();
}
int Thread::sleep (time_t time)
{
    return time_sleep(time);
}
Thread::Thread ()
{
    if(body == nullptr){ //so that run is ignored if constructor already called, else set run as the correct body
        this->body = runWrapper;
        this->arg = this;
    }

}
void Thread:: runWrapper(void* thr) {
    Thread* thread=(Thread*)thr;
    if(thread) {
        thread->run(); //call redefined function
    }
}

Semaphore::Semaphore (unsigned init)
{
    sem_open(&myHandle, init);
}
Semaphore::~Semaphore ()
{
    sem_close(myHandle);
}
int Semaphore::wait ()
{
    return sem_wait(myHandle);
}
int Semaphore::signal ()
{
    return sem_signal(myHandle);
}

PeriodicThread::PeriodicThread (time_t period) : Thread(), period(period) {}

void PeriodicThread::terminate ()
{
    period = 0;
}

void PeriodicThread:: runWrapper(void* thr) {
    PeriodicThread *perThr = (PeriodicThread *) thr;
    while (perThr->period>0) {
        perThr->periodicActivation();
        time_sleep(perThr->period);
    }
}

char Console::getc ()
{
    return ::getc(); //for some reason, ako ne stavim ::, funkcija nece biti pozvana tacno
}
void Console::putc (char c)
{
    ::putc(c);
}