//
// Created by os on 9/17/25.
//

#include "../h/syscall_cpp.hpp"

void* operator new (size_t size)
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

Thread::Thread (void (*body)(void*), void* arg)
{
    this->body = body;
    this->arg = arg;
}
Thread::~Thread ()
{
    myHandle->setFinished(true);
}
int Thread::start ()
{
    //if(myHandle != nullptr && body != nullptr && arg != nullptr)
    thread_create(&myHandle, body, arg);
    if(body== nullptr)TCB::running=myHandle;
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
    this->body = runWrapper;
    this->arg = this;

}
void Thread:: runWrapper(void* thr) {
    Thread* thread=(Thread*)thr;
    if(thread) {
        thread->run();
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
    return ::getc();
}
void Console::putc (char c)
{
    ::putc(c);
}