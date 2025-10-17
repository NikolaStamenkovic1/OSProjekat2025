//
// Created by os on 8/15/25.
//

#include "../h/riscv.h"
#include "../h/MemoryAllocator.h"
#include "../h/tcb.h"
#include "../h/Semaphore.h"
#include "../h/buffer.h"
#include "../h/console.h"
#include "../h/sleeper.h"
#include "../lib/console.h"
#include "printing.hpp"


void Riscv::popSppSpie(){
	setPriviledge();
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret"); //pops spp and places it in the correct place it needs to be
                             // because we jumped to whole different location with dispatch and new nit, so in the
                            // wrapper we make sure it can get out of the supervisor trap with sret
    //sret would return to where sepc says, but we dont want that sicne it would return it to the nit that just lost
    //processor - we dont want that! want to return to the threadWrapper, so we change sepc
    //therefore very important to not be inline - since inline would then jump to where it was inlined!
}

void Riscv::handleSupervisorTrap(){
	uint64 volatile arg4;
	__asm__ volatile ("mv %0, a4" : "=r"(arg4));
    uint64 scause = r_scause();
    uint64 volatile arg1, arg2, arg3;
    __asm__ volatile("mv %0, a1" : "=r"(arg1));
    __asm__ volatile("mv %0, a2" : "=r"(arg2));
    __asm__ volatile("mv %0, a3" : "=r"(arg3));
    //razgranit skok
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){ //if from ecall or exception
        uint64 volatile sepc = r_sepc() + 4;
        uint64 volatile sstatus = r_sstatus();
        //interrupt: no; cause code: environment call from U-mode(8) or S-mode(9)
        //sepc += 4; //even if have ra for thread, need sepc because we entered through the supervisor trap - sync or async
                //and since sepc is the one that saves the actual pc when we enter sup mode, we need to track it AND pc
                // of the supervisor trap instructions
                //this is actually only true for ecalls! so dont need to do this for the other ones
				//no dumbass - need to move this one from ecall instruction. Others are interrupts so return to instruction
        //get interrupt code and work with it razgrani na svaku syscall that you need
        uint64 volatile opcode = 0;
        //if no opcode, cause context change from yield?
        __asm__ volatile("mv %0, a0" : "=r"(opcode));
		switch(opcode) {
			case 0x01:
				{//mem alloc, zadatu vrednost u bajtovima zaokruzi na cele blokove
				//(tako da zahtevani prostor stane u te blokove) i izrazi u blokovima pre nego sto izvrsi ovaj sistemski poziv abi-a
				/*size_t size;
				__asm__ volatile("mv %0, a1" : "=r"(size));*/
				void* ptr = MemoryAllocator::mem_alloc((size_t) arg1 );
				//__asm__ volatile("mv a0, %0" : : "r"(ptr));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (ptr));
				break;
                }
			case 0x02:
                {
				//mem free
				/*void* ptr;
				__asm__ volatile("mv %0, a1" : "=r"(ptr));*/
				int finish_code = MemoryAllocator::mem_free((void*)arg1);
				//__asm__ volatile("mv a0, %0" : : "r"(finish_code));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (finish_code));
				break;
                }
			case 0x03:
				{
				// size_t mem_get_free_space()
				size_t free_space = MemoryAllocator::mem_get_free_space();
				//__asm__ volatile("mv a0, %0" : : "r"(free_space));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (free_space));
				break;
				}
			case 0x04:
				{
				// size_t mem_get_largest_free_block()
				size_t largest_free_block = MemoryAllocator::mem_get_largest_free_block();
				//__asm__ volatile("mv a0, %0" : : "r"(largest_free_block));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (largest_free_block));
				break;
				}
			case 0x11:
                {
				//thread create, poslednja lokacija ukzuje stack_space,
				//thread create u c-api treba da alocira stek pre nego sto izvrsi ovaj sistemski poziv
                TCB** tcb = (TCB**)arg1;
                /*TCB::Body body;
                void* arg;
                __asm__ volatile ("mv %0, a1" : "=r" (tcb));
                __asm__ volatile ("mv %0, a2" : "=r" (body));
                __asm__ volatile ("mv %0, a7" : "=r" (arg));*/

				//add with stack
                if(arg4) {
                    *tcb = TCB::createThread((TCB::Body)arg2, (void*)arg3, (uint64*)arg4);
                }
                else {
                    *tcb = TCB::createThread((TCB::Body)arg2, (void*)arg3);
                }
                int retVal;
				if(*tcb == nullptr)
				{
					//__asm__ volatile("li a0, -1");
                    retVal = -1;
				}else{
					//__asm__ volatile("li a0, 0");
                    retVal = 0;
				}
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
				break;
                }
			case 0x12:
                {
				//thread exit
                int retVal = TCB::thread_exit();
                //__asm__ volatile("mv a0, %0" : : "r"(retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x13:
                {
				//thread dispatch
				TCB::timeSliceCounter = 0;
                TCB::dispatch();
                break;
                }
			case 0x21:
                {
				//sem open
                SemaphoreC** sem = (SemaphoreC**)arg1;
                /*unsigned volatile init;
                __asm__ volatile ("mv %0, a1" : "=r" (sem));
                __asm__ volatile ("mv %0, a2" : "=r" (init));*/

                *sem = SemaphoreC::sem_open((unsigned)arg2);
                int retVal;
                if(*sem == nullptr)
                {
                    retVal = -1;
                }else{
                    retVal = 0;
                }
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x22:
                {
				//sem close - check if handles are nullptrs
                SemaphoreC* sem = (SemaphoreC*)arg1;
                //__asm__ volatile ("mv %0, a1" : "=r" (sem));

                int retVal = sem->close();

                //__asm__ volatile ("mv a0, %0" : "=r" (retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x23:
                {
				//sem wait
                SemaphoreC* sem = (SemaphoreC*)arg1;
                //__asm__ volatile ("mv %0, a1" : "=r" (sem));

                int retVal = sem->wait();

                //__asm__ volatile ("mv a0, %0" : "=r" (retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x24:
                {
				//sem signal
                SemaphoreC* sem = (SemaphoreC*)arg1;
                //__asm__ volatile ("mv %0, a1" : "=r" (sem));

                int retVal = sem->signal();

                //__asm__ volatile ("mv a0, %0" : "=r" (retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x31:
                {
				//time sleep - sleep the running(calling) thread
                /*time_t time;
                __asm__ volatile ("mv %0, a1" : "=r" (time));*/
                int retVal = Sleeper::time_sleep((time_t) arg1);
                //__asm__ volatile ("mv a0, %0" : "=r" (retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x41:
                {
 				//getc
                char retVal = ConsoleC::getc();
                /*printString("Retval in riscv: ");
                __putc(retVal);
                __putc('\n');*/
                //__asm__ volatile ("mv a0, %0" :: "r" (retVal));
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
                break;
                }
			case 0x42:
                {
				//putc
                /*char c;
                __asm__ volatile ("mv %0, a1" : "=r" (c));*/
                ConsoleC::putc((char)arg1);
                break;
                }
            default:
            {
                //thread yield SPECIFICALLY - PROPER INTERRUPT HANDLED IN SOFTVER PREKID SINCE THATS A TIMER INTERRUPT
                //this is also for end of thread wrapper synchronously transferring control to new thread when thread
                //ends
                //sepc gets incremented since ecall returns to itself since its a bad instruction and needs to be punished >:(
                TCB::timeSliceCounter = 0; //reset thread to 0, since new nit hasnt used time yet
				TCB::dispatch(); //assuming that the last nit also ended here - important to set up edge cases (new nit)
                break;
            }
		}
        w_sstatus(sstatus);
        w_sepc(sepc);
    }else if(scause == 0x8000000000000001UL ){ //if softver prekid - tacnije, timer interrupt
        //interrupt: yes; cause code: interrupt from software from highest level privelege (timer)
        //timer prekid, thread dispatch here - this is why we save 1 and 2 instead of doing yield, because we are catching
        //an exception, so cant expect to push and put regs and properly save context in thread like we do in dispatch
        //dispatch moves and saves sp and ra as they are chagned throughout the process, but here its unpredictable,
        //so sometimes you get no change and no context chage! but ra and sp owuold have been moved in the process of
        //interrupt so still need it saved.

		//here also check for any sleeping threads and put them back into scheduler
       mc_sip(SIP_SSIP); //obradjen softver prekid indicator
       Sleeper::awaken();
       TCB::timeSliceCounter++;
       if(TCB::timeSliceCounter >= TCB::running->getTimeSlice())
	   {
	        //even with no context change, sepc needs to be incremented and changed, but sstatus doesnt, so can chagne that here
            uint64 volatile sepc = r_sepc();
            uint64 volatile sstatus = r_sstatus();
	        TCB::timeSliceCounter = 0; //reset thread to 0, since new nit hasnt used time yet
	        TCB::dispatch(); //assuming that the last nit also ended here - important to set up edge cases (new nit)!!
	        //everywhere where it should code enters into privilege, check if not in here
            w_sstatus(sstatus);
            w_sepc(sepc);

	   }
    }else if (scause == 0x8000000000000009UL){ //if hardware prekid - tacnije, console prekid
        //interrupt: yes; cause code: interrupt from outside hardware (console)
        //console handler
		//to handle getc: check the console status (bit 0 u ovom slucaju) and do a while loop of it, transferring
		//data from console (console_rx_data) until the status bit changes
		//limit it also by say half of the default size of the buffer - if the buffer is full cant make it wait, so
		//instead, throw away the input
        uint64 volatile sepc = r_sepc();
        uint64 volatile sstatus = r_sstatus();
        mc_sip(SIP_SEIP);
        uint64 reason = plic_claim();
		//printInt(reason);
		if(reason == CONSOLE_IRQ)
		{
			//is there even to send at the location of RX register???
	        uint64 cntHardware = 0;
	        while( ( *((char *)(CONSOLE_STATUS)) & CONSOLE_RX_STATUS_BIT ) && (cntHardware < (DEFAULT_BUFFER_SIZE/2) ) )
	        {
	            if(!ConsoleC::inputBuffer->isFull())
	            {
					char c = (*(char*)CONSOLE_RX_DATA);
	                ConsoleC::inputBuffer->deposit( c );
	                //send here signal getsem to unblock if it is waiting
	                ConsoleC::getSem->signal();
	            }
				cntHardware += 1;
	        }
    	}
        plic_complete(reason);
        w_sstatus(sstatus);
        w_sepc(sepc);
    }else{ // else unexpected trap - handle
        //unexpected trap cause
        //ispisi scause na terminal
		//__putc('f');
		printString("\nSCAUSE: ");
		uint64 scause = r_scause();
		printInt(scause, 16, 0);
		printString("\nSSTATUS: ");
		uint64 sstatus = r_sstatus();
    	printInt(sstatus, 16, 0);
		uint64 sepc = r_sepc();
    	printString("\nSEPC: ");
    	printInt(sepc, 16, 0);
    	__putc('\n');

		while(1){ }
    }

    //check if sip (supervisor interrupt pending) can work instead of scause? tho scause seems pretty elegant as is - tells which prekid active
    //crsc - control sup reg clear mc - mask clear csrs - control sup reg set
}



