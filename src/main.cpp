//
// Created by os on 7/31/25.
//
#include "printing.hpp"
#include "../lib/console.h"
#include "../h/MemoryAllocator.h"
#include "../h/riscv.h"
#include "../h/console.h"
#include "../h/syscall_c.h"
//things we need to make but can use beforehand are in console.h

extern void userMain();
extern void workerTest10();

void main() {
    //testing for memory functions "${DIR_LIBS}/mem.lib \"
	//testing for console functions "${DIR_LIBS}/console.lib"
	/*printInt(  *((char *)(CONSOLE_STATUS)), 16 );
	__putc('\n');*/

	MemoryAllocator::init_block();
    ConsoleC::init_console();

   	TCB* main = TCB::createThread(nullptr, nullptr); //main thread
    main->setSysThread(true);
    TCB::running = Scheduler::get();
    TCB* idle = TCB::createThread(reinterpret_cast<void (*)(void *)>(TCB::idle_thread), nullptr);//idle thread
	TCB* output = TCB::createThread(reinterpret_cast<void (*)(void *)>(ConsoleC::putterT), nullptr); // put thread
    idle->setSysThread(true);
    output->setSysThread(true);

	Riscv::w_stvec((uint64) &Riscv::supervisorTrap); //set our ecall to be of supervisor trap
	Riscv::ms_sstatus(Riscv::SSTATUS_SIE); //set so interrupts are enabled specifically timer prekids!

	//TCB* userMainThread = TCB::createThread(reinterpret_cast<void (*)(void *)>(userMain), nullptr);
	//while(!userMainThread->isFinished())
	//{
	//	thread_dispatch();
	//}
	//TCB* workerBodyThread = TCB::createThread(reinterpret_cast<void (*)(void *)>(workerTest10), nullptr);
	/*while(!workerBodyThread->isFinished())
	{
		//printString("Thread Dispatched MAIN\n");
		thread_dispatch();
	}*/

	//finishing the function----------------------------
	int* finish_address = (int*)0x100000;
	*finish_address = 0x5555;
	//-------------------------------------------------
    //zabrani prekid during printing or inputs - if enabled, can prekid in the middle of string which is bad

	return;
}

//periodic threads cpp api --------------------------------------!