//
// Created by os on 7/31/25.
//
#include "printing.hpp"
#include "../h/MemoryAllocator.h"
#include "../h/riscv.h"
#include "../h/console.h"
#include "../h/syscall_c.h"

extern void userMain();
extern void workerTest10();

void main() {
	MemoryAllocator::init_block(); //initialize memory block tracking
    ConsoleC::init_console(); //initialize console by creating semaphores and buffers

   	TCB* main = TCB::createThread(nullptr, nullptr);//main thread
    main->setSysThread(true);//main thread is System Thread
    TCB::running = Scheduler::get();
    TCB* idle = TCB::createThread(reinterpret_cast<void (*)(void *)>(TCB::idle_thread), nullptr);//idle thread
	TCB* output = TCB::createThread(reinterpret_cast<void (*)(void *)>(ConsoleC::putterT), nullptr); //put thread
    idle->setSysThread(true);//Idle thread is System Thread
    output->setSysThread(true);//Output thread is System Thread

	Riscv::w_stvec((uint64) &Riscv::supervisorTrap); //set our ecall to be of supervisor trap
	Riscv::ms_sstatus(Riscv::SSTATUS_SIE); //set so interrupts are enabled specifically timer prekids!

	//TCB* userMainThread = TCB::createThread(reinterpret_cast<void (*)(void *)>(userMain), nullptr);
	//while(!userMainThread->isFinished())
	//{
	//	thread_dispatch();
	//}
	//TCB* workerBodyThread = TCB::createThread(reinterpret_cast<void (*)(void *)>(workerTest10), nullptr);
	//while(!workerBodyThread->isFinished())
	//{
	//	thread_dispatch();
	//}

	//finishing the function----------------------------
	int* finish_address = (int*)0x100000;
	*finish_address = 0x5555;
	//-------------------------------------------------
	return;
}

//periodic threads cpp api --------------------------------------!