
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	b2813103          	ld	sp,-1240(sp) # 8000cb28 <_GLOBAL_OFFSET_TABLE_+0x40>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	71c070ef          	jal	ra,80007738 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack (na sistemski deo steka niti)
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    # call handler here do nothing for the time being
    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	054050ef          	jal	ra,800060f8 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack (sa sistemskog dela steka niti koja se vratila iz hendlera - ako se vratila)
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    #this pops spp - which is the bit in the sstatus register that tells us what rezim/mode the user was in before
    #thus returning us too that mode, and if prekidi were ok before

    sret
    8000112c:	10200073          	sret

0000000080001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    # a0 - &old->context
    # a1 - &running->context
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:
#include "../h/syscall_c.h"
#include "printing.hpp"
#include "../lib/console.h"

void* mem_alloc(size_t size)
{
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16
    if(size < MEM_BLOCK_SIZE) { newSize = 1;} else {
        size /= MEM_BLOCK_SIZE;
        newSize = (size % MEM_BLOCK_SIZE != 0) ? size + 1 : size;
    }
    */
    size_t rsize = size * MEM_BLOCK_SIZE;
    80001150:	00651513          	slli	a0,a0,0x6
    __asm__ volatile("mv a1, %0" : : "r"(rsize));
    80001154:	00050593          	mv	a1,a0
    __asm__ volatile("li a0, 0x01");
    80001158:	00100513          	li	a0,1
    __asm__ volatile("ecall");
    8000115c:	00000073          	ecall

    void* retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001160:	00050513          	mv	a0,a0
    return retVal;
}
    80001164:	00813403          	ld	s0,8(sp)
    80001168:	01010113          	addi	sp,sp,16
    8000116c:	00008067          	ret

0000000080001170 <_Z8mem_freePv>:
int mem_free(void* p)
{
    80001170:	ff010113          	addi	sp,sp,-16
    80001174:	00813423          	sd	s0,8(sp)
    80001178:	01010413          	addi	s0,sp,16
    __asm__ volatile("mv a1, %0" : : "r"(p));
    8000117c:	00050593          	mv	a1,a0
    __asm__ volatile("li a0, 0x02");
    80001180:	00200513          	li	a0,2
    __asm__ volatile("ecall");
    80001184:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001188:	00050513          	mv	a0,a0
    return retVal;
}
    8000118c:	0005051b          	sext.w	a0,a0
    80001190:	00813403          	ld	s0,8(sp)
    80001194:	01010113          	addi	sp,sp,16
    80001198:	00008067          	ret

000000008000119c <_Z18mem_get_free_spacev>:
size_t mem_get_free_space()
{
    8000119c:	ff010113          	addi	sp,sp,-16
    800011a0:	00813423          	sd	s0,8(sp)
    800011a4:	01010413          	addi	s0,sp,16
    __asm__ volatile("li a0, 0x03");
    800011a8:	00300513          	li	a0,3
    __asm__ volatile("ecall");
    800011ac:	00000073          	ecall

    size_t retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    800011b0:	00050513          	mv	a0,a0
    return retVal;
}
    800011b4:	00813403          	ld	s0,8(sp)
    800011b8:	01010113          	addi	sp,sp,16
    800011bc:	00008067          	ret

00000000800011c0 <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    800011c0:	ff010113          	addi	sp,sp,-16
    800011c4:	00813423          	sd	s0,8(sp)
    800011c8:	01010413          	addi	s0,sp,16
    __asm__ volatile("li a0, 0x04");
    800011cc:	00400513          	li	a0,4
    __asm__ volatile("ecall");
    800011d0:	00000073          	ecall

    size_t retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    800011d4:	00050513          	mv	a0,a0
    return retVal;
}
    800011d8:	00813403          	ld	s0,8(sp)
    800011dc:	01010113          	addi	sp,sp,16
    800011e0:	00008067          	ret

00000000800011e4 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg)
{
    800011e4:	fc010113          	addi	sp,sp,-64
    800011e8:	02113c23          	sd	ra,56(sp)
    800011ec:	02813823          	sd	s0,48(sp)
    800011f0:	02913423          	sd	s1,40(sp)
    800011f4:	03213023          	sd	s2,32(sp)
    800011f8:	01313c23          	sd	s3,24(sp)
    800011fc:	04010413          	addi	s0,sp,64
    80001200:	00050913          	mv	s2,a0
    80001204:	00058493          	mv	s1,a1
    80001208:	00060993          	mv	s3,a2
    /*
    void* volatile stack= nullptr;
    if(start_routine)stack = mem_alloc(DEFAULT_STACK_SIZE);
    */
    void* volatile stack = nullptr;
    8000120c:	fc043423          	sd	zero,-56(s0)
    if(start_routine) stack = MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE);
    80001210:	00058a63          	beqz	a1,80001224 <_Z13thread_createPP3TCBPFvPvES2_+0x40>
    80001214:	00001537          	lui	a0,0x1
    80001218:	00006097          	auipc	ra,0x6
    8000121c:	a9c080e7          	jalr	-1380(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    80001220:	fca43423          	sd	a0,-56(s0)
    __asm__ volatile ("mv a4, %0" :: "r" (stack));
    80001224:	fc843783          	ld	a5,-56(s0)
    80001228:	00078713          	mv	a4,a5
    __asm__ volatile ("mv a3, %0" :: "r" (arg));
    8000122c:	00098693          	mv	a3,s3
    __asm__ volatile ("mv a2, %0" :: "r" (start_routine));
    80001230:	00048613          	mv	a2,s1
    __asm__ volatile ("mv a1, %0" :: "r" (handle));
    80001234:	00090593          	mv	a1,s2

    //printString("Syscall correclty starting\n");
    __asm__ volatile("li a0, 0x11");
    80001238:	01100513          	li	a0,17
    __asm__ volatile("ecall");
    8000123c:	00000073          	ecall
    //printString("Syscall correclty finished\n");

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001240:	00050513          	mv	a0,a0
    return retVal;
}
    80001244:	0005051b          	sext.w	a0,a0
    80001248:	03813083          	ld	ra,56(sp)
    8000124c:	03013403          	ld	s0,48(sp)
    80001250:	02813483          	ld	s1,40(sp)
    80001254:	02013903          	ld	s2,32(sp)
    80001258:	01813983          	ld	s3,24(sp)
    8000125c:	04010113          	addi	sp,sp,64
    80001260:	00008067          	ret

0000000080001264 <_Z11thread_exitv>:
int thread_exit()
{
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00813423          	sd	s0,8(sp)
    8000126c:	01010413          	addi	s0,sp,16
    __asm__ volatile("li a0, 0x12");
    80001270:	01200513          	li	a0,18
    __asm__ volatile("ecall");
    80001274:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001278:	00050513          	mv	a0,a0
    return retVal;
}
    8000127c:	0005051b          	sext.w	a0,a0
    80001280:	00813403          	ld	s0,8(sp)
    80001284:	01010113          	addi	sp,sp,16
    80001288:	00008067          	ret

000000008000128c <_Z15thread_dispatchv>:
void thread_dispatch()
{
    8000128c:	ff010113          	addi	sp,sp,-16
    80001290:	00813423          	sd	s0,8(sp)
    80001294:	01010413          	addi	s0,sp,16
    __asm__ volatile("li a0, 0x13");
    80001298:	01300513          	li	a0,19
    __asm__ volatile("ecall");
    8000129c:	00000073          	ecall
    return;
}
    800012a0:	00813403          	ld	s0,8(sp)
    800012a4:	01010113          	addi	sp,sp,16
    800012a8:	00008067          	ret

00000000800012ac <_Z8sem_openPP10SemaphoreCj>:

int sem_open(sem_t* handle, unsigned init)
{
    800012ac:	ff010113          	addi	sp,sp,-16
    800012b0:	00813423          	sd	s0,8(sp)
    800012b4:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a2, %0" :: "r" (init));
    800012b8:	00058613          	mv	a2,a1
    __asm__ volatile ("mv a1, %0":: "r" (handle));
    800012bc:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x21");
    800012c0:	02100513          	li	a0,33
    __asm__ volatile("ecall");
    800012c4:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    800012c8:	00050513          	mv	a0,a0
    return retVal;
}
    800012cc:	0005051b          	sext.w	a0,a0
    800012d0:	00813403          	ld	s0,8(sp)
    800012d4:	01010113          	addi	sp,sp,16
    800012d8:	00008067          	ret

00000000800012dc <_Z9sem_closeP10SemaphoreC>:
int sem_close(sem_t handle)
{
    800012dc:	ff010113          	addi	sp,sp,-16
    800012e0:	00813423          	sd	s0,8(sp)
    800012e4:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0":: "r" (handle));
    800012e8:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x22");
    800012ec:	02200513          	li	a0,34
    __asm__ volatile("ecall");
    800012f0:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    800012f4:	00050513          	mv	a0,a0
    return retVal;
}
    800012f8:	0005051b          	sext.w	a0,a0
    800012fc:	00813403          	ld	s0,8(sp)
    80001300:	01010113          	addi	sp,sp,16
    80001304:	00008067          	ret

0000000080001308 <_Z8sem_waitP10SemaphoreC>:
int sem_wait(sem_t id)
{
    80001308:	ff010113          	addi	sp,sp,-16
    8000130c:	00813423          	sd	s0,8(sp)
    80001310:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0":: "r" (id));
    80001314:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x23");
    80001318:	02300513          	li	a0,35
    __asm__ volatile("ecall");
    8000131c:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001320:	00050513          	mv	a0,a0
    return retVal;
}
    80001324:	0005051b          	sext.w	a0,a0
    80001328:	00813403          	ld	s0,8(sp)
    8000132c:	01010113          	addi	sp,sp,16
    80001330:	00008067          	ret

0000000080001334 <_Z10sem_signalP10SemaphoreC>:
int sem_signal(sem_t id)
{
    80001334:	ff010113          	addi	sp,sp,-16
    80001338:	00813423          	sd	s0,8(sp)
    8000133c:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0":: "r" (id));
    80001340:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x24");
    80001344:	02400513          	li	a0,36
    __asm__ volatile("ecall");
    80001348:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    8000134c:	00050513          	mv	a0,a0
    return retVal;
}
    80001350:	0005051b          	sext.w	a0,a0
    80001354:	00813403          	ld	s0,8(sp)
    80001358:	01010113          	addi	sp,sp,16
    8000135c:	00008067          	ret

0000000080001360 <_Z10time_sleepm>:

int time_sleep(time_t time)
{
    80001360:	ff010113          	addi	sp,sp,-16
    80001364:	00813423          	sd	s0,8(sp)
    80001368:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0":: "r" (time));
    8000136c:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x31");
    80001370:	03100513          	li	a0,49
    __asm__ volatile("ecall");
    80001374:	00000073          	ecall

    int retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    80001378:	00050513          	mv	a0,a0
    return retVal;
}
    8000137c:	0005051b          	sext.w	a0,a0
    80001380:	00813403          	ld	s0,8(sp)
    80001384:	01010113          	addi	sp,sp,16
    80001388:	00008067          	ret

000000008000138c <_Z4getcv>:

char getc()
{
    8000138c:	ff010113          	addi	sp,sp,-16
    80001390:	00813423          	sd	s0,8(sp)
    80001394:	01010413          	addi	s0,sp,16
    __asm__ volatile("li a0, 0x41");
    80001398:	04100513          	li	a0,65
    __asm__ volatile("ecall");
    8000139c:	00000073          	ecall

    char retVal;
    __asm__ volatile("mv %0, a0" : "=r"(retVal));
    800013a0:	00050513          	mv	a0,a0
    return retVal;
}
    800013a4:	0ff57513          	andi	a0,a0,255
    800013a8:	00813403          	ld	s0,8(sp)
    800013ac:	01010113          	addi	sp,sp,16
    800013b0:	00008067          	ret

00000000800013b4 <_Z4putcc>:
void putc(char c)
{
    800013b4:	ff010113          	addi	sp,sp,-16
    800013b8:	00813423          	sd	s0,8(sp)
    800013bc:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv a1, %0":: "r" (c));
    800013c0:	00050593          	mv	a1,a0

    __asm__ volatile("li a0, 0x42");
    800013c4:	04200513          	li	a0,66
    __asm__ volatile("ecall");
    800013c8:	00000073          	ecall

    return;
    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	01010113          	addi	sp,sp,16
    800013d4:	00008067          	ret

00000000800013d8 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800013d8:	fe010113          	addi	sp,sp,-32
    800013dc:	00113c23          	sd	ra,24(sp)
    800013e0:	00813823          	sd	s0,16(sp)
    800013e4:	00913423          	sd	s1,8(sp)
    800013e8:	01213023          	sd	s2,0(sp)
    800013ec:	02010413          	addi	s0,sp,32
    800013f0:	00050493          	mv	s1,a0
    __putc('\n');
    printInt(data->id);
    __putc('\n');*/

    int key;
    int i = 0;
    800013f4:	00000913          	li	s2,0
    800013f8:	00c0006f          	j	80001404 <_ZL16producerKeyboardPv+0x2c>
        //__putc('\n');
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800013fc:	00000097          	auipc	ra,0x0
    80001400:	e90080e7          	jalr	-368(ra) # 8000128c <_Z15thread_dispatchv>
    while ((key = getc()) != 0x30) {//change this to see if it will force end properly since i dont recognize that code (escape character 0x1b)
    80001404:	00000097          	auipc	ra,0x0
    80001408:	f88080e7          	jalr	-120(ra) # 8000138c <_Z4getcv>
    8000140c:	0005059b          	sext.w	a1,a0
    80001410:	03000793          	li	a5,48
    80001414:	02f58a63          	beq	a1,a5,80001448 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80001418:	0084b503          	ld	a0,8(s1)
    8000141c:	00006097          	auipc	ra,0x6
    80001420:	098080e7          	jalr	152(ra) # 800074b4 <_ZN6Buffer3putEi>
        i++;
    80001424:	0019071b          	addiw	a4,s2,1
    80001428:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000142c:	0004a683          	lw	a3,0(s1)
    80001430:	0026979b          	slliw	a5,a3,0x2
    80001434:	00d787bb          	addw	a5,a5,a3
    80001438:	0017979b          	slliw	a5,a5,0x1
    8000143c:	02f767bb          	remw	a5,a4,a5
    80001440:	fc0792e3          	bnez	a5,80001404 <_ZL16producerKeyboardPv+0x2c>
    80001444:	fb9ff06f          	j	800013fc <_ZL16producerKeyboardPv+0x24>
        }
    }
    /*__putc('L');
    __putc('\n');*/
    threadEnd = 1;
    80001448:	00100793          	li	a5,1
    8000144c:	0000b717          	auipc	a4,0xb
    80001450:	78f72a23          	sw	a5,1940(a4) # 8000cbe0 <_ZL9threadEnd>
    data->buffer->put('!');
    80001454:	02100593          	li	a1,33
    80001458:	0084b503          	ld	a0,8(s1)
    8000145c:	00006097          	auipc	ra,0x6
    80001460:	058080e7          	jalr	88(ra) # 800074b4 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80001464:	0104b503          	ld	a0,16(s1)
    80001468:	00000097          	auipc	ra,0x0
    8000146c:	ecc080e7          	jalr	-308(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
}
    80001470:	01813083          	ld	ra,24(sp)
    80001474:	01013403          	ld	s0,16(sp)
    80001478:	00813483          	ld	s1,8(sp)
    8000147c:	00013903          	ld	s2,0(sp)
    80001480:	02010113          	addi	sp,sp,32
    80001484:	00008067          	ret

0000000080001488 <_ZL8producerPv>:

static void producer(void *arg) {
    80001488:	fe010113          	addi	sp,sp,-32
    8000148c:	00113c23          	sd	ra,24(sp)
    80001490:	00813823          	sd	s0,16(sp)
    80001494:	00913423          	sd	s1,8(sp)
    80001498:	01213023          	sd	s2,0(sp)
    8000149c:	02010413          	addi	s0,sp,32
    800014a0:	00050493          	mv	s1,a0
    /*__putc('P');
    __putc('\n');
    printInt(data->id);
    __putc('\n');*/

    int i = 0;
    800014a4:	00000913          	li	s2,0
    800014a8:	00c0006f          	j	800014b4 <_ZL8producerPv+0x2c>
        //__putc('\n');
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800014ac:	00000097          	auipc	ra,0x0
    800014b0:	de0080e7          	jalr	-544(ra) # 8000128c <_Z15thread_dispatchv>
    while (!threadEnd) {
    800014b4:	0000b797          	auipc	a5,0xb
    800014b8:	72c7a783          	lw	a5,1836(a5) # 8000cbe0 <_ZL9threadEnd>
    800014bc:	02079e63          	bnez	a5,800014f8 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800014c0:	0004a583          	lw	a1,0(s1)
    800014c4:	0305859b          	addiw	a1,a1,48
    800014c8:	0084b503          	ld	a0,8(s1)
    800014cc:	00006097          	auipc	ra,0x6
    800014d0:	fe8080e7          	jalr	-24(ra) # 800074b4 <_ZN6Buffer3putEi>
        i++;
    800014d4:	0019071b          	addiw	a4,s2,1
    800014d8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800014dc:	0004a683          	lw	a3,0(s1)
    800014e0:	0026979b          	slliw	a5,a3,0x2
    800014e4:	00d787bb          	addw	a5,a5,a3
    800014e8:	0017979b          	slliw	a5,a5,0x1
    800014ec:	02f767bb          	remw	a5,a4,a5
    800014f0:	fc0792e3          	bnez	a5,800014b4 <_ZL8producerPv+0x2c>
    800014f4:	fb9ff06f          	j	800014ac <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800014f8:	0104b503          	ld	a0,16(s1)
    800014fc:	00000097          	auipc	ra,0x0
    80001500:	e38080e7          	jalr	-456(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
}
    80001504:	01813083          	ld	ra,24(sp)
    80001508:	01013403          	ld	s0,16(sp)
    8000150c:	00813483          	ld	s1,8(sp)
    80001510:	00013903          	ld	s2,0(sp)
    80001514:	02010113          	addi	sp,sp,32
    80001518:	00008067          	ret

000000008000151c <_ZL8consumerPv>:

static void consumer(void *arg) {
    8000151c:	fd010113          	addi	sp,sp,-48
    80001520:	02113423          	sd	ra,40(sp)
    80001524:	02813023          	sd	s0,32(sp)
    80001528:	00913c23          	sd	s1,24(sp)
    8000152c:	01213823          	sd	s2,16(sp)
    80001530:	01313423          	sd	s3,8(sp)
    80001534:	03010413          	addi	s0,sp,48
    80001538:	00050913          	mv	s2,a0
    /*__putc('C');
    __putc('\n');
    printInt(data->id);
    __putc('\n');*/

    int i = 0;
    8000153c:	00000993          	li	s3,0
    80001540:	01c0006f          	j	8000155c <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80001544:	00000097          	auipc	ra,0x0
    80001548:	d48080e7          	jalr	-696(ra) # 8000128c <_Z15thread_dispatchv>
    8000154c:	0500006f          	j	8000159c <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80001550:	00a00513          	li	a0,10
    80001554:	00000097          	auipc	ra,0x0
    80001558:	e60080e7          	jalr	-416(ra) # 800013b4 <_Z4putcc>
    while (!threadEnd) {
    8000155c:	0000b797          	auipc	a5,0xb
    80001560:	6847a783          	lw	a5,1668(a5) # 8000cbe0 <_ZL9threadEnd>
    80001564:	06079063          	bnez	a5,800015c4 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80001568:	00893503          	ld	a0,8(s2)
    8000156c:	00006097          	auipc	ra,0x6
    80001570:	fd8080e7          	jalr	-40(ra) # 80007544 <_ZN6Buffer3getEv>
        i++;
    80001574:	0019849b          	addiw	s1,s3,1
    80001578:	0004899b          	sext.w	s3,s1
        putc(key);
    8000157c:	0ff57513          	andi	a0,a0,255
    80001580:	00000097          	auipc	ra,0x0
    80001584:	e34080e7          	jalr	-460(ra) # 800013b4 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80001588:	00092703          	lw	a4,0(s2)
    8000158c:	0027179b          	slliw	a5,a4,0x2
    80001590:	00e787bb          	addw	a5,a5,a4
    80001594:	02f4e7bb          	remw	a5,s1,a5
    80001598:	fa0786e3          	beqz	a5,80001544 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    8000159c:	05000793          	li	a5,80
    800015a0:	02f4e4bb          	remw	s1,s1,a5
    800015a4:	fa049ce3          	bnez	s1,8000155c <_ZL8consumerPv+0x40>
    800015a8:	fa9ff06f          	j	80001550 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    800015ac:	00893503          	ld	a0,8(s2)
    800015b0:	00006097          	auipc	ra,0x6
    800015b4:	f94080e7          	jalr	-108(ra) # 80007544 <_ZN6Buffer3getEv>
        putc(key);
    800015b8:	0ff57513          	andi	a0,a0,255
    800015bc:	00000097          	auipc	ra,0x0
    800015c0:	df8080e7          	jalr	-520(ra) # 800013b4 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800015c4:	00893503          	ld	a0,8(s2)
    800015c8:	00006097          	auipc	ra,0x6
    800015cc:	008080e7          	jalr	8(ra) # 800075d0 <_ZN6Buffer6getCntEv>
    800015d0:	fca04ee3          	bgtz	a0,800015ac <_ZL8consumerPv+0x90>
    }
    //__putc('e');
    //__putc('\n');
    sem_signal(data->wait); //signal not freeing it at 10---------------------------------------------------------------!
    800015d4:	01093503          	ld	a0,16(s2)
    800015d8:	00000097          	auipc	ra,0x0
    800015dc:	d5c080e7          	jalr	-676(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
}
    800015e0:	02813083          	ld	ra,40(sp)
    800015e4:	02013403          	ld	s0,32(sp)
    800015e8:	01813483          	ld	s1,24(sp)
    800015ec:	01013903          	ld	s2,16(sp)
    800015f0:	00813983          	ld	s3,8(sp)
    800015f4:	03010113          	addi	sp,sp,48
    800015f8:	00008067          	ret

00000000800015fc <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800015fc:	f9010113          	addi	sp,sp,-112
    80001600:	06113423          	sd	ra,104(sp)
    80001604:	06813023          	sd	s0,96(sp)
    80001608:	04913c23          	sd	s1,88(sp)
    8000160c:	05213823          	sd	s2,80(sp)
    80001610:	05313423          	sd	s3,72(sp)
    80001614:	05413023          	sd	s4,64(sp)
    80001618:	03513c23          	sd	s5,56(sp)
    8000161c:	03613823          	sd	s6,48(sp)
    80001620:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }
    printString("\nEnding nicely?\n");
    sem_close(waitForAll);

    delete buffer;
    80001624:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80001628:	00009517          	auipc	a0,0x9
    8000162c:	9f850513          	addi	a0,a0,-1544 # 8000a020 <CONSOLE_STATUS+0x10>
    80001630:	00002097          	auipc	ra,0x2
    80001634:	564080e7          	jalr	1380(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    80001638:	01e00593          	li	a1,30
    8000163c:	fa040493          	addi	s1,s0,-96
    80001640:	00048513          	mv	a0,s1
    80001644:	00002097          	auipc	ra,0x2
    80001648:	5d8080e7          	jalr	1496(ra) # 80003c1c <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000164c:	00048513          	mv	a0,s1
    80001650:	00002097          	auipc	ra,0x2
    80001654:	6a4080e7          	jalr	1700(ra) # 80003cf4 <_Z11stringToIntPKc>
    80001658:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000165c:	00009517          	auipc	a0,0x9
    80001660:	9e450513          	addi	a0,a0,-1564 # 8000a040 <CONSOLE_STATUS+0x30>
    80001664:	00002097          	auipc	ra,0x2
    80001668:	530080e7          	jalr	1328(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    8000166c:	01e00593          	li	a1,30
    80001670:	00048513          	mv	a0,s1
    80001674:	00002097          	auipc	ra,0x2
    80001678:	5a8080e7          	jalr	1448(ra) # 80003c1c <_Z9getStringPci>
    n = stringToInt(input);
    8000167c:	00048513          	mv	a0,s1
    80001680:	00002097          	auipc	ra,0x2
    80001684:	674080e7          	jalr	1652(ra) # 80003cf4 <_Z11stringToIntPKc>
    80001688:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000168c:	00009517          	auipc	a0,0x9
    80001690:	9d450513          	addi	a0,a0,-1580 # 8000a060 <CONSOLE_STATUS+0x50>
    80001694:	00002097          	auipc	ra,0x2
    80001698:	500080e7          	jalr	1280(ra) # 80003b94 <_Z11printStringPKc>
    8000169c:	00000613          	li	a2,0
    800016a0:	00a00593          	li	a1,10
    800016a4:	00090513          	mv	a0,s2
    800016a8:	00002097          	auipc	ra,0x2
    800016ac:	69c080e7          	jalr	1692(ra) # 80003d44 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800016b0:	00009517          	auipc	a0,0x9
    800016b4:	9c850513          	addi	a0,a0,-1592 # 8000a078 <CONSOLE_STATUS+0x68>
    800016b8:	00002097          	auipc	ra,0x2
    800016bc:	4dc080e7          	jalr	1244(ra) # 80003b94 <_Z11printStringPKc>
    800016c0:	00000613          	li	a2,0
    800016c4:	00a00593          	li	a1,10
    800016c8:	00048513          	mv	a0,s1
    800016cc:	00002097          	auipc	ra,0x2
    800016d0:	678080e7          	jalr	1656(ra) # 80003d44 <_Z8printIntiii>
    printString(".\n");
    800016d4:	00009517          	auipc	a0,0x9
    800016d8:	9bc50513          	addi	a0,a0,-1604 # 8000a090 <CONSOLE_STATUS+0x80>
    800016dc:	00002097          	auipc	ra,0x2
    800016e0:	4b8080e7          	jalr	1208(ra) # 80003b94 <_Z11printStringPKc>
    if(threadNum > n) {
    800016e4:	0324c463          	blt	s1,s2,8000170c <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    800016e8:	03205c63          	blez	s2,80001720 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    800016ec:	03800513          	li	a0,56
    800016f0:	00003097          	auipc	ra,0x3
    800016f4:	6dc080e7          	jalr	1756(ra) # 80004dcc <_Znwm>
    800016f8:	00050a13          	mv	s4,a0
    800016fc:	00048593          	mv	a1,s1
    80001700:	00006097          	auipc	ra,0x6
    80001704:	d18080e7          	jalr	-744(ra) # 80007418 <_ZN6BufferC1Ei>
    80001708:	0300006f          	j	80001738 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000170c:	00009517          	auipc	a0,0x9
    80001710:	98c50513          	addi	a0,a0,-1652 # 8000a098 <CONSOLE_STATUS+0x88>
    80001714:	00002097          	auipc	ra,0x2
    80001718:	480080e7          	jalr	1152(ra) # 80003b94 <_Z11printStringPKc>
        return;
    8000171c:	0140006f          	j	80001730 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80001720:	00009517          	auipc	a0,0x9
    80001724:	9b850513          	addi	a0,a0,-1608 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    80001728:	00002097          	auipc	ra,0x2
    8000172c:	46c080e7          	jalr	1132(ra) # 80003b94 <_Z11printStringPKc>
        return;
    80001730:	000b0113          	mv	sp,s6
    80001734:	1600006f          	j	80001894 <_Z22producerConsumer_C_APIv+0x298>
    sem_open(&waitForAll, 0); // this is set as 0 initially, should it be one?------------------------------------------!!
    80001738:	00000593          	li	a1,0
    8000173c:	0000b517          	auipc	a0,0xb
    80001740:	4ac50513          	addi	a0,a0,1196 # 8000cbe8 <_ZL10waitForAll>
    80001744:	00000097          	auipc	ra,0x0
    80001748:	b68080e7          	jalr	-1176(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
    thread_t threads[threadNum];
    8000174c:	00391793          	slli	a5,s2,0x3
    80001750:	00f78793          	addi	a5,a5,15
    80001754:	ff07f793          	andi	a5,a5,-16
    80001758:	40f10133          	sub	sp,sp,a5
    8000175c:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80001760:	0019071b          	addiw	a4,s2,1
    80001764:	00171793          	slli	a5,a4,0x1
    80001768:	00e787b3          	add	a5,a5,a4
    8000176c:	00379793          	slli	a5,a5,0x3
    80001770:	00f78793          	addi	a5,a5,15
    80001774:	ff07f793          	andi	a5,a5,-16
    80001778:	40f10133          	sub	sp,sp,a5
    8000177c:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80001780:	00191613          	slli	a2,s2,0x1
    80001784:	012607b3          	add	a5,a2,s2
    80001788:	00379793          	slli	a5,a5,0x3
    8000178c:	00f987b3          	add	a5,s3,a5
    80001790:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80001794:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80001798:	0000b717          	auipc	a4,0xb
    8000179c:	45073703          	ld	a4,1104(a4) # 8000cbe8 <_ZL10waitForAll>
    800017a0:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800017a4:	00078613          	mv	a2,a5
    800017a8:	00000597          	auipc	a1,0x0
    800017ac:	d7458593          	addi	a1,a1,-652 # 8000151c <_ZL8consumerPv>
    800017b0:	f9840513          	addi	a0,s0,-104
    800017b4:	00000097          	auipc	ra,0x0
    800017b8:	a30080e7          	jalr	-1488(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800017bc:	00000493          	li	s1,0
    800017c0:	0280006f          	j	800017e8 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    800017c4:	00000597          	auipc	a1,0x0
    800017c8:	c1458593          	addi	a1,a1,-1004 # 800013d8 <_ZL16producerKeyboardPv>
                      data + i);
    800017cc:	00179613          	slli	a2,a5,0x1
    800017d0:	00f60633          	add	a2,a2,a5
    800017d4:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    800017d8:	00c98633          	add	a2,s3,a2
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	a08080e7          	jalr	-1528(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800017e4:	0014849b          	addiw	s1,s1,1
    800017e8:	0524d263          	bge	s1,s2,8000182c <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    800017ec:	00149793          	slli	a5,s1,0x1
    800017f0:	009787b3          	add	a5,a5,s1
    800017f4:	00379793          	slli	a5,a5,0x3
    800017f8:	00f987b3          	add	a5,s3,a5
    800017fc:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80001800:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80001804:	0000b717          	auipc	a4,0xb
    80001808:	3e473703          	ld	a4,996(a4) # 8000cbe8 <_ZL10waitForAll>
    8000180c:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80001810:	00048793          	mv	a5,s1
    80001814:	00349513          	slli	a0,s1,0x3
    80001818:	00aa8533          	add	a0,s5,a0
    8000181c:	fa9054e3          	blez	s1,800017c4 <_Z22producerConsumer_C_APIv+0x1c8>
    80001820:	00000597          	auipc	a1,0x0
    80001824:	c6858593          	addi	a1,a1,-920 # 80001488 <_ZL8producerPv>
    80001828:	fa5ff06f          	j	800017cc <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch(); //dispatch here is where SCAUSE = 7 happens-------------------------------------------------------!
    8000182c:	00000097          	auipc	ra,0x0
    80001830:	a60080e7          	jalr	-1440(ra) # 8000128c <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80001834:	00000493          	li	s1,0
    80001838:	00994e63          	blt	s2,s1,80001854 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    8000183c:	0000b517          	auipc	a0,0xb
    80001840:	3ac53503          	ld	a0,940(a0) # 8000cbe8 <_ZL10waitForAll>
    80001844:	00000097          	auipc	ra,0x0
    80001848:	ac4080e7          	jalr	-1340(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>
    for (int i = 0; i <= threadNum; i++) {
    8000184c:	0014849b          	addiw	s1,s1,1
    80001850:	fe9ff06f          	j	80001838 <_Z22producerConsumer_C_APIv+0x23c>
    printString("\nEnding nicely?\n");
    80001854:	00009517          	auipc	a0,0x9
    80001858:	8b450513          	addi	a0,a0,-1868 # 8000a108 <CONSOLE_STATUS+0xf8>
    8000185c:	00002097          	auipc	ra,0x2
    80001860:	338080e7          	jalr	824(ra) # 80003b94 <_Z11printStringPKc>
    sem_close(waitForAll);
    80001864:	0000b517          	auipc	a0,0xb
    80001868:	38453503          	ld	a0,900(a0) # 8000cbe8 <_ZL10waitForAll>
    8000186c:	00000097          	auipc	ra,0x0
    80001870:	a70080e7          	jalr	-1424(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
    delete buffer;
    80001874:	000a0e63          	beqz	s4,80001890 <_Z22producerConsumer_C_APIv+0x294>
    80001878:	000a0513          	mv	a0,s4
    8000187c:	00006097          	auipc	ra,0x6
    80001880:	ddc080e7          	jalr	-548(ra) # 80007658 <_ZN6BufferD1Ev>
    80001884:	000a0513          	mv	a0,s4
    80001888:	00003097          	auipc	ra,0x3
    8000188c:	594080e7          	jalr	1428(ra) # 80004e1c <_ZdlPv>
    80001890:	000b0113          	mv	sp,s6

}
    80001894:	f9040113          	addi	sp,s0,-112
    80001898:	06813083          	ld	ra,104(sp)
    8000189c:	06013403          	ld	s0,96(sp)
    800018a0:	05813483          	ld	s1,88(sp)
    800018a4:	05013903          	ld	s2,80(sp)
    800018a8:	04813983          	ld	s3,72(sp)
    800018ac:	04013a03          	ld	s4,64(sp)
    800018b0:	03813a83          	ld	s5,56(sp)
    800018b4:	03013b03          	ld	s6,48(sp)
    800018b8:	07010113          	addi	sp,sp,112
    800018bc:	00008067          	ret
    800018c0:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    800018c4:	000a0513          	mv	a0,s4
    800018c8:	00003097          	auipc	ra,0x3
    800018cc:	554080e7          	jalr	1364(ra) # 80004e1c <_ZdlPv>
    800018d0:	00048513          	mv	a0,s1
    800018d4:	0000c097          	auipc	ra,0xc
    800018d8:	4b4080e7          	jalr	1204(ra) # 8000dd88 <_Unwind_Resume>

00000000800018dc <_ZN10SemaphoreC8sem_openEi>:
#include "../h/Semaphore.h"
#include "printing.hpp"
#include "../lib/console.h"

SemaphoreC* SemaphoreC::sem_open(int init)
{
    800018dc:	fe010113          	addi	sp,sp,-32
    800018e0:	00113c23          	sd	ra,24(sp)
    800018e4:	00813823          	sd	s0,16(sp)
    800018e8:	00913423          	sd	s1,8(sp)
    800018ec:	02010413          	addi	s0,sp,32
    800018f0:	00050493          	mv	s1,a0

    int close();

    void* operator new(size_t size)
     {
         return MemoryAllocator::mem_alloc(size);
    800018f4:	01800513          	li	a0,24
    800018f8:	00005097          	auipc	ra,0x5
    800018fc:	3bc080e7          	jalr	956(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    {
        MemoryAllocator::mem_free(ptr);
        return;
    }
private:
    SemaphoreC(int init = 0) : val(init), closed(false)  {}
    80001900:	00952023          	sw	s1,0(a0)
    80001904:	00050223          	sb	zero,4(a0)
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001908:	00053423          	sd	zero,8(a0)
    8000190c:	00053823          	sd	zero,16(a0)
    //printString("NEW SEMAPHORE---\n");
    return new SemaphoreC(init);
}
    80001910:	01813083          	ld	ra,24(sp)
    80001914:	01013403          	ld	s0,16(sp)
    80001918:	00813483          	ld	s1,8(sp)
    8000191c:	02010113          	addi	sp,sp,32
    80001920:	00008067          	ret

0000000080001924 <_ZN10SemaphoreC4waitEv>:
    bool isClosed() const { return closed; }
    80001924:	00454783          	lbu	a5,4(a0)

int SemaphoreC::wait()
{
    if(this->isClosed()) return -1;
    80001928:	0c079263          	bnez	a5,800019ec <_ZN10SemaphoreC4waitEv+0xc8>
{
    8000192c:	fe010113          	addi	sp,sp,-32
    80001930:	00113c23          	sd	ra,24(sp)
    80001934:	00813823          	sd	s0,16(sp)
    80001938:	00913423          	sd	s1,8(sp)
    8000193c:	01213023          	sd	s2,0(sp)
    80001940:	02010413          	addi	s0,sp,32
    80001944:	00050493          	mv	s1,a0

    if((int)(--this->val) < 0){
    80001948:	00052783          	lw	a5,0(a0)
    8000194c:	fff7879b          	addiw	a5,a5,-1
    80001950:	00f52023          	sw	a5,0(a0)
    80001954:	02079713          	slli	a4,a5,0x20
    80001958:	02074063          	bltz	a4,80001978 <_ZN10SemaphoreC4waitEv+0x54>
            TCB::dispatch();
        }
        if(this->closed) return -1;
    }

    return 0;
    8000195c:	00000513          	li	a0,0
}
    80001960:	01813083          	ld	ra,24(sp)
    80001964:	01013403          	ld	s0,16(sp)
    80001968:	00813483          	ld	s1,8(sp)
    8000196c:	00013903          	ld	s2,0(sp)
    80001970:	02010113          	addi	sp,sp,32
    80001974:	00008067          	ret
        if(!TCB::running->isFinished() || !(TCB::running == nullptr)){
    80001978:	0000b797          	auipc	a5,0xb
    8000197c:	1e87b783          	ld	a5,488(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80001980:	0007b903          	ld	s2,0(a5)
{
public:

    ~TCB() { delete[] stack; } //delete the whole stack??? might have issue here with mem leaks-----------------------------------------

    bool isFinished() const { return finished; }
    80001984:	02894783          	lbu	a5,40(s2)
    80001988:	00078463          	beqz	a5,80001990 <_ZN10SemaphoreC4waitEv+0x6c>
    8000198c:	04090263          	beqz	s2,800019d0 <_ZN10SemaphoreC4waitEv+0xac>
            tcb->t_blocked = true;
    80001990:	00100793          	li	a5,1
    80001994:	02f904a3          	sb	a5,41(s2)
            return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    80001998:	01000513          	li	a0,16
    8000199c:	00005097          	auipc	ra,0x5
    800019a0:	318080e7          	jalr	792(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800019a4:	01253023          	sd	s2,0(a0)
    800019a8:	00053423          	sd	zero,8(a0)
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
        if (tail)
    800019ac:	0104b783          	ld	a5,16(s1)
    800019b0:	02078863          	beqz	a5,800019e0 <_ZN10SemaphoreC4waitEv+0xbc>
        {
            tail->next = elem;
    800019b4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800019b8:	00a4b823          	sd	a0,16(s1)
            TCB::timeSliceCounter=0;
    800019bc:	0000b797          	auipc	a5,0xb
    800019c0:	1547b783          	ld	a5,340(a5) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    800019c4:	0007b023          	sd	zero,0(a5)
            TCB::dispatch();
    800019c8:	00003097          	auipc	ra,0x3
    800019cc:	280080e7          	jalr	640(ra) # 80004c48 <_ZN3TCB8dispatchEv>
        if(this->closed) return -1;
    800019d0:	0044c783          	lbu	a5,4(s1)
    800019d4:	02079063          	bnez	a5,800019f4 <_ZN10SemaphoreC4waitEv+0xd0>
    return 0;
    800019d8:	00000513          	li	a0,0
    800019dc:	f85ff06f          	j	80001960 <_ZN10SemaphoreC4waitEv+0x3c>
        } else
        {
            head = tail = elem;
    800019e0:	00a4b823          	sd	a0,16(s1)
    800019e4:	00a4b423          	sd	a0,8(s1)
    800019e8:	fd5ff06f          	j	800019bc <_ZN10SemaphoreC4waitEv+0x98>
    if(this->isClosed()) return -1;
    800019ec:	fff00513          	li	a0,-1
}
    800019f0:	00008067          	ret
        if(this->closed) return -1;
    800019f4:	fff00513          	li	a0,-1
    800019f8:	f69ff06f          	j	80001960 <_ZN10SemaphoreC4waitEv+0x3c>

00000000800019fc <_ZN10SemaphoreC6signalEv>:
    800019fc:	00454703          	lbu	a4,4(a0)

int SemaphoreC::signal()
{
    if(this->isClosed()) return -1;
    80001a00:	08071863          	bnez	a4,80001a90 <_ZN10SemaphoreC6signalEv+0x94>
    80001a04:	00050793          	mv	a5,a0

    if((int)(++this->val) <= 0){
    80001a08:	00052703          	lw	a4,0(a0)
    80001a0c:	0017071b          	addiw	a4,a4,1
    80001a10:	0007069b          	sext.w	a3,a4
    80001a14:	00e52023          	sw	a4,0(a0)
    80001a18:	00d05663          	blez	a3,80001a24 <_ZN10SemaphoreC6signalEv+0x28>
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
        Scheduler::put(tcb);
    }
    return 0;
    80001a1c:	00000513          	li	a0,0
}
    80001a20:	00008067          	ret
{
    80001a24:	fe010113          	addi	sp,sp,-32
    80001a28:	00113c23          	sd	ra,24(sp)
    80001a2c:	00813823          	sd	s0,16(sp)
    80001a30:	00913423          	sd	s1,8(sp)
    80001a34:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001a38:	00853503          	ld	a0,8(a0)
    80001a3c:	04050663          	beqz	a0,80001a88 <_ZN10SemaphoreC6signalEv+0x8c>

        Elem *elem = head;
        head = head->next;
    80001a40:	00853703          	ld	a4,8(a0)
    80001a44:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001a48:	02070c63          	beqz	a4,80001a80 <_ZN10SemaphoreC6signalEv+0x84>

        T *ret = elem->data;
    80001a4c:	00053483          	ld	s1,0(a0)
            MemoryAllocator::mem_free(ptr);
    80001a50:	00005097          	auipc	ra,0x5
    80001a54:	54c080e7          	jalr	1356(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
        tcb->t_blocked = false;
    80001a58:	020484a3          	sb	zero,41(s1)
        Scheduler::put(tcb);
    80001a5c:	00048513          	mv	a0,s1
    80001a60:	00005097          	auipc	ra,0x5
    80001a64:	bcc080e7          	jalr	-1076(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
    return 0;
    80001a68:	00000513          	li	a0,0
}
    80001a6c:	01813083          	ld	ra,24(sp)
    80001a70:	01013403          	ld	s0,16(sp)
    80001a74:	00813483          	ld	s1,8(sp)
    80001a78:	02010113          	addi	sp,sp,32
    80001a7c:	00008067          	ret
        if (!head) { tail = 0; }
    80001a80:	0007b823          	sd	zero,16(a5)
    80001a84:	fc9ff06f          	j	80001a4c <_ZN10SemaphoreC6signalEv+0x50>
        if (!head) { return 0; }
    80001a88:	00050493          	mv	s1,a0
    80001a8c:	fcdff06f          	j	80001a58 <_ZN10SemaphoreC6signalEv+0x5c>
    if(this->isClosed()) return -1;
    80001a90:	fff00513          	li	a0,-1
    80001a94:	00008067          	ret

0000000080001a98 <_ZN10SemaphoreC5closeEv>:

int SemaphoreC::close()
{
    80001a98:	fe010113          	addi	sp,sp,-32
    80001a9c:	00113c23          	sd	ra,24(sp)
    80001aa0:	00813823          	sd	s0,16(sp)
    80001aa4:	00913423          	sd	s1,8(sp)
    80001aa8:	01213023          	sd	s2,0(sp)
    80001aac:	02010413          	addi	s0,sp,32
    80001ab0:	00050493          	mv	s1,a0
    80001ab4:	00454783          	lbu	a5,4(a0)
    if(this->isClosed()) return -1;
    80001ab8:	02078663          	beqz	a5,80001ae4 <_ZN10SemaphoreC5closeEv+0x4c>
    80001abc:	fff00513          	li	a0,-1
    80001ac0:	0600006f          	j	80001b20 <_ZN10SemaphoreC5closeEv+0x88>
        if (!head) { tail = 0; }
    80001ac4:	0004b823          	sd	zero,16(s1)
        T *ret = elem->data;
    80001ac8:	00053903          	ld	s2,0(a0)
            MemoryAllocator::mem_free(ptr);
    80001acc:	00005097          	auipc	ra,0x5
    80001ad0:	4d0080e7          	jalr	1232(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
    while(this->blocked.peekLast()){ //peek first?
        TCB *tcb = this->blocked.removeFirst();
        tcb->t_blocked = false;
    80001ad4:	020904a3          	sb	zero,41(s2)
        Scheduler::put(tcb);
    80001ad8:	00090513          	mv	a0,s2
    80001adc:	00005097          	auipc	ra,0x5
    80001ae0:	b50080e7          	jalr	-1200(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
        return ret;
    }

    T *peekLast()
    {
        if (!tail) { return 0; }
    80001ae4:	0104b783          	ld	a5,16(s1)
    80001ae8:	02078663          	beqz	a5,80001b14 <_ZN10SemaphoreC5closeEv+0x7c>
        return tail->data;
    80001aec:	0007b783          	ld	a5,0(a5)
    while(this->blocked.peekLast()){ //peek first?
    80001af0:	02078263          	beqz	a5,80001b14 <_ZN10SemaphoreC5closeEv+0x7c>
        if (!head) { return 0; }
    80001af4:	0084b503          	ld	a0,8(s1)
    80001af8:	00050a63          	beqz	a0,80001b0c <_ZN10SemaphoreC5closeEv+0x74>
        head = head->next;
    80001afc:	00853783          	ld	a5,8(a0)
    80001b00:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    80001b04:	fc0792e3          	bnez	a5,80001ac8 <_ZN10SemaphoreC5closeEv+0x30>
    80001b08:	fbdff06f          	j	80001ac4 <_ZN10SemaphoreC5closeEv+0x2c>
        if (!head) { return 0; }
    80001b0c:	00050913          	mv	s2,a0
    80001b10:	fc5ff06f          	j	80001ad4 <_ZN10SemaphoreC5closeEv+0x3c>
    }
    closed = true;
    80001b14:	00100793          	li	a5,1
    80001b18:	00f48223          	sb	a5,4(s1)
    return 0;
    80001b1c:	00000513          	li	a0,0

    80001b20:	01813083          	ld	ra,24(sp)
    80001b24:	01013403          	ld	s0,16(sp)
    80001b28:	00813483          	ld	s1,8(sp)
    80001b2c:	00013903          	ld	s2,0(sp)
    80001b30:	02010113          	addi	sp,sp,32
    80001b34:	00008067          	ret

0000000080001b38 <_ZN8ConsoleC7putterTEv>:
    //prvo proveri da li je spreman kontroler tako sto proveri console status register (bit 5 ovde)
    //ako jeste, salji iz bafera sve dok bafer ima nesto i bit idalje postavljen tacno
    //blokira se ako je bafer prazan
    while(1)
    {
        while( ( *((char *)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT ) )
    80001b38:	0000b797          	auipc	a5,0xb
    80001b3c:	fc07b783          	ld	a5,-64(a5) # 8000caf8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001b40:	0007b783          	ld	a5,0(a5)
    80001b44:	0007c783          	lbu	a5,0(a5)
    80001b48:	0207f793          	andi	a5,a5,32
    80001b4c:	fe0786e3          	beqz	a5,80001b38 <_ZN8ConsoleC7putterTEv>
{
    80001b50:	fe010113          	addi	sp,sp,-32
    80001b54:	00113c23          	sd	ra,24(sp)
    80001b58:	00813823          	sd	s0,16(sp)
    80001b5c:	00913423          	sd	s1,8(sp)
    80001b60:	02010413          	addi	s0,sp,32
        {
            jezgroSem->wait();
    80001b64:	0000b797          	auipc	a5,0xb
    80001b68:	0147b783          	ld	a5,20(a5) # 8000cb78 <_GLOBAL_OFFSET_TABLE_+0x90>
    80001b6c:	0007b503          	ld	a0,0(a5)
    80001b70:	00000097          	auipc	ra,0x0
    80001b74:	db4080e7          	jalr	-588(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
            mutex->wait();
    80001b78:	0000b497          	auipc	s1,0xb
    80001b7c:	fd84b483          	ld	s1,-40(s1) # 8000cb50 <_GLOBAL_OFFSET_TABLE_+0x68>
    80001b80:	0004b503          	ld	a0,0(s1)
    80001b84:	00000097          	auipc	ra,0x0
    80001b88:	da0080e7          	jalr	-608(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
            char *recieve_reg = (char*)CONSOLE_TX_DATA;
    80001b8c:	0000b797          	auipc	a5,0xb
    80001b90:	f947b783          	ld	a5,-108(a5) # 8000cb20 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001b94:	0007b603          	ld	a2,0(a5)
            *recieve_reg = outputBuffer->withdraw();
    80001b98:	0000b797          	auipc	a5,0xb
    80001b9c:	f807b783          	ld	a5,-128(a5) # 8000cb18 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001ba0:	0007b783          	ld	a5,0(a5)
    }
    ~Buffer() { mem_free(c_buffer); }

    uchar withdraw()
    {
        counter--;
    80001ba4:	0007b703          	ld	a4,0(a5)
    80001ba8:	fff70713          	addi	a4,a4,-1
    80001bac:	00e7b023          	sd	a4,0(a5)
        uchar c = c_buffer[tail];
    80001bb0:	0207b683          	ld	a3,32(a5)
    80001bb4:	0187b703          	ld	a4,24(a5)
    80001bb8:	00e686b3          	add	a3,a3,a4
    80001bbc:	0006c683          	lbu	a3,0(a3)
        tail = (tail + 1) % cap;
    80001bc0:	00170713          	addi	a4,a4,1
    80001bc4:	0087b583          	ld	a1,8(a5)
    80001bc8:	02b77733          	remu	a4,a4,a1
    80001bcc:	00e7bc23          	sd	a4,24(a5)
    80001bd0:	00d60023          	sb	a3,0(a2)
            if(recieve_reg) {} //check this later---------------------------------------------------------------------------- !
            mutex->signal();
    80001bd4:	0004b503          	ld	a0,0(s1)
    80001bd8:	00000097          	auipc	ra,0x0
    80001bdc:	e24080e7          	jalr	-476(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
            putSem->signal();
    80001be0:	0000b797          	auipc	a5,0xb
    80001be4:	f687b783          	ld	a5,-152(a5) # 8000cb48 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001be8:	0007b503          	ld	a0,0(a5)
    80001bec:	00000097          	auipc	ra,0x0
    80001bf0:	e10080e7          	jalr	-496(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
        while( ( *((char *)(CONSOLE_STATUS)) & CONSOLE_TX_STATUS_BIT ) )
    80001bf4:	0000b797          	auipc	a5,0xb
    80001bf8:	f047b783          	ld	a5,-252(a5) # 8000caf8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001bfc:	0007b783          	ld	a5,0(a5)
    80001c00:	0007c783          	lbu	a5,0(a5)
    80001c04:	0207f793          	andi	a5,a5,32
    80001c08:	fe0786e3          	beqz	a5,80001bf4 <_ZN8ConsoleC7putterTEv+0xbc>
    80001c0c:	f59ff06f          	j	80001b64 <_ZN8ConsoleC7putterTEv+0x2c>

0000000080001c10 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001c10:	fe010113          	addi	sp,sp,-32
    80001c14:	00113c23          	sd	ra,24(sp)
    80001c18:	00813823          	sd	s0,16(sp)
    80001c1c:	00913423          	sd	s1,8(sp)
    80001c20:	01213023          	sd	s2,0(sp)
    80001c24:	02010413          	addi	s0,sp,32
    80001c28:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001c2c:	00100793          	li	a5,1
    80001c30:	02a7f863          	bgeu	a5,a0,80001c60 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001c34:	00a00793          	li	a5,10
    80001c38:	02f577b3          	remu	a5,a0,a5
    80001c3c:	02078e63          	beqz	a5,80001c78 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001c40:	fff48513          	addi	a0,s1,-1
    80001c44:	00000097          	auipc	ra,0x0
    80001c48:	fcc080e7          	jalr	-52(ra) # 80001c10 <_ZL9fibonaccim>
    80001c4c:	00050913          	mv	s2,a0
    80001c50:	ffe48513          	addi	a0,s1,-2
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	fbc080e7          	jalr	-68(ra) # 80001c10 <_ZL9fibonaccim>
    80001c5c:	00a90533          	add	a0,s2,a0
}
    80001c60:	01813083          	ld	ra,24(sp)
    80001c64:	01013403          	ld	s0,16(sp)
    80001c68:	00813483          	ld	s1,8(sp)
    80001c6c:	00013903          	ld	s2,0(sp)
    80001c70:	02010113          	addi	sp,sp,32
    80001c74:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	614080e7          	jalr	1556(ra) # 8000128c <_Z15thread_dispatchv>
    80001c80:	fc1ff06f          	j	80001c40 <_ZL9fibonaccim+0x30>

0000000080001c84 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80001c84:	fe010113          	addi	sp,sp,-32
    80001c88:	00113c23          	sd	ra,24(sp)
    80001c8c:	00813823          	sd	s0,16(sp)
    80001c90:	00913423          	sd	s1,8(sp)
    80001c94:	01213023          	sd	s2,0(sp)
    80001c98:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001c9c:	00000913          	li	s2,0
    80001ca0:	0380006f          	j	80001cd8 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001ca4:	fffff097          	auipc	ra,0xfffff
    80001ca8:	5e8080e7          	jalr	1512(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001cac:	00148493          	addi	s1,s1,1
    80001cb0:	000027b7          	lui	a5,0x2
    80001cb4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001cb8:	0097ee63          	bltu	a5,s1,80001cd4 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001cbc:	00000713          	li	a4,0
    80001cc0:	000077b7          	lui	a5,0x7
    80001cc4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001cc8:	fce7eee3          	bltu	a5,a4,80001ca4 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80001ccc:	00170713          	addi	a4,a4,1
    80001cd0:	ff1ff06f          	j	80001cc0 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001cd4:	00190913          	addi	s2,s2,1
    80001cd8:	00900793          	li	a5,9
    80001cdc:	0527e063          	bltu	a5,s2,80001d1c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001ce0:	00008517          	auipc	a0,0x8
    80001ce4:	44050513          	addi	a0,a0,1088 # 8000a120 <CONSOLE_STATUS+0x110>
    80001ce8:	00002097          	auipc	ra,0x2
    80001cec:	eac080e7          	jalr	-340(ra) # 80003b94 <_Z11printStringPKc>
    80001cf0:	00000613          	li	a2,0
    80001cf4:	00a00593          	li	a1,10
    80001cf8:	0009051b          	sext.w	a0,s2
    80001cfc:	00002097          	auipc	ra,0x2
    80001d00:	048080e7          	jalr	72(ra) # 80003d44 <_Z8printIntiii>
    80001d04:	00008517          	auipc	a0,0x8
    80001d08:	67c50513          	addi	a0,a0,1660 # 8000a380 <CONSOLE_STATUS+0x370>
    80001d0c:	00002097          	auipc	ra,0x2
    80001d10:	e88080e7          	jalr	-376(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001d14:	00000493          	li	s1,0
    80001d18:	f99ff06f          	j	80001cb0 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001d1c:	00008517          	auipc	a0,0x8
    80001d20:	40c50513          	addi	a0,a0,1036 # 8000a128 <CONSOLE_STATUS+0x118>
    80001d24:	00002097          	auipc	ra,0x2
    80001d28:	e70080e7          	jalr	-400(ra) # 80003b94 <_Z11printStringPKc>
    finishedA = true;
    80001d2c:	00100793          	li	a5,1
    80001d30:	0000b717          	auipc	a4,0xb
    80001d34:	ecf70023          	sb	a5,-320(a4) # 8000cbf0 <_ZL9finishedA>
}
    80001d38:	01813083          	ld	ra,24(sp)
    80001d3c:	01013403          	ld	s0,16(sp)
    80001d40:	00813483          	ld	s1,8(sp)
    80001d44:	00013903          	ld	s2,0(sp)
    80001d48:	02010113          	addi	sp,sp,32
    80001d4c:	00008067          	ret

0000000080001d50 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001d50:	fe010113          	addi	sp,sp,-32
    80001d54:	00113c23          	sd	ra,24(sp)
    80001d58:	00813823          	sd	s0,16(sp)
    80001d5c:	00913423          	sd	s1,8(sp)
    80001d60:	01213023          	sd	s2,0(sp)
    80001d64:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001d68:	00000913          	li	s2,0
    80001d6c:	0380006f          	j	80001da4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001d70:	fffff097          	auipc	ra,0xfffff
    80001d74:	51c080e7          	jalr	1308(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001d78:	00148493          	addi	s1,s1,1
    80001d7c:	000027b7          	lui	a5,0x2
    80001d80:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001d84:	0097ee63          	bltu	a5,s1,80001da0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001d88:	00000713          	li	a4,0
    80001d8c:	000077b7          	lui	a5,0x7
    80001d90:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001d94:	fce7eee3          	bltu	a5,a4,80001d70 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80001d98:	00170713          	addi	a4,a4,1
    80001d9c:	ff1ff06f          	j	80001d8c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001da0:	00190913          	addi	s2,s2,1
    80001da4:	00f00793          	li	a5,15
    80001da8:	0527e063          	bltu	a5,s2,80001de8 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001dac:	00008517          	auipc	a0,0x8
    80001db0:	38c50513          	addi	a0,a0,908 # 8000a138 <CONSOLE_STATUS+0x128>
    80001db4:	00002097          	auipc	ra,0x2
    80001db8:	de0080e7          	jalr	-544(ra) # 80003b94 <_Z11printStringPKc>
    80001dbc:	00000613          	li	a2,0
    80001dc0:	00a00593          	li	a1,10
    80001dc4:	0009051b          	sext.w	a0,s2
    80001dc8:	00002097          	auipc	ra,0x2
    80001dcc:	f7c080e7          	jalr	-132(ra) # 80003d44 <_Z8printIntiii>
    80001dd0:	00008517          	auipc	a0,0x8
    80001dd4:	5b050513          	addi	a0,a0,1456 # 8000a380 <CONSOLE_STATUS+0x370>
    80001dd8:	00002097          	auipc	ra,0x2
    80001ddc:	dbc080e7          	jalr	-580(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001de0:	00000493          	li	s1,0
    80001de4:	f99ff06f          	j	80001d7c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001de8:	00008517          	auipc	a0,0x8
    80001dec:	35850513          	addi	a0,a0,856 # 8000a140 <CONSOLE_STATUS+0x130>
    80001df0:	00002097          	auipc	ra,0x2
    80001df4:	da4080e7          	jalr	-604(ra) # 80003b94 <_Z11printStringPKc>
    finishedB = true;
    80001df8:	00100793          	li	a5,1
    80001dfc:	0000b717          	auipc	a4,0xb
    80001e00:	def70aa3          	sb	a5,-523(a4) # 8000cbf1 <_ZL9finishedB>
    thread_dispatch();
    80001e04:	fffff097          	auipc	ra,0xfffff
    80001e08:	488080e7          	jalr	1160(ra) # 8000128c <_Z15thread_dispatchv>
}
    80001e0c:	01813083          	ld	ra,24(sp)
    80001e10:	01013403          	ld	s0,16(sp)
    80001e14:	00813483          	ld	s1,8(sp)
    80001e18:	00013903          	ld	s2,0(sp)
    80001e1c:	02010113          	addi	sp,sp,32
    80001e20:	00008067          	ret

0000000080001e24 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80001e24:	fe010113          	addi	sp,sp,-32
    80001e28:	00113c23          	sd	ra,24(sp)
    80001e2c:	00813823          	sd	s0,16(sp)
    80001e30:	00913423          	sd	s1,8(sp)
    80001e34:	01213023          	sd	s2,0(sp)
    80001e38:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001e3c:	00000493          	li	s1,0
    80001e40:	0400006f          	j	80001e80 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001e44:	00008517          	auipc	a0,0x8
    80001e48:	30c50513          	addi	a0,a0,780 # 8000a150 <CONSOLE_STATUS+0x140>
    80001e4c:	00002097          	auipc	ra,0x2
    80001e50:	d48080e7          	jalr	-696(ra) # 80003b94 <_Z11printStringPKc>
    80001e54:	00000613          	li	a2,0
    80001e58:	00a00593          	li	a1,10
    80001e5c:	00048513          	mv	a0,s1
    80001e60:	00002097          	auipc	ra,0x2
    80001e64:	ee4080e7          	jalr	-284(ra) # 80003d44 <_Z8printIntiii>
    80001e68:	00008517          	auipc	a0,0x8
    80001e6c:	51850513          	addi	a0,a0,1304 # 8000a380 <CONSOLE_STATUS+0x370>
    80001e70:	00002097          	auipc	ra,0x2
    80001e74:	d24080e7          	jalr	-732(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001e78:	0014849b          	addiw	s1,s1,1
    80001e7c:	0ff4f493          	andi	s1,s1,255
    80001e80:	00200793          	li	a5,2
    80001e84:	fc97f0e3          	bgeu	a5,s1,80001e44 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001e88:	00008517          	auipc	a0,0x8
    80001e8c:	2d050513          	addi	a0,a0,720 # 8000a158 <CONSOLE_STATUS+0x148>
    80001e90:	00002097          	auipc	ra,0x2
    80001e94:	d04080e7          	jalr	-764(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001e98:	00700313          	li	t1,7
    thread_dispatch();
    80001e9c:	fffff097          	auipc	ra,0xfffff
    80001ea0:	3f0080e7          	jalr	1008(ra) # 8000128c <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001ea4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80001ea8:	00008517          	auipc	a0,0x8
    80001eac:	2c050513          	addi	a0,a0,704 # 8000a168 <CONSOLE_STATUS+0x158>
    80001eb0:	00002097          	auipc	ra,0x2
    80001eb4:	ce4080e7          	jalr	-796(ra) # 80003b94 <_Z11printStringPKc>
    80001eb8:	00000613          	li	a2,0
    80001ebc:	00a00593          	li	a1,10
    80001ec0:	0009051b          	sext.w	a0,s2
    80001ec4:	00002097          	auipc	ra,0x2
    80001ec8:	e80080e7          	jalr	-384(ra) # 80003d44 <_Z8printIntiii>
    80001ecc:	00008517          	auipc	a0,0x8
    80001ed0:	4b450513          	addi	a0,a0,1204 # 8000a380 <CONSOLE_STATUS+0x370>
    80001ed4:	00002097          	auipc	ra,0x2
    80001ed8:	cc0080e7          	jalr	-832(ra) # 80003b94 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001edc:	00c00513          	li	a0,12
    80001ee0:	00000097          	auipc	ra,0x0
    80001ee4:	d30080e7          	jalr	-720(ra) # 80001c10 <_ZL9fibonaccim>
    80001ee8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001eec:	00008517          	auipc	a0,0x8
    80001ef0:	28450513          	addi	a0,a0,644 # 8000a170 <CONSOLE_STATUS+0x160>
    80001ef4:	00002097          	auipc	ra,0x2
    80001ef8:	ca0080e7          	jalr	-864(ra) # 80003b94 <_Z11printStringPKc>
    80001efc:	00000613          	li	a2,0
    80001f00:	00a00593          	li	a1,10
    80001f04:	0009051b          	sext.w	a0,s2
    80001f08:	00002097          	auipc	ra,0x2
    80001f0c:	e3c080e7          	jalr	-452(ra) # 80003d44 <_Z8printIntiii>
    80001f10:	00008517          	auipc	a0,0x8
    80001f14:	47050513          	addi	a0,a0,1136 # 8000a380 <CONSOLE_STATUS+0x370>
    80001f18:	00002097          	auipc	ra,0x2
    80001f1c:	c7c080e7          	jalr	-900(ra) # 80003b94 <_Z11printStringPKc>
    80001f20:	0400006f          	j	80001f60 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001f24:	00008517          	auipc	a0,0x8
    80001f28:	22c50513          	addi	a0,a0,556 # 8000a150 <CONSOLE_STATUS+0x140>
    80001f2c:	00002097          	auipc	ra,0x2
    80001f30:	c68080e7          	jalr	-920(ra) # 80003b94 <_Z11printStringPKc>
    80001f34:	00000613          	li	a2,0
    80001f38:	00a00593          	li	a1,10
    80001f3c:	00048513          	mv	a0,s1
    80001f40:	00002097          	auipc	ra,0x2
    80001f44:	e04080e7          	jalr	-508(ra) # 80003d44 <_Z8printIntiii>
    80001f48:	00008517          	auipc	a0,0x8
    80001f4c:	43850513          	addi	a0,a0,1080 # 8000a380 <CONSOLE_STATUS+0x370>
    80001f50:	00002097          	auipc	ra,0x2
    80001f54:	c44080e7          	jalr	-956(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001f58:	0014849b          	addiw	s1,s1,1
    80001f5c:	0ff4f493          	andi	s1,s1,255
    80001f60:	00500793          	li	a5,5
    80001f64:	fc97f0e3          	bgeu	a5,s1,80001f24 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    80001f68:	00008517          	auipc	a0,0x8
    80001f6c:	21850513          	addi	a0,a0,536 # 8000a180 <CONSOLE_STATUS+0x170>
    80001f70:	00002097          	auipc	ra,0x2
    80001f74:	c24080e7          	jalr	-988(ra) # 80003b94 <_Z11printStringPKc>
    finishedC = true;
    80001f78:	00100793          	li	a5,1
    80001f7c:	0000b717          	auipc	a4,0xb
    80001f80:	c6f70b23          	sb	a5,-906(a4) # 8000cbf2 <_ZL9finishedC>
    thread_dispatch();
    80001f84:	fffff097          	auipc	ra,0xfffff
    80001f88:	308080e7          	jalr	776(ra) # 8000128c <_Z15thread_dispatchv>
}
    80001f8c:	01813083          	ld	ra,24(sp)
    80001f90:	01013403          	ld	s0,16(sp)
    80001f94:	00813483          	ld	s1,8(sp)
    80001f98:	00013903          	ld	s2,0(sp)
    80001f9c:	02010113          	addi	sp,sp,32
    80001fa0:	00008067          	ret

0000000080001fa4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80001fa4:	fe010113          	addi	sp,sp,-32
    80001fa8:	00113c23          	sd	ra,24(sp)
    80001fac:	00813823          	sd	s0,16(sp)
    80001fb0:	00913423          	sd	s1,8(sp)
    80001fb4:	01213023          	sd	s2,0(sp)
    80001fb8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001fbc:	00a00493          	li	s1,10
    80001fc0:	0400006f          	j	80002000 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001fc4:	00008517          	auipc	a0,0x8
    80001fc8:	1cc50513          	addi	a0,a0,460 # 8000a190 <CONSOLE_STATUS+0x180>
    80001fcc:	00002097          	auipc	ra,0x2
    80001fd0:	bc8080e7          	jalr	-1080(ra) # 80003b94 <_Z11printStringPKc>
    80001fd4:	00000613          	li	a2,0
    80001fd8:	00a00593          	li	a1,10
    80001fdc:	00048513          	mv	a0,s1
    80001fe0:	00002097          	auipc	ra,0x2
    80001fe4:	d64080e7          	jalr	-668(ra) # 80003d44 <_Z8printIntiii>
    80001fe8:	00008517          	auipc	a0,0x8
    80001fec:	39850513          	addi	a0,a0,920 # 8000a380 <CONSOLE_STATUS+0x370>
    80001ff0:	00002097          	auipc	ra,0x2
    80001ff4:	ba4080e7          	jalr	-1116(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001ff8:	0014849b          	addiw	s1,s1,1
    80001ffc:	0ff4f493          	andi	s1,s1,255
    80002000:	00c00793          	li	a5,12
    80002004:	fc97f0e3          	bgeu	a5,s1,80001fc4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002008:	00008517          	auipc	a0,0x8
    8000200c:	19050513          	addi	a0,a0,400 # 8000a198 <CONSOLE_STATUS+0x188>
    80002010:	00002097          	auipc	ra,0x2
    80002014:	b84080e7          	jalr	-1148(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002018:	00500313          	li	t1,5
    thread_dispatch();
    8000201c:	fffff097          	auipc	ra,0xfffff
    80002020:	270080e7          	jalr	624(ra) # 8000128c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002024:	01000513          	li	a0,16
    80002028:	00000097          	auipc	ra,0x0
    8000202c:	be8080e7          	jalr	-1048(ra) # 80001c10 <_ZL9fibonaccim>
    80002030:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002034:	00008517          	auipc	a0,0x8
    80002038:	17450513          	addi	a0,a0,372 # 8000a1a8 <CONSOLE_STATUS+0x198>
    8000203c:	00002097          	auipc	ra,0x2
    80002040:	b58080e7          	jalr	-1192(ra) # 80003b94 <_Z11printStringPKc>
    80002044:	00000613          	li	a2,0
    80002048:	00a00593          	li	a1,10
    8000204c:	0009051b          	sext.w	a0,s2
    80002050:	00002097          	auipc	ra,0x2
    80002054:	cf4080e7          	jalr	-780(ra) # 80003d44 <_Z8printIntiii>
    80002058:	00008517          	auipc	a0,0x8
    8000205c:	32850513          	addi	a0,a0,808 # 8000a380 <CONSOLE_STATUS+0x370>
    80002060:	00002097          	auipc	ra,0x2
    80002064:	b34080e7          	jalr	-1228(ra) # 80003b94 <_Z11printStringPKc>
    80002068:	0400006f          	j	800020a8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000206c:	00008517          	auipc	a0,0x8
    80002070:	12450513          	addi	a0,a0,292 # 8000a190 <CONSOLE_STATUS+0x180>
    80002074:	00002097          	auipc	ra,0x2
    80002078:	b20080e7          	jalr	-1248(ra) # 80003b94 <_Z11printStringPKc>
    8000207c:	00000613          	li	a2,0
    80002080:	00a00593          	li	a1,10
    80002084:	00048513          	mv	a0,s1
    80002088:	00002097          	auipc	ra,0x2
    8000208c:	cbc080e7          	jalr	-836(ra) # 80003d44 <_Z8printIntiii>
    80002090:	00008517          	auipc	a0,0x8
    80002094:	2f050513          	addi	a0,a0,752 # 8000a380 <CONSOLE_STATUS+0x370>
    80002098:	00002097          	auipc	ra,0x2
    8000209c:	afc080e7          	jalr	-1284(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800020a0:	0014849b          	addiw	s1,s1,1
    800020a4:	0ff4f493          	andi	s1,s1,255
    800020a8:	00f00793          	li	a5,15
    800020ac:	fc97f0e3          	bgeu	a5,s1,8000206c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800020b0:	00008517          	auipc	a0,0x8
    800020b4:	10850513          	addi	a0,a0,264 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    800020b8:	00002097          	auipc	ra,0x2
    800020bc:	adc080e7          	jalr	-1316(ra) # 80003b94 <_Z11printStringPKc>
    finishedD = true;
    800020c0:	00100793          	li	a5,1
    800020c4:	0000b717          	auipc	a4,0xb
    800020c8:	b2f707a3          	sb	a5,-1233(a4) # 8000cbf3 <_ZL9finishedD>
    thread_dispatch();
    800020cc:	fffff097          	auipc	ra,0xfffff
    800020d0:	1c0080e7          	jalr	448(ra) # 8000128c <_Z15thread_dispatchv>
}
    800020d4:	01813083          	ld	ra,24(sp)
    800020d8:	01013403          	ld	s0,16(sp)
    800020dc:	00813483          	ld	s1,8(sp)
    800020e0:	00013903          	ld	s2,0(sp)
    800020e4:	02010113          	addi	sp,sp,32
    800020e8:	00008067          	ret

00000000800020ec <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800020ec:	fc010113          	addi	sp,sp,-64
    800020f0:	02113c23          	sd	ra,56(sp)
    800020f4:	02813823          	sd	s0,48(sp)
    800020f8:	02913423          	sd	s1,40(sp)
    800020fc:	03213023          	sd	s2,32(sp)
    80002100:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002104:	02000513          	li	a0,32
    80002108:	00003097          	auipc	ra,0x3
    8000210c:	cc4080e7          	jalr	-828(ra) # 80004dcc <_Znwm>
    80002110:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002114:	00003097          	auipc	ra,0x3
    80002118:	ec4080e7          	jalr	-316(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    8000211c:	0000a797          	auipc	a5,0xa
    80002120:	7bc78793          	addi	a5,a5,1980 # 8000c8d8 <_ZTV7WorkerA+0x10>
    80002124:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80002128:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    8000212c:	00008517          	auipc	a0,0x8
    80002130:	09c50513          	addi	a0,a0,156 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80002134:	00002097          	auipc	ra,0x2
    80002138:	a60080e7          	jalr	-1440(ra) # 80003b94 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    8000213c:	02000513          	li	a0,32
    80002140:	00003097          	auipc	ra,0x3
    80002144:	c8c080e7          	jalr	-884(ra) # 80004dcc <_Znwm>
    80002148:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    8000214c:	00003097          	auipc	ra,0x3
    80002150:	e8c080e7          	jalr	-372(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    80002154:	0000a797          	auipc	a5,0xa
    80002158:	7ac78793          	addi	a5,a5,1964 # 8000c900 <_ZTV7WorkerB+0x10>
    8000215c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002160:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002164:	00008517          	auipc	a0,0x8
    80002168:	07c50513          	addi	a0,a0,124 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    8000216c:	00002097          	auipc	ra,0x2
    80002170:	a28080e7          	jalr	-1496(ra) # 80003b94 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002174:	02000513          	li	a0,32
    80002178:	00003097          	auipc	ra,0x3
    8000217c:	c54080e7          	jalr	-940(ra) # 80004dcc <_Znwm>
    80002180:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002184:	00003097          	auipc	ra,0x3
    80002188:	e54080e7          	jalr	-428(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    8000218c:	0000a797          	auipc	a5,0xa
    80002190:	79c78793          	addi	a5,a5,1948 # 8000c928 <_ZTV7WorkerC+0x10>
    80002194:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002198:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    8000219c:	00008517          	auipc	a0,0x8
    800021a0:	05c50513          	addi	a0,a0,92 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    800021a4:	00002097          	auipc	ra,0x2
    800021a8:	9f0080e7          	jalr	-1552(ra) # 80003b94 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    800021ac:	02000513          	li	a0,32
    800021b0:	00003097          	auipc	ra,0x3
    800021b4:	c1c080e7          	jalr	-996(ra) # 80004dcc <_Znwm>
    800021b8:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    800021bc:	00003097          	auipc	ra,0x3
    800021c0:	e1c080e7          	jalr	-484(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    800021c4:	0000a797          	auipc	a5,0xa
    800021c8:	78c78793          	addi	a5,a5,1932 # 8000c950 <_ZTV7WorkerD+0x10>
    800021cc:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    800021d0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    800021d4:	00008517          	auipc	a0,0x8
    800021d8:	03c50513          	addi	a0,a0,60 # 8000a210 <CONSOLE_STATUS+0x200>
    800021dc:	00002097          	auipc	ra,0x2
    800021e0:	9b8080e7          	jalr	-1608(ra) # 80003b94 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800021e4:	00000493          	li	s1,0
    800021e8:	00300793          	li	a5,3
    800021ec:	0297c663          	blt	a5,s1,80002218 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    800021f0:	00349793          	slli	a5,s1,0x3
    800021f4:	fe040713          	addi	a4,s0,-32
    800021f8:	00f707b3          	add	a5,a4,a5
    800021fc:	fe07b503          	ld	a0,-32(a5)
    80002200:	00003097          	auipc	ra,0x3
    80002204:	d18080e7          	jalr	-744(ra) # 80004f18 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002208:	0014849b          	addiw	s1,s1,1
    8000220c:	fddff06f          	j	800021e8 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002210:	00003097          	auipc	ra,0x3
    80002214:	d78080e7          	jalr	-648(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002218:	0000b797          	auipc	a5,0xb
    8000221c:	9d87c783          	lbu	a5,-1576(a5) # 8000cbf0 <_ZL9finishedA>
    80002220:	fe0788e3          	beqz	a5,80002210 <_Z20Threads_CPP_API_testv+0x124>
    80002224:	0000b797          	auipc	a5,0xb
    80002228:	9cd7c783          	lbu	a5,-1587(a5) # 8000cbf1 <_ZL9finishedB>
    8000222c:	fe0782e3          	beqz	a5,80002210 <_Z20Threads_CPP_API_testv+0x124>
    80002230:	0000b797          	auipc	a5,0xb
    80002234:	9c27c783          	lbu	a5,-1598(a5) # 8000cbf2 <_ZL9finishedC>
    80002238:	fc078ce3          	beqz	a5,80002210 <_Z20Threads_CPP_API_testv+0x124>
    8000223c:	0000b797          	auipc	a5,0xb
    80002240:	9b77c783          	lbu	a5,-1609(a5) # 8000cbf3 <_ZL9finishedD>
    80002244:	fc0786e3          	beqz	a5,80002210 <_Z20Threads_CPP_API_testv+0x124>
    80002248:	fc040493          	addi	s1,s0,-64
    8000224c:	0080006f          	j	80002254 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002250:	00848493          	addi	s1,s1,8
    80002254:	fe040793          	addi	a5,s0,-32
    80002258:	08f48663          	beq	s1,a5,800022e4 <_Z20Threads_CPP_API_testv+0x1f8>
    8000225c:	0004b503          	ld	a0,0(s1)
    80002260:	fe0508e3          	beqz	a0,80002250 <_Z20Threads_CPP_API_testv+0x164>
    80002264:	00053783          	ld	a5,0(a0)
    80002268:	0087b783          	ld	a5,8(a5)
    8000226c:	000780e7          	jalr	a5
    80002270:	fe1ff06f          	j	80002250 <_Z20Threads_CPP_API_testv+0x164>
    80002274:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002278:	00048513          	mv	a0,s1
    8000227c:	00003097          	auipc	ra,0x3
    80002280:	ba0080e7          	jalr	-1120(ra) # 80004e1c <_ZdlPv>
    80002284:	00090513          	mv	a0,s2
    80002288:	0000c097          	auipc	ra,0xc
    8000228c:	b00080e7          	jalr	-1280(ra) # 8000dd88 <_Unwind_Resume>
    80002290:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002294:	00048513          	mv	a0,s1
    80002298:	00003097          	auipc	ra,0x3
    8000229c:	b84080e7          	jalr	-1148(ra) # 80004e1c <_ZdlPv>
    800022a0:	00090513          	mv	a0,s2
    800022a4:	0000c097          	auipc	ra,0xc
    800022a8:	ae4080e7          	jalr	-1308(ra) # 8000dd88 <_Unwind_Resume>
    800022ac:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    800022b0:	00048513          	mv	a0,s1
    800022b4:	00003097          	auipc	ra,0x3
    800022b8:	b68080e7          	jalr	-1176(ra) # 80004e1c <_ZdlPv>
    800022bc:	00090513          	mv	a0,s2
    800022c0:	0000c097          	auipc	ra,0xc
    800022c4:	ac8080e7          	jalr	-1336(ra) # 8000dd88 <_Unwind_Resume>
    800022c8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    800022cc:	00048513          	mv	a0,s1
    800022d0:	00003097          	auipc	ra,0x3
    800022d4:	b4c080e7          	jalr	-1204(ra) # 80004e1c <_ZdlPv>
    800022d8:	00090513          	mv	a0,s2
    800022dc:	0000c097          	auipc	ra,0xc
    800022e0:	aac080e7          	jalr	-1364(ra) # 8000dd88 <_Unwind_Resume>
    //printString("End of CPP");
}
    800022e4:	03813083          	ld	ra,56(sp)
    800022e8:	03013403          	ld	s0,48(sp)
    800022ec:	02813483          	ld	s1,40(sp)
    800022f0:	02013903          	ld	s2,32(sp)
    800022f4:	04010113          	addi	sp,sp,64
    800022f8:	00008067          	ret

00000000800022fc <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800022fc:	ff010113          	addi	sp,sp,-16
    80002300:	00113423          	sd	ra,8(sp)
    80002304:	00813023          	sd	s0,0(sp)
    80002308:	01010413          	addi	s0,sp,16
    8000230c:	0000a797          	auipc	a5,0xa
    80002310:	5cc78793          	addi	a5,a5,1484 # 8000c8d8 <_ZTV7WorkerA+0x10>
    80002314:	00f53023          	sd	a5,0(a0)
    80002318:	00003097          	auipc	ra,0x3
    8000231c:	a24080e7          	jalr	-1500(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002320:	00813083          	ld	ra,8(sp)
    80002324:	00013403          	ld	s0,0(sp)
    80002328:	01010113          	addi	sp,sp,16
    8000232c:	00008067          	ret

0000000080002330 <_ZN7WorkerAD0Ev>:
    80002330:	fe010113          	addi	sp,sp,-32
    80002334:	00113c23          	sd	ra,24(sp)
    80002338:	00813823          	sd	s0,16(sp)
    8000233c:	00913423          	sd	s1,8(sp)
    80002340:	02010413          	addi	s0,sp,32
    80002344:	00050493          	mv	s1,a0
    80002348:	0000a797          	auipc	a5,0xa
    8000234c:	59078793          	addi	a5,a5,1424 # 8000c8d8 <_ZTV7WorkerA+0x10>
    80002350:	00f53023          	sd	a5,0(a0)
    80002354:	00003097          	auipc	ra,0x3
    80002358:	9e8080e7          	jalr	-1560(ra) # 80004d3c <_ZN6ThreadD1Ev>
    8000235c:	00048513          	mv	a0,s1
    80002360:	00003097          	auipc	ra,0x3
    80002364:	abc080e7          	jalr	-1348(ra) # 80004e1c <_ZdlPv>
    80002368:	01813083          	ld	ra,24(sp)
    8000236c:	01013403          	ld	s0,16(sp)
    80002370:	00813483          	ld	s1,8(sp)
    80002374:	02010113          	addi	sp,sp,32
    80002378:	00008067          	ret

000000008000237c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    8000237c:	ff010113          	addi	sp,sp,-16
    80002380:	00113423          	sd	ra,8(sp)
    80002384:	00813023          	sd	s0,0(sp)
    80002388:	01010413          	addi	s0,sp,16
    8000238c:	0000a797          	auipc	a5,0xa
    80002390:	57478793          	addi	a5,a5,1396 # 8000c900 <_ZTV7WorkerB+0x10>
    80002394:	00f53023          	sd	a5,0(a0)
    80002398:	00003097          	auipc	ra,0x3
    8000239c:	9a4080e7          	jalr	-1628(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800023a0:	00813083          	ld	ra,8(sp)
    800023a4:	00013403          	ld	s0,0(sp)
    800023a8:	01010113          	addi	sp,sp,16
    800023ac:	00008067          	ret

00000000800023b0 <_ZN7WorkerBD0Ev>:
    800023b0:	fe010113          	addi	sp,sp,-32
    800023b4:	00113c23          	sd	ra,24(sp)
    800023b8:	00813823          	sd	s0,16(sp)
    800023bc:	00913423          	sd	s1,8(sp)
    800023c0:	02010413          	addi	s0,sp,32
    800023c4:	00050493          	mv	s1,a0
    800023c8:	0000a797          	auipc	a5,0xa
    800023cc:	53878793          	addi	a5,a5,1336 # 8000c900 <_ZTV7WorkerB+0x10>
    800023d0:	00f53023          	sd	a5,0(a0)
    800023d4:	00003097          	auipc	ra,0x3
    800023d8:	968080e7          	jalr	-1688(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800023dc:	00048513          	mv	a0,s1
    800023e0:	00003097          	auipc	ra,0x3
    800023e4:	a3c080e7          	jalr	-1476(ra) # 80004e1c <_ZdlPv>
    800023e8:	01813083          	ld	ra,24(sp)
    800023ec:	01013403          	ld	s0,16(sp)
    800023f0:	00813483          	ld	s1,8(sp)
    800023f4:	02010113          	addi	sp,sp,32
    800023f8:	00008067          	ret

00000000800023fc <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800023fc:	ff010113          	addi	sp,sp,-16
    80002400:	00113423          	sd	ra,8(sp)
    80002404:	00813023          	sd	s0,0(sp)
    80002408:	01010413          	addi	s0,sp,16
    8000240c:	0000a797          	auipc	a5,0xa
    80002410:	51c78793          	addi	a5,a5,1308 # 8000c928 <_ZTV7WorkerC+0x10>
    80002414:	00f53023          	sd	a5,0(a0)
    80002418:	00003097          	auipc	ra,0x3
    8000241c:	924080e7          	jalr	-1756(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002420:	00813083          	ld	ra,8(sp)
    80002424:	00013403          	ld	s0,0(sp)
    80002428:	01010113          	addi	sp,sp,16
    8000242c:	00008067          	ret

0000000080002430 <_ZN7WorkerCD0Ev>:
    80002430:	fe010113          	addi	sp,sp,-32
    80002434:	00113c23          	sd	ra,24(sp)
    80002438:	00813823          	sd	s0,16(sp)
    8000243c:	00913423          	sd	s1,8(sp)
    80002440:	02010413          	addi	s0,sp,32
    80002444:	00050493          	mv	s1,a0
    80002448:	0000a797          	auipc	a5,0xa
    8000244c:	4e078793          	addi	a5,a5,1248 # 8000c928 <_ZTV7WorkerC+0x10>
    80002450:	00f53023          	sd	a5,0(a0)
    80002454:	00003097          	auipc	ra,0x3
    80002458:	8e8080e7          	jalr	-1816(ra) # 80004d3c <_ZN6ThreadD1Ev>
    8000245c:	00048513          	mv	a0,s1
    80002460:	00003097          	auipc	ra,0x3
    80002464:	9bc080e7          	jalr	-1604(ra) # 80004e1c <_ZdlPv>
    80002468:	01813083          	ld	ra,24(sp)
    8000246c:	01013403          	ld	s0,16(sp)
    80002470:	00813483          	ld	s1,8(sp)
    80002474:	02010113          	addi	sp,sp,32
    80002478:	00008067          	ret

000000008000247c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    8000247c:	ff010113          	addi	sp,sp,-16
    80002480:	00113423          	sd	ra,8(sp)
    80002484:	00813023          	sd	s0,0(sp)
    80002488:	01010413          	addi	s0,sp,16
    8000248c:	0000a797          	auipc	a5,0xa
    80002490:	4c478793          	addi	a5,a5,1220 # 8000c950 <_ZTV7WorkerD+0x10>
    80002494:	00f53023          	sd	a5,0(a0)
    80002498:	00003097          	auipc	ra,0x3
    8000249c:	8a4080e7          	jalr	-1884(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800024a0:	00813083          	ld	ra,8(sp)
    800024a4:	00013403          	ld	s0,0(sp)
    800024a8:	01010113          	addi	sp,sp,16
    800024ac:	00008067          	ret

00000000800024b0 <_ZN7WorkerDD0Ev>:
    800024b0:	fe010113          	addi	sp,sp,-32
    800024b4:	00113c23          	sd	ra,24(sp)
    800024b8:	00813823          	sd	s0,16(sp)
    800024bc:	00913423          	sd	s1,8(sp)
    800024c0:	02010413          	addi	s0,sp,32
    800024c4:	00050493          	mv	s1,a0
    800024c8:	0000a797          	auipc	a5,0xa
    800024cc:	48878793          	addi	a5,a5,1160 # 8000c950 <_ZTV7WorkerD+0x10>
    800024d0:	00f53023          	sd	a5,0(a0)
    800024d4:	00003097          	auipc	ra,0x3
    800024d8:	868080e7          	jalr	-1944(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800024dc:	00048513          	mv	a0,s1
    800024e0:	00003097          	auipc	ra,0x3
    800024e4:	93c080e7          	jalr	-1732(ra) # 80004e1c <_ZdlPv>
    800024e8:	01813083          	ld	ra,24(sp)
    800024ec:	01013403          	ld	s0,16(sp)
    800024f0:	00813483          	ld	s1,8(sp)
    800024f4:	02010113          	addi	sp,sp,32
    800024f8:	00008067          	ret

00000000800024fc <_ZN7WorkerA3runEv>:
    void run() override {
    800024fc:	ff010113          	addi	sp,sp,-16
    80002500:	00113423          	sd	ra,8(sp)
    80002504:	00813023          	sd	s0,0(sp)
    80002508:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    8000250c:	00000593          	li	a1,0
    80002510:	fffff097          	auipc	ra,0xfffff
    80002514:	774080e7          	jalr	1908(ra) # 80001c84 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002518:	00813083          	ld	ra,8(sp)
    8000251c:	00013403          	ld	s0,0(sp)
    80002520:	01010113          	addi	sp,sp,16
    80002524:	00008067          	ret

0000000080002528 <_ZN7WorkerB3runEv>:
    void run() override {
    80002528:	ff010113          	addi	sp,sp,-16
    8000252c:	00113423          	sd	ra,8(sp)
    80002530:	00813023          	sd	s0,0(sp)
    80002534:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002538:	00000593          	li	a1,0
    8000253c:	00000097          	auipc	ra,0x0
    80002540:	814080e7          	jalr	-2028(ra) # 80001d50 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002544:	00813083          	ld	ra,8(sp)
    80002548:	00013403          	ld	s0,0(sp)
    8000254c:	01010113          	addi	sp,sp,16
    80002550:	00008067          	ret

0000000080002554 <_ZN7WorkerC3runEv>:
    void run() override {
    80002554:	ff010113          	addi	sp,sp,-16
    80002558:	00113423          	sd	ra,8(sp)
    8000255c:	00813023          	sd	s0,0(sp)
    80002560:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002564:	00000593          	li	a1,0
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	8bc080e7          	jalr	-1860(ra) # 80001e24 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002570:	00813083          	ld	ra,8(sp)
    80002574:	00013403          	ld	s0,0(sp)
    80002578:	01010113          	addi	sp,sp,16
    8000257c:	00008067          	ret

0000000080002580 <_ZN7WorkerD3runEv>:
    void run() override {
    80002580:	ff010113          	addi	sp,sp,-16
    80002584:	00113423          	sd	ra,8(sp)
    80002588:	00813023          	sd	s0,0(sp)
    8000258c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002590:	00000593          	li	a1,0
    80002594:	00000097          	auipc	ra,0x0
    80002598:	a10080e7          	jalr	-1520(ra) # 80001fa4 <_ZN7WorkerD11workerBodyDEPv>
    }
    8000259c:	00813083          	ld	ra,8(sp)
    800025a0:	00013403          	ld	s0,0(sp)
    800025a4:	01010113          	addi	sp,sp,16
    800025a8:	00008067          	ret

00000000800025ac <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800025ac:	f8010113          	addi	sp,sp,-128
    800025b0:	06113c23          	sd	ra,120(sp)
    800025b4:	06813823          	sd	s0,112(sp)
    800025b8:	06913423          	sd	s1,104(sp)
    800025bc:	07213023          	sd	s2,96(sp)
    800025c0:	05313c23          	sd	s3,88(sp)
    800025c4:	05413823          	sd	s4,80(sp)
    800025c8:	05513423          	sd	s5,72(sp)
    800025cc:	05613023          	sd	s6,64(sp)
    800025d0:	03713c23          	sd	s7,56(sp)
    800025d4:	03813823          	sd	s8,48(sp)
    800025d8:	03913423          	sd	s9,40(sp)
    800025dc:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    800025e0:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    800025e4:	00008517          	auipc	a0,0x8
    800025e8:	a3c50513          	addi	a0,a0,-1476 # 8000a020 <CONSOLE_STATUS+0x10>
    800025ec:	00001097          	auipc	ra,0x1
    800025f0:	5a8080e7          	jalr	1448(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    800025f4:	01e00593          	li	a1,30
    800025f8:	f8040493          	addi	s1,s0,-128
    800025fc:	00048513          	mv	a0,s1
    80002600:	00001097          	auipc	ra,0x1
    80002604:	61c080e7          	jalr	1564(ra) # 80003c1c <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002608:	00048513          	mv	a0,s1
    8000260c:	00001097          	auipc	ra,0x1
    80002610:	6e8080e7          	jalr	1768(ra) # 80003cf4 <_Z11stringToIntPKc>
    80002614:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80002618:	00008517          	auipc	a0,0x8
    8000261c:	a2850513          	addi	a0,a0,-1496 # 8000a040 <CONSOLE_STATUS+0x30>
    80002620:	00001097          	auipc	ra,0x1
    80002624:	574080e7          	jalr	1396(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    80002628:	01e00593          	li	a1,30
    8000262c:	00048513          	mv	a0,s1
    80002630:	00001097          	auipc	ra,0x1
    80002634:	5ec080e7          	jalr	1516(ra) # 80003c1c <_Z9getStringPci>
    n = stringToInt(input);
    80002638:	00048513          	mv	a0,s1
    8000263c:	00001097          	auipc	ra,0x1
    80002640:	6b8080e7          	jalr	1720(ra) # 80003cf4 <_Z11stringToIntPKc>
    80002644:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80002648:	00008517          	auipc	a0,0x8
    8000264c:	a1850513          	addi	a0,a0,-1512 # 8000a060 <CONSOLE_STATUS+0x50>
    80002650:	00001097          	auipc	ra,0x1
    80002654:	544080e7          	jalr	1348(ra) # 80003b94 <_Z11printStringPKc>
    printInt(threadNum);
    80002658:	00000613          	li	a2,0
    8000265c:	00a00593          	li	a1,10
    80002660:	00098513          	mv	a0,s3
    80002664:	00001097          	auipc	ra,0x1
    80002668:	6e0080e7          	jalr	1760(ra) # 80003d44 <_Z8printIntiii>
    printString(" i velicina bafera ");
    8000266c:	00008517          	auipc	a0,0x8
    80002670:	a0c50513          	addi	a0,a0,-1524 # 8000a078 <CONSOLE_STATUS+0x68>
    80002674:	00001097          	auipc	ra,0x1
    80002678:	520080e7          	jalr	1312(ra) # 80003b94 <_Z11printStringPKc>
    printInt(n);
    8000267c:	00000613          	li	a2,0
    80002680:	00a00593          	li	a1,10
    80002684:	00048513          	mv	a0,s1
    80002688:	00001097          	auipc	ra,0x1
    8000268c:	6bc080e7          	jalr	1724(ra) # 80003d44 <_Z8printIntiii>
    printString(".\n");
    80002690:	00008517          	auipc	a0,0x8
    80002694:	a0050513          	addi	a0,a0,-1536 # 8000a090 <CONSOLE_STATUS+0x80>
    80002698:	00001097          	auipc	ra,0x1
    8000269c:	4fc080e7          	jalr	1276(ra) # 80003b94 <_Z11printStringPKc>
    if (threadNum > n) {
    800026a0:	0334c463          	blt	s1,s3,800026c8 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    800026a4:	03305c63          	blez	s3,800026dc <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800026a8:	03800513          	li	a0,56
    800026ac:	00002097          	auipc	ra,0x2
    800026b0:	720080e7          	jalr	1824(ra) # 80004dcc <_Znwm>
    800026b4:	00050a93          	mv	s5,a0
    800026b8:	00048593          	mv	a1,s1
    800026bc:	00001097          	auipc	ra,0x1
    800026c0:	7a8080e7          	jalr	1960(ra) # 80003e64 <_ZN9BufferCPPC1Ei>
    800026c4:	0300006f          	j	800026f4 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800026c8:	00008517          	auipc	a0,0x8
    800026cc:	9d050513          	addi	a0,a0,-1584 # 8000a098 <CONSOLE_STATUS+0x88>
    800026d0:	00001097          	auipc	ra,0x1
    800026d4:	4c4080e7          	jalr	1220(ra) # 80003b94 <_Z11printStringPKc>
        return;
    800026d8:	0140006f          	j	800026ec <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800026dc:	00008517          	auipc	a0,0x8
    800026e0:	9fc50513          	addi	a0,a0,-1540 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    800026e4:	00001097          	auipc	ra,0x1
    800026e8:	4b0080e7          	jalr	1200(ra) # 80003b94 <_Z11printStringPKc>
        return;
    800026ec:	000c0113          	mv	sp,s8
    800026f0:	2140006f          	j	80002904 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    800026f4:	01000513          	li	a0,16
    800026f8:	00002097          	auipc	ra,0x2
    800026fc:	6d4080e7          	jalr	1748(ra) # 80004dcc <_Znwm>
    80002700:	00050913          	mv	s2,a0
    80002704:	00000593          	li	a1,0
    80002708:	00003097          	auipc	ra,0x3
    8000270c:	904080e7          	jalr	-1788(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    80002710:	0000a797          	auipc	a5,0xa
    80002714:	4f27b823          	sd	s2,1264(a5) # 8000cc00 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80002718:	00399793          	slli	a5,s3,0x3
    8000271c:	00f78793          	addi	a5,a5,15
    80002720:	ff07f793          	andi	a5,a5,-16
    80002724:	40f10133          	sub	sp,sp,a5
    80002728:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    8000272c:	0019871b          	addiw	a4,s3,1
    80002730:	00171793          	slli	a5,a4,0x1
    80002734:	00e787b3          	add	a5,a5,a4
    80002738:	00379793          	slli	a5,a5,0x3
    8000273c:	00f78793          	addi	a5,a5,15
    80002740:	ff07f793          	andi	a5,a5,-16
    80002744:	40f10133          	sub	sp,sp,a5
    80002748:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    8000274c:	00199493          	slli	s1,s3,0x1
    80002750:	013484b3          	add	s1,s1,s3
    80002754:	00349493          	slli	s1,s1,0x3
    80002758:	009b04b3          	add	s1,s6,s1
    8000275c:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80002760:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80002764:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002768:	02800513          	li	a0,40
    8000276c:	00002097          	auipc	ra,0x2
    80002770:	660080e7          	jalr	1632(ra) # 80004dcc <_Znwm>
    80002774:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80002778:	00003097          	auipc	ra,0x3
    8000277c:	860080e7          	jalr	-1952(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    80002780:	0000a797          	auipc	a5,0xa
    80002784:	24878793          	addi	a5,a5,584 # 8000c9c8 <_ZTV8Consumer+0x10>
    80002788:	00fbb023          	sd	a5,0(s7)
    8000278c:	029bb023          	sd	s1,32(s7)
    consumer->start();
    80002790:	000b8513          	mv	a0,s7
    80002794:	00002097          	auipc	ra,0x2
    80002798:	784080e7          	jalr	1924(ra) # 80004f18 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    8000279c:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    800027a0:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    800027a4:	0000a797          	auipc	a5,0xa
    800027a8:	45c7b783          	ld	a5,1116(a5) # 8000cc00 <_ZL10waitForAll>
    800027ac:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800027b0:	02800513          	li	a0,40
    800027b4:	00002097          	auipc	ra,0x2
    800027b8:	618080e7          	jalr	1560(ra) # 80004dcc <_Znwm>
    800027bc:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    800027c0:	00003097          	auipc	ra,0x3
    800027c4:	818080e7          	jalr	-2024(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    800027c8:	0000a797          	auipc	a5,0xa
    800027cc:	1b078793          	addi	a5,a5,432 # 8000c978 <_ZTV16ProducerKeyborad+0x10>
    800027d0:	00f4b023          	sd	a5,0(s1)
    800027d4:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800027d8:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    800027dc:	00048513          	mv	a0,s1
    800027e0:	00002097          	auipc	ra,0x2
    800027e4:	738080e7          	jalr	1848(ra) # 80004f18 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    800027e8:	00100913          	li	s2,1
    800027ec:	0300006f          	j	8000281c <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800027f0:	0000a797          	auipc	a5,0xa
    800027f4:	1b078793          	addi	a5,a5,432 # 8000c9a0 <_ZTV8Producer+0x10>
    800027f8:	00fcb023          	sd	a5,0(s9)
    800027fc:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80002800:	00391793          	slli	a5,s2,0x3
    80002804:	00fa07b3          	add	a5,s4,a5
    80002808:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    8000280c:	000c8513          	mv	a0,s9
    80002810:	00002097          	auipc	ra,0x2
    80002814:	708080e7          	jalr	1800(ra) # 80004f18 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80002818:	0019091b          	addiw	s2,s2,1
    8000281c:	05395263          	bge	s2,s3,80002860 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80002820:	00191493          	slli	s1,s2,0x1
    80002824:	012484b3          	add	s1,s1,s2
    80002828:	00349493          	slli	s1,s1,0x3
    8000282c:	009b04b3          	add	s1,s6,s1
    80002830:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80002834:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80002838:	0000a797          	auipc	a5,0xa
    8000283c:	3c87b783          	ld	a5,968(a5) # 8000cc00 <_ZL10waitForAll>
    80002840:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80002844:	02800513          	li	a0,40
    80002848:	00002097          	auipc	ra,0x2
    8000284c:	584080e7          	jalr	1412(ra) # 80004dcc <_Znwm>
    80002850:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80002854:	00002097          	auipc	ra,0x2
    80002858:	784080e7          	jalr	1924(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    8000285c:	f95ff06f          	j	800027f0 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80002860:	00002097          	auipc	ra,0x2
    80002864:	728080e7          	jalr	1832(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80002868:	00000493          	li	s1,0
    8000286c:	0099ce63          	blt	s3,s1,80002888 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    80002870:	0000a517          	auipc	a0,0xa
    80002874:	39053503          	ld	a0,912(a0) # 8000cc00 <_ZL10waitForAll>
    80002878:	00002097          	auipc	ra,0x2
    8000287c:	7cc080e7          	jalr	1996(ra) # 80005044 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80002880:	0014849b          	addiw	s1,s1,1
    80002884:	fe9ff06f          	j	8000286c <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    80002888:	0000a517          	auipc	a0,0xa
    8000288c:	37853503          	ld	a0,888(a0) # 8000cc00 <_ZL10waitForAll>
    80002890:	00050863          	beqz	a0,800028a0 <_Z20testConsumerProducerv+0x2f4>
    80002894:	00053783          	ld	a5,0(a0)
    80002898:	0087b783          	ld	a5,8(a5)
    8000289c:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    800028a0:	00000493          	li	s1,0
    800028a4:	0080006f          	j	800028ac <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    800028a8:	0014849b          	addiw	s1,s1,1
    800028ac:	0334d263          	bge	s1,s3,800028d0 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    800028b0:	00349793          	slli	a5,s1,0x3
    800028b4:	00fa07b3          	add	a5,s4,a5
    800028b8:	0007b503          	ld	a0,0(a5)
    800028bc:	fe0506e3          	beqz	a0,800028a8 <_Z20testConsumerProducerv+0x2fc>
    800028c0:	00053783          	ld	a5,0(a0)
    800028c4:	0087b783          	ld	a5,8(a5)
    800028c8:	000780e7          	jalr	a5
    800028cc:	fddff06f          	j	800028a8 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    800028d0:	000b8a63          	beqz	s7,800028e4 <_Z20testConsumerProducerv+0x338>
    800028d4:	000bb783          	ld	a5,0(s7)
    800028d8:	0087b783          	ld	a5,8(a5)
    800028dc:	000b8513          	mv	a0,s7
    800028e0:	000780e7          	jalr	a5
    delete buffer;
    800028e4:	000a8e63          	beqz	s5,80002900 <_Z20testConsumerProducerv+0x354>
    800028e8:	000a8513          	mv	a0,s5
    800028ec:	00002097          	auipc	ra,0x2
    800028f0:	870080e7          	jalr	-1936(ra) # 8000415c <_ZN9BufferCPPD1Ev>
    800028f4:	000a8513          	mv	a0,s5
    800028f8:	00002097          	auipc	ra,0x2
    800028fc:	524080e7          	jalr	1316(ra) # 80004e1c <_ZdlPv>
    80002900:	000c0113          	mv	sp,s8
}
    80002904:	f8040113          	addi	sp,s0,-128
    80002908:	07813083          	ld	ra,120(sp)
    8000290c:	07013403          	ld	s0,112(sp)
    80002910:	06813483          	ld	s1,104(sp)
    80002914:	06013903          	ld	s2,96(sp)
    80002918:	05813983          	ld	s3,88(sp)
    8000291c:	05013a03          	ld	s4,80(sp)
    80002920:	04813a83          	ld	s5,72(sp)
    80002924:	04013b03          	ld	s6,64(sp)
    80002928:	03813b83          	ld	s7,56(sp)
    8000292c:	03013c03          	ld	s8,48(sp)
    80002930:	02813c83          	ld	s9,40(sp)
    80002934:	08010113          	addi	sp,sp,128
    80002938:	00008067          	ret
    8000293c:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80002940:	000a8513          	mv	a0,s5
    80002944:	00002097          	auipc	ra,0x2
    80002948:	4d8080e7          	jalr	1240(ra) # 80004e1c <_ZdlPv>
    8000294c:	00048513          	mv	a0,s1
    80002950:	0000b097          	auipc	ra,0xb
    80002954:	438080e7          	jalr	1080(ra) # 8000dd88 <_Unwind_Resume>
    80002958:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    8000295c:	00090513          	mv	a0,s2
    80002960:	00002097          	auipc	ra,0x2
    80002964:	4bc080e7          	jalr	1212(ra) # 80004e1c <_ZdlPv>
    80002968:	00048513          	mv	a0,s1
    8000296c:	0000b097          	auipc	ra,0xb
    80002970:	41c080e7          	jalr	1052(ra) # 8000dd88 <_Unwind_Resume>
    80002974:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80002978:	000b8513          	mv	a0,s7
    8000297c:	00002097          	auipc	ra,0x2
    80002980:	4a0080e7          	jalr	1184(ra) # 80004e1c <_ZdlPv>
    80002984:	00048513          	mv	a0,s1
    80002988:	0000b097          	auipc	ra,0xb
    8000298c:	400080e7          	jalr	1024(ra) # 8000dd88 <_Unwind_Resume>
    80002990:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80002994:	00048513          	mv	a0,s1
    80002998:	00002097          	auipc	ra,0x2
    8000299c:	484080e7          	jalr	1156(ra) # 80004e1c <_ZdlPv>
    800029a0:	00090513          	mv	a0,s2
    800029a4:	0000b097          	auipc	ra,0xb
    800029a8:	3e4080e7          	jalr	996(ra) # 8000dd88 <_Unwind_Resume>
    800029ac:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    800029b0:	000c8513          	mv	a0,s9
    800029b4:	00002097          	auipc	ra,0x2
    800029b8:	468080e7          	jalr	1128(ra) # 80004e1c <_ZdlPv>
    800029bc:	00048513          	mv	a0,s1
    800029c0:	0000b097          	auipc	ra,0xb
    800029c4:	3c8080e7          	jalr	968(ra) # 8000dd88 <_Unwind_Resume>

00000000800029c8 <_ZN8Consumer3runEv>:
    void run() override {
    800029c8:	fd010113          	addi	sp,sp,-48
    800029cc:	02113423          	sd	ra,40(sp)
    800029d0:	02813023          	sd	s0,32(sp)
    800029d4:	00913c23          	sd	s1,24(sp)
    800029d8:	01213823          	sd	s2,16(sp)
    800029dc:	01313423          	sd	s3,8(sp)
    800029e0:	03010413          	addi	s0,sp,48
    800029e4:	00050913          	mv	s2,a0
        int i = 0;
    800029e8:	00000993          	li	s3,0
    800029ec:	0100006f          	j	800029fc <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    800029f0:	00a00513          	li	a0,10
    800029f4:	00002097          	auipc	ra,0x2
    800029f8:	790080e7          	jalr	1936(ra) # 80005184 <_ZN7Console4putcEc>
        while (!threadEnd) {
    800029fc:	0000a797          	auipc	a5,0xa
    80002a00:	1fc7a783          	lw	a5,508(a5) # 8000cbf8 <_ZL9threadEnd>
    80002a04:	04079a63          	bnez	a5,80002a58 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80002a08:	02093783          	ld	a5,32(s2)
    80002a0c:	0087b503          	ld	a0,8(a5)
    80002a10:	00001097          	auipc	ra,0x1
    80002a14:	638080e7          	jalr	1592(ra) # 80004048 <_ZN9BufferCPP3getEv>
            i++;
    80002a18:	0019849b          	addiw	s1,s3,1
    80002a1c:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80002a20:	0ff57513          	andi	a0,a0,255
    80002a24:	00002097          	auipc	ra,0x2
    80002a28:	760080e7          	jalr	1888(ra) # 80005184 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80002a2c:	05000793          	li	a5,80
    80002a30:	02f4e4bb          	remw	s1,s1,a5
    80002a34:	fc0494e3          	bnez	s1,800029fc <_ZN8Consumer3runEv+0x34>
    80002a38:	fb9ff06f          	j	800029f0 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80002a3c:	02093783          	ld	a5,32(s2)
    80002a40:	0087b503          	ld	a0,8(a5)
    80002a44:	00001097          	auipc	ra,0x1
    80002a48:	604080e7          	jalr	1540(ra) # 80004048 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80002a4c:	0ff57513          	andi	a0,a0,255
    80002a50:	00002097          	auipc	ra,0x2
    80002a54:	734080e7          	jalr	1844(ra) # 80005184 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80002a58:	02093783          	ld	a5,32(s2)
    80002a5c:	0087b503          	ld	a0,8(a5)
    80002a60:	00001097          	auipc	ra,0x1
    80002a64:	674080e7          	jalr	1652(ra) # 800040d4 <_ZN9BufferCPP6getCntEv>
    80002a68:	fca04ae3          	bgtz	a0,80002a3c <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80002a6c:	02093783          	ld	a5,32(s2)
    80002a70:	0107b503          	ld	a0,16(a5)
    80002a74:	00002097          	auipc	ra,0x2
    80002a78:	5fc080e7          	jalr	1532(ra) # 80005070 <_ZN9Semaphore6signalEv>
    }
    80002a7c:	02813083          	ld	ra,40(sp)
    80002a80:	02013403          	ld	s0,32(sp)
    80002a84:	01813483          	ld	s1,24(sp)
    80002a88:	01013903          	ld	s2,16(sp)
    80002a8c:	00813983          	ld	s3,8(sp)
    80002a90:	03010113          	addi	sp,sp,48
    80002a94:	00008067          	ret

0000000080002a98 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00113423          	sd	ra,8(sp)
    80002aa0:	00813023          	sd	s0,0(sp)
    80002aa4:	01010413          	addi	s0,sp,16
    80002aa8:	0000a797          	auipc	a5,0xa
    80002aac:	f2078793          	addi	a5,a5,-224 # 8000c9c8 <_ZTV8Consumer+0x10>
    80002ab0:	00f53023          	sd	a5,0(a0)
    80002ab4:	00002097          	auipc	ra,0x2
    80002ab8:	288080e7          	jalr	648(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002abc:	00813083          	ld	ra,8(sp)
    80002ac0:	00013403          	ld	s0,0(sp)
    80002ac4:	01010113          	addi	sp,sp,16
    80002ac8:	00008067          	ret

0000000080002acc <_ZN8ConsumerD0Ev>:
    80002acc:	fe010113          	addi	sp,sp,-32
    80002ad0:	00113c23          	sd	ra,24(sp)
    80002ad4:	00813823          	sd	s0,16(sp)
    80002ad8:	00913423          	sd	s1,8(sp)
    80002adc:	02010413          	addi	s0,sp,32
    80002ae0:	00050493          	mv	s1,a0
    80002ae4:	0000a797          	auipc	a5,0xa
    80002ae8:	ee478793          	addi	a5,a5,-284 # 8000c9c8 <_ZTV8Consumer+0x10>
    80002aec:	00f53023          	sd	a5,0(a0)
    80002af0:	00002097          	auipc	ra,0x2
    80002af4:	24c080e7          	jalr	588(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002af8:	00048513          	mv	a0,s1
    80002afc:	00002097          	auipc	ra,0x2
    80002b00:	320080e7          	jalr	800(ra) # 80004e1c <_ZdlPv>
    80002b04:	01813083          	ld	ra,24(sp)
    80002b08:	01013403          	ld	s0,16(sp)
    80002b0c:	00813483          	ld	s1,8(sp)
    80002b10:	02010113          	addi	sp,sp,32
    80002b14:	00008067          	ret

0000000080002b18 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80002b18:	ff010113          	addi	sp,sp,-16
    80002b1c:	00113423          	sd	ra,8(sp)
    80002b20:	00813023          	sd	s0,0(sp)
    80002b24:	01010413          	addi	s0,sp,16
    80002b28:	0000a797          	auipc	a5,0xa
    80002b2c:	e5078793          	addi	a5,a5,-432 # 8000c978 <_ZTV16ProducerKeyborad+0x10>
    80002b30:	00f53023          	sd	a5,0(a0)
    80002b34:	00002097          	auipc	ra,0x2
    80002b38:	208080e7          	jalr	520(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002b3c:	00813083          	ld	ra,8(sp)
    80002b40:	00013403          	ld	s0,0(sp)
    80002b44:	01010113          	addi	sp,sp,16
    80002b48:	00008067          	ret

0000000080002b4c <_ZN16ProducerKeyboradD0Ev>:
    80002b4c:	fe010113          	addi	sp,sp,-32
    80002b50:	00113c23          	sd	ra,24(sp)
    80002b54:	00813823          	sd	s0,16(sp)
    80002b58:	00913423          	sd	s1,8(sp)
    80002b5c:	02010413          	addi	s0,sp,32
    80002b60:	00050493          	mv	s1,a0
    80002b64:	0000a797          	auipc	a5,0xa
    80002b68:	e1478793          	addi	a5,a5,-492 # 8000c978 <_ZTV16ProducerKeyborad+0x10>
    80002b6c:	00f53023          	sd	a5,0(a0)
    80002b70:	00002097          	auipc	ra,0x2
    80002b74:	1cc080e7          	jalr	460(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002b78:	00048513          	mv	a0,s1
    80002b7c:	00002097          	auipc	ra,0x2
    80002b80:	2a0080e7          	jalr	672(ra) # 80004e1c <_ZdlPv>
    80002b84:	01813083          	ld	ra,24(sp)
    80002b88:	01013403          	ld	s0,16(sp)
    80002b8c:	00813483          	ld	s1,8(sp)
    80002b90:	02010113          	addi	sp,sp,32
    80002b94:	00008067          	ret

0000000080002b98 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80002b98:	ff010113          	addi	sp,sp,-16
    80002b9c:	00113423          	sd	ra,8(sp)
    80002ba0:	00813023          	sd	s0,0(sp)
    80002ba4:	01010413          	addi	s0,sp,16
    80002ba8:	0000a797          	auipc	a5,0xa
    80002bac:	df878793          	addi	a5,a5,-520 # 8000c9a0 <_ZTV8Producer+0x10>
    80002bb0:	00f53023          	sd	a5,0(a0)
    80002bb4:	00002097          	auipc	ra,0x2
    80002bb8:	188080e7          	jalr	392(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002bbc:	00813083          	ld	ra,8(sp)
    80002bc0:	00013403          	ld	s0,0(sp)
    80002bc4:	01010113          	addi	sp,sp,16
    80002bc8:	00008067          	ret

0000000080002bcc <_ZN8ProducerD0Ev>:
    80002bcc:	fe010113          	addi	sp,sp,-32
    80002bd0:	00113c23          	sd	ra,24(sp)
    80002bd4:	00813823          	sd	s0,16(sp)
    80002bd8:	00913423          	sd	s1,8(sp)
    80002bdc:	02010413          	addi	s0,sp,32
    80002be0:	00050493          	mv	s1,a0
    80002be4:	0000a797          	auipc	a5,0xa
    80002be8:	dbc78793          	addi	a5,a5,-580 # 8000c9a0 <_ZTV8Producer+0x10>
    80002bec:	00f53023          	sd	a5,0(a0)
    80002bf0:	00002097          	auipc	ra,0x2
    80002bf4:	14c080e7          	jalr	332(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80002bf8:	00048513          	mv	a0,s1
    80002bfc:	00002097          	auipc	ra,0x2
    80002c00:	220080e7          	jalr	544(ra) # 80004e1c <_ZdlPv>
    80002c04:	01813083          	ld	ra,24(sp)
    80002c08:	01013403          	ld	s0,16(sp)
    80002c0c:	00813483          	ld	s1,8(sp)
    80002c10:	02010113          	addi	sp,sp,32
    80002c14:	00008067          	ret

0000000080002c18 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80002c18:	fe010113          	addi	sp,sp,-32
    80002c1c:	00113c23          	sd	ra,24(sp)
    80002c20:	00813823          	sd	s0,16(sp)
    80002c24:	00913423          	sd	s1,8(sp)
    80002c28:	02010413          	addi	s0,sp,32
    80002c2c:	00050493          	mv	s1,a0
        while ((key = Console::getc()) != 0x30) { // changing from escape character (0x1b) to easier 0x30 0
    80002c30:	00002097          	auipc	ra,0x2
    80002c34:	52c080e7          	jalr	1324(ra) # 8000515c <_ZN7Console4getcEv>
    80002c38:	0005059b          	sext.w	a1,a0
    80002c3c:	03000793          	li	a5,48
    80002c40:	00f58c63          	beq	a1,a5,80002c58 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80002c44:	0204b783          	ld	a5,32(s1)
    80002c48:	0087b503          	ld	a0,8(a5)
    80002c4c:	00001097          	auipc	ra,0x1
    80002c50:	36c080e7          	jalr	876(ra) # 80003fb8 <_ZN9BufferCPP3putEi>
        while ((key = Console::getc()) != 0x30) { // changing from escape character (0x1b) to easier 0x30 0
    80002c54:	fddff06f          	j	80002c30 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80002c58:	00100793          	li	a5,1
    80002c5c:	0000a717          	auipc	a4,0xa
    80002c60:	f8f72e23          	sw	a5,-100(a4) # 8000cbf8 <_ZL9threadEnd>
        td->buffer->put('!');
    80002c64:	0204b783          	ld	a5,32(s1)
    80002c68:	02100593          	li	a1,33
    80002c6c:	0087b503          	ld	a0,8(a5)
    80002c70:	00001097          	auipc	ra,0x1
    80002c74:	348080e7          	jalr	840(ra) # 80003fb8 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80002c78:	0204b783          	ld	a5,32(s1)
    80002c7c:	0107b503          	ld	a0,16(a5)
    80002c80:	00002097          	auipc	ra,0x2
    80002c84:	3f0080e7          	jalr	1008(ra) # 80005070 <_ZN9Semaphore6signalEv>
    }
    80002c88:	01813083          	ld	ra,24(sp)
    80002c8c:	01013403          	ld	s0,16(sp)
    80002c90:	00813483          	ld	s1,8(sp)
    80002c94:	02010113          	addi	sp,sp,32
    80002c98:	00008067          	ret

0000000080002c9c <_ZN8Producer3runEv>:
    void run() override {
    80002c9c:	fe010113          	addi	sp,sp,-32
    80002ca0:	00113c23          	sd	ra,24(sp)
    80002ca4:	00813823          	sd	s0,16(sp)
    80002ca8:	00913423          	sd	s1,8(sp)
    80002cac:	01213023          	sd	s2,0(sp)
    80002cb0:	02010413          	addi	s0,sp,32
    80002cb4:	00050493          	mv	s1,a0
        int i = 0;
    80002cb8:	00000913          	li	s2,0
        while (!threadEnd) {
    80002cbc:	0000a797          	auipc	a5,0xa
    80002cc0:	f3c7a783          	lw	a5,-196(a5) # 8000cbf8 <_ZL9threadEnd>
    80002cc4:	04079263          	bnez	a5,80002d08 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80002cc8:	0204b783          	ld	a5,32(s1)
    80002ccc:	0007a583          	lw	a1,0(a5)
    80002cd0:	0305859b          	addiw	a1,a1,48
    80002cd4:	0087b503          	ld	a0,8(a5)
    80002cd8:	00001097          	auipc	ra,0x1
    80002cdc:	2e0080e7          	jalr	736(ra) # 80003fb8 <_ZN9BufferCPP3putEi>
            i++;
    80002ce0:	0019071b          	addiw	a4,s2,1
    80002ce4:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5); //most likely a sleep issue for why its not doing the other 2 producers
    80002ce8:	0204b783          	ld	a5,32(s1)
    80002cec:	0007a783          	lw	a5,0(a5)
    80002cf0:	00e787bb          	addw	a5,a5,a4
    80002cf4:	00500513          	li	a0,5
    80002cf8:	02a7e53b          	remw	a0,a5,a0
    80002cfc:	00002097          	auipc	ra,0x2
    80002d00:	2b4080e7          	jalr	692(ra) # 80004fb0 <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    80002d04:	fb9ff06f          	j	80002cbc <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80002d08:	0204b783          	ld	a5,32(s1)
    80002d0c:	0107b503          	ld	a0,16(a5)
    80002d10:	00002097          	auipc	ra,0x2
    80002d14:	360080e7          	jalr	864(ra) # 80005070 <_ZN9Semaphore6signalEv>
    }
    80002d18:	01813083          	ld	ra,24(sp)
    80002d1c:	01013403          	ld	s0,16(sp)
    80002d20:	00813483          	ld	s1,8(sp)
    80002d24:	00013903          	ld	s2,0(sp)
    80002d28:	02010113          	addi	sp,sp,32
    80002d2c:	00008067          	ret

0000000080002d30 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002d30:	fe010113          	addi	sp,sp,-32
    80002d34:	00113c23          	sd	ra,24(sp)
    80002d38:	00813823          	sd	s0,16(sp)
    80002d3c:	00913423          	sd	s1,8(sp)
    80002d40:	01213023          	sd	s2,0(sp)
    80002d44:	02010413          	addi	s0,sp,32
    80002d48:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002d4c:	00100793          	li	a5,1
    80002d50:	02a7f863          	bgeu	a5,a0,80002d80 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002d54:	00a00793          	li	a5,10
    80002d58:	02f577b3          	remu	a5,a0,a5
    80002d5c:	02078e63          	beqz	a5,80002d98 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002d60:	fff48513          	addi	a0,s1,-1
    80002d64:	00000097          	auipc	ra,0x0
    80002d68:	fcc080e7          	jalr	-52(ra) # 80002d30 <_ZL9fibonaccim>
    80002d6c:	00050913          	mv	s2,a0
    80002d70:	ffe48513          	addi	a0,s1,-2
    80002d74:	00000097          	auipc	ra,0x0
    80002d78:	fbc080e7          	jalr	-68(ra) # 80002d30 <_ZL9fibonaccim>
    80002d7c:	00a90533          	add	a0,s2,a0
}
    80002d80:	01813083          	ld	ra,24(sp)
    80002d84:	01013403          	ld	s0,16(sp)
    80002d88:	00813483          	ld	s1,8(sp)
    80002d8c:	00013903          	ld	s2,0(sp)
    80002d90:	02010113          	addi	sp,sp,32
    80002d94:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002d98:	ffffe097          	auipc	ra,0xffffe
    80002d9c:	4f4080e7          	jalr	1268(ra) # 8000128c <_Z15thread_dispatchv>
    80002da0:	fc1ff06f          	j	80002d60 <_ZL9fibonaccim+0x30>

0000000080002da4 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002da4:	fe010113          	addi	sp,sp,-32
    80002da8:	00113c23          	sd	ra,24(sp)
    80002dac:	00813823          	sd	s0,16(sp)
    80002db0:	00913423          	sd	s1,8(sp)
    80002db4:	01213023          	sd	s2,0(sp)
    80002db8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002dbc:	00a00493          	li	s1,10
    80002dc0:	0400006f          	j	80002e00 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002dc4:	00007517          	auipc	a0,0x7
    80002dc8:	3cc50513          	addi	a0,a0,972 # 8000a190 <CONSOLE_STATUS+0x180>
    80002dcc:	00001097          	auipc	ra,0x1
    80002dd0:	dc8080e7          	jalr	-568(ra) # 80003b94 <_Z11printStringPKc>
    80002dd4:	00000613          	li	a2,0
    80002dd8:	00a00593          	li	a1,10
    80002ddc:	00048513          	mv	a0,s1
    80002de0:	00001097          	auipc	ra,0x1
    80002de4:	f64080e7          	jalr	-156(ra) # 80003d44 <_Z8printIntiii>
    80002de8:	00007517          	auipc	a0,0x7
    80002dec:	59850513          	addi	a0,a0,1432 # 8000a380 <CONSOLE_STATUS+0x370>
    80002df0:	00001097          	auipc	ra,0x1
    80002df4:	da4080e7          	jalr	-604(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002df8:	0014849b          	addiw	s1,s1,1
    80002dfc:	0ff4f493          	andi	s1,s1,255
    80002e00:	00c00793          	li	a5,12
    80002e04:	fc97f0e3          	bgeu	a5,s1,80002dc4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002e08:	00007517          	auipc	a0,0x7
    80002e0c:	39050513          	addi	a0,a0,912 # 8000a198 <CONSOLE_STATUS+0x188>
    80002e10:	00001097          	auipc	ra,0x1
    80002e14:	d84080e7          	jalr	-636(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002e18:	00500313          	li	t1,5
    thread_dispatch();
    80002e1c:	ffffe097          	auipc	ra,0xffffe
    80002e20:	470080e7          	jalr	1136(ra) # 8000128c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002e24:	01000513          	li	a0,16
    80002e28:	00000097          	auipc	ra,0x0
    80002e2c:	f08080e7          	jalr	-248(ra) # 80002d30 <_ZL9fibonaccim>
    80002e30:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002e34:	00007517          	auipc	a0,0x7
    80002e38:	37450513          	addi	a0,a0,884 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80002e3c:	00001097          	auipc	ra,0x1
    80002e40:	d58080e7          	jalr	-680(ra) # 80003b94 <_Z11printStringPKc>
    80002e44:	00000613          	li	a2,0
    80002e48:	00a00593          	li	a1,10
    80002e4c:	0009051b          	sext.w	a0,s2
    80002e50:	00001097          	auipc	ra,0x1
    80002e54:	ef4080e7          	jalr	-268(ra) # 80003d44 <_Z8printIntiii>
    80002e58:	00007517          	auipc	a0,0x7
    80002e5c:	52850513          	addi	a0,a0,1320 # 8000a380 <CONSOLE_STATUS+0x370>
    80002e60:	00001097          	auipc	ra,0x1
    80002e64:	d34080e7          	jalr	-716(ra) # 80003b94 <_Z11printStringPKc>
    80002e68:	0400006f          	j	80002ea8 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002e6c:	00007517          	auipc	a0,0x7
    80002e70:	32450513          	addi	a0,a0,804 # 8000a190 <CONSOLE_STATUS+0x180>
    80002e74:	00001097          	auipc	ra,0x1
    80002e78:	d20080e7          	jalr	-736(ra) # 80003b94 <_Z11printStringPKc>
    80002e7c:	00000613          	li	a2,0
    80002e80:	00a00593          	li	a1,10
    80002e84:	00048513          	mv	a0,s1
    80002e88:	00001097          	auipc	ra,0x1
    80002e8c:	ebc080e7          	jalr	-324(ra) # 80003d44 <_Z8printIntiii>
    80002e90:	00007517          	auipc	a0,0x7
    80002e94:	4f050513          	addi	a0,a0,1264 # 8000a380 <CONSOLE_STATUS+0x370>
    80002e98:	00001097          	auipc	ra,0x1
    80002e9c:	cfc080e7          	jalr	-772(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002ea0:	0014849b          	addiw	s1,s1,1
    80002ea4:	0ff4f493          	andi	s1,s1,255
    80002ea8:	00f00793          	li	a5,15
    80002eac:	fc97f0e3          	bgeu	a5,s1,80002e6c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002eb0:	00007517          	auipc	a0,0x7
    80002eb4:	30850513          	addi	a0,a0,776 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    80002eb8:	00001097          	auipc	ra,0x1
    80002ebc:	cdc080e7          	jalr	-804(ra) # 80003b94 <_Z11printStringPKc>
    finishedD = true;
    80002ec0:	00100793          	li	a5,1
    80002ec4:	0000a717          	auipc	a4,0xa
    80002ec8:	d4f70223          	sb	a5,-700(a4) # 8000cc08 <_ZL9finishedD>
    thread_dispatch();
    80002ecc:	ffffe097          	auipc	ra,0xffffe
    80002ed0:	3c0080e7          	jalr	960(ra) # 8000128c <_Z15thread_dispatchv>
}
    80002ed4:	01813083          	ld	ra,24(sp)
    80002ed8:	01013403          	ld	s0,16(sp)
    80002edc:	00813483          	ld	s1,8(sp)
    80002ee0:	00013903          	ld	s2,0(sp)
    80002ee4:	02010113          	addi	sp,sp,32
    80002ee8:	00008067          	ret

0000000080002eec <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80002eec:	fe010113          	addi	sp,sp,-32
    80002ef0:	00113c23          	sd	ra,24(sp)
    80002ef4:	00813823          	sd	s0,16(sp)
    80002ef8:	00913423          	sd	s1,8(sp)
    80002efc:	01213023          	sd	s2,0(sp)
    80002f00:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002f04:	00000493          	li	s1,0
    80002f08:	0400006f          	j	80002f48 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80002f0c:	00007517          	auipc	a0,0x7
    80002f10:	24450513          	addi	a0,a0,580 # 8000a150 <CONSOLE_STATUS+0x140>
    80002f14:	00001097          	auipc	ra,0x1
    80002f18:	c80080e7          	jalr	-896(ra) # 80003b94 <_Z11printStringPKc>
    80002f1c:	00000613          	li	a2,0
    80002f20:	00a00593          	li	a1,10
    80002f24:	00048513          	mv	a0,s1
    80002f28:	00001097          	auipc	ra,0x1
    80002f2c:	e1c080e7          	jalr	-484(ra) # 80003d44 <_Z8printIntiii>
    80002f30:	00007517          	auipc	a0,0x7
    80002f34:	45050513          	addi	a0,a0,1104 # 8000a380 <CONSOLE_STATUS+0x370>
    80002f38:	00001097          	auipc	ra,0x1
    80002f3c:	c5c080e7          	jalr	-932(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002f40:	0014849b          	addiw	s1,s1,1
    80002f44:	0ff4f493          	andi	s1,s1,255
    80002f48:	00200793          	li	a5,2
    80002f4c:	fc97f0e3          	bgeu	a5,s1,80002f0c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80002f50:	00007517          	auipc	a0,0x7
    80002f54:	20850513          	addi	a0,a0,520 # 8000a158 <CONSOLE_STATUS+0x148>
    80002f58:	00001097          	auipc	ra,0x1
    80002f5c:	c3c080e7          	jalr	-964(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002f60:	00700313          	li	t1,7
    thread_dispatch();
    80002f64:	ffffe097          	auipc	ra,0xffffe
    80002f68:	328080e7          	jalr	808(ra) # 8000128c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002f6c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002f70:	00007517          	auipc	a0,0x7
    80002f74:	1f850513          	addi	a0,a0,504 # 8000a168 <CONSOLE_STATUS+0x158>
    80002f78:	00001097          	auipc	ra,0x1
    80002f7c:	c1c080e7          	jalr	-996(ra) # 80003b94 <_Z11printStringPKc>
    80002f80:	00000613          	li	a2,0
    80002f84:	00a00593          	li	a1,10
    80002f88:	0009051b          	sext.w	a0,s2
    80002f8c:	00001097          	auipc	ra,0x1
    80002f90:	db8080e7          	jalr	-584(ra) # 80003d44 <_Z8printIntiii>
    80002f94:	00007517          	auipc	a0,0x7
    80002f98:	3ec50513          	addi	a0,a0,1004 # 8000a380 <CONSOLE_STATUS+0x370>
    80002f9c:	00001097          	auipc	ra,0x1
    80002fa0:	bf8080e7          	jalr	-1032(ra) # 80003b94 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80002fa4:	00c00513          	li	a0,12
    80002fa8:	00000097          	auipc	ra,0x0
    80002fac:	d88080e7          	jalr	-632(ra) # 80002d30 <_ZL9fibonaccim>
    80002fb0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002fb4:	00007517          	auipc	a0,0x7
    80002fb8:	1bc50513          	addi	a0,a0,444 # 8000a170 <CONSOLE_STATUS+0x160>
    80002fbc:	00001097          	auipc	ra,0x1
    80002fc0:	bd8080e7          	jalr	-1064(ra) # 80003b94 <_Z11printStringPKc>
    80002fc4:	00000613          	li	a2,0
    80002fc8:	00a00593          	li	a1,10
    80002fcc:	0009051b          	sext.w	a0,s2
    80002fd0:	00001097          	auipc	ra,0x1
    80002fd4:	d74080e7          	jalr	-652(ra) # 80003d44 <_Z8printIntiii>
    80002fd8:	00007517          	auipc	a0,0x7
    80002fdc:	3a850513          	addi	a0,a0,936 # 8000a380 <CONSOLE_STATUS+0x370>
    80002fe0:	00001097          	auipc	ra,0x1
    80002fe4:	bb4080e7          	jalr	-1100(ra) # 80003b94 <_Z11printStringPKc>
    80002fe8:	0400006f          	j	80003028 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80002fec:	00007517          	auipc	a0,0x7
    80002ff0:	16450513          	addi	a0,a0,356 # 8000a150 <CONSOLE_STATUS+0x140>
    80002ff4:	00001097          	auipc	ra,0x1
    80002ff8:	ba0080e7          	jalr	-1120(ra) # 80003b94 <_Z11printStringPKc>
    80002ffc:	00000613          	li	a2,0
    80003000:	00a00593          	li	a1,10
    80003004:	00048513          	mv	a0,s1
    80003008:	00001097          	auipc	ra,0x1
    8000300c:	d3c080e7          	jalr	-708(ra) # 80003d44 <_Z8printIntiii>
    80003010:	00007517          	auipc	a0,0x7
    80003014:	37050513          	addi	a0,a0,880 # 8000a380 <CONSOLE_STATUS+0x370>
    80003018:	00001097          	auipc	ra,0x1
    8000301c:	b7c080e7          	jalr	-1156(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003020:	0014849b          	addiw	s1,s1,1
    80003024:	0ff4f493          	andi	s1,s1,255
    80003028:	00500793          	li	a5,5
    8000302c:	fc97f0e3          	bgeu	a5,s1,80002fec <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80003030:	00007517          	auipc	a0,0x7
    80003034:	15050513          	addi	a0,a0,336 # 8000a180 <CONSOLE_STATUS+0x170>
    80003038:	00001097          	auipc	ra,0x1
    8000303c:	b5c080e7          	jalr	-1188(ra) # 80003b94 <_Z11printStringPKc>
    finishedC = true;
    80003040:	00100793          	li	a5,1
    80003044:	0000a717          	auipc	a4,0xa
    80003048:	bcf702a3          	sb	a5,-1083(a4) # 8000cc09 <_ZL9finishedC>
    thread_dispatch();
    8000304c:	ffffe097          	auipc	ra,0xffffe
    80003050:	240080e7          	jalr	576(ra) # 8000128c <_Z15thread_dispatchv>
}
    80003054:	01813083          	ld	ra,24(sp)
    80003058:	01013403          	ld	s0,16(sp)
    8000305c:	00813483          	ld	s1,8(sp)
    80003060:	00013903          	ld	s2,0(sp)
    80003064:	02010113          	addi	sp,sp,32
    80003068:	00008067          	ret

000000008000306c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000306c:	fe010113          	addi	sp,sp,-32
    80003070:	00113c23          	sd	ra,24(sp)
    80003074:	00813823          	sd	s0,16(sp)
    80003078:	00913423          	sd	s1,8(sp)
    8000307c:	01213023          	sd	s2,0(sp)
    80003080:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003084:	00000913          	li	s2,0
    80003088:	0380006f          	j	800030c0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    8000308c:	ffffe097          	auipc	ra,0xffffe
    80003090:	200080e7          	jalr	512(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003094:	00148493          	addi	s1,s1,1
    80003098:	000027b7          	lui	a5,0x2
    8000309c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800030a0:	0097ee63          	bltu	a5,s1,800030bc <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800030a4:	00000713          	li	a4,0
    800030a8:	000077b7          	lui	a5,0x7
    800030ac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800030b0:	fce7eee3          	bltu	a5,a4,8000308c <_ZL11workerBodyBPv+0x20>
    800030b4:	00170713          	addi	a4,a4,1
    800030b8:	ff1ff06f          	j	800030a8 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800030bc:	00190913          	addi	s2,s2,1
    800030c0:	00f00793          	li	a5,15
    800030c4:	0527e063          	bltu	a5,s2,80003104 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800030c8:	00007517          	auipc	a0,0x7
    800030cc:	07050513          	addi	a0,a0,112 # 8000a138 <CONSOLE_STATUS+0x128>
    800030d0:	00001097          	auipc	ra,0x1
    800030d4:	ac4080e7          	jalr	-1340(ra) # 80003b94 <_Z11printStringPKc>
    800030d8:	00000613          	li	a2,0
    800030dc:	00a00593          	li	a1,10
    800030e0:	0009051b          	sext.w	a0,s2
    800030e4:	00001097          	auipc	ra,0x1
    800030e8:	c60080e7          	jalr	-928(ra) # 80003d44 <_Z8printIntiii>
    800030ec:	00007517          	auipc	a0,0x7
    800030f0:	29450513          	addi	a0,a0,660 # 8000a380 <CONSOLE_STATUS+0x370>
    800030f4:	00001097          	auipc	ra,0x1
    800030f8:	aa0080e7          	jalr	-1376(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800030fc:	00000493          	li	s1,0
    80003100:	f99ff06f          	j	80003098 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003104:	00007517          	auipc	a0,0x7
    80003108:	03c50513          	addi	a0,a0,60 # 8000a140 <CONSOLE_STATUS+0x130>
    8000310c:	00001097          	auipc	ra,0x1
    80003110:	a88080e7          	jalr	-1400(ra) # 80003b94 <_Z11printStringPKc>
    finishedB = true;
    80003114:	00100793          	li	a5,1
    80003118:	0000a717          	auipc	a4,0xa
    8000311c:	aef70923          	sb	a5,-1294(a4) # 8000cc0a <_ZL9finishedB>
    thread_dispatch();
    80003120:	ffffe097          	auipc	ra,0xffffe
    80003124:	16c080e7          	jalr	364(ra) # 8000128c <_Z15thread_dispatchv>
}
    80003128:	01813083          	ld	ra,24(sp)
    8000312c:	01013403          	ld	s0,16(sp)
    80003130:	00813483          	ld	s1,8(sp)
    80003134:	00013903          	ld	s2,0(sp)
    80003138:	02010113          	addi	sp,sp,32
    8000313c:	00008067          	ret

0000000080003140 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003140:	fe010113          	addi	sp,sp,-32
    80003144:	00113c23          	sd	ra,24(sp)
    80003148:	00813823          	sd	s0,16(sp)
    8000314c:	00913423          	sd	s1,8(sp)
    80003150:	01213023          	sd	s2,0(sp)
    80003154:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003158:	00000913          	li	s2,0
    8000315c:	0380006f          	j	80003194 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003160:	ffffe097          	auipc	ra,0xffffe
    80003164:	12c080e7          	jalr	300(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003168:	00148493          	addi	s1,s1,1
    8000316c:	000027b7          	lui	a5,0x2
    80003170:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003174:	0097ee63          	bltu	a5,s1,80003190 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003178:	00000713          	li	a4,0
    8000317c:	000077b7          	lui	a5,0x7
    80003180:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003184:	fce7eee3          	bltu	a5,a4,80003160 <_ZL11workerBodyAPv+0x20>
    80003188:	00170713          	addi	a4,a4,1
    8000318c:	ff1ff06f          	j	8000317c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003190:	00190913          	addi	s2,s2,1
    80003194:	00900793          	li	a5,9
    80003198:	0527e063          	bltu	a5,s2,800031d8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000319c:	00007517          	auipc	a0,0x7
    800031a0:	f8450513          	addi	a0,a0,-124 # 8000a120 <CONSOLE_STATUS+0x110>
    800031a4:	00001097          	auipc	ra,0x1
    800031a8:	9f0080e7          	jalr	-1552(ra) # 80003b94 <_Z11printStringPKc>
    800031ac:	00000613          	li	a2,0
    800031b0:	00a00593          	li	a1,10
    800031b4:	0009051b          	sext.w	a0,s2
    800031b8:	00001097          	auipc	ra,0x1
    800031bc:	b8c080e7          	jalr	-1140(ra) # 80003d44 <_Z8printIntiii>
    800031c0:	00007517          	auipc	a0,0x7
    800031c4:	1c050513          	addi	a0,a0,448 # 8000a380 <CONSOLE_STATUS+0x370>
    800031c8:	00001097          	auipc	ra,0x1
    800031cc:	9cc080e7          	jalr	-1588(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800031d0:	00000493          	li	s1,0
    800031d4:	f99ff06f          	j	8000316c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800031d8:	00007517          	auipc	a0,0x7
    800031dc:	f5050513          	addi	a0,a0,-176 # 8000a128 <CONSOLE_STATUS+0x118>
    800031e0:	00001097          	auipc	ra,0x1
    800031e4:	9b4080e7          	jalr	-1612(ra) # 80003b94 <_Z11printStringPKc>
    finishedA = true;
    800031e8:	00100793          	li	a5,1
    800031ec:	0000a717          	auipc	a4,0xa
    800031f0:	a0f70fa3          	sb	a5,-1505(a4) # 8000cc0b <_ZL9finishedA>
}
    800031f4:	01813083          	ld	ra,24(sp)
    800031f8:	01013403          	ld	s0,16(sp)
    800031fc:	00813483          	ld	s1,8(sp)
    80003200:	00013903          	ld	s2,0(sp)
    80003204:	02010113          	addi	sp,sp,32
    80003208:	00008067          	ret

000000008000320c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000320c:	fd010113          	addi	sp,sp,-48
    80003210:	02113423          	sd	ra,40(sp)
    80003214:	02813023          	sd	s0,32(sp)
    80003218:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000321c:	00000613          	li	a2,0
    80003220:	00000597          	auipc	a1,0x0
    80003224:	f2058593          	addi	a1,a1,-224 # 80003140 <_ZL11workerBodyAPv>
    80003228:	fd040513          	addi	a0,s0,-48
    8000322c:	ffffe097          	auipc	ra,0xffffe
    80003230:	fb8080e7          	jalr	-72(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80003234:	00007517          	auipc	a0,0x7
    80003238:	f9450513          	addi	a0,a0,-108 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    8000323c:	00001097          	auipc	ra,0x1
    80003240:	958080e7          	jalr	-1704(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80003244:	00000613          	li	a2,0
    80003248:	00000597          	auipc	a1,0x0
    8000324c:	e2458593          	addi	a1,a1,-476 # 8000306c <_ZL11workerBodyBPv>
    80003250:	fd840513          	addi	a0,s0,-40
    80003254:	ffffe097          	auipc	ra,0xffffe
    80003258:	f90080e7          	jalr	-112(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    8000325c:	00007517          	auipc	a0,0x7
    80003260:	f8450513          	addi	a0,a0,-124 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80003264:	00001097          	auipc	ra,0x1
    80003268:	930080e7          	jalr	-1744(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000326c:	00000613          	li	a2,0
    80003270:	00000597          	auipc	a1,0x0
    80003274:	c7c58593          	addi	a1,a1,-900 # 80002eec <_ZL11workerBodyCPv>
    80003278:	fe040513          	addi	a0,s0,-32
    8000327c:	ffffe097          	auipc	ra,0xffffe
    80003280:	f68080e7          	jalr	-152(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80003284:	00007517          	auipc	a0,0x7
    80003288:	f7450513          	addi	a0,a0,-140 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    8000328c:	00001097          	auipc	ra,0x1
    80003290:	908080e7          	jalr	-1784(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003294:	00000613          	li	a2,0
    80003298:	00000597          	auipc	a1,0x0
    8000329c:	b0c58593          	addi	a1,a1,-1268 # 80002da4 <_ZL11workerBodyDPv>
    800032a0:	fe840513          	addi	a0,s0,-24
    800032a4:	ffffe097          	auipc	ra,0xffffe
    800032a8:	f40080e7          	jalr	-192(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800032ac:	00007517          	auipc	a0,0x7
    800032b0:	f6450513          	addi	a0,a0,-156 # 8000a210 <CONSOLE_STATUS+0x200>
    800032b4:	00001097          	auipc	ra,0x1
    800032b8:	8e0080e7          	jalr	-1824(ra) # 80003b94 <_Z11printStringPKc>
    800032bc:	00c0006f          	j	800032c8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        //printString("Thread Dispatched CAPITEST\n");
        thread_dispatch();
    800032c0:	ffffe097          	auipc	ra,0xffffe
    800032c4:	fcc080e7          	jalr	-52(ra) # 8000128c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800032c8:	0000a797          	auipc	a5,0xa
    800032cc:	9437c783          	lbu	a5,-1725(a5) # 8000cc0b <_ZL9finishedA>
    800032d0:	fe0788e3          	beqz	a5,800032c0 <_Z18Threads_C_API_testv+0xb4>
    800032d4:	0000a797          	auipc	a5,0xa
    800032d8:	9367c783          	lbu	a5,-1738(a5) # 8000cc0a <_ZL9finishedB>
    800032dc:	fe0782e3          	beqz	a5,800032c0 <_Z18Threads_C_API_testv+0xb4>
    800032e0:	0000a797          	auipc	a5,0xa
    800032e4:	9297c783          	lbu	a5,-1751(a5) # 8000cc09 <_ZL9finishedC>
    800032e8:	fc078ce3          	beqz	a5,800032c0 <_Z18Threads_C_API_testv+0xb4>
    800032ec:	0000a797          	auipc	a5,0xa
    800032f0:	91c7c783          	lbu	a5,-1764(a5) # 8000cc08 <_ZL9finishedD>
    800032f4:	fc0786e3          	beqz	a5,800032c0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800032f8:	02813083          	ld	ra,40(sp)
    800032fc:	02013403          	ld	s0,32(sp)
    80003300:	03010113          	addi	sp,sp,48
    80003304:	00008067          	ret

0000000080003308 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003308:	fd010113          	addi	sp,sp,-48
    8000330c:	02113423          	sd	ra,40(sp)
    80003310:	02813023          	sd	s0,32(sp)
    80003314:	00913c23          	sd	s1,24(sp)
    80003318:	01213823          	sd	s2,16(sp)
    8000331c:	01313423          	sd	s3,8(sp)
    80003320:	03010413          	addi	s0,sp,48
    80003324:	00050993          	mv	s3,a0
    80003328:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;
    int key;
    int i = 0;
    8000332c:	00000913          	li	s2,0
    80003330:	00c0006f          	j	8000333c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = Console::getc()) != 0x30) { //changing here to zero instead of escape character (0x1b) to test
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003334:	00002097          	auipc	ra,0x2
    80003338:	c54080e7          	jalr	-940(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    while ((key = Console::getc()) != 0x30) { //changing here to zero instead of escape character (0x1b) to test
    8000333c:	00002097          	auipc	ra,0x2
    80003340:	e20080e7          	jalr	-480(ra) # 8000515c <_ZN7Console4getcEv>
    80003344:	0005059b          	sext.w	a1,a0
    80003348:	03000793          	li	a5,48
    8000334c:	02f58a63          	beq	a1,a5,80003380 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80003350:	0084b503          	ld	a0,8(s1)
    80003354:	00001097          	auipc	ra,0x1
    80003358:	c64080e7          	jalr	-924(ra) # 80003fb8 <_ZN9BufferCPP3putEi>
        i++;
    8000335c:	0019071b          	addiw	a4,s2,1
    80003360:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003364:	0004a683          	lw	a3,0(s1)
    80003368:	0026979b          	slliw	a5,a3,0x2
    8000336c:	00d787bb          	addw	a5,a5,a3
    80003370:	0017979b          	slliw	a5,a5,0x1
    80003374:	02f767bb          	remw	a5,a4,a5
    80003378:	fc0792e3          	bnez	a5,8000333c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000337c:	fb9ff06f          	j	80003334 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80003380:	00100793          	li	a5,1
    80003384:	0000a717          	auipc	a4,0xa
    80003388:	88f72623          	sw	a5,-1908(a4) # 8000cc10 <_ZL9threadEnd>
    td->buffer->put('!');
    8000338c:	0209b783          	ld	a5,32(s3)
    80003390:	02100593          	li	a1,33
    80003394:	0087b503          	ld	a0,8(a5)
    80003398:	00001097          	auipc	ra,0x1
    8000339c:	c20080e7          	jalr	-992(ra) # 80003fb8 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800033a0:	0104b503          	ld	a0,16(s1)
    800033a4:	00002097          	auipc	ra,0x2
    800033a8:	ccc080e7          	jalr	-820(ra) # 80005070 <_ZN9Semaphore6signalEv>
}
    800033ac:	02813083          	ld	ra,40(sp)
    800033b0:	02013403          	ld	s0,32(sp)
    800033b4:	01813483          	ld	s1,24(sp)
    800033b8:	01013903          	ld	s2,16(sp)
    800033bc:	00813983          	ld	s3,8(sp)
    800033c0:	03010113          	addi	sp,sp,48
    800033c4:	00008067          	ret

00000000800033c8 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800033c8:	fe010113          	addi	sp,sp,-32
    800033cc:	00113c23          	sd	ra,24(sp)
    800033d0:	00813823          	sd	s0,16(sp)
    800033d4:	00913423          	sd	s1,8(sp)
    800033d8:	01213023          	sd	s2,0(sp)
    800033dc:	02010413          	addi	s0,sp,32
    800033e0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;
    int i = 0;
    800033e4:	00000913          	li	s2,0
    800033e8:	00c0006f          	j	800033f4 <_ZN12ProducerSync8producerEPv+0x2c>

        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800033ec:	00002097          	auipc	ra,0x2
    800033f0:	b9c080e7          	jalr	-1124(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800033f4:	0000a797          	auipc	a5,0xa
    800033f8:	81c7a783          	lw	a5,-2020(a5) # 8000cc10 <_ZL9threadEnd>
    800033fc:	02079e63          	bnez	a5,80003438 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80003400:	0004a583          	lw	a1,0(s1)
    80003404:	0305859b          	addiw	a1,a1,48
    80003408:	0084b503          	ld	a0,8(s1)
    8000340c:	00001097          	auipc	ra,0x1
    80003410:	bac080e7          	jalr	-1108(ra) # 80003fb8 <_ZN9BufferCPP3putEi>
        i++;
    80003414:	0019071b          	addiw	a4,s2,1
    80003418:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000341c:	0004a683          	lw	a3,0(s1)
    80003420:	0026979b          	slliw	a5,a3,0x2
    80003424:	00d787bb          	addw	a5,a5,a3
    80003428:	0017979b          	slliw	a5,a5,0x1
    8000342c:	02f767bb          	remw	a5,a4,a5
    80003430:	fc0792e3          	bnez	a5,800033f4 <_ZN12ProducerSync8producerEPv+0x2c>
    80003434:	fb9ff06f          	j	800033ec <_ZN12ProducerSync8producerEPv+0x24>
        }
    }
    data->wait->signal();
    80003438:	0104b503          	ld	a0,16(s1)
    8000343c:	00002097          	auipc	ra,0x2
    80003440:	c34080e7          	jalr	-972(ra) # 80005070 <_ZN9Semaphore6signalEv>
}
    80003444:	01813083          	ld	ra,24(sp)
    80003448:	01013403          	ld	s0,16(sp)
    8000344c:	00813483          	ld	s1,8(sp)
    80003450:	00013903          	ld	s2,0(sp)
    80003454:	02010113          	addi	sp,sp,32
    80003458:	00008067          	ret

000000008000345c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    8000345c:	fd010113          	addi	sp,sp,-48
    80003460:	02113423          	sd	ra,40(sp)
    80003464:	02813023          	sd	s0,32(sp)
    80003468:	00913c23          	sd	s1,24(sp)
    8000346c:	01213823          	sd	s2,16(sp)
    80003470:	01313423          	sd	s3,8(sp)
    80003474:	01413023          	sd	s4,0(sp)
    80003478:	03010413          	addi	s0,sp,48
    8000347c:	00050993          	mv	s3,a0
    80003480:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;
    int i = 0;
    80003484:	00000a13          	li	s4,0
    80003488:	01c0006f          	j	800034a4 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        Console::putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    8000348c:	00002097          	auipc	ra,0x2
    80003490:	afc080e7          	jalr	-1284(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    80003494:	0500006f          	j	800034e4 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            Console::putc('\n');
    80003498:	00a00513          	li	a0,10
    8000349c:	00002097          	auipc	ra,0x2
    800034a0:	ce8080e7          	jalr	-792(ra) # 80005184 <_ZN7Console4putcEc>
    while (!threadEnd) {
    800034a4:	00009797          	auipc	a5,0x9
    800034a8:	76c7a783          	lw	a5,1900(a5) # 8000cc10 <_ZL9threadEnd>
    800034ac:	06079263          	bnez	a5,80003510 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800034b0:	00893503          	ld	a0,8(s2)
    800034b4:	00001097          	auipc	ra,0x1
    800034b8:	b94080e7          	jalr	-1132(ra) # 80004048 <_ZN9BufferCPP3getEv>
        i++;
    800034bc:	001a049b          	addiw	s1,s4,1
    800034c0:	00048a1b          	sext.w	s4,s1
        Console::putc(key);
    800034c4:	0ff57513          	andi	a0,a0,255
    800034c8:	00002097          	auipc	ra,0x2
    800034cc:	cbc080e7          	jalr	-836(ra) # 80005184 <_ZN7Console4putcEc>
        if (i % (5 * data->id) == 0) {
    800034d0:	00092703          	lw	a4,0(s2)
    800034d4:	0027179b          	slliw	a5,a4,0x2
    800034d8:	00e787bb          	addw	a5,a5,a4
    800034dc:	02f4e7bb          	remw	a5,s1,a5
    800034e0:	fa0786e3          	beqz	a5,8000348c <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800034e4:	05000793          	li	a5,80
    800034e8:	02f4e4bb          	remw	s1,s1,a5
    800034ec:	fa049ce3          	bnez	s1,800034a4 <_ZN12ConsumerSync8consumerEPv+0x48>
    800034f0:	fa9ff06f          	j	80003498 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }
    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800034f4:	0209b783          	ld	a5,32(s3)
    800034f8:	0087b503          	ld	a0,8(a5)
    800034fc:	00001097          	auipc	ra,0x1
    80003500:	b4c080e7          	jalr	-1204(ra) # 80004048 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003504:	0ff57513          	andi	a0,a0,255
    80003508:	00002097          	auipc	ra,0x2
    8000350c:	c7c080e7          	jalr	-900(ra) # 80005184 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80003510:	0209b783          	ld	a5,32(s3)
    80003514:	0087b503          	ld	a0,8(a5)
    80003518:	00001097          	auipc	ra,0x1
    8000351c:	bbc080e7          	jalr	-1092(ra) # 800040d4 <_ZN9BufferCPP6getCntEv>
    80003520:	fca04ae3          	bgtz	a0,800034f4 <_ZN12ConsumerSync8consumerEPv+0x98>
    }
    data->wait->signal();
    80003524:	01093503          	ld	a0,16(s2)
    80003528:	00002097          	auipc	ra,0x2
    8000352c:	b48080e7          	jalr	-1208(ra) # 80005070 <_ZN9Semaphore6signalEv>
}
    80003530:	02813083          	ld	ra,40(sp)
    80003534:	02013403          	ld	s0,32(sp)
    80003538:	01813483          	ld	s1,24(sp)
    8000353c:	01013903          	ld	s2,16(sp)
    80003540:	00813983          	ld	s3,8(sp)
    80003544:	00013a03          	ld	s4,0(sp)
    80003548:	03010113          	addi	sp,sp,48
    8000354c:	00008067          	ret

0000000080003550 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003550:	f8010113          	addi	sp,sp,-128
    80003554:	06113c23          	sd	ra,120(sp)
    80003558:	06813823          	sd	s0,112(sp)
    8000355c:	06913423          	sd	s1,104(sp)
    80003560:	07213023          	sd	s2,96(sp)
    80003564:	05313c23          	sd	s3,88(sp)
    80003568:	05413823          	sd	s4,80(sp)
    8000356c:	05513423          	sd	s5,72(sp)
    80003570:	05613023          	sd	s6,64(sp)
    80003574:	03713c23          	sd	s7,56(sp)
    80003578:	03813823          	sd	s8,48(sp)
    8000357c:	03913423          	sd	s9,40(sp)
    80003580:	08010413          	addi	s0,sp,128
        delete threads[i];
    }

    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003584:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003588:	00007517          	auipc	a0,0x7
    8000358c:	a9850513          	addi	a0,a0,-1384 # 8000a020 <CONSOLE_STATUS+0x10>
    80003590:	00000097          	auipc	ra,0x0
    80003594:	604080e7          	jalr	1540(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    80003598:	01e00593          	li	a1,30
    8000359c:	f8040493          	addi	s1,s0,-128
    800035a0:	00048513          	mv	a0,s1
    800035a4:	00000097          	auipc	ra,0x0
    800035a8:	678080e7          	jalr	1656(ra) # 80003c1c <_Z9getStringPci>
    threadNum = stringToInt(input);
    800035ac:	00048513          	mv	a0,s1
    800035b0:	00000097          	auipc	ra,0x0
    800035b4:	744080e7          	jalr	1860(ra) # 80003cf4 <_Z11stringToIntPKc>
    800035b8:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800035bc:	00007517          	auipc	a0,0x7
    800035c0:	a8450513          	addi	a0,a0,-1404 # 8000a040 <CONSOLE_STATUS+0x30>
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	5d0080e7          	jalr	1488(ra) # 80003b94 <_Z11printStringPKc>
    getString(input, 30);
    800035cc:	01e00593          	li	a1,30
    800035d0:	00048513          	mv	a0,s1
    800035d4:	00000097          	auipc	ra,0x0
    800035d8:	648080e7          	jalr	1608(ra) # 80003c1c <_Z9getStringPci>
    n = stringToInt(input);
    800035dc:	00048513          	mv	a0,s1
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	714080e7          	jalr	1812(ra) # 80003cf4 <_Z11stringToIntPKc>
    800035e8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800035ec:	00007517          	auipc	a0,0x7
    800035f0:	a7450513          	addi	a0,a0,-1420 # 8000a060 <CONSOLE_STATUS+0x50>
    800035f4:	00000097          	auipc	ra,0x0
    800035f8:	5a0080e7          	jalr	1440(ra) # 80003b94 <_Z11printStringPKc>
    800035fc:	00000613          	li	a2,0
    80003600:	00a00593          	li	a1,10
    80003604:	00090513          	mv	a0,s2
    80003608:	00000097          	auipc	ra,0x0
    8000360c:	73c080e7          	jalr	1852(ra) # 80003d44 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80003610:	00007517          	auipc	a0,0x7
    80003614:	a6850513          	addi	a0,a0,-1432 # 8000a078 <CONSOLE_STATUS+0x68>
    80003618:	00000097          	auipc	ra,0x0
    8000361c:	57c080e7          	jalr	1404(ra) # 80003b94 <_Z11printStringPKc>
    80003620:	00000613          	li	a2,0
    80003624:	00a00593          	li	a1,10
    80003628:	00048513          	mv	a0,s1
    8000362c:	00000097          	auipc	ra,0x0
    80003630:	718080e7          	jalr	1816(ra) # 80003d44 <_Z8printIntiii>
    printString(".\n");
    80003634:	00007517          	auipc	a0,0x7
    80003638:	a5c50513          	addi	a0,a0,-1444 # 8000a090 <CONSOLE_STATUS+0x80>
    8000363c:	00000097          	auipc	ra,0x0
    80003640:	558080e7          	jalr	1368(ra) # 80003b94 <_Z11printStringPKc>
    if(threadNum > n) {
    80003644:	0324c463          	blt	s1,s2,8000366c <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80003648:	03205c63          	blez	s2,80003680 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    8000364c:	03800513          	li	a0,56
    80003650:	00001097          	auipc	ra,0x1
    80003654:	77c080e7          	jalr	1916(ra) # 80004dcc <_Znwm>
    80003658:	00050a93          	mv	s5,a0
    8000365c:	00048593          	mv	a1,s1
    80003660:	00001097          	auipc	ra,0x1
    80003664:	804080e7          	jalr	-2044(ra) # 80003e64 <_ZN9BufferCPPC1Ei>
    80003668:	0300006f          	j	80003698 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000366c:	00007517          	auipc	a0,0x7
    80003670:	a2c50513          	addi	a0,a0,-1492 # 8000a098 <CONSOLE_STATUS+0x88>
    80003674:	00000097          	auipc	ra,0x0
    80003678:	520080e7          	jalr	1312(ra) # 80003b94 <_Z11printStringPKc>
        return;
    8000367c:	0140006f          	j	80003690 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003680:	00007517          	auipc	a0,0x7
    80003684:	a5850513          	addi	a0,a0,-1448 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    80003688:	00000097          	auipc	ra,0x0
    8000368c:	50c080e7          	jalr	1292(ra) # 80003b94 <_Z11printStringPKc>
        return;
    80003690:	000b8113          	mv	sp,s7
    80003694:	2380006f          	j	800038cc <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003698:	01000513          	li	a0,16
    8000369c:	00001097          	auipc	ra,0x1
    800036a0:	730080e7          	jalr	1840(ra) # 80004dcc <_Znwm>
    800036a4:	00050493          	mv	s1,a0
    800036a8:	00000593          	li	a1,0
    800036ac:	00002097          	auipc	ra,0x2
    800036b0:	960080e7          	jalr	-1696(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    800036b4:	00009797          	auipc	a5,0x9
    800036b8:	5697b223          	sd	s1,1380(a5) # 8000cc18 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800036bc:	00391793          	slli	a5,s2,0x3
    800036c0:	00f78793          	addi	a5,a5,15
    800036c4:	ff07f793          	andi	a5,a5,-16
    800036c8:	40f10133          	sub	sp,sp,a5
    800036cc:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800036d0:	0019071b          	addiw	a4,s2,1
    800036d4:	00171793          	slli	a5,a4,0x1
    800036d8:	00e787b3          	add	a5,a5,a4
    800036dc:	00379793          	slli	a5,a5,0x3
    800036e0:	00f78793          	addi	a5,a5,15
    800036e4:	ff07f793          	andi	a5,a5,-16
    800036e8:	40f10133          	sub	sp,sp,a5
    800036ec:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800036f0:	00191c13          	slli	s8,s2,0x1
    800036f4:	012c07b3          	add	a5,s8,s2
    800036f8:	00379793          	slli	a5,a5,0x3
    800036fc:	00fa07b3          	add	a5,s4,a5
    80003700:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003704:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003708:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    8000370c:	02800513          	li	a0,40
    80003710:	00001097          	auipc	ra,0x1
    80003714:	6bc080e7          	jalr	1724(ra) # 80004dcc <_Znwm>
    80003718:	00050b13          	mv	s6,a0
    8000371c:	012c0c33          	add	s8,s8,s2
    80003720:	003c1c13          	slli	s8,s8,0x3
    80003724:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003728:	00002097          	auipc	ra,0x2
    8000372c:	8b0080e7          	jalr	-1872(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    80003730:	00009797          	auipc	a5,0x9
    80003734:	31078793          	addi	a5,a5,784 # 8000ca40 <_ZTV12ConsumerSync+0x10>
    80003738:	00fb3023          	sd	a5,0(s6)
    8000373c:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80003740:	000b0513          	mv	a0,s6
    80003744:	00001097          	auipc	ra,0x1
    80003748:	7d4080e7          	jalr	2004(ra) # 80004f18 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    8000374c:	00000493          	li	s1,0
    80003750:	0380006f          	j	80003788 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003754:	00009797          	auipc	a5,0x9
    80003758:	2c478793          	addi	a5,a5,708 # 8000ca18 <_ZTV12ProducerSync+0x10>
    8000375c:	00fcb023          	sd	a5,0(s9)
    80003760:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003764:	00349793          	slli	a5,s1,0x3
    80003768:	00f987b3          	add	a5,s3,a5
    8000376c:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003770:	00349793          	slli	a5,s1,0x3
    80003774:	00f987b3          	add	a5,s3,a5
    80003778:	0007b503          	ld	a0,0(a5)
    8000377c:	00001097          	auipc	ra,0x1
    80003780:	79c080e7          	jalr	1948(ra) # 80004f18 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003784:	0014849b          	addiw	s1,s1,1
    80003788:	0b24d063          	bge	s1,s2,80003828 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    8000378c:	00149793          	slli	a5,s1,0x1
    80003790:	009787b3          	add	a5,a5,s1
    80003794:	00379793          	slli	a5,a5,0x3
    80003798:	00fa07b3          	add	a5,s4,a5
    8000379c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800037a0:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800037a4:	00009717          	auipc	a4,0x9
    800037a8:	47473703          	ld	a4,1140(a4) # 8000cc18 <_ZL10waitForAll>
    800037ac:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800037b0:	02905863          	blez	s1,800037e0 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    800037b4:	02800513          	li	a0,40
    800037b8:	00001097          	auipc	ra,0x1
    800037bc:	614080e7          	jalr	1556(ra) # 80004dcc <_Znwm>
    800037c0:	00050c93          	mv	s9,a0
    800037c4:	00149c13          	slli	s8,s1,0x1
    800037c8:	009c0c33          	add	s8,s8,s1
    800037cc:	003c1c13          	slli	s8,s8,0x3
    800037d0:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800037d4:	00002097          	auipc	ra,0x2
    800037d8:	804080e7          	jalr	-2044(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    800037dc:	f79ff06f          	j	80003754 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    800037e0:	02800513          	li	a0,40
    800037e4:	00001097          	auipc	ra,0x1
    800037e8:	5e8080e7          	jalr	1512(ra) # 80004dcc <_Znwm>
    800037ec:	00050c93          	mv	s9,a0
    800037f0:	00149c13          	slli	s8,s1,0x1
    800037f4:	009c0c33          	add	s8,s8,s1
    800037f8:	003c1c13          	slli	s8,s8,0x3
    800037fc:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003800:	00001097          	auipc	ra,0x1
    80003804:	7d8080e7          	jalr	2008(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    80003808:	00009797          	auipc	a5,0x9
    8000380c:	1e878793          	addi	a5,a5,488 # 8000c9f0 <_ZTV16ProducerKeyboard+0x10>
    80003810:	00fcb023          	sd	a5,0(s9)
    80003814:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80003818:	00349793          	slli	a5,s1,0x3
    8000381c:	00f987b3          	add	a5,s3,a5
    80003820:	0197b023          	sd	s9,0(a5)
    80003824:	f4dff06f          	j	80003770 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80003828:	00001097          	auipc	ra,0x1
    8000382c:	760080e7          	jalr	1888(ra) # 80004f88 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003830:	00000493          	li	s1,0
    80003834:	00994e63          	blt	s2,s1,80003850 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80003838:	00009517          	auipc	a0,0x9
    8000383c:	3e053503          	ld	a0,992(a0) # 8000cc18 <_ZL10waitForAll>
    80003840:	00002097          	auipc	ra,0x2
    80003844:	804080e7          	jalr	-2044(ra) # 80005044 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003848:	0014849b          	addiw	s1,s1,1
    8000384c:	fe9ff06f          	j	80003834 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003850:	00000493          	li	s1,0
    80003854:	0080006f          	j	8000385c <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003858:	0014849b          	addiw	s1,s1,1
    8000385c:	0324d263          	bge	s1,s2,80003880 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003860:	00349793          	slli	a5,s1,0x3
    80003864:	00f987b3          	add	a5,s3,a5
    80003868:	0007b503          	ld	a0,0(a5)
    8000386c:	fe0506e3          	beqz	a0,80003858 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003870:	00053783          	ld	a5,0(a0)
    80003874:	0087b783          	ld	a5,8(a5)
    80003878:	000780e7          	jalr	a5
    8000387c:	fddff06f          	j	80003858 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003880:	000b0a63          	beqz	s6,80003894 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003884:	000b3783          	ld	a5,0(s6)
    80003888:	0087b783          	ld	a5,8(a5)
    8000388c:	000b0513          	mv	a0,s6
    80003890:	000780e7          	jalr	a5
    delete waitForAll;
    80003894:	00009517          	auipc	a0,0x9
    80003898:	38453503          	ld	a0,900(a0) # 8000cc18 <_ZL10waitForAll>
    8000389c:	00050863          	beqz	a0,800038ac <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    800038a0:	00053783          	ld	a5,0(a0)
    800038a4:	0087b783          	ld	a5,8(a5)
    800038a8:	000780e7          	jalr	a5
    delete buffer;
    800038ac:	000a8e63          	beqz	s5,800038c8 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    800038b0:	000a8513          	mv	a0,s5
    800038b4:	00001097          	auipc	ra,0x1
    800038b8:	8a8080e7          	jalr	-1880(ra) # 8000415c <_ZN9BufferCPPD1Ev>
    800038bc:	000a8513          	mv	a0,s5
    800038c0:	00001097          	auipc	ra,0x1
    800038c4:	55c080e7          	jalr	1372(ra) # 80004e1c <_ZdlPv>
    800038c8:	000b8113          	mv	sp,s7
    //printString("Ending nicely?\n");
}
    800038cc:	f8040113          	addi	sp,s0,-128
    800038d0:	07813083          	ld	ra,120(sp)
    800038d4:	07013403          	ld	s0,112(sp)
    800038d8:	06813483          	ld	s1,104(sp)
    800038dc:	06013903          	ld	s2,96(sp)
    800038e0:	05813983          	ld	s3,88(sp)
    800038e4:	05013a03          	ld	s4,80(sp)
    800038e8:	04813a83          	ld	s5,72(sp)
    800038ec:	04013b03          	ld	s6,64(sp)
    800038f0:	03813b83          	ld	s7,56(sp)
    800038f4:	03013c03          	ld	s8,48(sp)
    800038f8:	02813c83          	ld	s9,40(sp)
    800038fc:	08010113          	addi	sp,sp,128
    80003900:	00008067          	ret
    80003904:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003908:	000a8513          	mv	a0,s5
    8000390c:	00001097          	auipc	ra,0x1
    80003910:	510080e7          	jalr	1296(ra) # 80004e1c <_ZdlPv>
    80003914:	00048513          	mv	a0,s1
    80003918:	0000a097          	auipc	ra,0xa
    8000391c:	470080e7          	jalr	1136(ra) # 8000dd88 <_Unwind_Resume>
    80003920:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003924:	00048513          	mv	a0,s1
    80003928:	00001097          	auipc	ra,0x1
    8000392c:	4f4080e7          	jalr	1268(ra) # 80004e1c <_ZdlPv>
    80003930:	00090513          	mv	a0,s2
    80003934:	0000a097          	auipc	ra,0xa
    80003938:	454080e7          	jalr	1108(ra) # 8000dd88 <_Unwind_Resume>
    8000393c:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003940:	000b0513          	mv	a0,s6
    80003944:	00001097          	auipc	ra,0x1
    80003948:	4d8080e7          	jalr	1240(ra) # 80004e1c <_ZdlPv>
    8000394c:	00048513          	mv	a0,s1
    80003950:	0000a097          	auipc	ra,0xa
    80003954:	438080e7          	jalr	1080(ra) # 8000dd88 <_Unwind_Resume>
    80003958:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    8000395c:	000c8513          	mv	a0,s9
    80003960:	00001097          	auipc	ra,0x1
    80003964:	4bc080e7          	jalr	1212(ra) # 80004e1c <_ZdlPv>
    80003968:	00048513          	mv	a0,s1
    8000396c:	0000a097          	auipc	ra,0xa
    80003970:	41c080e7          	jalr	1052(ra) # 8000dd88 <_Unwind_Resume>
    80003974:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003978:	000c8513          	mv	a0,s9
    8000397c:	00001097          	auipc	ra,0x1
    80003980:	4a0080e7          	jalr	1184(ra) # 80004e1c <_ZdlPv>
    80003984:	00048513          	mv	a0,s1
    80003988:	0000a097          	auipc	ra,0xa
    8000398c:	400080e7          	jalr	1024(ra) # 8000dd88 <_Unwind_Resume>

0000000080003990 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003990:	ff010113          	addi	sp,sp,-16
    80003994:	00113423          	sd	ra,8(sp)
    80003998:	00813023          	sd	s0,0(sp)
    8000399c:	01010413          	addi	s0,sp,16
    800039a0:	00009797          	auipc	a5,0x9
    800039a4:	0a078793          	addi	a5,a5,160 # 8000ca40 <_ZTV12ConsumerSync+0x10>
    800039a8:	00f53023          	sd	a5,0(a0)
    800039ac:	00001097          	auipc	ra,0x1
    800039b0:	390080e7          	jalr	912(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800039b4:	00813083          	ld	ra,8(sp)
    800039b8:	00013403          	ld	s0,0(sp)
    800039bc:	01010113          	addi	sp,sp,16
    800039c0:	00008067          	ret

00000000800039c4 <_ZN12ConsumerSyncD0Ev>:
    800039c4:	fe010113          	addi	sp,sp,-32
    800039c8:	00113c23          	sd	ra,24(sp)
    800039cc:	00813823          	sd	s0,16(sp)
    800039d0:	00913423          	sd	s1,8(sp)
    800039d4:	02010413          	addi	s0,sp,32
    800039d8:	00050493          	mv	s1,a0
    800039dc:	00009797          	auipc	a5,0x9
    800039e0:	06478793          	addi	a5,a5,100 # 8000ca40 <_ZTV12ConsumerSync+0x10>
    800039e4:	00f53023          	sd	a5,0(a0)
    800039e8:	00001097          	auipc	ra,0x1
    800039ec:	354080e7          	jalr	852(ra) # 80004d3c <_ZN6ThreadD1Ev>
    800039f0:	00048513          	mv	a0,s1
    800039f4:	00001097          	auipc	ra,0x1
    800039f8:	428080e7          	jalr	1064(ra) # 80004e1c <_ZdlPv>
    800039fc:	01813083          	ld	ra,24(sp)
    80003a00:	01013403          	ld	s0,16(sp)
    80003a04:	00813483          	ld	s1,8(sp)
    80003a08:	02010113          	addi	sp,sp,32
    80003a0c:	00008067          	ret

0000000080003a10 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003a10:	ff010113          	addi	sp,sp,-16
    80003a14:	00113423          	sd	ra,8(sp)
    80003a18:	00813023          	sd	s0,0(sp)
    80003a1c:	01010413          	addi	s0,sp,16
    80003a20:	00009797          	auipc	a5,0x9
    80003a24:	ff878793          	addi	a5,a5,-8 # 8000ca18 <_ZTV12ProducerSync+0x10>
    80003a28:	00f53023          	sd	a5,0(a0)
    80003a2c:	00001097          	auipc	ra,0x1
    80003a30:	310080e7          	jalr	784(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80003a34:	00813083          	ld	ra,8(sp)
    80003a38:	00013403          	ld	s0,0(sp)
    80003a3c:	01010113          	addi	sp,sp,16
    80003a40:	00008067          	ret

0000000080003a44 <_ZN12ProducerSyncD0Ev>:
    80003a44:	fe010113          	addi	sp,sp,-32
    80003a48:	00113c23          	sd	ra,24(sp)
    80003a4c:	00813823          	sd	s0,16(sp)
    80003a50:	00913423          	sd	s1,8(sp)
    80003a54:	02010413          	addi	s0,sp,32
    80003a58:	00050493          	mv	s1,a0
    80003a5c:	00009797          	auipc	a5,0x9
    80003a60:	fbc78793          	addi	a5,a5,-68 # 8000ca18 <_ZTV12ProducerSync+0x10>
    80003a64:	00f53023          	sd	a5,0(a0)
    80003a68:	00001097          	auipc	ra,0x1
    80003a6c:	2d4080e7          	jalr	724(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80003a70:	00048513          	mv	a0,s1
    80003a74:	00001097          	auipc	ra,0x1
    80003a78:	3a8080e7          	jalr	936(ra) # 80004e1c <_ZdlPv>
    80003a7c:	01813083          	ld	ra,24(sp)
    80003a80:	01013403          	ld	s0,16(sp)
    80003a84:	00813483          	ld	s1,8(sp)
    80003a88:	02010113          	addi	sp,sp,32
    80003a8c:	00008067          	ret

0000000080003a90 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003a90:	ff010113          	addi	sp,sp,-16
    80003a94:	00113423          	sd	ra,8(sp)
    80003a98:	00813023          	sd	s0,0(sp)
    80003a9c:	01010413          	addi	s0,sp,16
    80003aa0:	00009797          	auipc	a5,0x9
    80003aa4:	f5078793          	addi	a5,a5,-176 # 8000c9f0 <_ZTV16ProducerKeyboard+0x10>
    80003aa8:	00f53023          	sd	a5,0(a0)
    80003aac:	00001097          	auipc	ra,0x1
    80003ab0:	290080e7          	jalr	656(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80003ab4:	00813083          	ld	ra,8(sp)
    80003ab8:	00013403          	ld	s0,0(sp)
    80003abc:	01010113          	addi	sp,sp,16
    80003ac0:	00008067          	ret

0000000080003ac4 <_ZN16ProducerKeyboardD0Ev>:
    80003ac4:	fe010113          	addi	sp,sp,-32
    80003ac8:	00113c23          	sd	ra,24(sp)
    80003acc:	00813823          	sd	s0,16(sp)
    80003ad0:	00913423          	sd	s1,8(sp)
    80003ad4:	02010413          	addi	s0,sp,32
    80003ad8:	00050493          	mv	s1,a0
    80003adc:	00009797          	auipc	a5,0x9
    80003ae0:	f1478793          	addi	a5,a5,-236 # 8000c9f0 <_ZTV16ProducerKeyboard+0x10>
    80003ae4:	00f53023          	sd	a5,0(a0)
    80003ae8:	00001097          	auipc	ra,0x1
    80003aec:	254080e7          	jalr	596(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80003af0:	00048513          	mv	a0,s1
    80003af4:	00001097          	auipc	ra,0x1
    80003af8:	328080e7          	jalr	808(ra) # 80004e1c <_ZdlPv>
    80003afc:	01813083          	ld	ra,24(sp)
    80003b00:	01013403          	ld	s0,16(sp)
    80003b04:	00813483          	ld	s1,8(sp)
    80003b08:	02010113          	addi	sp,sp,32
    80003b0c:	00008067          	ret

0000000080003b10 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003b10:	ff010113          	addi	sp,sp,-16
    80003b14:	00113423          	sd	ra,8(sp)
    80003b18:	00813023          	sd	s0,0(sp)
    80003b1c:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003b20:	02053583          	ld	a1,32(a0)
    80003b24:	fffff097          	auipc	ra,0xfffff
    80003b28:	7e4080e7          	jalr	2020(ra) # 80003308 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003b2c:	00813083          	ld	ra,8(sp)
    80003b30:	00013403          	ld	s0,0(sp)
    80003b34:	01010113          	addi	sp,sp,16
    80003b38:	00008067          	ret

0000000080003b3c <_ZN12ProducerSync3runEv>:
    void run() override {
    80003b3c:	ff010113          	addi	sp,sp,-16
    80003b40:	00113423          	sd	ra,8(sp)
    80003b44:	00813023          	sd	s0,0(sp)
    80003b48:	01010413          	addi	s0,sp,16
        producer(td);
    80003b4c:	02053583          	ld	a1,32(a0)
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	878080e7          	jalr	-1928(ra) # 800033c8 <_ZN12ProducerSync8producerEPv>
    }
    80003b58:	00813083          	ld	ra,8(sp)
    80003b5c:	00013403          	ld	s0,0(sp)
    80003b60:	01010113          	addi	sp,sp,16
    80003b64:	00008067          	ret

0000000080003b68 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003b68:	ff010113          	addi	sp,sp,-16
    80003b6c:	00113423          	sd	ra,8(sp)
    80003b70:	00813023          	sd	s0,0(sp)
    80003b74:	01010413          	addi	s0,sp,16
        consumer(td);
    80003b78:	02053583          	ld	a1,32(a0)
    80003b7c:	00000097          	auipc	ra,0x0
    80003b80:	8e0080e7          	jalr	-1824(ra) # 8000345c <_ZN12ConsumerSync8consumerEPv>
    }
    80003b84:	00813083          	ld	ra,8(sp)
    80003b88:	00013403          	ld	s0,0(sp)
    80003b8c:	01010113          	addi	sp,sp,16
    80003b90:	00008067          	ret

0000000080003b94 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch();
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003b94:	fe010113          	addi	sp,sp,-32
    80003b98:	00113c23          	sd	ra,24(sp)
    80003b9c:	00813823          	sd	s0,16(sp)
    80003ba0:	00913423          	sd	s1,8(sp)
    80003ba4:	02010413          	addi	s0,sp,32
    80003ba8:	00050493          	mv	s1,a0
    LOCK();
    80003bac:	00100613          	li	a2,1
    80003bb0:	00000593          	li	a1,0
    80003bb4:	00009517          	auipc	a0,0x9
    80003bb8:	06c50513          	addi	a0,a0,108 # 8000cc20 <lockPrint>
    80003bbc:	ffffd097          	auipc	ra,0xffffd
    80003bc0:	444080e7          	jalr	1092(ra) # 80001000 <copy_and_swap>
    80003bc4:	00050863          	beqz	a0,80003bd4 <_Z11printStringPKc+0x40>
    80003bc8:	ffffd097          	auipc	ra,0xffffd
    80003bcc:	6c4080e7          	jalr	1732(ra) # 8000128c <_Z15thread_dispatchv>
    80003bd0:	fddff06f          	j	80003bac <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003bd4:	0004c503          	lbu	a0,0(s1)
    80003bd8:	00050a63          	beqz	a0,80003bec <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003bdc:	ffffd097          	auipc	ra,0xffffd
    80003be0:	7d8080e7          	jalr	2008(ra) # 800013b4 <_Z4putcc>
        string++;
    80003be4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003be8:	fedff06f          	j	80003bd4 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003bec:	00000613          	li	a2,0
    80003bf0:	00100593          	li	a1,1
    80003bf4:	00009517          	auipc	a0,0x9
    80003bf8:	02c50513          	addi	a0,a0,44 # 8000cc20 <lockPrint>
    80003bfc:	ffffd097          	auipc	ra,0xffffd
    80003c00:	404080e7          	jalr	1028(ra) # 80001000 <copy_and_swap>
    80003c04:	fe0514e3          	bnez	a0,80003bec <_Z11printStringPKc+0x58>
}
    80003c08:	01813083          	ld	ra,24(sp)
    80003c0c:	01013403          	ld	s0,16(sp)
    80003c10:	00813483          	ld	s1,8(sp)
    80003c14:	02010113          	addi	sp,sp,32
    80003c18:	00008067          	ret

0000000080003c1c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003c1c:	fd010113          	addi	sp,sp,-48
    80003c20:	02113423          	sd	ra,40(sp)
    80003c24:	02813023          	sd	s0,32(sp)
    80003c28:	00913c23          	sd	s1,24(sp)
    80003c2c:	01213823          	sd	s2,16(sp)
    80003c30:	01313423          	sd	s3,8(sp)
    80003c34:	01413023          	sd	s4,0(sp)
    80003c38:	03010413          	addi	s0,sp,48
    80003c3c:	00050993          	mv	s3,a0
    80003c40:	00058a13          	mv	s4,a1
    LOCK();
    80003c44:	00100613          	li	a2,1
    80003c48:	00000593          	li	a1,0
    80003c4c:	00009517          	auipc	a0,0x9
    80003c50:	fd450513          	addi	a0,a0,-44 # 8000cc20 <lockPrint>
    80003c54:	ffffd097          	auipc	ra,0xffffd
    80003c58:	3ac080e7          	jalr	940(ra) # 80001000 <copy_and_swap>
    80003c5c:	00050863          	beqz	a0,80003c6c <_Z9getStringPci+0x50>
    80003c60:	ffffd097          	auipc	ra,0xffffd
    80003c64:	62c080e7          	jalr	1580(ra) # 8000128c <_Z15thread_dispatchv>
    80003c68:	fddff06f          	j	80003c44 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003c6c:	00000913          	li	s2,0
    80003c70:	00090493          	mv	s1,s2
    80003c74:	0019091b          	addiw	s2,s2,1
    80003c78:	03495a63          	bge	s2,s4,80003cac <_Z9getStringPci+0x90>

        cc = getc();
    80003c7c:	ffffd097          	auipc	ra,0xffffd
    80003c80:	710080e7          	jalr	1808(ra) # 8000138c <_Z4getcv>
        if(cc < 1)
    80003c84:	02050463          	beqz	a0,80003cac <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003c88:	009984b3          	add	s1,s3,s1
    80003c8c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003c90:	00a00793          	li	a5,10
    80003c94:	00f50a63          	beq	a0,a5,80003ca8 <_Z9getStringPci+0x8c>
    80003c98:	00d00793          	li	a5,13
    80003c9c:	fcf51ae3          	bne	a0,a5,80003c70 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003ca0:	00090493          	mv	s1,s2
    80003ca4:	0080006f          	j	80003cac <_Z9getStringPci+0x90>
    80003ca8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003cac:	009984b3          	add	s1,s3,s1
    80003cb0:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003cb4:	00000613          	li	a2,0
    80003cb8:	00100593          	li	a1,1
    80003cbc:	00009517          	auipc	a0,0x9
    80003cc0:	f6450513          	addi	a0,a0,-156 # 8000cc20 <lockPrint>
    80003cc4:	ffffd097          	auipc	ra,0xffffd
    80003cc8:	33c080e7          	jalr	828(ra) # 80001000 <copy_and_swap>
    80003ccc:	fe0514e3          	bnez	a0,80003cb4 <_Z9getStringPci+0x98>
    return buf;
}
    80003cd0:	00098513          	mv	a0,s3
    80003cd4:	02813083          	ld	ra,40(sp)
    80003cd8:	02013403          	ld	s0,32(sp)
    80003cdc:	01813483          	ld	s1,24(sp)
    80003ce0:	01013903          	ld	s2,16(sp)
    80003ce4:	00813983          	ld	s3,8(sp)
    80003ce8:	00013a03          	ld	s4,0(sp)
    80003cec:	03010113          	addi	sp,sp,48
    80003cf0:	00008067          	ret

0000000080003cf4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003cf4:	ff010113          	addi	sp,sp,-16
    80003cf8:	00813423          	sd	s0,8(sp)
    80003cfc:	01010413          	addi	s0,sp,16
    80003d00:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003d04:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003d08:	0006c603          	lbu	a2,0(a3)
    80003d0c:	fd06071b          	addiw	a4,a2,-48
    80003d10:	0ff77713          	andi	a4,a4,255
    80003d14:	00900793          	li	a5,9
    80003d18:	02e7e063          	bltu	a5,a4,80003d38 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003d1c:	0025179b          	slliw	a5,a0,0x2
    80003d20:	00a787bb          	addw	a5,a5,a0
    80003d24:	0017979b          	slliw	a5,a5,0x1
    80003d28:	00168693          	addi	a3,a3,1
    80003d2c:	00c787bb          	addw	a5,a5,a2
    80003d30:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003d34:	fd5ff06f          	j	80003d08 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003d38:	00813403          	ld	s0,8(sp)
    80003d3c:	01010113          	addi	sp,sp,16
    80003d40:	00008067          	ret

0000000080003d44 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003d44:	fc010113          	addi	sp,sp,-64
    80003d48:	02113c23          	sd	ra,56(sp)
    80003d4c:	02813823          	sd	s0,48(sp)
    80003d50:	02913423          	sd	s1,40(sp)
    80003d54:	03213023          	sd	s2,32(sp)
    80003d58:	01313c23          	sd	s3,24(sp)
    80003d5c:	04010413          	addi	s0,sp,64
    80003d60:	00050493          	mv	s1,a0
    80003d64:	00058913          	mv	s2,a1
    80003d68:	00060993          	mv	s3,a2
    LOCK();
    80003d6c:	00100613          	li	a2,1
    80003d70:	00000593          	li	a1,0
    80003d74:	00009517          	auipc	a0,0x9
    80003d78:	eac50513          	addi	a0,a0,-340 # 8000cc20 <lockPrint>
    80003d7c:	ffffd097          	auipc	ra,0xffffd
    80003d80:	284080e7          	jalr	644(ra) # 80001000 <copy_and_swap>
    80003d84:	00050863          	beqz	a0,80003d94 <_Z8printIntiii+0x50>
    80003d88:	ffffd097          	auipc	ra,0xffffd
    80003d8c:	504080e7          	jalr	1284(ra) # 8000128c <_Z15thread_dispatchv>
    80003d90:	fddff06f          	j	80003d6c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003d94:	00098463          	beqz	s3,80003d9c <_Z8printIntiii+0x58>
    80003d98:	0804c463          	bltz	s1,80003e20 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003d9c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003da0:	00000593          	li	a1,0
    }

    i = 0;
    80003da4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003da8:	0009079b          	sext.w	a5,s2
    80003dac:	0325773b          	remuw	a4,a0,s2
    80003db0:	00048613          	mv	a2,s1
    80003db4:	0014849b          	addiw	s1,s1,1
    80003db8:	02071693          	slli	a3,a4,0x20
    80003dbc:	0206d693          	srli	a3,a3,0x20
    80003dc0:	00009717          	auipc	a4,0x9
    80003dc4:	c9870713          	addi	a4,a4,-872 # 8000ca58 <digits>
    80003dc8:	00d70733          	add	a4,a4,a3
    80003dcc:	00074683          	lbu	a3,0(a4)
    80003dd0:	fd040713          	addi	a4,s0,-48
    80003dd4:	00c70733          	add	a4,a4,a2
    80003dd8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003ddc:	0005071b          	sext.w	a4,a0
    80003de0:	0325553b          	divuw	a0,a0,s2
    80003de4:	fcf772e3          	bgeu	a4,a5,80003da8 <_Z8printIntiii+0x64>
    if(neg)
    80003de8:	00058c63          	beqz	a1,80003e00 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003dec:	fd040793          	addi	a5,s0,-48
    80003df0:	009784b3          	add	s1,a5,s1
    80003df4:	02d00793          	li	a5,45
    80003df8:	fef48823          	sb	a5,-16(s1)
    80003dfc:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003e00:	fff4849b          	addiw	s1,s1,-1
    80003e04:	0204c463          	bltz	s1,80003e2c <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80003e08:	fd040793          	addi	a5,s0,-48
    80003e0c:	009787b3          	add	a5,a5,s1
    80003e10:	ff07c503          	lbu	a0,-16(a5)
    80003e14:	ffffd097          	auipc	ra,0xffffd
    80003e18:	5a0080e7          	jalr	1440(ra) # 800013b4 <_Z4putcc>
    80003e1c:	fe5ff06f          	j	80003e00 <_Z8printIntiii+0xbc>
        x = -xx;
    80003e20:	4090053b          	negw	a0,s1
        neg = 1;
    80003e24:	00100593          	li	a1,1
        x = -xx;
    80003e28:	f7dff06f          	j	80003da4 <_Z8printIntiii+0x60>

    UNLOCK();
    80003e2c:	00000613          	li	a2,0
    80003e30:	00100593          	li	a1,1
    80003e34:	00009517          	auipc	a0,0x9
    80003e38:	dec50513          	addi	a0,a0,-532 # 8000cc20 <lockPrint>
    80003e3c:	ffffd097          	auipc	ra,0xffffd
    80003e40:	1c4080e7          	jalr	452(ra) # 80001000 <copy_and_swap>
    80003e44:	fe0514e3          	bnez	a0,80003e2c <_Z8printIntiii+0xe8>
    80003e48:	03813083          	ld	ra,56(sp)
    80003e4c:	03013403          	ld	s0,48(sp)
    80003e50:	02813483          	ld	s1,40(sp)
    80003e54:	02013903          	ld	s2,32(sp)
    80003e58:	01813983          	ld	s3,24(sp)
    80003e5c:	04010113          	addi	sp,sp,64
    80003e60:	00008067          	ret

0000000080003e64 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"
#include "../lib/console.h"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003e64:	fd010113          	addi	sp,sp,-48
    80003e68:	02113423          	sd	ra,40(sp)
    80003e6c:	02813023          	sd	s0,32(sp)
    80003e70:	00913c23          	sd	s1,24(sp)
    80003e74:	01213823          	sd	s2,16(sp)
    80003e78:	01313423          	sd	s3,8(sp)
    80003e7c:	03010413          	addi	s0,sp,48
    80003e80:	00050493          	mv	s1,a0
    80003e84:	00058913          	mv	s2,a1
    80003e88:	0015879b          	addiw	a5,a1,1
    80003e8c:	0007851b          	sext.w	a0,a5
    80003e90:	00f4a023          	sw	a5,0(s1)
    80003e94:	0004a823          	sw	zero,16(s1)
    80003e98:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003e9c:	00251513          	slli	a0,a0,0x2
    80003ea0:	ffffd097          	auipc	ra,0xffffd
    80003ea4:	2a4080e7          	jalr	676(ra) # 80001144 <_Z9mem_allocm>
    80003ea8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80003eac:	01000513          	li	a0,16
    80003eb0:	00001097          	auipc	ra,0x1
    80003eb4:	f1c080e7          	jalr	-228(ra) # 80004dcc <_Znwm>
    80003eb8:	00050993          	mv	s3,a0
    80003ebc:	00000593          	li	a1,0
    80003ec0:	00001097          	auipc	ra,0x1
    80003ec4:	14c080e7          	jalr	332(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    80003ec8:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80003ecc:	01000513          	li	a0,16
    80003ed0:	00001097          	auipc	ra,0x1
    80003ed4:	efc080e7          	jalr	-260(ra) # 80004dcc <_Znwm>
    80003ed8:	00050993          	mv	s3,a0
    80003edc:	00090593          	mv	a1,s2
    80003ee0:	00001097          	auipc	ra,0x1
    80003ee4:	12c080e7          	jalr	300(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    80003ee8:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80003eec:	01000513          	li	a0,16
    80003ef0:	00001097          	auipc	ra,0x1
    80003ef4:	edc080e7          	jalr	-292(ra) # 80004dcc <_Znwm>
    80003ef8:	00050913          	mv	s2,a0
    80003efc:	00100593          	li	a1,1
    80003f00:	00001097          	auipc	ra,0x1
    80003f04:	10c080e7          	jalr	268(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    80003f08:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80003f0c:	01000513          	li	a0,16
    80003f10:	00001097          	auipc	ra,0x1
    80003f14:	ebc080e7          	jalr	-324(ra) # 80004dcc <_Znwm>
    80003f18:	00050913          	mv	s2,a0
    80003f1c:	00100593          	li	a1,1
    80003f20:	00001097          	auipc	ra,0x1
    80003f24:	0ec080e7          	jalr	236(ra) # 8000500c <_ZN9SemaphoreC1Ej>
    80003f28:	0324b823          	sd	s2,48(s1)
}
    80003f2c:	02813083          	ld	ra,40(sp)
    80003f30:	02013403          	ld	s0,32(sp)
    80003f34:	01813483          	ld	s1,24(sp)
    80003f38:	01013903          	ld	s2,16(sp)
    80003f3c:	00813983          	ld	s3,8(sp)
    80003f40:	03010113          	addi	sp,sp,48
    80003f44:	00008067          	ret
    80003f48:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80003f4c:	00098513          	mv	a0,s3
    80003f50:	00001097          	auipc	ra,0x1
    80003f54:	ecc080e7          	jalr	-308(ra) # 80004e1c <_ZdlPv>
    80003f58:	00048513          	mv	a0,s1
    80003f5c:	0000a097          	auipc	ra,0xa
    80003f60:	e2c080e7          	jalr	-468(ra) # 8000dd88 <_Unwind_Resume>
    80003f64:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80003f68:	00098513          	mv	a0,s3
    80003f6c:	00001097          	auipc	ra,0x1
    80003f70:	eb0080e7          	jalr	-336(ra) # 80004e1c <_ZdlPv>
    80003f74:	00048513          	mv	a0,s1
    80003f78:	0000a097          	auipc	ra,0xa
    80003f7c:	e10080e7          	jalr	-496(ra) # 8000dd88 <_Unwind_Resume>
    80003f80:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80003f84:	00090513          	mv	a0,s2
    80003f88:	00001097          	auipc	ra,0x1
    80003f8c:	e94080e7          	jalr	-364(ra) # 80004e1c <_ZdlPv>
    80003f90:	00048513          	mv	a0,s1
    80003f94:	0000a097          	auipc	ra,0xa
    80003f98:	df4080e7          	jalr	-524(ra) # 8000dd88 <_Unwind_Resume>
    80003f9c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80003fa0:	00090513          	mv	a0,s2
    80003fa4:	00001097          	auipc	ra,0x1
    80003fa8:	e78080e7          	jalr	-392(ra) # 80004e1c <_ZdlPv>
    80003fac:	00048513          	mv	a0,s1
    80003fb0:	0000a097          	auipc	ra,0xa
    80003fb4:	dd8080e7          	jalr	-552(ra) # 8000dd88 <_Unwind_Resume>

0000000080003fb8 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80003fb8:	fe010113          	addi	sp,sp,-32
    80003fbc:	00113c23          	sd	ra,24(sp)
    80003fc0:	00813823          	sd	s0,16(sp)
    80003fc4:	00913423          	sd	s1,8(sp)
    80003fc8:	01213023          	sd	s2,0(sp)
    80003fcc:	02010413          	addi	s0,sp,32
    80003fd0:	00050493          	mv	s1,a0
    80003fd4:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80003fd8:	01853503          	ld	a0,24(a0)
    80003fdc:	00001097          	auipc	ra,0x1
    80003fe0:	068080e7          	jalr	104(ra) # 80005044 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80003fe4:	0304b503          	ld	a0,48(s1)
    80003fe8:	00001097          	auipc	ra,0x1
    80003fec:	05c080e7          	jalr	92(ra) # 80005044 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80003ff0:	0084b783          	ld	a5,8(s1)
    80003ff4:	0144a703          	lw	a4,20(s1)
    80003ff8:	00271713          	slli	a4,a4,0x2
    80003ffc:	00e787b3          	add	a5,a5,a4
    80004000:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004004:	0144a783          	lw	a5,20(s1)
    80004008:	0017879b          	addiw	a5,a5,1
    8000400c:	0004a703          	lw	a4,0(s1)
    80004010:	02e7e7bb          	remw	a5,a5,a4
    80004014:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004018:	0304b503          	ld	a0,48(s1)
    8000401c:	00001097          	auipc	ra,0x1
    80004020:	054080e7          	jalr	84(ra) # 80005070 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004024:	0204b503          	ld	a0,32(s1)
    80004028:	00001097          	auipc	ra,0x1
    8000402c:	048080e7          	jalr	72(ra) # 80005070 <_ZN9Semaphore6signalEv>

}
    80004030:	01813083          	ld	ra,24(sp)
    80004034:	01013403          	ld	s0,16(sp)
    80004038:	00813483          	ld	s1,8(sp)
    8000403c:	00013903          	ld	s2,0(sp)
    80004040:	02010113          	addi	sp,sp,32
    80004044:	00008067          	ret

0000000080004048 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004048:	fe010113          	addi	sp,sp,-32
    8000404c:	00113c23          	sd	ra,24(sp)
    80004050:	00813823          	sd	s0,16(sp)
    80004054:	00913423          	sd	s1,8(sp)
    80004058:	01213023          	sd	s2,0(sp)
    8000405c:	02010413          	addi	s0,sp,32
    80004060:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004064:	02053503          	ld	a0,32(a0)
    80004068:	00001097          	auipc	ra,0x1
    8000406c:	fdc080e7          	jalr	-36(ra) # 80005044 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004070:	0284b503          	ld	a0,40(s1)
    80004074:	00001097          	auipc	ra,0x1
    80004078:	fd0080e7          	jalr	-48(ra) # 80005044 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000407c:	0084b703          	ld	a4,8(s1)
    80004080:	0104a783          	lw	a5,16(s1)
    80004084:	00279693          	slli	a3,a5,0x2
    80004088:	00d70733          	add	a4,a4,a3
    8000408c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004090:	0017879b          	addiw	a5,a5,1
    80004094:	0004a703          	lw	a4,0(s1)
    80004098:	02e7e7bb          	remw	a5,a5,a4
    8000409c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800040a0:	0284b503          	ld	a0,40(s1)
    800040a4:	00001097          	auipc	ra,0x1
    800040a8:	fcc080e7          	jalr	-52(ra) # 80005070 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800040ac:	0184b503          	ld	a0,24(s1)
    800040b0:	00001097          	auipc	ra,0x1
    800040b4:	fc0080e7          	jalr	-64(ra) # 80005070 <_ZN9Semaphore6signalEv>

    return ret;
}
    800040b8:	00090513          	mv	a0,s2
    800040bc:	01813083          	ld	ra,24(sp)
    800040c0:	01013403          	ld	s0,16(sp)
    800040c4:	00813483          	ld	s1,8(sp)
    800040c8:	00013903          	ld	s2,0(sp)
    800040cc:	02010113          	addi	sp,sp,32
    800040d0:	00008067          	ret

00000000800040d4 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800040d4:	fe010113          	addi	sp,sp,-32
    800040d8:	00113c23          	sd	ra,24(sp)
    800040dc:	00813823          	sd	s0,16(sp)
    800040e0:	00913423          	sd	s1,8(sp)
    800040e4:	01213023          	sd	s2,0(sp)
    800040e8:	02010413          	addi	s0,sp,32
    800040ec:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800040f0:	02853503          	ld	a0,40(a0)
    800040f4:	00001097          	auipc	ra,0x1
    800040f8:	f50080e7          	jalr	-176(ra) # 80005044 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800040fc:	0304b503          	ld	a0,48(s1)
    80004100:	00001097          	auipc	ra,0x1
    80004104:	f44080e7          	jalr	-188(ra) # 80005044 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004108:	0144a783          	lw	a5,20(s1)
    8000410c:	0104a903          	lw	s2,16(s1)
    80004110:	0327ce63          	blt	a5,s2,8000414c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004114:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004118:	0304b503          	ld	a0,48(s1)
    8000411c:	00001097          	auipc	ra,0x1
    80004120:	f54080e7          	jalr	-172(ra) # 80005070 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004124:	0284b503          	ld	a0,40(s1)
    80004128:	00001097          	auipc	ra,0x1
    8000412c:	f48080e7          	jalr	-184(ra) # 80005070 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004130:	00090513          	mv	a0,s2
    80004134:	01813083          	ld	ra,24(sp)
    80004138:	01013403          	ld	s0,16(sp)
    8000413c:	00813483          	ld	s1,8(sp)
    80004140:	00013903          	ld	s2,0(sp)
    80004144:	02010113          	addi	sp,sp,32
    80004148:	00008067          	ret
        ret = cap - head + tail;
    8000414c:	0004a703          	lw	a4,0(s1)
    80004150:	4127093b          	subw	s2,a4,s2
    80004154:	00f9093b          	addw	s2,s2,a5
    80004158:	fc1ff06f          	j	80004118 <_ZN9BufferCPP6getCntEv+0x44>

000000008000415c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000415c:	fe010113          	addi	sp,sp,-32
    80004160:	00113c23          	sd	ra,24(sp)
    80004164:	00813823          	sd	s0,16(sp)
    80004168:	00913423          	sd	s1,8(sp)
    8000416c:	02010413          	addi	s0,sp,32
    80004170:	00050493          	mv	s1,a0
    printString("Buffer deleted!\n");
    80004174:	00006517          	auipc	a0,0x6
    80004178:	0b450513          	addi	a0,a0,180 # 8000a228 <CONSOLE_STATUS+0x218>
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	a18080e7          	jalr	-1512(ra) # 80003b94 <_Z11printStringPKc>
    while (getCnt()) {
    80004184:	00048513          	mv	a0,s1
    80004188:	00000097          	auipc	ra,0x0
    8000418c:	f4c080e7          	jalr	-180(ra) # 800040d4 <_ZN9BufferCPP6getCntEv>
    80004190:	02050c63          	beqz	a0,800041c8 <_ZN9BufferCPPD1Ev+0x6c>
        char ch = buffer[head];
    80004194:	0084b783          	ld	a5,8(s1)
    80004198:	0104a703          	lw	a4,16(s1)
    8000419c:	00271713          	slli	a4,a4,0x2
    800041a0:	00e787b3          	add	a5,a5,a4
        __putc(ch);
    800041a4:	0007c503          	lbu	a0,0(a5)
    800041a8:	00005097          	auipc	ra,0x5
    800041ac:	654080e7          	jalr	1620(ra) # 800097fc <__putc>
        head = (head + 1) % cap;
    800041b0:	0104a783          	lw	a5,16(s1)
    800041b4:	0017879b          	addiw	a5,a5,1
    800041b8:	0004a703          	lw	a4,0(s1)
    800041bc:	02e7e7bb          	remw	a5,a5,a4
    800041c0:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800041c4:	fc1ff06f          	j	80004184 <_ZN9BufferCPPD1Ev+0x28>
    mem_free(buffer);
    800041c8:	0084b503          	ld	a0,8(s1)
    800041cc:	ffffd097          	auipc	ra,0xffffd
    800041d0:	fa4080e7          	jalr	-92(ra) # 80001170 <_Z8mem_freePv>
    delete itemAvailable;
    800041d4:	0204b503          	ld	a0,32(s1)
    800041d8:	00050863          	beqz	a0,800041e8 <_ZN9BufferCPPD1Ev+0x8c>
    800041dc:	00053783          	ld	a5,0(a0)
    800041e0:	0087b783          	ld	a5,8(a5)
    800041e4:	000780e7          	jalr	a5
    delete spaceAvailable;
    800041e8:	0184b503          	ld	a0,24(s1)
    800041ec:	00050863          	beqz	a0,800041fc <_ZN9BufferCPPD1Ev+0xa0>
    800041f0:	00053783          	ld	a5,0(a0)
    800041f4:	0087b783          	ld	a5,8(a5)
    800041f8:	000780e7          	jalr	a5
    delete mutexTail;
    800041fc:	0304b503          	ld	a0,48(s1)
    80004200:	00050863          	beqz	a0,80004210 <_ZN9BufferCPPD1Ev+0xb4>
    80004204:	00053783          	ld	a5,0(a0)
    80004208:	0087b783          	ld	a5,8(a5)
    8000420c:	000780e7          	jalr	a5
    delete mutexHead;
    80004210:	0284b503          	ld	a0,40(s1)
    80004214:	00050863          	beqz	a0,80004224 <_ZN9BufferCPPD1Ev+0xc8>
    80004218:	00053783          	ld	a5,0(a0)
    8000421c:	0087b783          	ld	a5,8(a5)
    80004220:	000780e7          	jalr	a5
}
    80004224:	01813083          	ld	ra,24(sp)
    80004228:	01013403          	ld	s0,16(sp)
    8000422c:	00813483          	ld	s1,8(sp)
    80004230:	02010113          	addi	sp,sp,32
    80004234:	00008067          	ret

0000000080004238 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80004238:	fe010113          	addi	sp,sp,-32
    8000423c:	00113c23          	sd	ra,24(sp)
    80004240:	00813823          	sd	s0,16(sp)
    80004244:	00913423          	sd	s1,8(sp)
    80004248:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    8000424c:	00006517          	auipc	a0,0x6
    80004250:	ff450513          	addi	a0,a0,-12 # 8000a240 <CONSOLE_STATUS+0x230>
    80004254:	00000097          	auipc	ra,0x0
    80004258:	940080e7          	jalr	-1728(ra) # 80003b94 <_Z11printStringPKc>
    int test = getc() - '0';
    8000425c:	ffffd097          	auipc	ra,0xffffd
    80004260:	130080e7          	jalr	304(ra) # 8000138c <_Z4getcv>
    80004264:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80004268:	ffffd097          	auipc	ra,0xffffd
    8000426c:	124080e7          	jalr	292(ra) # 8000138c <_Z4getcv>
    }
    /*putc('\n');
    printInt(test);
    putc('\n');*/

    switch (test) {
    80004270:	00700793          	li	a5,7
    80004274:	1097e263          	bltu	a5,s1,80004378 <_Z8userMainv+0x140>
    80004278:	00249493          	slli	s1,s1,0x2
    8000427c:	00006717          	auipc	a4,0x6
    80004280:	21c70713          	addi	a4,a4,540 # 8000a498 <CONSOLE_STATUS+0x488>
    80004284:	00e484b3          	add	s1,s1,a4
    80004288:	0004a783          	lw	a5,0(s1)
    8000428c:	00e787b3          	add	a5,a5,a4
    80004290:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80004294:	fffff097          	auipc	ra,0xfffff
    80004298:	f78080e7          	jalr	-136(ra) # 8000320c <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    8000429c:	00006517          	auipc	a0,0x6
    800042a0:	fc450513          	addi	a0,a0,-60 # 8000a260 <CONSOLE_STATUS+0x250>
    800042a4:	00000097          	auipc	ra,0x0
    800042a8:	8f0080e7          	jalr	-1808(ra) # 80003b94 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800042ac:	01813083          	ld	ra,24(sp)
    800042b0:	01013403          	ld	s0,16(sp)
    800042b4:	00813483          	ld	s1,8(sp)
    800042b8:	02010113          	addi	sp,sp,32
    800042bc:	00008067          	ret
            Threads_CPP_API_test();//errors in cpp api send back like in c api
    800042c0:	ffffe097          	auipc	ra,0xffffe
    800042c4:	e2c080e7          	jalr	-468(ra) # 800020ec <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    800042c8:	00006517          	auipc	a0,0x6
    800042cc:	fd850513          	addi	a0,a0,-40 # 8000a2a0 <CONSOLE_STATUS+0x290>
    800042d0:	00000097          	auipc	ra,0x0
    800042d4:	8c4080e7          	jalr	-1852(ra) # 80003b94 <_Z11printStringPKc>
            break;
    800042d8:	fd5ff06f          	j	800042ac <_Z8userMainv+0x74>
            producerConsumer_C_API();
    800042dc:	ffffd097          	auipc	ra,0xffffd
    800042e0:	320080e7          	jalr	800(ra) # 800015fc <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    800042e4:	00006517          	auipc	a0,0x6
    800042e8:	ffc50513          	addi	a0,a0,-4 # 8000a2e0 <CONSOLE_STATUS+0x2d0>
    800042ec:	00000097          	auipc	ra,0x0
    800042f0:	8a8080e7          	jalr	-1880(ra) # 80003b94 <_Z11printStringPKc>
            break;
    800042f4:	fb9ff06f          	j	800042ac <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	258080e7          	jalr	600(ra) # 80003550 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80004300:	00006517          	auipc	a0,0x6
    80004304:	03050513          	addi	a0,a0,48 # 8000a330 <CONSOLE_STATUS+0x320>
    80004308:	00000097          	auipc	ra,0x0
    8000430c:	88c080e7          	jalr	-1908(ra) # 80003b94 <_Z11printStringPKc>
            break;
    80004310:	f9dff06f          	j	800042ac <_Z8userMainv+0x74>
            testSleeping();
    80004314:	00001097          	auipc	ra,0x1
    80004318:	fec080e7          	jalr	-20(ra) # 80005300 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    8000431c:	00006517          	auipc	a0,0x6
    80004320:	06c50513          	addi	a0,a0,108 # 8000a388 <CONSOLE_STATUS+0x378>
    80004324:	00000097          	auipc	ra,0x0
    80004328:	870080e7          	jalr	-1936(ra) # 80003b94 <_Z11printStringPKc>
            break;
    8000432c:	f81ff06f          	j	800042ac <_Z8userMainv+0x74>
            testConsumerProducer();
    80004330:	ffffe097          	auipc	ra,0xffffe
    80004334:	27c080e7          	jalr	636(ra) # 800025ac <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80004338:	00006517          	auipc	a0,0x6
    8000433c:	08050513          	addi	a0,a0,128 # 8000a3b8 <CONSOLE_STATUS+0x3a8>
    80004340:	00000097          	auipc	ra,0x0
    80004344:	854080e7          	jalr	-1964(ra) # 80003b94 <_Z11printStringPKc>
            break;
    80004348:	f65ff06f          	j	800042ac <_Z8userMainv+0x74>
            System_Mode_test();
    8000434c:	00003097          	auipc	ra,0x3
    80004350:	86c080e7          	jalr	-1940(ra) # 80006bb8 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80004354:	00006517          	auipc	a0,0x6
    80004358:	0a450513          	addi	a0,a0,164 # 8000a3f8 <CONSOLE_STATUS+0x3e8>
    8000435c:	00000097          	auipc	ra,0x0
    80004360:	838080e7          	jalr	-1992(ra) # 80003b94 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80004364:	00006517          	auipc	a0,0x6
    80004368:	0b450513          	addi	a0,a0,180 # 8000a418 <CONSOLE_STATUS+0x408>
    8000436c:	00000097          	auipc	ra,0x0
    80004370:	828080e7          	jalr	-2008(ra) # 80003b94 <_Z11printStringPKc>
            break;
    80004374:	f39ff06f          	j	800042ac <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80004378:	00006517          	auipc	a0,0x6
    8000437c:	0f850513          	addi	a0,a0,248 # 8000a470 <CONSOLE_STATUS+0x460>
    80004380:	00000097          	auipc	ra,0x0
    80004384:	814080e7          	jalr	-2028(ra) # 80003b94 <_Z11printStringPKc>
    80004388:	f25ff06f          	j	800042ac <_Z8userMainv+0x74>

000000008000438c <_Z41__static_initialization_and_destruction_0ii>:

        }
    }

    return;
    8000438c:	ff010113          	addi	sp,sp,-16
    80004390:	00813423          	sd	s0,8(sp)
    80004394:	01010413          	addi	s0,sp,16
    80004398:	00100793          	li	a5,1
    8000439c:	00f50863          	beq	a0,a5,800043ac <_Z41__static_initialization_and_destruction_0ii+0x20>
    800043a0:	00813403          	ld	s0,8(sp)
    800043a4:	01010113          	addi	sp,sp,16
    800043a8:	00008067          	ret
    800043ac:	000107b7          	lui	a5,0x10
    800043b0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800043b4:	fef596e3          	bne	a1,a5,800043a0 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *curr, *head, *tail;

public:
    Sleep_list() : curr(0), head(0), tail(0) {}
    800043b8:	00009797          	auipc	a5,0x9
    800043bc:	87078793          	addi	a5,a5,-1936 # 8000cc28 <_ZN7Sleeper5sleepE>
    800043c0:	0007b023          	sd	zero,0(a5)
    800043c4:	0007b423          	sd	zero,8(a5)
    800043c8:	0007b823          	sd	zero,16(a5)
    800043cc:	fd5ff06f          	j	800043a0 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800043d0 <_ZN7Sleeper10time_sleepEm>:
    if(time <= 0) return -1;
    800043d0:	1c050663          	beqz	a0,8000459c <_ZN7Sleeper10time_sleepEm+0x1cc>
{
    800043d4:	fe010113          	addi	sp,sp,-32
    800043d8:	00113c23          	sd	ra,24(sp)
    800043dc:	00813823          	sd	s0,16(sp)
    800043e0:	00913423          	sd	s1,8(sp)
    800043e4:	01213023          	sd	s2,0(sp)
    800043e8:	02010413          	addi	s0,sp,32
    800043ec:	00050493          	mv	s1,a0
    TCB *tcb = TCB::running;
    800043f0:	00008797          	auipc	a5,0x8
    800043f4:	7707b783          	ld	a5,1904(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    800043f8:	0007b903          	ld	s2,0(a5)
    if(tcb == nullptr) return -2;
    800043fc:	1a090463          	beqz	s2,800045a4 <_ZN7Sleeper10time_sleepEm+0x1d4>

    void setFinished(bool value) { finished = value; }

    uint64 getTimeSlice() const { return timeSlice; }

    bool isBlocked() const { return t_blocked; }
    80004400:	02994783          	lbu	a5,41(s2)
    if(tcb->isBlocked() || tcb->isFinished()) return -3;
    80004404:	1a079463          	bnez	a5,800045ac <_ZN7Sleeper10time_sleepEm+0x1dc>
    bool isFinished() const { return finished; }
    80004408:	02894783          	lbu	a5,40(s2)
    8000440c:	1a079463          	bnez	a5,800045b4 <_ZN7Sleeper10time_sleepEm+0x1e4>
    tcb->t_blocked = true;
    80004410:	00100793          	li	a5,1
    80004414:	02f904a3          	sb	a5,41(s2)

    void add(TCB* data, time_t time)//subtract time properly
    {

        time_t time_test = time;
        if(head == 0)
    80004418:	00009797          	auipc	a5,0x9
    8000441c:	8187b783          	ld	a5,-2024(a5) # 8000cc30 <_ZN7Sleeper5sleepE+0x8>
    80004420:	02078e63          	beqz	a5,8000445c <_ZN7Sleeper10time_sleepEm+0x8c>
        {
            Elem *elem = new Elem(data, 0, 0, time);
            head = elem;
            if (!tail) { tail = head; }
            return;
        } else if( head->time > time ) {
    80004424:	0187b703          	ld	a4,24(a5)
    80004428:	06e56863          	bltu	a0,a4,80004498 <_ZN7Sleeper10time_sleepEm+0xc8>
            head->prev = elem;
            head->time -= time;
            head = elem;
            return;
        } else {
            curr = head;
    8000442c:	00008717          	auipc	a4,0x8
    80004430:	7ef73e23          	sd	a5,2044(a4) # 8000cc28 <_ZN7Sleeper5sleepE>
            while(curr && ( curr->time <= time_test) ) {
    80004434:	00008797          	auipc	a5,0x8
    80004438:	7f47b783          	ld	a5,2036(a5) # 8000cc28 <_ZN7Sleeper5sleepE>
    8000443c:	0a078063          	beqz	a5,800044dc <_ZN7Sleeper10time_sleepEm+0x10c>
    80004440:	0187b703          	ld	a4,24(a5)
    80004444:	08e4ec63          	bltu	s1,a4,800044dc <_ZN7Sleeper10time_sleepEm+0x10c>
                time_test -= curr->time;
    80004448:	40e484b3          	sub	s1,s1,a4
                curr = curr->next;
    8000444c:	0087b783          	ld	a5,8(a5)
    80004450:	00008717          	auipc	a4,0x8
    80004454:	7cf73c23          	sd	a5,2008(a4) # 8000cc28 <_ZN7Sleeper5sleepE>
            while(curr && ( curr->time <= time_test) ) {
    80004458:	fddff06f          	j	80004434 <_ZN7Sleeper10time_sleepEm+0x64>
           return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    8000445c:	02000513          	li	a0,32
    80004460:	00003097          	auipc	ra,0x3
    80004464:	854080e7          	jalr	-1964(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
        Elem(TCB *data, Elem *next, Elem *prev, time_t time) : data(data), next(next), prev(prev), time(time) {}
    80004468:	01253023          	sd	s2,0(a0)
    8000446c:	00053423          	sd	zero,8(a0)
    80004470:	00053823          	sd	zero,16(a0)
    80004474:	00953c23          	sd	s1,24(a0)
            head = elem;
    80004478:	00008797          	auipc	a5,0x8
    8000447c:	7b078793          	addi	a5,a5,1968 # 8000cc28 <_ZN7Sleeper5sleepE>
    80004480:	00a7b423          	sd	a0,8(a5)
            if (!tail) { tail = head; }
    80004484:	0107b783          	ld	a5,16(a5)
    80004488:	0a079663          	bnez	a5,80004534 <_ZN7Sleeper10time_sleepEm+0x164>
    8000448c:	00008797          	auipc	a5,0x8
    80004490:	7aa7b623          	sd	a0,1964(a5) # 8000cc38 <_ZN7Sleeper5sleepE+0x10>
            return;
    80004494:	0a00006f          	j	80004534 <_ZN7Sleeper10time_sleepEm+0x164>
           return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    80004498:	02000513          	li	a0,32
    8000449c:	00003097          	auipc	ra,0x3
    800044a0:	818080e7          	jalr	-2024(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
            Elem *elem = new Elem(data, head, 0, time);
    800044a4:	00008797          	auipc	a5,0x8
    800044a8:	78478793          	addi	a5,a5,1924 # 8000cc28 <_ZN7Sleeper5sleepE>
    800044ac:	0087b703          	ld	a4,8(a5)
        Elem(TCB *data, Elem *next, Elem *prev, time_t time) : data(data), next(next), prev(prev), time(time) {}
    800044b0:	01253023          	sd	s2,0(a0)
    800044b4:	00e53423          	sd	a4,8(a0)
    800044b8:	00053823          	sd	zero,16(a0)
    800044bc:	00953c23          	sd	s1,24(a0)
            head->prev = elem;
    800044c0:	0087b703          	ld	a4,8(a5)
    800044c4:	00a73823          	sd	a0,16(a4)
            head->time -= time;
    800044c8:	01873683          	ld	a3,24(a4)
    800044cc:	409684b3          	sub	s1,a3,s1
    800044d0:	00973c23          	sd	s1,24(a4)
            head = elem;
    800044d4:	00a7b423          	sd	a0,8(a5)
            return;
    800044d8:	05c0006f          	j	80004534 <_ZN7Sleeper10time_sleepEm+0x164>
            }

            if(curr){
    800044dc:	08078463          	beqz	a5,80004564 <_ZN7Sleeper10time_sleepEm+0x194>
           return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    800044e0:	02000513          	li	a0,32
    800044e4:	00002097          	auipc	ra,0x2
    800044e8:	7d0080e7          	jalr	2000(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
                Elem *elem = new Elem(data, curr, curr->prev, time_test);
    800044ec:	00008797          	auipc	a5,0x8
    800044f0:	73c78793          	addi	a5,a5,1852 # 8000cc28 <_ZN7Sleeper5sleepE>
    800044f4:	0007b703          	ld	a4,0(a5)
    800044f8:	01073683          	ld	a3,16(a4)
        Elem(TCB *data, Elem *next, Elem *prev, time_t time) : data(data), next(next), prev(prev), time(time) {}
    800044fc:	01253023          	sd	s2,0(a0)
    80004500:	00e53423          	sd	a4,8(a0)
    80004504:	00d53823          	sd	a3,16(a0)
    80004508:	00953c23          	sd	s1,24(a0)
                if(curr->prev) curr->prev->next = elem;
    8000450c:	0007b783          	ld	a5,0(a5)
    80004510:	0107b783          	ld	a5,16(a5)
    80004514:	00078463          	beqz	a5,8000451c <_ZN7Sleeper10time_sleepEm+0x14c>
    80004518:	00a7b423          	sd	a0,8(a5)
                curr->prev = elem;
    8000451c:	00008797          	auipc	a5,0x8
    80004520:	70c7b783          	ld	a5,1804(a5) # 8000cc28 <_ZN7Sleeper5sleepE>
    80004524:	00a7b823          	sd	a0,16(a5)
                curr->time -= time_test;
    80004528:	0187b503          	ld	a0,24(a5)
    8000452c:	409504b3          	sub	s1,a0,s1
    80004530:	0097bc23          	sd	s1,24(a5)
    TCB::timeSliceCounter=0;
    80004534:	00008797          	auipc	a5,0x8
    80004538:	5dc7b783          	ld	a5,1500(a5) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000453c:	0007b023          	sd	zero,0(a5)
    TCB::dispatch();
    80004540:	00000097          	auipc	ra,0x0
    80004544:	708080e7          	jalr	1800(ra) # 80004c48 <_ZN3TCB8dispatchEv>
    return 0;
    80004548:	00000513          	li	a0,0
}
    8000454c:	01813083          	ld	ra,24(sp)
    80004550:	01013403          	ld	s0,16(sp)
    80004554:	00813483          	ld	s1,8(sp)
    80004558:	00013903          	ld	s2,0(sp)
    8000455c:	02010113          	addi	sp,sp,32
    80004560:	00008067          	ret
           return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    80004564:	02000513          	li	a0,32
    80004568:	00002097          	auipc	ra,0x2
    8000456c:	74c080e7          	jalr	1868(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
                return;
            }else{
                Elem *elem = new Elem(data, 0, tail, time_test);
    80004570:	00008797          	auipc	a5,0x8
    80004574:	6b878793          	addi	a5,a5,1720 # 8000cc28 <_ZN7Sleeper5sleepE>
    80004578:	0107b703          	ld	a4,16(a5)
        Elem(TCB *data, Elem *next, Elem *prev, time_t time) : data(data), next(next), prev(prev), time(time) {}
    8000457c:	01253023          	sd	s2,0(a0)
    80004580:	00053423          	sd	zero,8(a0)
    80004584:	00e53823          	sd	a4,16(a0)
    80004588:	00953c23          	sd	s1,24(a0)
                tail->next = elem;
    8000458c:	0107b703          	ld	a4,16(a5)
    80004590:	00a73423          	sd	a0,8(a4)
                tail = elem;
    80004594:	00a7b823          	sd	a0,16(a5)
                return;
    80004598:	f9dff06f          	j	80004534 <_ZN7Sleeper10time_sleepEm+0x164>
    if(time <= 0) return -1;
    8000459c:	fff00513          	li	a0,-1
}
    800045a0:	00008067          	ret
    if(tcb == nullptr) return -2;
    800045a4:	ffe00513          	li	a0,-2
    800045a8:	fa5ff06f          	j	8000454c <_ZN7Sleeper10time_sleepEm+0x17c>
    if(tcb->isBlocked() || tcb->isFinished()) return -3;
    800045ac:	ffd00513          	li	a0,-3
    800045b0:	f9dff06f          	j	8000454c <_ZN7Sleeper10time_sleepEm+0x17c>
    800045b4:	ffd00513          	li	a0,-3
    800045b8:	f95ff06f          	j	8000454c <_ZN7Sleeper10time_sleepEm+0x17c>

00000000800045bc <_ZN7Sleeper6awakenEv>:
        return ret;
    }

    TCB *peekFirst()
    {
        if (!head) { return 0; }
    800045bc:	00008797          	auipc	a5,0x8
    800045c0:	6747b783          	ld	a5,1652(a5) # 8000cc30 <_ZN7Sleeper5sleepE+0x8>
    800045c4:	0a078263          	beqz	a5,80004668 <_ZN7Sleeper6awakenEv+0xac>
        return head->data;
    800045c8:	0007b703          	ld	a4,0(a5)
    if(sleep.peekFirst() != 0)
    800045cc:	08070e63          	beqz	a4,80004668 <_ZN7Sleeper6awakenEv+0xac>
        sleep.head->time -= 1;
    800045d0:	0187b703          	ld	a4,24(a5)
    800045d4:	fff70713          	addi	a4,a4,-1
    800045d8:	00e7bc23          	sd	a4,24(a5)
        while(sleep.head && sleep.head->time == 0)
    800045dc:	00008517          	auipc	a0,0x8
    800045e0:	65453503          	ld	a0,1620(a0) # 8000cc30 <_ZN7Sleeper5sleepE+0x8>
    800045e4:	08050263          	beqz	a0,80004668 <_ZN7Sleeper6awakenEv+0xac>
    800045e8:	01853783          	ld	a5,24(a0)
    800045ec:	06079e63          	bnez	a5,80004668 <_ZN7Sleeper6awakenEv+0xac>
{
    800045f0:	fe010113          	addi	sp,sp,-32
    800045f4:	00113c23          	sd	ra,24(sp)
    800045f8:	00813823          	sd	s0,16(sp)
    800045fc:	00913423          	sd	s1,8(sp)
    80004600:	02010413          	addi	s0,sp,32
    80004604:	03c0006f          	j	80004640 <_ZN7Sleeper6awakenEv+0x84>
        if (!head) { tail = 0; }
    80004608:	00008797          	auipc	a5,0x8
    8000460c:	6207b823          	sd	zero,1584(a5) # 8000cc38 <_ZN7Sleeper5sleepE+0x10>
        TCB *ret = elem->data;
    80004610:	00053483          	ld	s1,0(a0)
            MemoryAllocator::mem_free(ptr);
    80004614:	00003097          	auipc	ra,0x3
    80004618:	988080e7          	jalr	-1656(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
            tcb->t_blocked = false;
    8000461c:	020484a3          	sb	zero,41(s1)
            Scheduler::put(tcb);
    80004620:	00048513          	mv	a0,s1
    80004624:	00002097          	auipc	ra,0x2
    80004628:	008080e7          	jalr	8(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
        while(sleep.head && sleep.head->time == 0)
    8000462c:	00008517          	auipc	a0,0x8
    80004630:	60453503          	ld	a0,1540(a0) # 8000cc30 <_ZN7Sleeper5sleepE+0x8>
    80004634:	02050063          	beqz	a0,80004654 <_ZN7Sleeper6awakenEv+0x98>
    80004638:	01853783          	ld	a5,24(a0)
    8000463c:	00079c63          	bnez	a5,80004654 <_ZN7Sleeper6awakenEv+0x98>
        head = head->next;
    80004640:	00853783          	ld	a5,8(a0)
    80004644:	00008717          	auipc	a4,0x8
    80004648:	5ef73623          	sd	a5,1516(a4) # 8000cc30 <_ZN7Sleeper5sleepE+0x8>
        if (!head) { tail = 0; }
    8000464c:	fc0792e3          	bnez	a5,80004610 <_ZN7Sleeper6awakenEv+0x54>
    80004650:	fb9ff06f          	j	80004608 <_ZN7Sleeper6awakenEv+0x4c>
    80004654:	01813083          	ld	ra,24(sp)
    80004658:	01013403          	ld	s0,16(sp)
    8000465c:	00813483          	ld	s1,8(sp)
    80004660:	02010113          	addi	sp,sp,32
    80004664:	00008067          	ret
    80004668:	00008067          	ret

000000008000466c <_GLOBAL__sub_I__ZN7Sleeper5sleepE>:
    8000466c:	ff010113          	addi	sp,sp,-16
    80004670:	00113423          	sd	ra,8(sp)
    80004674:	00813023          	sd	s0,0(sp)
    80004678:	01010413          	addi	s0,sp,16
    8000467c:	000105b7          	lui	a1,0x10
    80004680:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80004684:	00100513          	li	a0,1
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	d04080e7          	jalr	-764(ra) # 8000438c <_Z41__static_initialization_and_destruction_0ii>
    80004690:	00813083          	ld	ra,8(sp)
    80004694:	00013403          	ld	s0,0(sp)
    80004698:	01010113          	addi	sp,sp,16
    8000469c:	00008067          	ret

00000000800046a0 <main>:
//things we need to make but can use beforehand are in console.h

extern void userMain();
extern void workerTest10();

void main() {
    800046a0:	fe010113          	addi	sp,sp,-32
    800046a4:	00113c23          	sd	ra,24(sp)
    800046a8:	00813823          	sd	s0,16(sp)
    800046ac:	00913423          	sd	s1,8(sp)
    800046b0:	01213023          	sd	s2,0(sp)
    800046b4:	02010413          	addi	s0,sp,32
class MemoryAllocator {
public:
    static void* mem_alloc(size_t size);
    static int mem_free(void* ptr);
	static void init_block(){
        free_mem_head = (mem_header*)((uint64)HEAP_START_ADDR);
    800046b8:	00008697          	auipc	a3,0x8
    800046bc:	4486b683          	ld	a3,1096(a3) # 8000cb00 <_GLOBAL_OFFSET_TABLE_+0x18>
    800046c0:	0006b783          	ld	a5,0(a3)
    800046c4:	00008717          	auipc	a4,0x8
    800046c8:	4bc73703          	ld	a4,1212(a4) # 8000cb80 <_GLOBAL_OFFSET_TABLE_+0x98>
    800046cc:	00f73023          	sd	a5,0(a4)
        free_mem_head->next = free_mem_head->prev = nullptr;
    800046d0:	0007b423          	sd	zero,8(a5)
    800046d4:	0007b023          	sd	zero,0(a5)
        free_mem_head->size = ((uint64)HEAP_END_ADDR) - ((uint64)HEAP_START_ADDR) - sizeof(mem_header);
    800046d8:	00008797          	auipc	a5,0x8
    800046dc:	4987b783          	ld	a5,1176(a5) # 8000cb70 <_GLOBAL_OFFSET_TABLE_+0x88>
    800046e0:	0007b783          	ld	a5,0(a5)
    800046e4:	0006b683          	ld	a3,0(a3)
    800046e8:	40d787b3          	sub	a5,a5,a3
    800046ec:	00073703          	ld	a4,0(a4)
    800046f0:	fe878793          	addi	a5,a5,-24
    800046f4:	00f73823          	sd	a5,16(a4)
		used_mem_head = nullptr;
    800046f8:	00008797          	auipc	a5,0x8
    800046fc:	4487b783          	ld	a5,1096(a5) # 8000cb40 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004700:	0007b023          	sd	zero,0(a5)
	//testing for console functions "${DIR_LIBS}/console.lib"
	/*printInt(  *((char *)(CONSOLE_STATUS)), 16 );
	__putc('\n');*/

	MemoryAllocator::init_block();
    ConsoleC::init_console();
    80004704:	00000097          	auipc	ra,0x0
    80004708:	1f8080e7          	jalr	504(ra) # 800048fc <_ZN8ConsoleC12init_consoleEv>

   	TCB* main = TCB::createThread(nullptr, nullptr); //main thread
    8000470c:	00000593          	li	a1,0
    80004710:	00000513          	li	a0,0
    80004714:	00000097          	auipc	ra,0x0
    80004718:	310080e7          	jalr	784(ra) # 80004a24 <_ZN3TCB12createThreadEPFvPvES0_>

    bool isSysThread() const { return sysThread; }

    void setSysThread(bool value) { sysThread = value; } // PRIVATE THIS LATER-------------------------------------------!
    8000471c:	00100493          	li	s1,1
    80004720:	02950c23          	sb	s1,56(a0)
    main->setSysThread(true);
    TCB::running = Scheduler::get();
    80004724:	00002097          	auipc	ra,0x2
    80004728:	ea0080e7          	jalr	-352(ra) # 800065c4 <_ZN9Scheduler3getEv>
    8000472c:	00008797          	auipc	a5,0x8
    80004730:	4347b783          	ld	a5,1076(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80004734:	00a7b023          	sd	a0,0(a5)
    TCB* idle = TCB::createThread(reinterpret_cast<void (*)(void *)>(TCB::idle_thread), nullptr);//idle thread
    80004738:	00000593          	li	a1,0
    8000473c:	00008517          	auipc	a0,0x8
    80004740:	3fc53503          	ld	a0,1020(a0) # 8000cb38 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004744:	00000097          	auipc	ra,0x0
    80004748:	2e0080e7          	jalr	736(ra) # 80004a24 <_ZN3TCB12createThreadEPFvPvES0_>
    8000474c:	00050913          	mv	s2,a0
	TCB* output = TCB::createThread(reinterpret_cast<void (*)(void *)>(ConsoleC::putterT), nullptr); // put thread
    80004750:	00000593          	li	a1,0
    80004754:	00008517          	auipc	a0,0x8
    80004758:	3dc53503          	ld	a0,988(a0) # 8000cb30 <_GLOBAL_OFFSET_TABLE_+0x48>
    8000475c:	00000097          	auipc	ra,0x0
    80004760:	2c8080e7          	jalr	712(ra) # 80004a24 <_ZN3TCB12createThreadEPFvPvES0_>
    80004764:	02990c23          	sb	s1,56(s2)
    80004768:	02950c23          	sb	s1,56(a0)
    idle->setSysThread(true);
    output->setSysThread(true);

	Riscv::w_stvec((uint64) &Riscv::supervisorTrap); //set our ecall to be of supervisor trap
    8000476c:	00008797          	auipc	a5,0x8
    80004770:	39c7b783          	ld	a5,924(a5) # 8000cb08 <_GLOBAL_OFFSET_TABLE_+0x20>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80004774:	10579073          	csrw	stvec,a5
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80004778:	00200793          	li	a5,2
    8000477c:	1007a073          	csrs	sstatus,a5
	Riscv::ms_sstatus(Riscv::SSTATUS_SIE); //set so interrupts are enabled specifically timer prekids!

	printInt(mem_get_free_space());
    80004780:	ffffd097          	auipc	ra,0xffffd
    80004784:	a1c080e7          	jalr	-1508(ra) # 8000119c <_Z18mem_get_free_spacev>
    80004788:	00000613          	li	a2,0
    8000478c:	00a00593          	li	a1,10
    80004790:	0005051b          	sext.w	a0,a0
    80004794:	fffff097          	auipc	ra,0xfffff
    80004798:	5b0080e7          	jalr	1456(ra) # 80003d44 <_Z8printIntiii>
    printString("\n");
    8000479c:	00006517          	auipc	a0,0x6
    800047a0:	be450513          	addi	a0,a0,-1052 # 8000a380 <CONSOLE_STATUS+0x370>
    800047a4:	fffff097          	auipc	ra,0xfffff
    800047a8:	3f0080e7          	jalr	1008(ra) # 80003b94 <_Z11printStringPKc>
    printInt(mem_get_largest_free_block());
    800047ac:	ffffd097          	auipc	ra,0xffffd
    800047b0:	a14080e7          	jalr	-1516(ra) # 800011c0 <_Z26mem_get_largest_free_blockv>
    800047b4:	00000613          	li	a2,0
    800047b8:	00a00593          	li	a1,10
    800047bc:	0005051b          	sext.w	a0,a0
    800047c0:	fffff097          	auipc	ra,0xfffff
    800047c4:	584080e7          	jalr	1412(ra) # 80003d44 <_Z8printIntiii>
    printString("\n");
    800047c8:	00006517          	auipc	a0,0x6
    800047cc:	bb850513          	addi	a0,a0,-1096 # 8000a380 <CONSOLE_STATUS+0x370>
    800047d0:	fffff097          	auipc	ra,0xfffff
    800047d4:	3c4080e7          	jalr	964(ra) # 80003b94 <_Z11printStringPKc>

    while(1) {}
    800047d8:	0000006f          	j	800047d8 <main+0x138>

00000000800047dc <_ZN8ConsoleC4getcEv>:

Buffer* ConsoleC:: inputBuffer = nullptr;
Buffer* ConsoleC:: outputBuffer = nullptr;

uchar ConsoleC::getc()
{
    800047dc:	fe010113          	addi	sp,sp,-32
    800047e0:	00113c23          	sd	ra,24(sp)
    800047e4:	00813823          	sd	s0,16(sp)
    800047e8:	00913423          	sd	s1,8(sp)
    800047ec:	02010413          	addi	s0,sp,32

    getSem->wait();
    800047f0:	00008497          	auipc	s1,0x8
    800047f4:	45048493          	addi	s1,s1,1104 # 8000cc40 <_ZN8ConsoleC6getSemE>
    800047f8:	0004b503          	ld	a0,0(s1)
    800047fc:	ffffd097          	auipc	ra,0xffffd
    80004800:	128080e7          	jalr	296(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
    return inputBuffer->withdraw();
    80004804:	0084b783          	ld	a5,8(s1)
        counter--;
    80004808:	0007b703          	ld	a4,0(a5)
    8000480c:	fff70713          	addi	a4,a4,-1
    80004810:	00e7b023          	sd	a4,0(a5)
        uchar c = c_buffer[tail];
    80004814:	0207b683          	ld	a3,32(a5)
    80004818:	0187b703          	ld	a4,24(a5)
    8000481c:	00e686b3          	add	a3,a3,a4
    80004820:	0006c503          	lbu	a0,0(a3)
        tail = (tail + 1) % cap;
    80004824:	00170713          	addi	a4,a4,1
    80004828:	0087b683          	ld	a3,8(a5)
    8000482c:	02d77733          	remu	a4,a4,a3
    80004830:	00e7bc23          	sd	a4,24(a5)
}
    80004834:	01813083          	ld	ra,24(sp)
    80004838:	01013403          	ld	s0,16(sp)
    8000483c:	00813483          	ld	s1,8(sp)
    80004840:	02010113          	addi	sp,sp,32
    80004844:	00008067          	ret

0000000080004848 <_ZN8ConsoleC4putcEh>:

void ConsoleC::putc(uchar c)
{
    80004848:	fe010113          	addi	sp,sp,-32
    8000484c:	00113c23          	sd	ra,24(sp)
    80004850:	00813823          	sd	s0,16(sp)
    80004854:	00913423          	sd	s1,8(sp)
    80004858:	01213023          	sd	s2,0(sp)
    8000485c:	02010413          	addi	s0,sp,32
    80004860:	00050913          	mv	s2,a0
    //if(outputBuffer->isFull())
    putSem->wait();
    80004864:	00008497          	auipc	s1,0x8
    80004868:	3dc48493          	addi	s1,s1,988 # 8000cc40 <_ZN8ConsoleC6getSemE>
    8000486c:	0104b503          	ld	a0,16(s1)
    80004870:	ffffd097          	auipc	ra,0xffffd
    80004874:	0b4080e7          	jalr	180(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
    mutex->wait();
    80004878:	0184b503          	ld	a0,24(s1)
    8000487c:	ffffd097          	auipc	ra,0xffffd
    80004880:	0a8080e7          	jalr	168(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
    outputBuffer->deposit(c);
    80004884:	0204b783          	ld	a5,32(s1)
        return c;
    }
    void deposit(uchar c)
    {

        if (counter < cap) {
    80004888:	0007b683          	ld	a3,0(a5)
    8000488c:	0087b703          	ld	a4,8(a5)
    80004890:	02e6fa63          	bgeu	a3,a4,800048c4 <_ZN8ConsoleC4putcEh+0x7c>
            c_buffer[head] = c;
    80004894:	0207b703          	ld	a4,32(a5)
    80004898:	0107b683          	ld	a3,16(a5)
    8000489c:	00d70733          	add	a4,a4,a3
    800048a0:	01270023          	sb	s2,0(a4)
            head = (head + 1) % cap;
    800048a4:	0107b703          	ld	a4,16(a5)
    800048a8:	00170713          	addi	a4,a4,1
    800048ac:	0087b683          	ld	a3,8(a5)
    800048b0:	02d77733          	remu	a4,a4,a3
    800048b4:	00e7b823          	sd	a4,16(a5)
            counter++;
    800048b8:	0007b703          	ld	a4,0(a5)
    800048bc:	00170713          	addi	a4,a4,1
    800048c0:	00e7b023          	sd	a4,0(a5)
    //if(jezgroSem->get_val() < 0)
    mutex->signal();
    800048c4:	00008497          	auipc	s1,0x8
    800048c8:	37c48493          	addi	s1,s1,892 # 8000cc40 <_ZN8ConsoleC6getSemE>
    800048cc:	0184b503          	ld	a0,24(s1)
    800048d0:	ffffd097          	auipc	ra,0xffffd
    800048d4:	12c080e7          	jalr	300(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
    jezgroSem->signal();
    800048d8:	0284b503          	ld	a0,40(s1)
    800048dc:	ffffd097          	auipc	ra,0xffffd
    800048e0:	120080e7          	jalr	288(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
}
    800048e4:	01813083          	ld	ra,24(sp)
    800048e8:	01013403          	ld	s0,16(sp)
    800048ec:	00813483          	ld	s1,8(sp)
    800048f0:	00013903          	ld	s2,0(sp)
    800048f4:	02010113          	addi	sp,sp,32
    800048f8:	00008067          	ret

00000000800048fc <_ZN8ConsoleC12init_consoleEv>:

void ConsoleC::init_console()
{
    800048fc:	fe010113          	addi	sp,sp,-32
    80004900:	00113c23          	sd	ra,24(sp)
    80004904:	00813823          	sd	s0,16(sp)
    80004908:	00913423          	sd	s1,8(sp)
    8000490c:	01213023          	sd	s2,0(sp)
    80004910:	02010413          	addi	s0,sp,32

    getSem = SemaphoreC::sem_open();
    80004914:	00000513          	li	a0,0
    80004918:	ffffd097          	auipc	ra,0xffffd
    8000491c:	fc4080e7          	jalr	-60(ra) # 800018dc <_ZN10SemaphoreC8sem_openEi>
    80004920:	00008497          	auipc	s1,0x8
    80004924:	32048493          	addi	s1,s1,800 # 8000cc40 <_ZN8ConsoleC6getSemE>
    80004928:	00a4b023          	sd	a0,0(s1)
    putSem = SemaphoreC::sem_open(DEFAULT_BUFFER_SIZE);
    8000492c:	01000513          	li	a0,16
    80004930:	ffffd097          	auipc	ra,0xffffd
    80004934:	fac080e7          	jalr	-84(ra) # 800018dc <_ZN10SemaphoreC8sem_openEi>
    80004938:	00a4b823          	sd	a0,16(s1)
    jezgroSem = SemaphoreC::sem_open();
    8000493c:	00000513          	li	a0,0
    80004940:	ffffd097          	auipc	ra,0xffffd
    80004944:	f9c080e7          	jalr	-100(ra) # 800018dc <_ZN10SemaphoreC8sem_openEi>
    80004948:	02a4b423          	sd	a0,40(s1)
    mutex = SemaphoreC::sem_open(1);
    8000494c:	00100513          	li	a0,1
    80004950:	ffffd097          	auipc	ra,0xffffd
    80004954:	f8c080e7          	jalr	-116(ra) # 800018dc <_ZN10SemaphoreC8sem_openEi>
    80004958:	00a4bc23          	sd	a0,24(s1)
        }
    }

    void* operator new(size_t size)
     {
         return MemoryAllocator::mem_alloc(size);
    8000495c:	02800513          	li	a0,40
    80004960:	00002097          	auipc	ra,0x2
    80004964:	354080e7          	jalr	852(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    80004968:	00050493          	mv	s1,a0
        c_buffer( (char*) MemoryAllocator::mem_alloc(cap * sizeof(char)))
    8000496c:	00053023          	sd	zero,0(a0)
    80004970:	01000793          	li	a5,16
    80004974:	00f53423          	sd	a5,8(a0)
    80004978:	00053823          	sd	zero,16(a0)
    8000497c:	00053c23          	sd	zero,24(a0)
    80004980:	01000513          	li	a0,16
    80004984:	00002097          	auipc	ra,0x2
    80004988:	330080e7          	jalr	816(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    8000498c:	02a4b023          	sd	a0,32(s1)

    inputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
    80004990:	00008797          	auipc	a5,0x8
    80004994:	2a97bc23          	sd	s1,696(a5) # 8000cc48 <_ZN8ConsoleC11inputBufferE>
         return MemoryAllocator::mem_alloc(size);
    80004998:	02800513          	li	a0,40
    8000499c:	00002097          	auipc	ra,0x2
    800049a0:	318080e7          	jalr	792(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    800049a4:	00050493          	mv	s1,a0
        c_buffer( (char*) MemoryAllocator::mem_alloc(cap * sizeof(char)))
    800049a8:	00053023          	sd	zero,0(a0)
    800049ac:	01000793          	li	a5,16
    800049b0:	00f53423          	sd	a5,8(a0)
    800049b4:	00053823          	sd	zero,16(a0)
    800049b8:	00053c23          	sd	zero,24(a0)
    800049bc:	01000513          	li	a0,16
    800049c0:	00002097          	auipc	ra,0x2
    800049c4:	2f4080e7          	jalr	756(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    800049c8:	02a4b023          	sd	a0,32(s1)
    outputBuffer = new Buffer(DEFAULT_BUFFER_SIZE);
    800049cc:	00008797          	auipc	a5,0x8
    800049d0:	2897ba23          	sd	s1,660(a5) # 8000cc60 <_ZN8ConsoleC12outputBufferE>
    800049d4:	01813083          	ld	ra,24(sp)
    800049d8:	01013403          	ld	s0,16(sp)
    800049dc:	00813483          	ld	s1,8(sp)
    800049e0:	00013903          	ld	s2,0(sp)
    800049e4:	02010113          	addi	sp,sp,32
    800049e8:	00008067          	ret
    800049ec:	00050913          	mv	s2,a0
    {
        return MemoryAllocator::mem_alloc(size);
    }
    void operator delete(void* ptr)
    {
        MemoryAllocator::mem_free(ptr);
    800049f0:	00048513          	mv	a0,s1
    800049f4:	00002097          	auipc	ra,0x2
    800049f8:	5a8080e7          	jalr	1448(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
        return;
    800049fc:	00090513          	mv	a0,s2
    80004a00:	00009097          	auipc	ra,0x9
    80004a04:	388080e7          	jalr	904(ra) # 8000dd88 <_Unwind_Resume>
    80004a08:	00050913          	mv	s2,a0
        MemoryAllocator::mem_free(ptr);
    80004a0c:	00048513          	mv	a0,s1
    80004a10:	00002097          	auipc	ra,0x2
    80004a14:	58c080e7          	jalr	1420(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
        return;
    80004a18:	00090513          	mv	a0,s2
    80004a1c:	00009097          	auipc	ra,0x9
    80004a20:	36c080e7          	jalr	876(ra) # 8000dd88 <_Unwind_Resume>

0000000080004a24 <_ZN3TCB12createThreadEPFvPvES0_>:

TCB *TCB::running = nullptr;
uint64 TCB::timeSliceCounter = 0;

TCB* TCB::createThread(Body body, void* args)
{
    80004a24:	fd010113          	addi	sp,sp,-48
    80004a28:	02113423          	sd	ra,40(sp)
    80004a2c:	02813023          	sd	s0,32(sp)
    80004a30:	00913c23          	sd	s1,24(sp)
    80004a34:	01213823          	sd	s2,16(sp)
    80004a38:	01313423          	sd	s3,8(sp)
    80004a3c:	03010413          	addi	s0,sp,48
    80004a40:	00050913          	mv	s2,a0
    80004a44:	00058993          	mv	s3,a1
    static TCB* createThread(Body body, void* args, uint64* stack);
	static int thread_exit();

    void* operator new(size_t size)
     {
         return MemoryAllocator::mem_alloc(size);
    80004a48:	04000513          	li	a0,64
    80004a4c:	00002097          	auipc	ra,0x2
    80004a50:	268080e7          	jalr	616(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    80004a54:	00050493          	mv	s1,a0
private: //time slice can nullpoint
    explicit TCB(Body body, void* args, uint64 timeSlice): body(body),
        stack( body != nullptr ? ( (uint64*) MemoryAllocator::mem_alloc( DEFAULT_STACK_SIZE * sizeof(uint64) ) ) : 0), args(args),
        context(
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0 }
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    80004a58:	01253023          	sd	s2,0(a0)
        stack( body != nullptr ? ( (uint64*) MemoryAllocator::mem_alloc( DEFAULT_STACK_SIZE * sizeof(uint64) ) ) : 0), args(args),
    80004a5c:	00090a63          	beqz	s2,80004a70 <_ZN3TCB12createThreadEPFvPvES0_+0x4c>
    80004a60:	00008537          	lui	a0,0x8
    80004a64:	00002097          	auipc	ra,0x2
    80004a68:	250080e7          	jalr	592(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    80004a6c:	0080006f          	j	80004a74 <_ZN3TCB12createThreadEPFvPvES0_+0x50>
    80004a70:	00000513          	li	a0,0
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    80004a74:	00a4b423          	sd	a0,8(s1)
    80004a78:	0134b823          	sd	s3,16(s1)
    80004a7c:	00000797          	auipc	a5,0x0
    80004a80:	17078793          	addi	a5,a5,368 # 80004bec <_ZN3TCB13threadWrapperEv>
    80004a84:	00f4bc23          	sd	a5,24(s1)
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0 }
    80004a88:	02050a63          	beqz	a0,80004abc <_ZN3TCB12createThreadEPFvPvES0_+0x98>
    80004a8c:	000087b7          	lui	a5,0x8
    80004a90:	00f50533          	add	a0,a0,a5
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    80004a94:	02a4b023          	sd	a0,32(s1)
    80004a98:	02048423          	sb	zero,40(s1)
    80004a9c:	020484a3          	sb	zero,41(s1)
    80004aa0:	00200793          	li	a5,2
    80004aa4:	02f4b823          	sd	a5,48(s1)
    80004aa8:	02048c23          	sb	zero,56(s1)
    {
        //if(body != nullptr) Scheduler::put(this);
        Scheduler::put(this);
    80004aac:	00048513          	mv	a0,s1
    80004ab0:	00002097          	auipc	ra,0x2
    80004ab4:	b7c080e7          	jalr	-1156(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
    80004ab8:	0280006f          	j	80004ae0 <_ZN3TCB12createThreadEPFvPvES0_+0xbc>
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0 }
    80004abc:	00000513          	li	a0,0
    80004ac0:	fd5ff06f          	j	80004a94 <_ZN3TCB12createThreadEPFvPvES0_+0x70>
    80004ac4:	00050913          	mv	s2,a0
        MemoryAllocator::mem_free(ptr);
    80004ac8:	00048513          	mv	a0,s1
    80004acc:	00002097          	auipc	ra,0x2
    80004ad0:	4d0080e7          	jalr	1232(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
        return;
    80004ad4:	00090513          	mv	a0,s2
    80004ad8:	00009097          	auipc	ra,0x9
    80004adc:	2b0080e7          	jalr	688(ra) # 8000dd88 <_Unwind_Resume>
    return new TCB(body, args, DEFAULT_TIME_SLICE);
}
    80004ae0:	00048513          	mv	a0,s1
    80004ae4:	02813083          	ld	ra,40(sp)
    80004ae8:	02013403          	ld	s0,32(sp)
    80004aec:	01813483          	ld	s1,24(sp)
    80004af0:	01013903          	ld	s2,16(sp)
    80004af4:	00813983          	ld	s3,8(sp)
    80004af8:	03010113          	addi	sp,sp,48
    80004afc:	00008067          	ret

0000000080004b00 <_ZN3TCB12createThreadEPFvPvES0_Pm>:

TCB* TCB::createThread(Body body, void* args, uint64* stack)
{
    80004b00:	fd010113          	addi	sp,sp,-48
    80004b04:	02113423          	sd	ra,40(sp)
    80004b08:	02813023          	sd	s0,32(sp)
    80004b0c:	00913c23          	sd	s1,24(sp)
    80004b10:	01213823          	sd	s2,16(sp)
    80004b14:	01313423          	sd	s3,8(sp)
    80004b18:	01413023          	sd	s4,0(sp)
    80004b1c:	03010413          	addi	s0,sp,48
    80004b20:	00050a13          	mv	s4,a0
    80004b24:	00058993          	mv	s3,a1
    80004b28:	00060913          	mv	s2,a2
         return MemoryAllocator::mem_alloc(size);
    80004b2c:	04000513          	li	a0,64
    80004b30:	00002097          	auipc	ra,0x2
    80004b34:	184080e7          	jalr	388(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
    80004b38:	00050493          	mv	s1,a0
    }
    explicit TCB(Body body, uint64* stack, void* args, uint64 timeSlice): body(body),
        stack( stack != nullptr ? stack : 0), args(args),
        context(
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE/sizeof(uint64)] : 0 }
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    80004b3c:	01453023          	sd	s4,0(a0) # 8000 <_entry-0x7fff8000>
    80004b40:	01253423          	sd	s2,8(a0)
    80004b44:	01353823          	sd	s3,16(a0)
    80004b48:	00000797          	auipc	a5,0x0
    80004b4c:	0a478793          	addi	a5,a5,164 # 80004bec <_ZN3TCB13threadWrapperEv>
    80004b50:	00f53c23          	sd	a5,24(a0)
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE/sizeof(uint64)] : 0 }
    80004b54:	02090a63          	beqz	s2,80004b88 <_ZN3TCB12createThreadEPFvPvES0_Pm+0x88>
    80004b58:	00001637          	lui	a2,0x1
    80004b5c:	00c90933          	add	s2,s2,a2
        ),finished(false), t_blocked(false), timeSlice(timeSlice), sysThread(false)
    80004b60:	0324b023          	sd	s2,32(s1)
    80004b64:	02048423          	sb	zero,40(s1)
    80004b68:	020484a3          	sb	zero,41(s1)
    80004b6c:	00200793          	li	a5,2
    80004b70:	02f4b823          	sd	a5,48(s1)
    80004b74:	02048c23          	sb	zero,56(s1)
    {
        //if(body != nullptr) Scheduler::put(this);
        Scheduler::put(this);
    80004b78:	00048513          	mv	a0,s1
    80004b7c:	00002097          	auipc	ra,0x2
    80004b80:	ab0080e7          	jalr	-1360(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
    80004b84:	0280006f          	j	80004bac <_ZN3TCB12createThreadEPFvPvES0_Pm+0xac>
           { (uint64) &threadWrapper, stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE/sizeof(uint64)] : 0 }
    80004b88:	00000913          	li	s2,0
    80004b8c:	fd5ff06f          	j	80004b60 <_ZN3TCB12createThreadEPFvPvES0_Pm+0x60>
    80004b90:	00050913          	mv	s2,a0
        MemoryAllocator::mem_free(ptr);
    80004b94:	00048513          	mv	a0,s1
    80004b98:	00002097          	auipc	ra,0x2
    80004b9c:	404080e7          	jalr	1028(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
        return;
    80004ba0:	00090513          	mv	a0,s2
    80004ba4:	00009097          	auipc	ra,0x9
    80004ba8:	1e4080e7          	jalr	484(ra) # 8000dd88 <_Unwind_Resume>
    return new TCB(body, stack, args, DEFAULT_TIME_SLICE);
}
    80004bac:	00048513          	mv	a0,s1
    80004bb0:	02813083          	ld	ra,40(sp)
    80004bb4:	02013403          	ld	s0,32(sp)
    80004bb8:	01813483          	ld	s1,24(sp)
    80004bbc:	01013903          	ld	s2,16(sp)
    80004bc0:	00813983          	ld	s3,8(sp)
    80004bc4:	00013a03          	ld	s4,0(sp)
    80004bc8:	03010113          	addi	sp,sp,48
    80004bcc:	00008067          	ret

0000000080004bd0 <_ZN3TCB5yieldEv>:

void TCB::yield()
{
    80004bd0:	ff010113          	addi	sp,sp,-16
    80004bd4:	00813423          	sd	s0,8(sp)
    80004bd8:	01010413          	addi	s0,sp,16
    //push registers on - all the ones that arent ra and sp
    //so we yield at the end of threat wrapper which needs to dispatch to the next nit - but ecall already used for
    //syscalls - so we make a new code of operation
    __asm__ volatile("ecall");
    80004bdc:	00000073          	ecall
}
    80004be0:	00813403          	ld	s0,8(sp)
    80004be4:	01010113          	addi	sp,sp,16
    80004be8:	00008067          	ret

0000000080004bec <_ZN3TCB13threadWrapperEv>:
    Riscv::setPriviledge();
    TCB::contextSwitch(&old->context, &running->context); //CONTEXT SWITCH IN
}

void TCB::threadWrapper()
{
    80004bec:	fe010113          	addi	sp,sp,-32
    80004bf0:	00113c23          	sd	ra,24(sp)
    80004bf4:	00813823          	sd	s0,16(sp)
    80004bf8:	00913423          	sd	s1,8(sp)
    80004bfc:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie(); // when new thread created from dispatch, it is still in sup mode - need to pop it to return
    80004c00:	00001097          	auipc	ra,0x1
    80004c04:	4b0080e7          	jalr	1200(ra) # 800060b0 <_ZN5Riscv10popSppSpieEv>
                        // to previous mode when executing from here thereafter, since it doesn't do it itself
    running->body(running->args);
    80004c08:	00008497          	auipc	s1,0x8
    80004c0c:	06848493          	addi	s1,s1,104 # 8000cc70 <_ZN3TCB7runningE>
    80004c10:	0004b783          	ld	a5,0(s1)
    80004c14:	0007b703          	ld	a4,0(a5)
    80004c18:	0107b503          	ld	a0,16(a5)
    80004c1c:	000700e7          	jalr	a4
    running->setFinished(true); //finish nit implicitno, dont have to explicitly release
    80004c20:	0004b783          	ld	a5,0(s1)
    void setFinished(bool value) { finished = value; }
    80004c24:	00100713          	li	a4,1
    80004c28:	02e78423          	sb	a4,40(a5)
    yield();
    80004c2c:	00000097          	auipc	ra,0x0
    80004c30:	fa4080e7          	jalr	-92(ra) # 80004bd0 <_ZN3TCB5yieldEv>

}
    80004c34:	01813083          	ld	ra,24(sp)
    80004c38:	01013403          	ld	s0,16(sp)
    80004c3c:	00813483          	ld	s1,8(sp)
    80004c40:	02010113          	addi	sp,sp,32
    80004c44:	00008067          	ret

0000000080004c48 <_ZN3TCB8dispatchEv>:
{
    80004c48:	fe010113          	addi	sp,sp,-32
    80004c4c:	00113c23          	sd	ra,24(sp)
    80004c50:	00813823          	sd	s0,16(sp)
    80004c54:	00913423          	sd	s1,8(sp)
    80004c58:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80004c5c:	00008497          	auipc	s1,0x8
    80004c60:	0144b483          	ld	s1,20(s1) # 8000cc70 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    80004c64:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() && !old->isBlocked())
    80004c68:	00079663          	bnez	a5,80004c74 <_ZN3TCB8dispatchEv+0x2c>
    bool isBlocked() const { return t_blocked; }
    80004c6c:	0294c783          	lbu	a5,41(s1)
    80004c70:	04078463          	beqz	a5,80004cb8 <_ZN3TCB8dispatchEv+0x70>
    running=Scheduler::get(); //ISSUE CAUSED HERE-----------------------------------------------------------------------!
    80004c74:	00002097          	auipc	ra,0x2
    80004c78:	950080e7          	jalr	-1712(ra) # 800065c4 <_ZN9Scheduler3getEv>
    80004c7c:	00008797          	auipc	a5,0x8
    80004c80:	fea7ba23          	sd	a0,-12(a5) # 8000cc70 <_ZN3TCB7runningE>
    bool isSysThread() const { return sysThread; }
    80004c84:	03854783          	lbu	a5,56(a0)
        if (TCB::running->isSysThread())
    80004c88:	04078063          	beqz	a5,80004cc8 <_ZN3TCB8dispatchEv+0x80>
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80004c8c:	10000793          	li	a5,256
    80004c90:	1007a073          	csrs	sstatus,a5
    TCB::contextSwitch(&old->context, &running->context); //CONTEXT SWITCH IN
    80004c94:	01850593          	addi	a1,a0,24
    80004c98:	01848513          	addi	a0,s1,24
    80004c9c:	ffffc097          	auipc	ra,0xffffc
    80004ca0:	494080e7          	jalr	1172(ra) # 80001130 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80004ca4:	01813083          	ld	ra,24(sp)
    80004ca8:	01013403          	ld	s0,16(sp)
    80004cac:	00813483          	ld	s1,8(sp)
    80004cb0:	02010113          	addi	sp,sp,32
    80004cb4:	00008067          	ret
        Scheduler::put(old);
    80004cb8:	00048513          	mv	a0,s1
    80004cbc:	00002097          	auipc	ra,0x2
    80004cc0:	970080e7          	jalr	-1680(ra) # 8000662c <_ZN9Scheduler3putEP3TCB>
    80004cc4:	fb1ff06f          	j	80004c74 <_ZN3TCB8dispatchEv+0x2c>
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80004cc8:	10000793          	li	a5,256
    80004ccc:	1007b073          	csrc	sstatus,a5
}
    80004cd0:	fc5ff06f          	j	80004c94 <_ZN3TCB8dispatchEv+0x4c>

0000000080004cd4 <_ZN3TCB11thread_exitEv>:

int TCB::thread_exit()
{
    if(running->body == nullptr) return -1;
    80004cd4:	00008797          	auipc	a5,0x8
    80004cd8:	f9c7b783          	ld	a5,-100(a5) # 8000cc70 <_ZN3TCB7runningE>
    80004cdc:	0007b703          	ld	a4,0(a5)
    80004ce0:	02070c63          	beqz	a4,80004d18 <_ZN3TCB11thread_exitEv+0x44>
{
    80004ce4:	ff010113          	addi	sp,sp,-16
    80004ce8:	00113423          	sd	ra,8(sp)
    80004cec:	00813023          	sd	s0,0(sp)
    80004cf0:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    80004cf4:	00100713          	li	a4,1
    80004cf8:	02e78423          	sb	a4,40(a5)
    running->setFinished(true);
    dispatch();
    80004cfc:	00000097          	auipc	ra,0x0
    80004d00:	f4c080e7          	jalr	-180(ra) # 80004c48 <_ZN3TCB8dispatchEv>
    return 0;
    80004d04:	00000513          	li	a0,0
}
    80004d08:	00813083          	ld	ra,8(sp)
    80004d0c:	00013403          	ld	s0,0(sp)
    80004d10:	01010113          	addi	sp,sp,16
    80004d14:	00008067          	ret
    if(running->body == nullptr) return -1;
    80004d18:	fff00513          	li	a0,-1
}
    80004d1c:	00008067          	ret

0000000080004d20 <_ZN3TCB11idle_threadEv>:

void TCB::idle_thread()
{
    80004d20:	ff010113          	addi	sp,sp,-16
    80004d24:	00113423          	sd	ra,8(sp)
    80004d28:	00813023          	sd	s0,0(sp)
    80004d2c:	01010413          	addi	s0,sp,16
    while(true) {
        dispatch();
    80004d30:	00000097          	auipc	ra,0x0
    80004d34:	f18080e7          	jalr	-232(ra) # 80004c48 <_ZN3TCB8dispatchEv>
    while(true) {
    80004d38:	ff9ff06f          	j	80004d30 <_ZN3TCB11idle_threadEv+0x10>

0000000080004d3c <_ZN6ThreadD1Ev>:
Thread::Thread (void (*body)(void*), void* arg)
{
    this->body = body;
    this->arg = arg;
}
Thread::~Thread ()
    80004d3c:	ff010113          	addi	sp,sp,-16
    80004d40:	00813423          	sd	s0,8(sp)
    80004d44:	01010413          	addi	s0,sp,16
{
    myHandle->setFinished(true);
    80004d48:	00853783          	ld	a5,8(a0)
    80004d4c:	00100713          	li	a4,1
    80004d50:	02e78423          	sb	a4,40(a5)
}
    80004d54:	00813403          	ld	s0,8(sp)
    80004d58:	01010113          	addi	sp,sp,16
    80004d5c:	00008067          	ret

0000000080004d60 <_ZN6Thread10runWrapperEPv>:
    this->arg = this;

}
void Thread:: runWrapper(void* thr) {
    Thread* thread=(Thread*)thr;
    if(thread) {
    80004d60:	02050863          	beqz	a0,80004d90 <_ZN6Thread10runWrapperEPv+0x30>
void Thread:: runWrapper(void* thr) {
    80004d64:	ff010113          	addi	sp,sp,-16
    80004d68:	00113423          	sd	ra,8(sp)
    80004d6c:	00813023          	sd	s0,0(sp)
    80004d70:	01010413          	addi	s0,sp,16
        thread->run();
    80004d74:	00053783          	ld	a5,0(a0)
    80004d78:	0107b783          	ld	a5,16(a5)
    80004d7c:	000780e7          	jalr	a5
    }
}
    80004d80:	00813083          	ld	ra,8(sp)
    80004d84:	00013403          	ld	s0,0(sp)
    80004d88:	01010113          	addi	sp,sp,16
    80004d8c:	00008067          	ret
    80004d90:	00008067          	ret

0000000080004d94 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore (unsigned init)
{
    sem_open(&myHandle, init);
}
Semaphore::~Semaphore ()
    80004d94:	ff010113          	addi	sp,sp,-16
    80004d98:	00113423          	sd	ra,8(sp)
    80004d9c:	00813023          	sd	s0,0(sp)
    80004da0:	01010413          	addi	s0,sp,16
    80004da4:	00008797          	auipc	a5,0x8
    80004da8:	d3478793          	addi	a5,a5,-716 # 8000cad8 <_ZTV9Semaphore+0x10>
    80004dac:	00f53023          	sd	a5,0(a0)
{
    sem_close(myHandle);
    80004db0:	00853503          	ld	a0,8(a0)
    80004db4:	ffffc097          	auipc	ra,0xffffc
    80004db8:	528080e7          	jalr	1320(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
}
    80004dbc:	00813083          	ld	ra,8(sp)
    80004dc0:	00013403          	ld	s0,0(sp)
    80004dc4:	01010113          	addi	sp,sp,16
    80004dc8:	00008067          	ret

0000000080004dcc <_Znwm>:
{
    80004dcc:	ff010113          	addi	sp,sp,-16
    80004dd0:	00113423          	sd	ra,8(sp)
    80004dd4:	00813023          	sd	s0,0(sp)
    80004dd8:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80004ddc:	ffffc097          	auipc	ra,0xffffc
    80004de0:	368080e7          	jalr	872(ra) # 80001144 <_Z9mem_allocm>
}
    80004de4:	00813083          	ld	ra,8(sp)
    80004de8:	00013403          	ld	s0,0(sp)
    80004dec:	01010113          	addi	sp,sp,16
    80004df0:	00008067          	ret

0000000080004df4 <_Znam>:
{
    80004df4:	ff010113          	addi	sp,sp,-16
    80004df8:	00113423          	sd	ra,8(sp)
    80004dfc:	00813023          	sd	s0,0(sp)
    80004e00:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80004e04:	ffffc097          	auipc	ra,0xffffc
    80004e08:	340080e7          	jalr	832(ra) # 80001144 <_Z9mem_allocm>
}
    80004e0c:	00813083          	ld	ra,8(sp)
    80004e10:	00013403          	ld	s0,0(sp)
    80004e14:	01010113          	addi	sp,sp,16
    80004e18:	00008067          	ret

0000000080004e1c <_ZdlPv>:
{
    80004e1c:	ff010113          	addi	sp,sp,-16
    80004e20:	00113423          	sd	ra,8(sp)
    80004e24:	00813023          	sd	s0,0(sp)
    80004e28:	01010413          	addi	s0,sp,16
    mem_free(p);
    80004e2c:	ffffc097          	auipc	ra,0xffffc
    80004e30:	344080e7          	jalr	836(ra) # 80001170 <_Z8mem_freePv>
}
    80004e34:	00813083          	ld	ra,8(sp)
    80004e38:	00013403          	ld	s0,0(sp)
    80004e3c:	01010113          	addi	sp,sp,16
    80004e40:	00008067          	ret

0000000080004e44 <_ZN6ThreadD0Ev>:
Thread::~Thread ()
    80004e44:	fe010113          	addi	sp,sp,-32
    80004e48:	00113c23          	sd	ra,24(sp)
    80004e4c:	00813823          	sd	s0,16(sp)
    80004e50:	00913423          	sd	s1,8(sp)
    80004e54:	02010413          	addi	s0,sp,32
    80004e58:	00050493          	mv	s1,a0
}
    80004e5c:	00000097          	auipc	ra,0x0
    80004e60:	ee0080e7          	jalr	-288(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80004e64:	00048513          	mv	a0,s1
    80004e68:	00000097          	auipc	ra,0x0
    80004e6c:	fb4080e7          	jalr	-76(ra) # 80004e1c <_ZdlPv>
    80004e70:	01813083          	ld	ra,24(sp)
    80004e74:	01013403          	ld	s0,16(sp)
    80004e78:	00813483          	ld	s1,8(sp)
    80004e7c:	02010113          	addi	sp,sp,32
    80004e80:	00008067          	ret

0000000080004e84 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore ()
    80004e84:	fe010113          	addi	sp,sp,-32
    80004e88:	00113c23          	sd	ra,24(sp)
    80004e8c:	00813823          	sd	s0,16(sp)
    80004e90:	00913423          	sd	s1,8(sp)
    80004e94:	02010413          	addi	s0,sp,32
    80004e98:	00050493          	mv	s1,a0
}
    80004e9c:	00000097          	auipc	ra,0x0
    80004ea0:	ef8080e7          	jalr	-264(ra) # 80004d94 <_ZN9SemaphoreD1Ev>
    80004ea4:	00048513          	mv	a0,s1
    80004ea8:	00000097          	auipc	ra,0x0
    80004eac:	f74080e7          	jalr	-140(ra) # 80004e1c <_ZdlPv>
    80004eb0:	01813083          	ld	ra,24(sp)
    80004eb4:	01013403          	ld	s0,16(sp)
    80004eb8:	00813483          	ld	s1,8(sp)
    80004ebc:	02010113          	addi	sp,sp,32
    80004ec0:	00008067          	ret

0000000080004ec4 <_ZdaPv>:
{
    80004ec4:	ff010113          	addi	sp,sp,-16
    80004ec8:	00113423          	sd	ra,8(sp)
    80004ecc:	00813023          	sd	s0,0(sp)
    80004ed0:	01010413          	addi	s0,sp,16
    mem_free(p);
    80004ed4:	ffffc097          	auipc	ra,0xffffc
    80004ed8:	29c080e7          	jalr	668(ra) # 80001170 <_Z8mem_freePv>
}
    80004edc:	00813083          	ld	ra,8(sp)
    80004ee0:	00013403          	ld	s0,0(sp)
    80004ee4:	01010113          	addi	sp,sp,16
    80004ee8:	00008067          	ret

0000000080004eec <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread (void (*body)(void*), void* arg)
    80004eec:	ff010113          	addi	sp,sp,-16
    80004ef0:	00813423          	sd	s0,8(sp)
    80004ef4:	01010413          	addi	s0,sp,16
    80004ef8:	00008797          	auipc	a5,0x8
    80004efc:	bb878793          	addi	a5,a5,-1096 # 8000cab0 <_ZTV6Thread+0x10>
    80004f00:	00f53023          	sd	a5,0(a0)
    this->body = body;
    80004f04:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    80004f08:	00c53c23          	sd	a2,24(a0)
}
    80004f0c:	00813403          	ld	s0,8(sp)
    80004f10:	01010113          	addi	sp,sp,16
    80004f14:	00008067          	ret

0000000080004f18 <_ZN6Thread5startEv>:
{
    80004f18:	fe010113          	addi	sp,sp,-32
    80004f1c:	00113c23          	sd	ra,24(sp)
    80004f20:	00813823          	sd	s0,16(sp)
    80004f24:	00913423          	sd	s1,8(sp)
    80004f28:	02010413          	addi	s0,sp,32
    80004f2c:	00050493          	mv	s1,a0
    thread_create(&myHandle, body, arg);
    80004f30:	01853603          	ld	a2,24(a0)
    80004f34:	01053583          	ld	a1,16(a0)
    80004f38:	00850513          	addi	a0,a0,8
    80004f3c:	ffffc097          	auipc	ra,0xffffc
    80004f40:	2a8080e7          	jalr	680(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    if(body== nullptr)TCB::running=myHandle;
    80004f44:	0104b783          	ld	a5,16(s1)
    80004f48:	02078263          	beqz	a5,80004f6c <_ZN6Thread5startEv+0x54>
    if(myHandle!= nullptr)return 0;
    80004f4c:	0084b783          	ld	a5,8(s1)
    80004f50:	02078863          	beqz	a5,80004f80 <_ZN6Thread5startEv+0x68>
    80004f54:	00000513          	li	a0,0
}
    80004f58:	01813083          	ld	ra,24(sp)
    80004f5c:	01013403          	ld	s0,16(sp)
    80004f60:	00813483          	ld	s1,8(sp)
    80004f64:	02010113          	addi	sp,sp,32
    80004f68:	00008067          	ret
    if(body== nullptr)TCB::running=myHandle;
    80004f6c:	0084b703          	ld	a4,8(s1)
    80004f70:	00008797          	auipc	a5,0x8
    80004f74:	bf07b783          	ld	a5,-1040(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80004f78:	00e7b023          	sd	a4,0(a5)
    80004f7c:	fd1ff06f          	j	80004f4c <_ZN6Thread5startEv+0x34>
    return -1;
    80004f80:	fff00513          	li	a0,-1
    80004f84:	fd5ff06f          	j	80004f58 <_ZN6Thread5startEv+0x40>

0000000080004f88 <_ZN6Thread8dispatchEv>:
{
    80004f88:	ff010113          	addi	sp,sp,-16
    80004f8c:	00113423          	sd	ra,8(sp)
    80004f90:	00813023          	sd	s0,0(sp)
    80004f94:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80004f98:	ffffc097          	auipc	ra,0xffffc
    80004f9c:	2f4080e7          	jalr	756(ra) # 8000128c <_Z15thread_dispatchv>
}
    80004fa0:	00813083          	ld	ra,8(sp)
    80004fa4:	00013403          	ld	s0,0(sp)
    80004fa8:	01010113          	addi	sp,sp,16
    80004fac:	00008067          	ret

0000000080004fb0 <_ZN6Thread5sleepEm>:
{
    80004fb0:	ff010113          	addi	sp,sp,-16
    80004fb4:	00113423          	sd	ra,8(sp)
    80004fb8:	00813023          	sd	s0,0(sp)
    80004fbc:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80004fc0:	ffffc097          	auipc	ra,0xffffc
    80004fc4:	3a0080e7          	jalr	928(ra) # 80001360 <_Z10time_sleepm>
}
    80004fc8:	00813083          	ld	ra,8(sp)
    80004fcc:	00013403          	ld	s0,0(sp)
    80004fd0:	01010113          	addi	sp,sp,16
    80004fd4:	00008067          	ret

0000000080004fd8 <_ZN6ThreadC1Ev>:
Thread::Thread ()
    80004fd8:	ff010113          	addi	sp,sp,-16
    80004fdc:	00813423          	sd	s0,8(sp)
    80004fe0:	01010413          	addi	s0,sp,16
    80004fe4:	00008797          	auipc	a5,0x8
    80004fe8:	acc78793          	addi	a5,a5,-1332 # 8000cab0 <_ZTV6Thread+0x10>
    80004fec:	00f53023          	sd	a5,0(a0)
    this->body = runWrapper;
    80004ff0:	00000797          	auipc	a5,0x0
    80004ff4:	d7078793          	addi	a5,a5,-656 # 80004d60 <_ZN6Thread10runWrapperEPv>
    80004ff8:	00f53823          	sd	a5,16(a0)
    this->arg = this;
    80004ffc:	00a53c23          	sd	a0,24(a0)
}
    80005000:	00813403          	ld	s0,8(sp)
    80005004:	01010113          	addi	sp,sp,16
    80005008:	00008067          	ret

000000008000500c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore (unsigned init)
    8000500c:	ff010113          	addi	sp,sp,-16
    80005010:	00113423          	sd	ra,8(sp)
    80005014:	00813023          	sd	s0,0(sp)
    80005018:	01010413          	addi	s0,sp,16
    8000501c:	00008797          	auipc	a5,0x8
    80005020:	abc78793          	addi	a5,a5,-1348 # 8000cad8 <_ZTV9Semaphore+0x10>
    80005024:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80005028:	00850513          	addi	a0,a0,8
    8000502c:	ffffc097          	auipc	ra,0xffffc
    80005030:	280080e7          	jalr	640(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
}
    80005034:	00813083          	ld	ra,8(sp)
    80005038:	00013403          	ld	s0,0(sp)
    8000503c:	01010113          	addi	sp,sp,16
    80005040:	00008067          	ret

0000000080005044 <_ZN9Semaphore4waitEv>:
int Semaphore::wait ()
{
    80005044:	ff010113          	addi	sp,sp,-16
    80005048:	00113423          	sd	ra,8(sp)
    8000504c:	00813023          	sd	s0,0(sp)
    80005050:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80005054:	00853503          	ld	a0,8(a0)
    80005058:	ffffc097          	auipc	ra,0xffffc
    8000505c:	2b0080e7          	jalr	688(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>
}
    80005060:	00813083          	ld	ra,8(sp)
    80005064:	00013403          	ld	s0,0(sp)
    80005068:	01010113          	addi	sp,sp,16
    8000506c:	00008067          	ret

0000000080005070 <_ZN9Semaphore6signalEv>:
int Semaphore::signal ()
{
    80005070:	ff010113          	addi	sp,sp,-16
    80005074:	00113423          	sd	ra,8(sp)
    80005078:	00813023          	sd	s0,0(sp)
    8000507c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80005080:	00853503          	ld	a0,8(a0)
    80005084:	ffffc097          	auipc	ra,0xffffc
    80005088:	2b0080e7          	jalr	688(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
}
    8000508c:	00813083          	ld	ra,8(sp)
    80005090:	00013403          	ld	s0,0(sp)
    80005094:	01010113          	addi	sp,sp,16
    80005098:	00008067          	ret

000000008000509c <_ZN14PeriodicThreadC1Em>:

PeriodicThread::PeriodicThread (time_t period) : Thread(), period(period) {}
    8000509c:	fe010113          	addi	sp,sp,-32
    800050a0:	00113c23          	sd	ra,24(sp)
    800050a4:	00813823          	sd	s0,16(sp)
    800050a8:	00913423          	sd	s1,8(sp)
    800050ac:	01213023          	sd	s2,0(sp)
    800050b0:	02010413          	addi	s0,sp,32
    800050b4:	00050493          	mv	s1,a0
    800050b8:	00058913          	mv	s2,a1
    800050bc:	00000097          	auipc	ra,0x0
    800050c0:	f1c080e7          	jalr	-228(ra) # 80004fd8 <_ZN6ThreadC1Ev>
    800050c4:	00008797          	auipc	a5,0x8
    800050c8:	9bc78793          	addi	a5,a5,-1604 # 8000ca80 <_ZTV14PeriodicThread+0x10>
    800050cc:	00f4b023          	sd	a5,0(s1)
    800050d0:	0324b023          	sd	s2,32(s1)
    800050d4:	01813083          	ld	ra,24(sp)
    800050d8:	01013403          	ld	s0,16(sp)
    800050dc:	00813483          	ld	s1,8(sp)
    800050e0:	00013903          	ld	s2,0(sp)
    800050e4:	02010113          	addi	sp,sp,32
    800050e8:	00008067          	ret

00000000800050ec <_ZN14PeriodicThread9terminateEv>:
void PeriodicThread::terminate ()
{
    800050ec:	ff010113          	addi	sp,sp,-16
    800050f0:	00813423          	sd	s0,8(sp)
    800050f4:	01010413          	addi	s0,sp,16
    period = 0;
    800050f8:	02053023          	sd	zero,32(a0)
}
    800050fc:	00813403          	ld	s0,8(sp)
    80005100:	01010113          	addi	sp,sp,16
    80005104:	00008067          	ret

0000000080005108 <_ZN14PeriodicThread10runWrapperEPv>:
void PeriodicThread:: runWrapper(void* thr) {
    80005108:	fe010113          	addi	sp,sp,-32
    8000510c:	00113c23          	sd	ra,24(sp)
    80005110:	00813823          	sd	s0,16(sp)
    80005114:	00913423          	sd	s1,8(sp)
    80005118:	02010413          	addi	s0,sp,32
    8000511c:	00050493          	mv	s1,a0
    PeriodicThread *perThr = (PeriodicThread *) thr;
    while (perThr->period>0) {
    80005120:	0204b783          	ld	a5,32(s1)
    80005124:	02078263          	beqz	a5,80005148 <_ZN14PeriodicThread10runWrapperEPv+0x40>
        perThr->periodicActivation();
    80005128:	0004b783          	ld	a5,0(s1)
    8000512c:	0187b783          	ld	a5,24(a5)
    80005130:	00048513          	mv	a0,s1
    80005134:	000780e7          	jalr	a5
        time_sleep(perThr->period);
    80005138:	0204b503          	ld	a0,32(s1)
    8000513c:	ffffc097          	auipc	ra,0xffffc
    80005140:	224080e7          	jalr	548(ra) # 80001360 <_Z10time_sleepm>
    while (perThr->period>0) {
    80005144:	fddff06f          	j	80005120 <_ZN14PeriodicThread10runWrapperEPv+0x18>
    }
}
    80005148:	01813083          	ld	ra,24(sp)
    8000514c:	01013403          	ld	s0,16(sp)
    80005150:	00813483          	ld	s1,8(sp)
    80005154:	02010113          	addi	sp,sp,32
    80005158:	00008067          	ret

000000008000515c <_ZN7Console4getcEv>:

char Console::getc ()
{
    8000515c:	ff010113          	addi	sp,sp,-16
    80005160:	00113423          	sd	ra,8(sp)
    80005164:	00813023          	sd	s0,0(sp)
    80005168:	01010413          	addi	s0,sp,16
    return ::getc();
    8000516c:	ffffc097          	auipc	ra,0xffffc
    80005170:	220080e7          	jalr	544(ra) # 8000138c <_Z4getcv>
}
    80005174:	00813083          	ld	ra,8(sp)
    80005178:	00013403          	ld	s0,0(sp)
    8000517c:	01010113          	addi	sp,sp,16
    80005180:	00008067          	ret

0000000080005184 <_ZN7Console4putcEc>:
void Console::putc (char c)
{
    80005184:	ff010113          	addi	sp,sp,-16
    80005188:	00113423          	sd	ra,8(sp)
    8000518c:	00813023          	sd	s0,0(sp)
    80005190:	01010413          	addi	s0,sp,16
    ::putc(c);
    80005194:	ffffc097          	auipc	ra,0xffffc
    80005198:	220080e7          	jalr	544(ra) # 800013b4 <_Z4putcc>
    8000519c:	00813083          	ld	ra,8(sp)
    800051a0:	00013403          	ld	s0,0(sp)
    800051a4:	01010113          	addi	sp,sp,16
    800051a8:	00008067          	ret

00000000800051ac <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    800051ac:	ff010113          	addi	sp,sp,-16
    800051b0:	00813423          	sd	s0,8(sp)
    800051b4:	01010413          	addi	s0,sp,16
    800051b8:	00813403          	ld	s0,8(sp)
    800051bc:	01010113          	addi	sp,sp,16
    800051c0:	00008067          	ret

00000000800051c4 <_ZN14PeriodicThread18periodicActivationEv>:
public:
    void terminate ();
    static void runWrapper(void* thr);
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    800051c4:	ff010113          	addi	sp,sp,-16
    800051c8:	00813423          	sd	s0,8(sp)
    800051cc:	01010413          	addi	s0,sp,16
    800051d0:	00813403          	ld	s0,8(sp)
    800051d4:	01010113          	addi	sp,sp,16
    800051d8:	00008067          	ret

00000000800051dc <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800051dc:	ff010113          	addi	sp,sp,-16
    800051e0:	00113423          	sd	ra,8(sp)
    800051e4:	00813023          	sd	s0,0(sp)
    800051e8:	01010413          	addi	s0,sp,16
    800051ec:	00008797          	auipc	a5,0x8
    800051f0:	89478793          	addi	a5,a5,-1900 # 8000ca80 <_ZTV14PeriodicThread+0x10>
    800051f4:	00f53023          	sd	a5,0(a0)
    800051f8:	00000097          	auipc	ra,0x0
    800051fc:	b44080e7          	jalr	-1212(ra) # 80004d3c <_ZN6ThreadD1Ev>
    80005200:	00813083          	ld	ra,8(sp)
    80005204:	00013403          	ld	s0,0(sp)
    80005208:	01010113          	addi	sp,sp,16
    8000520c:	00008067          	ret

0000000080005210 <_ZN14PeriodicThreadD0Ev>:
    80005210:	fe010113          	addi	sp,sp,-32
    80005214:	00113c23          	sd	ra,24(sp)
    80005218:	00813823          	sd	s0,16(sp)
    8000521c:	00913423          	sd	s1,8(sp)
    80005220:	02010413          	addi	s0,sp,32
    80005224:	00050493          	mv	s1,a0
    80005228:	00008797          	auipc	a5,0x8
    8000522c:	85878793          	addi	a5,a5,-1960 # 8000ca80 <_ZTV14PeriodicThread+0x10>
    80005230:	00f53023          	sd	a5,0(a0)
    80005234:	00000097          	auipc	ra,0x0
    80005238:	b08080e7          	jalr	-1272(ra) # 80004d3c <_ZN6ThreadD1Ev>
    8000523c:	00048513          	mv	a0,s1
    80005240:	00000097          	auipc	ra,0x0
    80005244:	bdc080e7          	jalr	-1060(ra) # 80004e1c <_ZdlPv>
    80005248:	01813083          	ld	ra,24(sp)
    8000524c:	01013403          	ld	s0,16(sp)
    80005250:	00813483          	ld	s1,8(sp)
    80005254:	02010113          	addi	sp,sp,32
    80005258:	00008067          	ret

000000008000525c <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    8000525c:	fe010113          	addi	sp,sp,-32
    80005260:	00113c23          	sd	ra,24(sp)
    80005264:	00813823          	sd	s0,16(sp)
    80005268:	00913423          	sd	s1,8(sp)
    8000526c:	01213023          	sd	s2,0(sp)
    80005270:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005274:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005278:	00600493          	li	s1,6
    while (--i > 0) {
    8000527c:	fff4849b          	addiw	s1,s1,-1
    80005280:	04905463          	blez	s1,800052c8 <_ZL9sleepyRunPv+0x6c>
        printString("Hello ");
    80005284:	00005517          	auipc	a0,0x5
    80005288:	23450513          	addi	a0,a0,564 # 8000a4b8 <CONSOLE_STATUS+0x4a8>
    8000528c:	fffff097          	auipc	ra,0xfffff
    80005290:	908080e7          	jalr	-1784(ra) # 80003b94 <_Z11printStringPKc>
        printInt(sleep_time);
    80005294:	00000613          	li	a2,0
    80005298:	00a00593          	li	a1,10
    8000529c:	0009051b          	sext.w	a0,s2
    800052a0:	fffff097          	auipc	ra,0xfffff
    800052a4:	aa4080e7          	jalr	-1372(ra) # 80003d44 <_Z8printIntiii>
        printString(" !\n");
    800052a8:	00005517          	auipc	a0,0x5
    800052ac:	21850513          	addi	a0,a0,536 # 8000a4c0 <CONSOLE_STATUS+0x4b0>
    800052b0:	fffff097          	auipc	ra,0xfffff
    800052b4:	8e4080e7          	jalr	-1820(ra) # 80003b94 <_Z11printStringPKc>
        time_sleep(sleep_time);
    800052b8:	00090513          	mv	a0,s2
    800052bc:	ffffc097          	auipc	ra,0xffffc
    800052c0:	0a4080e7          	jalr	164(ra) # 80001360 <_Z10time_sleepm>
    while (--i > 0) {
    800052c4:	fb9ff06f          	j	8000527c <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800052c8:	00a00793          	li	a5,10
    800052cc:	02f95933          	divu	s2,s2,a5
    800052d0:	fff90913          	addi	s2,s2,-1
    800052d4:	00008797          	auipc	a5,0x8
    800052d8:	9ac78793          	addi	a5,a5,-1620 # 8000cc80 <_ZL8finished>
    800052dc:	01278933          	add	s2,a5,s2
    800052e0:	00100793          	li	a5,1
    800052e4:	00f90023          	sb	a5,0(s2)
}
    800052e8:	01813083          	ld	ra,24(sp)
    800052ec:	01013403          	ld	s0,16(sp)
    800052f0:	00813483          	ld	s1,8(sp)
    800052f4:	00013903          	ld	s2,0(sp)
    800052f8:	02010113          	addi	sp,sp,32
    800052fc:	00008067          	ret

0000000080005300 <_Z12testSleepingv>:

void testSleeping() {
    80005300:	fc010113          	addi	sp,sp,-64
    80005304:	02113c23          	sd	ra,56(sp)
    80005308:	02813823          	sd	s0,48(sp)
    8000530c:	02913423          	sd	s1,40(sp)
    80005310:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005314:	00a00793          	li	a5,10
    80005318:	fcf43823          	sd	a5,-48(s0)
    8000531c:	01400793          	li	a5,20
    80005320:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005324:	00000493          	li	s1,0
    80005328:	02c0006f          	j	80005354 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000532c:	00349793          	slli	a5,s1,0x3
    80005330:	fd040613          	addi	a2,s0,-48
    80005334:	00f60633          	add	a2,a2,a5
    80005338:	00000597          	auipc	a1,0x0
    8000533c:	f2458593          	addi	a1,a1,-220 # 8000525c <_ZL9sleepyRunPv>
    80005340:	fc040513          	addi	a0,s0,-64
    80005344:	00f50533          	add	a0,a0,a5
    80005348:	ffffc097          	auipc	ra,0xffffc
    8000534c:	e9c080e7          	jalr	-356(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005350:	0014849b          	addiw	s1,s1,1
    80005354:	00100793          	li	a5,1
    80005358:	fc97dae3          	bge	a5,s1,8000532c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    8000535c:	00008797          	auipc	a5,0x8
    80005360:	9247c783          	lbu	a5,-1756(a5) # 8000cc80 <_ZL8finished>
    80005364:	fe078ce3          	beqz	a5,8000535c <_Z12testSleepingv+0x5c>
    80005368:	00008797          	auipc	a5,0x8
    8000536c:	9197c783          	lbu	a5,-1767(a5) # 8000cc81 <_ZL8finished+0x1>
    80005370:	fe0786e3          	beqz	a5,8000535c <_Z12testSleepingv+0x5c>

    printString("Ryu\n");
    80005374:	00005517          	auipc	a0,0x5
    80005378:	15450513          	addi	a0,a0,340 # 8000a4c8 <CONSOLE_STATUS+0x4b8>
    8000537c:	fffff097          	auipc	ra,0xfffff
    80005380:	818080e7          	jalr	-2024(ra) # 80003b94 <_Z11printStringPKc>
}
    80005384:	03813083          	ld	ra,56(sp)
    80005388:	03013403          	ld	s0,48(sp)
    8000538c:	02813483          	ld	s1,40(sp)
    80005390:	04010113          	addi	sp,sp,64
    80005394:	00008067          	ret

0000000080005398 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80005398:	fe010113          	addi	sp,sp,-32
    8000539c:	00113c23          	sd	ra,24(sp)
    800053a0:	00813823          	sd	s0,16(sp)
    800053a4:	00913423          	sd	s1,8(sp)
    800053a8:	01213023          	sd	s2,0(sp)
    800053ac:	02010413          	addi	s0,sp,32
    800053b0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800053b4:	00100793          	li	a5,1
    800053b8:	02a7f863          	bgeu	a5,a0,800053e8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800053bc:	00a00793          	li	a5,10
    800053c0:	02f577b3          	remu	a5,a0,a5
    800053c4:	02078e63          	beqz	a5,80005400 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800053c8:	fff48513          	addi	a0,s1,-1
    800053cc:	00000097          	auipc	ra,0x0
    800053d0:	fcc080e7          	jalr	-52(ra) # 80005398 <_ZL9fibonaccim>
    800053d4:	00050913          	mv	s2,a0
    800053d8:	ffe48513          	addi	a0,s1,-2
    800053dc:	00000097          	auipc	ra,0x0
    800053e0:	fbc080e7          	jalr	-68(ra) # 80005398 <_ZL9fibonaccim>
    800053e4:	00a90533          	add	a0,s2,a0
}
    800053e8:	01813083          	ld	ra,24(sp)
    800053ec:	01013403          	ld	s0,16(sp)
    800053f0:	00813483          	ld	s1,8(sp)
    800053f4:	00013903          	ld	s2,0(sp)
    800053f8:	02010113          	addi	sp,sp,32
    800053fc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005400:	ffffc097          	auipc	ra,0xffffc
    80005404:	e8c080e7          	jalr	-372(ra) # 8000128c <_Z15thread_dispatchv>
    80005408:	fc1ff06f          	j	800053c8 <_ZL9fibonaccim+0x30>

000000008000540c <_ZL11workerBodyJPv>:
    }
    printString("I finished!\n");
    finishedI = true;
}

static void workerBodyJ(void* arg) {
    8000540c:	fe010113          	addi	sp,sp,-32
    80005410:	00113c23          	sd	ra,24(sp)
    80005414:	00813823          	sd	s0,16(sp)
    80005418:	00913423          	sd	s1,8(sp)
    8000541c:	01213023          	sd	s2,0(sp)
    80005420:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005424:	00000913          	li	s2,0
    80005428:	0380006f          	j	80005460 <_ZL11workerBodyJPv+0x54>
        printString("J: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000542c:	ffffc097          	auipc	ra,0xffffc
    80005430:	e60080e7          	jalr	-416(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005434:	00148493          	addi	s1,s1,1
    80005438:	000027b7          	lui	a5,0x2
    8000543c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005440:	0097ee63          	bltu	a5,s1,8000545c <_ZL11workerBodyJPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005444:	00000713          	li	a4,0
    80005448:	000077b7          	lui	a5,0x7
    8000544c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005450:	fce7eee3          	bltu	a5,a4,8000542c <_ZL11workerBodyJPv+0x20>
    80005454:	00170713          	addi	a4,a4,1
    80005458:	ff1ff06f          	j	80005448 <_ZL11workerBodyJPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000545c:	00190913          	addi	s2,s2,1
    80005460:	00f00793          	li	a5,15
    80005464:	0527e063          	bltu	a5,s2,800054a4 <_ZL11workerBodyJPv+0x98>
        printString("J: i="); printInt(i); printString("\n");
    80005468:	00005517          	auipc	a0,0x5
    8000546c:	06850513          	addi	a0,a0,104 # 8000a4d0 <CONSOLE_STATUS+0x4c0>
    80005470:	ffffe097          	auipc	ra,0xffffe
    80005474:	724080e7          	jalr	1828(ra) # 80003b94 <_Z11printStringPKc>
    80005478:	00000613          	li	a2,0
    8000547c:	00a00593          	li	a1,10
    80005480:	0009051b          	sext.w	a0,s2
    80005484:	fffff097          	auipc	ra,0xfffff
    80005488:	8c0080e7          	jalr	-1856(ra) # 80003d44 <_Z8printIntiii>
    8000548c:	00005517          	auipc	a0,0x5
    80005490:	ef450513          	addi	a0,a0,-268 # 8000a380 <CONSOLE_STATUS+0x370>
    80005494:	ffffe097          	auipc	ra,0xffffe
    80005498:	700080e7          	jalr	1792(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000549c:	00000493          	li	s1,0
    800054a0:	f99ff06f          	j	80005438 <_ZL11workerBodyJPv+0x2c>
            //printString("Anjin\n");
        }
    }
    printString("J finished!\n");
    800054a4:	00005517          	auipc	a0,0x5
    800054a8:	03450513          	addi	a0,a0,52 # 8000a4d8 <CONSOLE_STATUS+0x4c8>
    800054ac:	ffffe097          	auipc	ra,0xffffe
    800054b0:	6e8080e7          	jalr	1768(ra) # 80003b94 <_Z11printStringPKc>
    finishedJ = true;
    800054b4:	00100793          	li	a5,1
    800054b8:	00007717          	auipc	a4,0x7
    800054bc:	7cf70523          	sb	a5,1994(a4) # 8000cc82 <_ZL9finishedJ>
    thread_dispatch();
    800054c0:	ffffc097          	auipc	ra,0xffffc
    800054c4:	dcc080e7          	jalr	-564(ra) # 8000128c <_Z15thread_dispatchv>
}
    800054c8:	01813083          	ld	ra,24(sp)
    800054cc:	01013403          	ld	s0,16(sp)
    800054d0:	00813483          	ld	s1,8(sp)
    800054d4:	00013903          	ld	s2,0(sp)
    800054d8:	02010113          	addi	sp,sp,32
    800054dc:	00008067          	ret

00000000800054e0 <_ZL11workerBodyIPv>:
static void workerBodyI(void* arg) {
    800054e0:	fe010113          	addi	sp,sp,-32
    800054e4:	00113c23          	sd	ra,24(sp)
    800054e8:	00813823          	sd	s0,16(sp)
    800054ec:	00913423          	sd	s1,8(sp)
    800054f0:	01213023          	sd	s2,0(sp)
    800054f4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800054f8:	00000913          	li	s2,0
    800054fc:	0380006f          	j	80005534 <_ZL11workerBodyIPv+0x54>
            thread_dispatch();
    80005500:	ffffc097          	auipc	ra,0xffffc
    80005504:	d8c080e7          	jalr	-628(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005508:	00148493          	addi	s1,s1,1
    8000550c:	000027b7          	lui	a5,0x2
    80005510:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005514:	0097ee63          	bltu	a5,s1,80005530 <_ZL11workerBodyIPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005518:	00000713          	li	a4,0
    8000551c:	000077b7          	lui	a5,0x7
    80005520:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005524:	fce7eee3          	bltu	a5,a4,80005500 <_ZL11workerBodyIPv+0x20>
    80005528:	00170713          	addi	a4,a4,1
    8000552c:	ff1ff06f          	j	8000551c <_ZL11workerBodyIPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005530:	00190913          	addi	s2,s2,1
    80005534:	00900793          	li	a5,9
    80005538:	0527e063          	bltu	a5,s2,80005578 <_ZL11workerBodyIPv+0x98>
        printString("I: i="); printInt(i); printString("\n");
    8000553c:	00005517          	auipc	a0,0x5
    80005540:	fac50513          	addi	a0,a0,-84 # 8000a4e8 <CONSOLE_STATUS+0x4d8>
    80005544:	ffffe097          	auipc	ra,0xffffe
    80005548:	650080e7          	jalr	1616(ra) # 80003b94 <_Z11printStringPKc>
    8000554c:	00000613          	li	a2,0
    80005550:	00a00593          	li	a1,10
    80005554:	0009051b          	sext.w	a0,s2
    80005558:	ffffe097          	auipc	ra,0xffffe
    8000555c:	7ec080e7          	jalr	2028(ra) # 80003d44 <_Z8printIntiii>
    80005560:	00005517          	auipc	a0,0x5
    80005564:	e2050513          	addi	a0,a0,-480 # 8000a380 <CONSOLE_STATUS+0x370>
    80005568:	ffffe097          	auipc	ra,0xffffe
    8000556c:	62c080e7          	jalr	1580(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005570:	00000493          	li	s1,0
    80005574:	f99ff06f          	j	8000550c <_ZL11workerBodyIPv+0x2c>
    printString("I finished!\n");
    80005578:	00005517          	auipc	a0,0x5
    8000557c:	f7850513          	addi	a0,a0,-136 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80005580:	ffffe097          	auipc	ra,0xffffe
    80005584:	614080e7          	jalr	1556(ra) # 80003b94 <_Z11printStringPKc>
    finishedI = true;
    80005588:	00100793          	li	a5,1
    8000558c:	00007717          	auipc	a4,0x7
    80005590:	6ef70ba3          	sb	a5,1783(a4) # 8000cc83 <_ZL9finishedI>
}
    80005594:	01813083          	ld	ra,24(sp)
    80005598:	01013403          	ld	s0,16(sp)
    8000559c:	00813483          	ld	s1,8(sp)
    800055a0:	00013903          	ld	s2,0(sp)
    800055a4:	02010113          	addi	sp,sp,32
    800055a8:	00008067          	ret

00000000800055ac <_ZL11workerBodyHPv>:
static void workerBodyH(void* arg) {
    800055ac:	fe010113          	addi	sp,sp,-32
    800055b0:	00113c23          	sd	ra,24(sp)
    800055b4:	00813823          	sd	s0,16(sp)
    800055b8:	00913423          	sd	s1,8(sp)
    800055bc:	01213023          	sd	s2,0(sp)
    800055c0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800055c4:	00a00493          	li	s1,10
    800055c8:	0400006f          	j	80005608 <_ZL11workerBodyHPv+0x5c>
        printString("H: i="); printInt(i); printString("\n");
    800055cc:	00005517          	auipc	a0,0x5
    800055d0:	f3450513          	addi	a0,a0,-204 # 8000a500 <CONSOLE_STATUS+0x4f0>
    800055d4:	ffffe097          	auipc	ra,0xffffe
    800055d8:	5c0080e7          	jalr	1472(ra) # 80003b94 <_Z11printStringPKc>
    800055dc:	00000613          	li	a2,0
    800055e0:	00a00593          	li	a1,10
    800055e4:	00048513          	mv	a0,s1
    800055e8:	ffffe097          	auipc	ra,0xffffe
    800055ec:	75c080e7          	jalr	1884(ra) # 80003d44 <_Z8printIntiii>
    800055f0:	00005517          	auipc	a0,0x5
    800055f4:	d9050513          	addi	a0,a0,-624 # 8000a380 <CONSOLE_STATUS+0x370>
    800055f8:	ffffe097          	auipc	ra,0xffffe
    800055fc:	59c080e7          	jalr	1436(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005600:	0014849b          	addiw	s1,s1,1
    80005604:	0ff4f493          	andi	s1,s1,255
    80005608:	00c00793          	li	a5,12
    8000560c:	fc97f0e3          	bgeu	a5,s1,800055cc <_ZL11workerBodyHPv+0x20>
    printString("H: dispatch\n");
    80005610:	00005517          	auipc	a0,0x5
    80005614:	ef850513          	addi	a0,a0,-264 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80005618:	ffffe097          	auipc	ra,0xffffe
    8000561c:	57c080e7          	jalr	1404(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005620:	00500313          	li	t1,5
    thread_dispatch();
    80005624:	ffffc097          	auipc	ra,0xffffc
    80005628:	c68080e7          	jalr	-920(ra) # 8000128c <_Z15thread_dispatchv>
    uint64 result = fibonacci(16);
    8000562c:	01000513          	li	a0,16
    80005630:	00000097          	auipc	ra,0x0
    80005634:	d68080e7          	jalr	-664(ra) # 80005398 <_ZL9fibonaccim>
    80005638:	00050913          	mv	s2,a0
    printString("H: fibonaci="); printInt(result); printString("\n");
    8000563c:	00005517          	auipc	a0,0x5
    80005640:	edc50513          	addi	a0,a0,-292 # 8000a518 <CONSOLE_STATUS+0x508>
    80005644:	ffffe097          	auipc	ra,0xffffe
    80005648:	550080e7          	jalr	1360(ra) # 80003b94 <_Z11printStringPKc>
    8000564c:	00000613          	li	a2,0
    80005650:	00a00593          	li	a1,10
    80005654:	0009051b          	sext.w	a0,s2
    80005658:	ffffe097          	auipc	ra,0xffffe
    8000565c:	6ec080e7          	jalr	1772(ra) # 80003d44 <_Z8printIntiii>
    80005660:	00005517          	auipc	a0,0x5
    80005664:	d2050513          	addi	a0,a0,-736 # 8000a380 <CONSOLE_STATUS+0x370>
    80005668:	ffffe097          	auipc	ra,0xffffe
    8000566c:	52c080e7          	jalr	1324(ra) # 80003b94 <_Z11printStringPKc>
    80005670:	0400006f          	j	800056b0 <_ZL11workerBodyHPv+0x104>
        printString("H: i="); printInt(i); printString("\n");
    80005674:	00005517          	auipc	a0,0x5
    80005678:	e8c50513          	addi	a0,a0,-372 # 8000a500 <CONSOLE_STATUS+0x4f0>
    8000567c:	ffffe097          	auipc	ra,0xffffe
    80005680:	518080e7          	jalr	1304(ra) # 80003b94 <_Z11printStringPKc>
    80005684:	00000613          	li	a2,0
    80005688:	00a00593          	li	a1,10
    8000568c:	00048513          	mv	a0,s1
    80005690:	ffffe097          	auipc	ra,0xffffe
    80005694:	6b4080e7          	jalr	1716(ra) # 80003d44 <_Z8printIntiii>
    80005698:	00005517          	auipc	a0,0x5
    8000569c:	ce850513          	addi	a0,a0,-792 # 8000a380 <CONSOLE_STATUS+0x370>
    800056a0:	ffffe097          	auipc	ra,0xffffe
    800056a4:	4f4080e7          	jalr	1268(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800056a8:	0014849b          	addiw	s1,s1,1
    800056ac:	0ff4f493          	andi	s1,s1,255
    800056b0:	00f00793          	li	a5,15
    800056b4:	fc97f0e3          	bgeu	a5,s1,80005674 <_ZL11workerBodyHPv+0xc8>
    printString("H finished!\n");
    800056b8:	00005517          	auipc	a0,0x5
    800056bc:	e7050513          	addi	a0,a0,-400 # 8000a528 <CONSOLE_STATUS+0x518>
    800056c0:	ffffe097          	auipc	ra,0xffffe
    800056c4:	4d4080e7          	jalr	1236(ra) # 80003b94 <_Z11printStringPKc>
    finishedH = true;
    800056c8:	00100793          	li	a5,1
    800056cc:	00007717          	auipc	a4,0x7
    800056d0:	5af70c23          	sb	a5,1464(a4) # 8000cc84 <_ZL9finishedH>
    thread_dispatch();
    800056d4:	ffffc097          	auipc	ra,0xffffc
    800056d8:	bb8080e7          	jalr	-1096(ra) # 8000128c <_Z15thread_dispatchv>
}
    800056dc:	01813083          	ld	ra,24(sp)
    800056e0:	01013403          	ld	s0,16(sp)
    800056e4:	00813483          	ld	s1,8(sp)
    800056e8:	00013903          	ld	s2,0(sp)
    800056ec:	02010113          	addi	sp,sp,32
    800056f0:	00008067          	ret

00000000800056f4 <_ZL11workerBodyGPv>:
static void workerBodyG(void* arg) {
    800056f4:	fe010113          	addi	sp,sp,-32
    800056f8:	00113c23          	sd	ra,24(sp)
    800056fc:	00813823          	sd	s0,16(sp)
    80005700:	00913423          	sd	s1,8(sp)
    80005704:	01213023          	sd	s2,0(sp)
    80005708:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000570c:	00000493          	li	s1,0
    80005710:	0400006f          	j	80005750 <_ZL11workerBodyGPv+0x5c>
        printString("G: i="); printInt(i); printString("\n");
    80005714:	00005517          	auipc	a0,0x5
    80005718:	e2450513          	addi	a0,a0,-476 # 8000a538 <CONSOLE_STATUS+0x528>
    8000571c:	ffffe097          	auipc	ra,0xffffe
    80005720:	478080e7          	jalr	1144(ra) # 80003b94 <_Z11printStringPKc>
    80005724:	00000613          	li	a2,0
    80005728:	00a00593          	li	a1,10
    8000572c:	00048513          	mv	a0,s1
    80005730:	ffffe097          	auipc	ra,0xffffe
    80005734:	614080e7          	jalr	1556(ra) # 80003d44 <_Z8printIntiii>
    80005738:	00005517          	auipc	a0,0x5
    8000573c:	c4850513          	addi	a0,a0,-952 # 8000a380 <CONSOLE_STATUS+0x370>
    80005740:	ffffe097          	auipc	ra,0xffffe
    80005744:	454080e7          	jalr	1108(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005748:	0014849b          	addiw	s1,s1,1
    8000574c:	0ff4f493          	andi	s1,s1,255
    80005750:	00200793          	li	a5,2
    80005754:	fc97f0e3          	bgeu	a5,s1,80005714 <_ZL11workerBodyGPv+0x20>
    printString("G: dispatch\n");
    80005758:	00005517          	auipc	a0,0x5
    8000575c:	de850513          	addi	a0,a0,-536 # 8000a540 <CONSOLE_STATUS+0x530>
    80005760:	ffffe097          	auipc	ra,0xffffe
    80005764:	434080e7          	jalr	1076(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005768:	00700313          	li	t1,7
    thread_dispatch();
    8000576c:	ffffc097          	auipc	ra,0xffffc
    80005770:	b20080e7          	jalr	-1248(ra) # 8000128c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005774:	00030913          	mv	s2,t1
    printString("G: t1="); printInt(t1); printString("\n");
    80005778:	00005517          	auipc	a0,0x5
    8000577c:	dd850513          	addi	a0,a0,-552 # 8000a550 <CONSOLE_STATUS+0x540>
    80005780:	ffffe097          	auipc	ra,0xffffe
    80005784:	414080e7          	jalr	1044(ra) # 80003b94 <_Z11printStringPKc>
    80005788:	00000613          	li	a2,0
    8000578c:	00a00593          	li	a1,10
    80005790:	0009051b          	sext.w	a0,s2
    80005794:	ffffe097          	auipc	ra,0xffffe
    80005798:	5b0080e7          	jalr	1456(ra) # 80003d44 <_Z8printIntiii>
    8000579c:	00005517          	auipc	a0,0x5
    800057a0:	be450513          	addi	a0,a0,-1052 # 8000a380 <CONSOLE_STATUS+0x370>
    800057a4:	ffffe097          	auipc	ra,0xffffe
    800057a8:	3f0080e7          	jalr	1008(ra) # 80003b94 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800057ac:	00c00513          	li	a0,12
    800057b0:	00000097          	auipc	ra,0x0
    800057b4:	be8080e7          	jalr	-1048(ra) # 80005398 <_ZL9fibonaccim>
    800057b8:	00050913          	mv	s2,a0
    printString("G: fibonaci="); printInt(result); printString("\n");
    800057bc:	00005517          	auipc	a0,0x5
    800057c0:	d9c50513          	addi	a0,a0,-612 # 8000a558 <CONSOLE_STATUS+0x548>
    800057c4:	ffffe097          	auipc	ra,0xffffe
    800057c8:	3d0080e7          	jalr	976(ra) # 80003b94 <_Z11printStringPKc>
    800057cc:	00000613          	li	a2,0
    800057d0:	00a00593          	li	a1,10
    800057d4:	0009051b          	sext.w	a0,s2
    800057d8:	ffffe097          	auipc	ra,0xffffe
    800057dc:	56c080e7          	jalr	1388(ra) # 80003d44 <_Z8printIntiii>
    800057e0:	00005517          	auipc	a0,0x5
    800057e4:	ba050513          	addi	a0,a0,-1120 # 8000a380 <CONSOLE_STATUS+0x370>
    800057e8:	ffffe097          	auipc	ra,0xffffe
    800057ec:	3ac080e7          	jalr	940(ra) # 80003b94 <_Z11printStringPKc>
    800057f0:	0400006f          	j	80005830 <_ZL11workerBodyGPv+0x13c>
        printString("G: i="); printInt(i); printString("\n");
    800057f4:	00005517          	auipc	a0,0x5
    800057f8:	d4450513          	addi	a0,a0,-700 # 8000a538 <CONSOLE_STATUS+0x528>
    800057fc:	ffffe097          	auipc	ra,0xffffe
    80005800:	398080e7          	jalr	920(ra) # 80003b94 <_Z11printStringPKc>
    80005804:	00000613          	li	a2,0
    80005808:	00a00593          	li	a1,10
    8000580c:	00048513          	mv	a0,s1
    80005810:	ffffe097          	auipc	ra,0xffffe
    80005814:	534080e7          	jalr	1332(ra) # 80003d44 <_Z8printIntiii>
    80005818:	00005517          	auipc	a0,0x5
    8000581c:	b6850513          	addi	a0,a0,-1176 # 8000a380 <CONSOLE_STATUS+0x370>
    80005820:	ffffe097          	auipc	ra,0xffffe
    80005824:	374080e7          	jalr	884(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005828:	0014849b          	addiw	s1,s1,1
    8000582c:	0ff4f493          	andi	s1,s1,255
    80005830:	00500793          	li	a5,5
    80005834:	fc97f0e3          	bgeu	a5,s1,800057f4 <_ZL11workerBodyGPv+0x100>
    printString("G finished!\n");
    80005838:	00005517          	auipc	a0,0x5
    8000583c:	d3050513          	addi	a0,a0,-720 # 8000a568 <CONSOLE_STATUS+0x558>
    80005840:	ffffe097          	auipc	ra,0xffffe
    80005844:	354080e7          	jalr	852(ra) # 80003b94 <_Z11printStringPKc>
    finishedG = true;
    80005848:	00100793          	li	a5,1
    8000584c:	00007717          	auipc	a4,0x7
    80005850:	42f70ca3          	sb	a5,1081(a4) # 8000cc85 <_ZL9finishedG>
    thread_dispatch();
    80005854:	ffffc097          	auipc	ra,0xffffc
    80005858:	a38080e7          	jalr	-1480(ra) # 8000128c <_Z15thread_dispatchv>
}
    8000585c:	01813083          	ld	ra,24(sp)
    80005860:	01013403          	ld	s0,16(sp)
    80005864:	00813483          	ld	s1,8(sp)
    80005868:	00013903          	ld	s2,0(sp)
    8000586c:	02010113          	addi	sp,sp,32
    80005870:	00008067          	ret

0000000080005874 <_ZL11workerBodyFPv>:
static void workerBodyF(void* arg) {
    80005874:	fe010113          	addi	sp,sp,-32
    80005878:	00113c23          	sd	ra,24(sp)
    8000587c:	00813823          	sd	s0,16(sp)
    80005880:	00913423          	sd	s1,8(sp)
    80005884:	01213023          	sd	s2,0(sp)
    80005888:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000588c:	00000913          	li	s2,0
    80005890:	0380006f          	j	800058c8 <_ZL11workerBodyFPv+0x54>
            thread_dispatch();
    80005894:	ffffc097          	auipc	ra,0xffffc
    80005898:	9f8080e7          	jalr	-1544(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000589c:	00148493          	addi	s1,s1,1
    800058a0:	000027b7          	lui	a5,0x2
    800058a4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800058a8:	0097ee63          	bltu	a5,s1,800058c4 <_ZL11workerBodyFPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800058ac:	00000713          	li	a4,0
    800058b0:	000077b7          	lui	a5,0x7
    800058b4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800058b8:	fce7eee3          	bltu	a5,a4,80005894 <_ZL11workerBodyFPv+0x20>
    800058bc:	00170713          	addi	a4,a4,1
    800058c0:	ff1ff06f          	j	800058b0 <_ZL11workerBodyFPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800058c4:	00190913          	addi	s2,s2,1
    800058c8:	00f00793          	li	a5,15
    800058cc:	0527e063          	bltu	a5,s2,8000590c <_ZL11workerBodyFPv+0x98>
        printString("F: i="); printInt(i); printString("\n");
    800058d0:	00005517          	auipc	a0,0x5
    800058d4:	ca850513          	addi	a0,a0,-856 # 8000a578 <CONSOLE_STATUS+0x568>
    800058d8:	ffffe097          	auipc	ra,0xffffe
    800058dc:	2bc080e7          	jalr	700(ra) # 80003b94 <_Z11printStringPKc>
    800058e0:	00000613          	li	a2,0
    800058e4:	00a00593          	li	a1,10
    800058e8:	0009051b          	sext.w	a0,s2
    800058ec:	ffffe097          	auipc	ra,0xffffe
    800058f0:	458080e7          	jalr	1112(ra) # 80003d44 <_Z8printIntiii>
    800058f4:	00005517          	auipc	a0,0x5
    800058f8:	a8c50513          	addi	a0,a0,-1396 # 8000a380 <CONSOLE_STATUS+0x370>
    800058fc:	ffffe097          	auipc	ra,0xffffe
    80005900:	298080e7          	jalr	664(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005904:	00000493          	li	s1,0
    80005908:	f99ff06f          	j	800058a0 <_ZL11workerBodyFPv+0x2c>
    printString("F finished!\n");
    8000590c:	00005517          	auipc	a0,0x5
    80005910:	c7450513          	addi	a0,a0,-908 # 8000a580 <CONSOLE_STATUS+0x570>
    80005914:	ffffe097          	auipc	ra,0xffffe
    80005918:	280080e7          	jalr	640(ra) # 80003b94 <_Z11printStringPKc>
    finishedF = true;
    8000591c:	00100793          	li	a5,1
    80005920:	00007717          	auipc	a4,0x7
    80005924:	36f70323          	sb	a5,870(a4) # 8000cc86 <_ZL9finishedF>
    thread_dispatch();
    80005928:	ffffc097          	auipc	ra,0xffffc
    8000592c:	964080e7          	jalr	-1692(ra) # 8000128c <_Z15thread_dispatchv>
}
    80005930:	01813083          	ld	ra,24(sp)
    80005934:	01013403          	ld	s0,16(sp)
    80005938:	00813483          	ld	s1,8(sp)
    8000593c:	00013903          	ld	s2,0(sp)
    80005940:	02010113          	addi	sp,sp,32
    80005944:	00008067          	ret

0000000080005948 <_ZL11workerBodyEPv>:
static void workerBodyE(void* arg) {
    80005948:	fe010113          	addi	sp,sp,-32
    8000594c:	00113c23          	sd	ra,24(sp)
    80005950:	00813823          	sd	s0,16(sp)
    80005954:	00913423          	sd	s1,8(sp)
    80005958:	01213023          	sd	s2,0(sp)
    8000595c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005960:	00000913          	li	s2,0
    80005964:	0380006f          	j	8000599c <_ZL11workerBodyEPv+0x54>
            thread_dispatch();
    80005968:	ffffc097          	auipc	ra,0xffffc
    8000596c:	924080e7          	jalr	-1756(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005970:	00148493          	addi	s1,s1,1
    80005974:	000027b7          	lui	a5,0x2
    80005978:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000597c:	0097ee63          	bltu	a5,s1,80005998 <_ZL11workerBodyEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005980:	00000713          	li	a4,0
    80005984:	000077b7          	lui	a5,0x7
    80005988:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000598c:	fce7eee3          	bltu	a5,a4,80005968 <_ZL11workerBodyEPv+0x20>
    80005990:	00170713          	addi	a4,a4,1
    80005994:	ff1ff06f          	j	80005984 <_ZL11workerBodyEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005998:	00190913          	addi	s2,s2,1
    8000599c:	00900793          	li	a5,9
    800059a0:	0527e063          	bltu	a5,s2,800059e0 <_ZL11workerBodyEPv+0x98>
        printString("E: i="); printInt(i); printString("\n");
    800059a4:	00005517          	auipc	a0,0x5
    800059a8:	bec50513          	addi	a0,a0,-1044 # 8000a590 <CONSOLE_STATUS+0x580>
    800059ac:	ffffe097          	auipc	ra,0xffffe
    800059b0:	1e8080e7          	jalr	488(ra) # 80003b94 <_Z11printStringPKc>
    800059b4:	00000613          	li	a2,0
    800059b8:	00a00593          	li	a1,10
    800059bc:	0009051b          	sext.w	a0,s2
    800059c0:	ffffe097          	auipc	ra,0xffffe
    800059c4:	384080e7          	jalr	900(ra) # 80003d44 <_Z8printIntiii>
    800059c8:	00005517          	auipc	a0,0x5
    800059cc:	9b850513          	addi	a0,a0,-1608 # 8000a380 <CONSOLE_STATUS+0x370>
    800059d0:	ffffe097          	auipc	ra,0xffffe
    800059d4:	1c4080e7          	jalr	452(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800059d8:	00000493          	li	s1,0
    800059dc:	f99ff06f          	j	80005974 <_ZL11workerBodyEPv+0x2c>
    printString("E finished!\n");
    800059e0:	00005517          	auipc	a0,0x5
    800059e4:	bb850513          	addi	a0,a0,-1096 # 8000a598 <CONSOLE_STATUS+0x588>
    800059e8:	ffffe097          	auipc	ra,0xffffe
    800059ec:	1ac080e7          	jalr	428(ra) # 80003b94 <_Z11printStringPKc>
    finishedE = true;
    800059f0:	00100793          	li	a5,1
    800059f4:	00007717          	auipc	a4,0x7
    800059f8:	28f709a3          	sb	a5,659(a4) # 8000cc87 <_ZL9finishedE>
}
    800059fc:	01813083          	ld	ra,24(sp)
    80005a00:	01013403          	ld	s0,16(sp)
    80005a04:	00813483          	ld	s1,8(sp)
    80005a08:	00013903          	ld	s2,0(sp)
    80005a0c:	02010113          	addi	sp,sp,32
    80005a10:	00008067          	ret

0000000080005a14 <_ZL11workerBodyDPv>:
static void workerBodyD(void* arg) {
    80005a14:	fe010113          	addi	sp,sp,-32
    80005a18:	00113c23          	sd	ra,24(sp)
    80005a1c:	00813823          	sd	s0,16(sp)
    80005a20:	00913423          	sd	s1,8(sp)
    80005a24:	01213023          	sd	s2,0(sp)
    80005a28:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005a2c:	00a00493          	li	s1,10
    80005a30:	0400006f          	j	80005a70 <_ZL11workerBodyDPv+0x5c>
        printString("D: i="); printInt(i); printString("\n");
    80005a34:	00004517          	auipc	a0,0x4
    80005a38:	75c50513          	addi	a0,a0,1884 # 8000a190 <CONSOLE_STATUS+0x180>
    80005a3c:	ffffe097          	auipc	ra,0xffffe
    80005a40:	158080e7          	jalr	344(ra) # 80003b94 <_Z11printStringPKc>
    80005a44:	00000613          	li	a2,0
    80005a48:	00a00593          	li	a1,10
    80005a4c:	00048513          	mv	a0,s1
    80005a50:	ffffe097          	auipc	ra,0xffffe
    80005a54:	2f4080e7          	jalr	756(ra) # 80003d44 <_Z8printIntiii>
    80005a58:	00005517          	auipc	a0,0x5
    80005a5c:	92850513          	addi	a0,a0,-1752 # 8000a380 <CONSOLE_STATUS+0x370>
    80005a60:	ffffe097          	auipc	ra,0xffffe
    80005a64:	134080e7          	jalr	308(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005a68:	0014849b          	addiw	s1,s1,1
    80005a6c:	0ff4f493          	andi	s1,s1,255
    80005a70:	00c00793          	li	a5,12
    80005a74:	fc97f0e3          	bgeu	a5,s1,80005a34 <_ZL11workerBodyDPv+0x20>
    printString("D: dispatch\n");
    80005a78:	00004517          	auipc	a0,0x4
    80005a7c:	72050513          	addi	a0,a0,1824 # 8000a198 <CONSOLE_STATUS+0x188>
    80005a80:	ffffe097          	auipc	ra,0xffffe
    80005a84:	114080e7          	jalr	276(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005a88:	00500313          	li	t1,5
    thread_dispatch();
    80005a8c:	ffffc097          	auipc	ra,0xffffc
    80005a90:	800080e7          	jalr	-2048(ra) # 8000128c <_Z15thread_dispatchv>
    uint64 result = fibonacci(16);
    80005a94:	01000513          	li	a0,16
    80005a98:	00000097          	auipc	ra,0x0
    80005a9c:	900080e7          	jalr	-1792(ra) # 80005398 <_ZL9fibonaccim>
    80005aa0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005aa4:	00004517          	auipc	a0,0x4
    80005aa8:	70450513          	addi	a0,a0,1796 # 8000a1a8 <CONSOLE_STATUS+0x198>
    80005aac:	ffffe097          	auipc	ra,0xffffe
    80005ab0:	0e8080e7          	jalr	232(ra) # 80003b94 <_Z11printStringPKc>
    80005ab4:	00000613          	li	a2,0
    80005ab8:	00a00593          	li	a1,10
    80005abc:	0009051b          	sext.w	a0,s2
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	284080e7          	jalr	644(ra) # 80003d44 <_Z8printIntiii>
    80005ac8:	00005517          	auipc	a0,0x5
    80005acc:	8b850513          	addi	a0,a0,-1864 # 8000a380 <CONSOLE_STATUS+0x370>
    80005ad0:	ffffe097          	auipc	ra,0xffffe
    80005ad4:	0c4080e7          	jalr	196(ra) # 80003b94 <_Z11printStringPKc>
    80005ad8:	0400006f          	j	80005b18 <_ZL11workerBodyDPv+0x104>
        printString("D: i="); printInt(i); printString("\n");
    80005adc:	00004517          	auipc	a0,0x4
    80005ae0:	6b450513          	addi	a0,a0,1716 # 8000a190 <CONSOLE_STATUS+0x180>
    80005ae4:	ffffe097          	auipc	ra,0xffffe
    80005ae8:	0b0080e7          	jalr	176(ra) # 80003b94 <_Z11printStringPKc>
    80005aec:	00000613          	li	a2,0
    80005af0:	00a00593          	li	a1,10
    80005af4:	00048513          	mv	a0,s1
    80005af8:	ffffe097          	auipc	ra,0xffffe
    80005afc:	24c080e7          	jalr	588(ra) # 80003d44 <_Z8printIntiii>
    80005b00:	00005517          	auipc	a0,0x5
    80005b04:	88050513          	addi	a0,a0,-1920 # 8000a380 <CONSOLE_STATUS+0x370>
    80005b08:	ffffe097          	auipc	ra,0xffffe
    80005b0c:	08c080e7          	jalr	140(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005b10:	0014849b          	addiw	s1,s1,1
    80005b14:	0ff4f493          	andi	s1,s1,255
    80005b18:	00f00793          	li	a5,15
    80005b1c:	fc97f0e3          	bgeu	a5,s1,80005adc <_ZL11workerBodyDPv+0xc8>
    printString("D finished!\n");
    80005b20:	00004517          	auipc	a0,0x4
    80005b24:	69850513          	addi	a0,a0,1688 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    80005b28:	ffffe097          	auipc	ra,0xffffe
    80005b2c:	06c080e7          	jalr	108(ra) # 80003b94 <_Z11printStringPKc>
    finishedD = true;
    80005b30:	00100793          	li	a5,1
    80005b34:	00007717          	auipc	a4,0x7
    80005b38:	14f70a23          	sb	a5,340(a4) # 8000cc88 <_ZL9finishedD>
    thread_dispatch();
    80005b3c:	ffffb097          	auipc	ra,0xffffb
    80005b40:	750080e7          	jalr	1872(ra) # 8000128c <_Z15thread_dispatchv>
}
    80005b44:	01813083          	ld	ra,24(sp)
    80005b48:	01013403          	ld	s0,16(sp)
    80005b4c:	00813483          	ld	s1,8(sp)
    80005b50:	00013903          	ld	s2,0(sp)
    80005b54:	02010113          	addi	sp,sp,32
    80005b58:	00008067          	ret

0000000080005b5c <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005b5c:	fe010113          	addi	sp,sp,-32
    80005b60:	00113c23          	sd	ra,24(sp)
    80005b64:	00813823          	sd	s0,16(sp)
    80005b68:	00913423          	sd	s1,8(sp)
    80005b6c:	01213023          	sd	s2,0(sp)
    80005b70:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005b74:	00000493          	li	s1,0
    80005b78:	0400006f          	j	80005bb8 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005b7c:	00004517          	auipc	a0,0x4
    80005b80:	5d450513          	addi	a0,a0,1492 # 8000a150 <CONSOLE_STATUS+0x140>
    80005b84:	ffffe097          	auipc	ra,0xffffe
    80005b88:	010080e7          	jalr	16(ra) # 80003b94 <_Z11printStringPKc>
    80005b8c:	00000613          	li	a2,0
    80005b90:	00a00593          	li	a1,10
    80005b94:	00048513          	mv	a0,s1
    80005b98:	ffffe097          	auipc	ra,0xffffe
    80005b9c:	1ac080e7          	jalr	428(ra) # 80003d44 <_Z8printIntiii>
    80005ba0:	00004517          	auipc	a0,0x4
    80005ba4:	7e050513          	addi	a0,a0,2016 # 8000a380 <CONSOLE_STATUS+0x370>
    80005ba8:	ffffe097          	auipc	ra,0xffffe
    80005bac:	fec080e7          	jalr	-20(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005bb0:	0014849b          	addiw	s1,s1,1
    80005bb4:	0ff4f493          	andi	s1,s1,255
    80005bb8:	00200793          	li	a5,2
    80005bbc:	fc97f0e3          	bgeu	a5,s1,80005b7c <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005bc0:	00004517          	auipc	a0,0x4
    80005bc4:	59850513          	addi	a0,a0,1432 # 8000a158 <CONSOLE_STATUS+0x148>
    80005bc8:	ffffe097          	auipc	ra,0xffffe
    80005bcc:	fcc080e7          	jalr	-52(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005bd0:	00700313          	li	t1,7
    thread_dispatch();
    80005bd4:	ffffb097          	auipc	ra,0xffffb
    80005bd8:	6b8080e7          	jalr	1720(ra) # 8000128c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005bdc:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005be0:	00004517          	auipc	a0,0x4
    80005be4:	58850513          	addi	a0,a0,1416 # 8000a168 <CONSOLE_STATUS+0x158>
    80005be8:	ffffe097          	auipc	ra,0xffffe
    80005bec:	fac080e7          	jalr	-84(ra) # 80003b94 <_Z11printStringPKc>
    80005bf0:	00000613          	li	a2,0
    80005bf4:	00a00593          	li	a1,10
    80005bf8:	0009051b          	sext.w	a0,s2
    80005bfc:	ffffe097          	auipc	ra,0xffffe
    80005c00:	148080e7          	jalr	328(ra) # 80003d44 <_Z8printIntiii>
    80005c04:	00004517          	auipc	a0,0x4
    80005c08:	77c50513          	addi	a0,a0,1916 # 8000a380 <CONSOLE_STATUS+0x370>
    80005c0c:	ffffe097          	auipc	ra,0xffffe
    80005c10:	f88080e7          	jalr	-120(ra) # 80003b94 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005c14:	00c00513          	li	a0,12
    80005c18:	fffff097          	auipc	ra,0xfffff
    80005c1c:	780080e7          	jalr	1920(ra) # 80005398 <_ZL9fibonaccim>
    80005c20:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005c24:	00004517          	auipc	a0,0x4
    80005c28:	54c50513          	addi	a0,a0,1356 # 8000a170 <CONSOLE_STATUS+0x160>
    80005c2c:	ffffe097          	auipc	ra,0xffffe
    80005c30:	f68080e7          	jalr	-152(ra) # 80003b94 <_Z11printStringPKc>
    80005c34:	00000613          	li	a2,0
    80005c38:	00a00593          	li	a1,10
    80005c3c:	0009051b          	sext.w	a0,s2
    80005c40:	ffffe097          	auipc	ra,0xffffe
    80005c44:	104080e7          	jalr	260(ra) # 80003d44 <_Z8printIntiii>
    80005c48:	00004517          	auipc	a0,0x4
    80005c4c:	73850513          	addi	a0,a0,1848 # 8000a380 <CONSOLE_STATUS+0x370>
    80005c50:	ffffe097          	auipc	ra,0xffffe
    80005c54:	f44080e7          	jalr	-188(ra) # 80003b94 <_Z11printStringPKc>
    80005c58:	0400006f          	j	80005c98 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005c5c:	00004517          	auipc	a0,0x4
    80005c60:	4f450513          	addi	a0,a0,1268 # 8000a150 <CONSOLE_STATUS+0x140>
    80005c64:	ffffe097          	auipc	ra,0xffffe
    80005c68:	f30080e7          	jalr	-208(ra) # 80003b94 <_Z11printStringPKc>
    80005c6c:	00000613          	li	a2,0
    80005c70:	00a00593          	li	a1,10
    80005c74:	00048513          	mv	a0,s1
    80005c78:	ffffe097          	auipc	ra,0xffffe
    80005c7c:	0cc080e7          	jalr	204(ra) # 80003d44 <_Z8printIntiii>
    80005c80:	00004517          	auipc	a0,0x4
    80005c84:	70050513          	addi	a0,a0,1792 # 8000a380 <CONSOLE_STATUS+0x370>
    80005c88:	ffffe097          	auipc	ra,0xffffe
    80005c8c:	f0c080e7          	jalr	-244(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005c90:	0014849b          	addiw	s1,s1,1
    80005c94:	0ff4f493          	andi	s1,s1,255
    80005c98:	00500793          	li	a5,5
    80005c9c:	fc97f0e3          	bgeu	a5,s1,80005c5c <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80005ca0:	00004517          	auipc	a0,0x4
    80005ca4:	4e050513          	addi	a0,a0,1248 # 8000a180 <CONSOLE_STATUS+0x170>
    80005ca8:	ffffe097          	auipc	ra,0xffffe
    80005cac:	eec080e7          	jalr	-276(ra) # 80003b94 <_Z11printStringPKc>
    finishedC = true;
    80005cb0:	00100793          	li	a5,1
    80005cb4:	00007717          	auipc	a4,0x7
    80005cb8:	fcf70aa3          	sb	a5,-43(a4) # 8000cc89 <_ZL9finishedC>
    thread_dispatch();
    80005cbc:	ffffb097          	auipc	ra,0xffffb
    80005cc0:	5d0080e7          	jalr	1488(ra) # 8000128c <_Z15thread_dispatchv>
}
    80005cc4:	01813083          	ld	ra,24(sp)
    80005cc8:	01013403          	ld	s0,16(sp)
    80005ccc:	00813483          	ld	s1,8(sp)
    80005cd0:	00013903          	ld	s2,0(sp)
    80005cd4:	02010113          	addi	sp,sp,32
    80005cd8:	00008067          	ret

0000000080005cdc <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005cdc:	fe010113          	addi	sp,sp,-32
    80005ce0:	00113c23          	sd	ra,24(sp)
    80005ce4:	00813823          	sd	s0,16(sp)
    80005ce8:	00913423          	sd	s1,8(sp)
    80005cec:	01213023          	sd	s2,0(sp)
    80005cf0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005cf4:	00000913          	li	s2,0
    80005cf8:	0380006f          	j	80005d30 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80005cfc:	ffffb097          	auipc	ra,0xffffb
    80005d00:	590080e7          	jalr	1424(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005d04:	00148493          	addi	s1,s1,1
    80005d08:	000027b7          	lui	a5,0x2
    80005d0c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005d10:	0097ee63          	bltu	a5,s1,80005d2c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005d14:	00000713          	li	a4,0
    80005d18:	000077b7          	lui	a5,0x7
    80005d1c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005d20:	fce7eee3          	bltu	a5,a4,80005cfc <_ZL11workerBodyBPv+0x20>
    80005d24:	00170713          	addi	a4,a4,1
    80005d28:	ff1ff06f          	j	80005d18 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005d2c:	00190913          	addi	s2,s2,1
    80005d30:	00f00793          	li	a5,15
    80005d34:	0527e063          	bltu	a5,s2,80005d74 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005d38:	00004517          	auipc	a0,0x4
    80005d3c:	40050513          	addi	a0,a0,1024 # 8000a138 <CONSOLE_STATUS+0x128>
    80005d40:	ffffe097          	auipc	ra,0xffffe
    80005d44:	e54080e7          	jalr	-428(ra) # 80003b94 <_Z11printStringPKc>
    80005d48:	00000613          	li	a2,0
    80005d4c:	00a00593          	li	a1,10
    80005d50:	0009051b          	sext.w	a0,s2
    80005d54:	ffffe097          	auipc	ra,0xffffe
    80005d58:	ff0080e7          	jalr	-16(ra) # 80003d44 <_Z8printIntiii>
    80005d5c:	00004517          	auipc	a0,0x4
    80005d60:	62450513          	addi	a0,a0,1572 # 8000a380 <CONSOLE_STATUS+0x370>
    80005d64:	ffffe097          	auipc	ra,0xffffe
    80005d68:	e30080e7          	jalr	-464(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005d6c:	00000493          	li	s1,0
    80005d70:	f99ff06f          	j	80005d08 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80005d74:	00004517          	auipc	a0,0x4
    80005d78:	3cc50513          	addi	a0,a0,972 # 8000a140 <CONSOLE_STATUS+0x130>
    80005d7c:	ffffe097          	auipc	ra,0xffffe
    80005d80:	e18080e7          	jalr	-488(ra) # 80003b94 <_Z11printStringPKc>
    finishedB = true;
    80005d84:	00100793          	li	a5,1
    80005d88:	00007717          	auipc	a4,0x7
    80005d8c:	f0f70123          	sb	a5,-254(a4) # 8000cc8a <_ZL9finishedB>
    thread_dispatch();
    80005d90:	ffffb097          	auipc	ra,0xffffb
    80005d94:	4fc080e7          	jalr	1276(ra) # 8000128c <_Z15thread_dispatchv>
}
    80005d98:	01813083          	ld	ra,24(sp)
    80005d9c:	01013403          	ld	s0,16(sp)
    80005da0:	00813483          	ld	s1,8(sp)
    80005da4:	00013903          	ld	s2,0(sp)
    80005da8:	02010113          	addi	sp,sp,32
    80005dac:	00008067          	ret

0000000080005db0 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005db0:	fe010113          	addi	sp,sp,-32
    80005db4:	00113c23          	sd	ra,24(sp)
    80005db8:	00813823          	sd	s0,16(sp)
    80005dbc:	00913423          	sd	s1,8(sp)
    80005dc0:	01213023          	sd	s2,0(sp)
    80005dc4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005dc8:	00000913          	li	s2,0
    80005dcc:	0380006f          	j	80005e04 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005dd0:	ffffb097          	auipc	ra,0xffffb
    80005dd4:	4bc080e7          	jalr	1212(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005dd8:	00148493          	addi	s1,s1,1
    80005ddc:	000027b7          	lui	a5,0x2
    80005de0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005de4:	0097ee63          	bltu	a5,s1,80005e00 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005de8:	00000713          	li	a4,0
    80005dec:	000077b7          	lui	a5,0x7
    80005df0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005df4:	fce7eee3          	bltu	a5,a4,80005dd0 <_ZL11workerBodyAPv+0x20>
    80005df8:	00170713          	addi	a4,a4,1
    80005dfc:	ff1ff06f          	j	80005dec <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005e00:	00190913          	addi	s2,s2,1
    80005e04:	00900793          	li	a5,9
    80005e08:	0527e063          	bltu	a5,s2,80005e48 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005e0c:	00004517          	auipc	a0,0x4
    80005e10:	31450513          	addi	a0,a0,788 # 8000a120 <CONSOLE_STATUS+0x110>
    80005e14:	ffffe097          	auipc	ra,0xffffe
    80005e18:	d80080e7          	jalr	-640(ra) # 80003b94 <_Z11printStringPKc>
    80005e1c:	00000613          	li	a2,0
    80005e20:	00a00593          	li	a1,10
    80005e24:	0009051b          	sext.w	a0,s2
    80005e28:	ffffe097          	auipc	ra,0xffffe
    80005e2c:	f1c080e7          	jalr	-228(ra) # 80003d44 <_Z8printIntiii>
    80005e30:	00004517          	auipc	a0,0x4
    80005e34:	55050513          	addi	a0,a0,1360 # 8000a380 <CONSOLE_STATUS+0x370>
    80005e38:	ffffe097          	auipc	ra,0xffffe
    80005e3c:	d5c080e7          	jalr	-676(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005e40:	00000493          	li	s1,0
    80005e44:	f99ff06f          	j	80005ddc <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005e48:	00004517          	auipc	a0,0x4
    80005e4c:	2e050513          	addi	a0,a0,736 # 8000a128 <CONSOLE_STATUS+0x118>
    80005e50:	ffffe097          	auipc	ra,0xffffe
    80005e54:	d44080e7          	jalr	-700(ra) # 80003b94 <_Z11printStringPKc>
    finishedA = true;
    80005e58:	00100793          	li	a5,1
    80005e5c:	00007717          	auipc	a4,0x7
    80005e60:	e2f707a3          	sb	a5,-465(a4) # 8000cc8b <_ZL9finishedA>
}
    80005e64:	01813083          	ld	ra,24(sp)
    80005e68:	01013403          	ld	s0,16(sp)
    80005e6c:	00813483          	ld	s1,8(sp)
    80005e70:	00013903          	ld	s2,0(sp)
    80005e74:	02010113          	addi	sp,sp,32
    80005e78:	00008067          	ret

0000000080005e7c <_Z12workerTest10v>:

void workerTest10() {
    80005e7c:	fa010113          	addi	sp,sp,-96
    80005e80:	04113c23          	sd	ra,88(sp)
    80005e84:	04813823          	sd	s0,80(sp)
    80005e88:	06010413          	addi	s0,sp,96
    thread_t threads[10];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005e8c:	00000613          	li	a2,0
    80005e90:	00000597          	auipc	a1,0x0
    80005e94:	f2058593          	addi	a1,a1,-224 # 80005db0 <_ZL11workerBodyAPv>
    80005e98:	fa040513          	addi	a0,s0,-96
    80005e9c:	ffffb097          	auipc	ra,0xffffb
    80005ea0:	348080e7          	jalr	840(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80005ea4:	00004517          	auipc	a0,0x4
    80005ea8:	32450513          	addi	a0,a0,804 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80005eac:	ffffe097          	auipc	ra,0xffffe
    80005eb0:	ce8080e7          	jalr	-792(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005eb4:	00000613          	li	a2,0
    80005eb8:	00000597          	auipc	a1,0x0
    80005ebc:	e2458593          	addi	a1,a1,-476 # 80005cdc <_ZL11workerBodyBPv>
    80005ec0:	fa840513          	addi	a0,s0,-88
    80005ec4:	ffffb097          	auipc	ra,0xffffb
    80005ec8:	320080e7          	jalr	800(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80005ecc:	00004517          	auipc	a0,0x4
    80005ed0:	31450513          	addi	a0,a0,788 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80005ed4:	ffffe097          	auipc	ra,0xffffe
    80005ed8:	cc0080e7          	jalr	-832(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005edc:	00000613          	li	a2,0
    80005ee0:	00000597          	auipc	a1,0x0
    80005ee4:	c7c58593          	addi	a1,a1,-900 # 80005b5c <_ZL11workerBodyCPv>
    80005ee8:	fb040513          	addi	a0,s0,-80
    80005eec:	ffffb097          	auipc	ra,0xffffb
    80005ef0:	2f8080e7          	jalr	760(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80005ef4:	00004517          	auipc	a0,0x4
    80005ef8:	30450513          	addi	a0,a0,772 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80005efc:	ffffe097          	auipc	ra,0xffffe
    80005f00:	c98080e7          	jalr	-872(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005f04:	00000613          	li	a2,0
    80005f08:	00000597          	auipc	a1,0x0
    80005f0c:	b0c58593          	addi	a1,a1,-1268 # 80005a14 <_ZL11workerBodyDPv>
    80005f10:	fb840513          	addi	a0,s0,-72
    80005f14:	ffffb097          	auipc	ra,0xffffb
    80005f18:	2d0080e7          	jalr	720(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80005f1c:	00004517          	auipc	a0,0x4
    80005f20:	2f450513          	addi	a0,a0,756 # 8000a210 <CONSOLE_STATUS+0x200>
    80005f24:	ffffe097          	auipc	ra,0xffffe
    80005f28:	c70080e7          	jalr	-912(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[4], workerBodyE, nullptr);
    80005f2c:	00000613          	li	a2,0
    80005f30:	00000597          	auipc	a1,0x0
    80005f34:	a1858593          	addi	a1,a1,-1512 # 80005948 <_ZL11workerBodyEPv>
    80005f38:	fc040513          	addi	a0,s0,-64
    80005f3c:	ffffb097          	auipc	ra,0xffffb
    80005f40:	2a8080e7          	jalr	680(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadE created\n");
    80005f44:	00004517          	auipc	a0,0x4
    80005f48:	66450513          	addi	a0,a0,1636 # 8000a5a8 <CONSOLE_STATUS+0x598>
    80005f4c:	ffffe097          	auipc	ra,0xffffe
    80005f50:	c48080e7          	jalr	-952(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[5], workerBodyF, nullptr);
    80005f54:	00000613          	li	a2,0
    80005f58:	00000597          	auipc	a1,0x0
    80005f5c:	91c58593          	addi	a1,a1,-1764 # 80005874 <_ZL11workerBodyFPv>
    80005f60:	fc840513          	addi	a0,s0,-56
    80005f64:	ffffb097          	auipc	ra,0xffffb
    80005f68:	280080e7          	jalr	640(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadF created\n");
    80005f6c:	00004517          	auipc	a0,0x4
    80005f70:	65450513          	addi	a0,a0,1620 # 8000a5c0 <CONSOLE_STATUS+0x5b0>
    80005f74:	ffffe097          	auipc	ra,0xffffe
    80005f78:	c20080e7          	jalr	-992(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[6], workerBodyG, nullptr);
    80005f7c:	00000613          	li	a2,0
    80005f80:	fffff597          	auipc	a1,0xfffff
    80005f84:	77458593          	addi	a1,a1,1908 # 800056f4 <_ZL11workerBodyGPv>
    80005f88:	fd040513          	addi	a0,s0,-48
    80005f8c:	ffffb097          	auipc	ra,0xffffb
    80005f90:	258080e7          	jalr	600(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadG created\n");
    80005f94:	00004517          	auipc	a0,0x4
    80005f98:	64450513          	addi	a0,a0,1604 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    80005f9c:	ffffe097          	auipc	ra,0xffffe
    80005fa0:	bf8080e7          	jalr	-1032(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[7], workerBodyH, nullptr);
    80005fa4:	00000613          	li	a2,0
    80005fa8:	fffff597          	auipc	a1,0xfffff
    80005fac:	60458593          	addi	a1,a1,1540 # 800055ac <_ZL11workerBodyHPv>
    80005fb0:	fd840513          	addi	a0,s0,-40
    80005fb4:	ffffb097          	auipc	ra,0xffffb
    80005fb8:	230080e7          	jalr	560(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadH created\n");
    80005fbc:	00004517          	auipc	a0,0x4
    80005fc0:	63450513          	addi	a0,a0,1588 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    80005fc4:	ffffe097          	auipc	ra,0xffffe
    80005fc8:	bd0080e7          	jalr	-1072(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[8], workerBodyI, nullptr);
    80005fcc:	00000613          	li	a2,0
    80005fd0:	fffff597          	auipc	a1,0xfffff
    80005fd4:	51058593          	addi	a1,a1,1296 # 800054e0 <_ZL11workerBodyIPv>
    80005fd8:	fe040513          	addi	a0,s0,-32
    80005fdc:	ffffb097          	auipc	ra,0xffffb
    80005fe0:	208080e7          	jalr	520(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadI created\n");
    80005fe4:	00004517          	auipc	a0,0x4
    80005fe8:	62450513          	addi	a0,a0,1572 # 8000a608 <CONSOLE_STATUS+0x5f8>
    80005fec:	ffffe097          	auipc	ra,0xffffe
    80005ff0:	ba8080e7          	jalr	-1112(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[9], workerBodyJ, nullptr);
    80005ff4:	00000613          	li	a2,0
    80005ff8:	fffff597          	auipc	a1,0xfffff
    80005ffc:	41458593          	addi	a1,a1,1044 # 8000540c <_ZL11workerBodyJPv>
    80006000:	fe840513          	addi	a0,s0,-24
    80006004:	ffffb097          	auipc	ra,0xffffb
    80006008:	1e0080e7          	jalr	480(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadJ created\n");
    8000600c:	00004517          	auipc	a0,0x4
    80006010:	61450513          	addi	a0,a0,1556 # 8000a620 <CONSOLE_STATUS+0x610>
    80006014:	ffffe097          	auipc	ra,0xffffe
    80006018:	b80080e7          	jalr	-1152(ra) # 80003b94 <_Z11printStringPKc>
    8000601c:	00c0006f          	j	80006028 <_Z12workerTest10v+0x1ac>

    while (!(finishedA && finishedB && finishedC && finishedD && finishedE && finishedF && finishedG && finishedH && finishedI && finishedJ ) ) {
        //printString("Thread Dispatched CAPITEST\n");s
        thread_dispatch();
    80006020:	ffffb097          	auipc	ra,0xffffb
    80006024:	26c080e7          	jalr	620(ra) # 8000128c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD && finishedE && finishedF && finishedG && finishedH && finishedI && finishedJ ) ) {
    80006028:	00007797          	auipc	a5,0x7
    8000602c:	c637c783          	lbu	a5,-925(a5) # 8000cc8b <_ZL9finishedA>
    80006030:	fe0788e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006034:	00007797          	auipc	a5,0x7
    80006038:	c567c783          	lbu	a5,-938(a5) # 8000cc8a <_ZL9finishedB>
    8000603c:	fe0782e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006040:	00007797          	auipc	a5,0x7
    80006044:	c497c783          	lbu	a5,-951(a5) # 8000cc89 <_ZL9finishedC>
    80006048:	fc078ce3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    8000604c:	00007797          	auipc	a5,0x7
    80006050:	c3c7c783          	lbu	a5,-964(a5) # 8000cc88 <_ZL9finishedD>
    80006054:	fc0786e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006058:	00007797          	auipc	a5,0x7
    8000605c:	c2f7c783          	lbu	a5,-977(a5) # 8000cc87 <_ZL9finishedE>
    80006060:	fc0780e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006064:	00007797          	auipc	a5,0x7
    80006068:	c227c783          	lbu	a5,-990(a5) # 8000cc86 <_ZL9finishedF>
    8000606c:	fa078ae3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006070:	00007797          	auipc	a5,0x7
    80006074:	c157c783          	lbu	a5,-1003(a5) # 8000cc85 <_ZL9finishedG>
    80006078:	fa0784e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    8000607c:	00007797          	auipc	a5,0x7
    80006080:	c087c783          	lbu	a5,-1016(a5) # 8000cc84 <_ZL9finishedH>
    80006084:	f8078ee3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006088:	00007797          	auipc	a5,0x7
    8000608c:	bfb7c783          	lbu	a5,-1029(a5) # 8000cc83 <_ZL9finishedI>
    80006090:	f80788e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    80006094:	00007797          	auipc	a5,0x7
    80006098:	bee7c783          	lbu	a5,-1042(a5) # 8000cc82 <_ZL9finishedJ>
    8000609c:	f80782e3          	beqz	a5,80006020 <_Z12workerTest10v+0x1a4>
    }

}
    800060a0:	05813083          	ld	ra,88(sp)
    800060a4:	05013403          	ld	s0,80(sp)
    800060a8:	06010113          	addi	sp,sp,96
    800060ac:	00008067          	ret

00000000800060b0 <_ZN5Riscv10popSppSpieEv>:
#include "../h/sleeper.h"
#include "../lib/console.h"
#include "printing.hpp"


void Riscv::popSppSpie(){
    800060b0:	ff010113          	addi	sp,sp,-16
    800060b4:	00813423          	sd	s0,8(sp)
    800060b8:	01010413          	addi	s0,sp,16
        if (TCB::running->isSysThread())
    800060bc:	00007797          	auipc	a5,0x7
    800060c0:	aa47b783          	ld	a5,-1372(a5) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    800060c4:	0007b783          	ld	a5,0(a5)
    bool isSysThread() const { return sysThread; }
    800060c8:	0387c783          	lbu	a5,56(a5)
    800060cc:	02078063          	beqz	a5,800060ec <_ZN5Riscv10popSppSpieEv+0x3c>
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800060d0:	10000793          	li	a5,256
    800060d4:	1007a073          	csrs	sstatus,a5
	setPriviledge();
    __asm__ volatile("csrw sepc, ra");
    800060d8:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret"); //pops spp and places it in the correct place it needs to be
    800060dc:	10200073          	sret
                             // because we jumped to whole different location with dispatch and new nit, so in the
                            // wrapper we make sure it can get out of the supervisor trap with sret
    //sret would return to where sepc says, but we dont want that sicne it would return it to the nit that just lost
    //processor - we dont want that! want to return to the threadWrapper, so we change sepc
    //therefore very important to not be inline - since inline would then jump to where it was inlined!
}
    800060e0:	00813403          	ld	s0,8(sp)
    800060e4:	01010113          	addi	sp,sp,16
    800060e8:	00008067          	ret
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800060ec:	10000793          	li	a5,256
    800060f0:	1007b073          	csrc	sstatus,a5
}
    800060f4:	fe5ff06f          	j	800060d8 <_ZN5Riscv10popSppSpieEv+0x28>

00000000800060f8 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap(){
    800060f8:	f5010113          	addi	sp,sp,-176
    800060fc:	0a113423          	sd	ra,168(sp)
    80006100:	0a813023          	sd	s0,160(sp)
    80006104:	08913c23          	sd	s1,152(sp)
    80006108:	09213823          	sd	s2,144(sp)
    8000610c:	0b010413          	addi	s0,sp,176
	uint64 volatile arg4;
	__asm__ volatile ("mv %0, a4" : "=r"(arg4));
    80006110:	00070793          	mv	a5,a4
    80006114:	fcf43c23          	sd	a5,-40(s0)
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80006118:	142027f3          	csrr	a5,scause
    8000611c:	f8f43423          	sd	a5,-120(s0)
    return scause;
    80006120:	f8843703          	ld	a4,-120(s0)
    uint64 scause = r_scause();
    uint64 volatile arg1, arg2, arg3;
    __asm__ volatile("mv %0, a1" : "=r"(arg1));
    80006124:	00058793          	mv	a5,a1
    80006128:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile("mv %0, a2" : "=r"(arg2));
    8000612c:	00060793          	mv	a5,a2
    80006130:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile("mv %0, a3" : "=r"(arg3));
    80006134:	00068793          	mv	a5,a3
    80006138:	fcf43023          	sd	a5,-64(s0)
    //razgranit skok
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){ //if from ecall or exception
    8000613c:	ff870693          	addi	a3,a4,-8
    80006140:	00100793          	li	a5,1
    80006144:	0cd7f263          	bgeu	a5,a3,80006208 <_ZN5Riscv20handleSupervisorTrapEv+0x110>
                break;
            }
		}
        w_sstatus(sstatus);
        w_sepc(sepc);
    }else if(scause == 0x8000000000000001UL ){ //if softver prekid - tacnije, timer interrupt
    80006148:	fff00793          	li	a5,-1
    8000614c:	03f79793          	slli	a5,a5,0x3f
    80006150:	00178793          	addi	a5,a5,1
    80006154:	2af70a63          	beq	a4,a5,80006408 <_ZN5Riscv20handleSupervisorTrapEv+0x310>
	        //everywhere where it should code enters into privilege, check if not in here
            w_sstatus(sstatus);
            w_sepc(sepc);

	   }
    }else if (scause == 0x8000000000000009UL){ //if hardware prekid - tacnije, console prekid
    80006158:	fff00793          	li	a5,-1
    8000615c:	03f79793          	slli	a5,a5,0x3f
    80006160:	00978793          	addi	a5,a5,9
    80006164:	32f70263          	beq	a4,a5,80006488 <_ZN5Riscv20handleSupervisorTrapEv+0x390>
        w_sepc(sepc);
    }else{ // else unexpected trap - handle
        //unexpected trap cause
        //ispisi scause na terminal
		//__putc('f');
		printString("\nSCAUSE: ");
    80006168:	00004517          	auipc	a0,0x4
    8000616c:	4d050513          	addi	a0,a0,1232 # 8000a638 <CONSOLE_STATUS+0x628>
    80006170:	ffffe097          	auipc	ra,0xffffe
    80006174:	a24080e7          	jalr	-1500(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80006178:	142027f3          	csrr	a5,scause
    8000617c:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80006180:	fb843503          	ld	a0,-72(s0)
		uint64 scause = r_scause();
		printInt(scause, 16, 0);
    80006184:	00000613          	li	a2,0
    80006188:	01000593          	li	a1,16
    8000618c:	0005051b          	sext.w	a0,a0
    80006190:	ffffe097          	auipc	ra,0xffffe
    80006194:	bb4080e7          	jalr	-1100(ra) # 80003d44 <_Z8printIntiii>
		printString("\nSSTATUS: ");
    80006198:	00004517          	auipc	a0,0x4
    8000619c:	4b050513          	addi	a0,a0,1200 # 8000a648 <CONSOLE_STATUS+0x638>
    800061a0:	ffffe097          	auipc	ra,0xffffe
    800061a4:	9f4080e7          	jalr	-1548(ra) # 80003b94 <_Z11printStringPKc>

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800061a8:	100027f3          	csrr	a5,sstatus
    800061ac:	faf43823          	sd	a5,-80(s0)
    return sstatus;
    800061b0:	fb043503          	ld	a0,-80(s0)
		uint64 sstatus = r_sstatus();
    	printInt(sstatus, 16, 0);
    800061b4:	00000613          	li	a2,0
    800061b8:	01000593          	li	a1,16
    800061bc:	0005051b          	sext.w	a0,a0
    800061c0:	ffffe097          	auipc	ra,0xffffe
    800061c4:	b84080e7          	jalr	-1148(ra) # 80003d44 <_Z8printIntiii>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800061c8:	141027f3          	csrr	a5,sepc
    800061cc:	faf43423          	sd	a5,-88(s0)
    return sepc;
    800061d0:	fa843483          	ld	s1,-88(s0)
		uint64 sepc = r_sepc();
    	printString("\nSEPC: ");
    800061d4:	00004517          	auipc	a0,0x4
    800061d8:	48450513          	addi	a0,a0,1156 # 8000a658 <CONSOLE_STATUS+0x648>
    800061dc:	ffffe097          	auipc	ra,0xffffe
    800061e0:	9b8080e7          	jalr	-1608(ra) # 80003b94 <_Z11printStringPKc>
    	printInt(sepc, 16, 0);
    800061e4:	00000613          	li	a2,0
    800061e8:	01000593          	li	a1,16
    800061ec:	0004851b          	sext.w	a0,s1
    800061f0:	ffffe097          	auipc	ra,0xffffe
    800061f4:	b54080e7          	jalr	-1196(ra) # 80003d44 <_Z8printIntiii>
    	__putc('\n');
    800061f8:	00a00513          	li	a0,10
    800061fc:	00003097          	auipc	ra,0x3
    80006200:	600080e7          	jalr	1536(ra) # 800097fc <__putc>

		while(1){ }
    80006204:	0000006f          	j	80006204 <_ZN5Riscv20handleSupervisorTrapEv+0x10c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80006208:	141027f3          	csrr	a5,sepc
    8000620c:	f8f43c23          	sd	a5,-104(s0)
    return sepc;
    80006210:	f9843783          	ld	a5,-104(s0)
        uint64 volatile sepc = r_sepc() + 4;
    80006214:	00478793          	addi	a5,a5,4
    80006218:	f4f43823          	sd	a5,-176(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    8000621c:	100027f3          	csrr	a5,sstatus
    80006220:	f8f43823          	sd	a5,-112(s0)
    return sstatus;
    80006224:	f9043783          	ld	a5,-112(s0)
        uint64 volatile sstatus = r_sstatus();
    80006228:	f4f43c23          	sd	a5,-168(s0)
        uint64 volatile opcode = 0;
    8000622c:	f6043023          	sd	zero,-160(s0)
        __asm__ volatile("mv %0, a0" : "=r"(opcode));
    80006230:	00050793          	mv	a5,a0
    80006234:	f6f43023          	sd	a5,-160(s0)
		switch(opcode) {
    80006238:	f6043783          	ld	a5,-160(s0)
    8000623c:	04200713          	li	a4,66
    80006240:	1af76863          	bltu	a4,a5,800063f0 <_ZN5Riscv20handleSupervisorTrapEv+0x2f8>
    80006244:	00279793          	slli	a5,a5,0x2
    80006248:	00004717          	auipc	a4,0x4
    8000624c:	41870713          	addi	a4,a4,1048 # 8000a660 <CONSOLE_STATUS+0x650>
    80006250:	00e787b3          	add	a5,a5,a4
    80006254:	0007a783          	lw	a5,0(a5)
    80006258:	00e787b3          	add	a5,a5,a4
    8000625c:	00078067          	jr	a5
				void* ptr = MemoryAllocator::mem_alloc((size_t) arg1 );
    80006260:	fd043503          	ld	a0,-48(s0)
    80006264:	00001097          	auipc	ra,0x1
    80006268:	a50080e7          	jalr	-1456(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (ptr));
    8000626c:	04a43823          	sd	a0,80(s0)
        w_sstatus(sstatus);
    80006270:	f5843783          	ld	a5,-168(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80006274:	10079073          	csrw	sstatus,a5
        w_sepc(sepc);
    80006278:	f5043783          	ld	a5,-176(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000627c:	14179073          	csrw	sepc,a5
    }

    //check if sip (supervisor interrupt pending) can work instead of scause? tho scause seems pretty elegant as is - tells which prekid active
    //crsc - control sup reg clear mc - mask clear csrs - control sup reg set
}
    80006280:	0a813083          	ld	ra,168(sp)
    80006284:	0a013403          	ld	s0,160(sp)
    80006288:	09813483          	ld	s1,152(sp)
    8000628c:	09013903          	ld	s2,144(sp)
    80006290:	0b010113          	addi	sp,sp,176
    80006294:	00008067          	ret
				int finish_code = MemoryAllocator::mem_free((void*)arg1);
    80006298:	fd043503          	ld	a0,-48(s0)
    8000629c:	00001097          	auipc	ra,0x1
    800062a0:	d00080e7          	jalr	-768(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (finish_code));
    800062a4:	04a43823          	sd	a0,80(s0)
				break;
    800062a8:	fc9ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
				size_t free_space = MemoryAllocator::mem_get_free_space();
    800062ac:	00001097          	auipc	ra,0x1
    800062b0:	0f4080e7          	jalr	244(ra) # 800073a0 <_ZN15MemoryAllocator18mem_get_free_spaceEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (free_space));
    800062b4:	04a43823          	sd	a0,80(s0)
				break;
    800062b8:	fb9ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
				size_t largest_free_block = MemoryAllocator::mem_get_largest_free_block();
    800062bc:	00001097          	auipc	ra,0x1
    800062c0:	11c080e7          	jalr	284(ra) # 800073d8 <_ZN15MemoryAllocator26mem_get_largest_free_blockEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (largest_free_block));
    800062c4:	04a43823          	sd	a0,80(s0)
				break;
    800062c8:	fa9ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                TCB** tcb = (TCB**)arg1;
    800062cc:	fd043483          	ld	s1,-48(s0)
                if(arg4) {
    800062d0:	fd843783          	ld	a5,-40(s0)
    800062d4:	02078863          	beqz	a5,80006304 <_ZN5Riscv20handleSupervisorTrapEv+0x20c>
                    *tcb = TCB::createThread((TCB::Body)arg2, (void*)arg3, (uint64*)arg4);
    800062d8:	fc843503          	ld	a0,-56(s0)
    800062dc:	fc043583          	ld	a1,-64(s0)
    800062e0:	fd843603          	ld	a2,-40(s0)
    800062e4:	fffff097          	auipc	ra,0xfffff
    800062e8:	81c080e7          	jalr	-2020(ra) # 80004b00 <_ZN3TCB12createThreadEPFvPvES0_Pm>
    800062ec:	00a4b023          	sd	a0,0(s1)
				if(*tcb == nullptr)
    800062f0:	0004b783          	ld	a5,0(s1)
    800062f4:	02078463          	beqz	a5,8000631c <_ZN5Riscv20handleSupervisorTrapEv+0x224>
                    retVal = 0;
    800062f8:	00000793          	li	a5,0
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    800062fc:	04f43823          	sd	a5,80(s0)
				break;
    80006300:	f71ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                    *tcb = TCB::createThread((TCB::Body)arg2, (void*)arg3);
    80006304:	fc843503          	ld	a0,-56(s0)
    80006308:	fc043583          	ld	a1,-64(s0)
    8000630c:	ffffe097          	auipc	ra,0xffffe
    80006310:	718080e7          	jalr	1816(ra) # 80004a24 <_ZN3TCB12createThreadEPFvPvES0_>
    80006314:	00a4b023          	sd	a0,0(s1)
    80006318:	fd9ff06f          	j	800062f0 <_ZN5Riscv20handleSupervisorTrapEv+0x1f8>
                    retVal = -1;
    8000631c:	fff00793          	li	a5,-1
    80006320:	fddff06f          	j	800062fc <_ZN5Riscv20handleSupervisorTrapEv+0x204>
                int retVal = TCB::thread_exit();
    80006324:	fffff097          	auipc	ra,0xfffff
    80006328:	9b0080e7          	jalr	-1616(ra) # 80004cd4 <_ZN3TCB11thread_exitEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    8000632c:	04a43823          	sd	a0,80(s0)
                break;
    80006330:	f41ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
				TCB::timeSliceCounter = 0;
    80006334:	00006797          	auipc	a5,0x6
    80006338:	7dc7b783          	ld	a5,2012(a5) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000633c:	0007b023          	sd	zero,0(a5)
                TCB::dispatch();
    80006340:	fffff097          	auipc	ra,0xfffff
    80006344:	908080e7          	jalr	-1784(ra) # 80004c48 <_ZN3TCB8dispatchEv>
                break;
    80006348:	f29ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                SemaphoreC** sem = (SemaphoreC**)arg1;
    8000634c:	fd043483          	ld	s1,-48(s0)
                *sem = SemaphoreC::sem_open((unsigned)arg2);
    80006350:	fc843503          	ld	a0,-56(s0)
    80006354:	0005051b          	sext.w	a0,a0
    80006358:	ffffb097          	auipc	ra,0xffffb
    8000635c:	584080e7          	jalr	1412(ra) # 800018dc <_ZN10SemaphoreC8sem_openEi>
    80006360:	00a4b023          	sd	a0,0(s1)
                if(*sem == nullptr)
    80006364:	00050863          	beqz	a0,80006374 <_ZN5Riscv20handleSupervisorTrapEv+0x27c>
                    retVal = 0;
    80006368:	00000793          	li	a5,0
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    8000636c:	04f43823          	sd	a5,80(s0)
                break;
    80006370:	f01ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                    retVal = -1;
    80006374:	fff00793          	li	a5,-1
    80006378:	ff5ff06f          	j	8000636c <_ZN5Riscv20handleSupervisorTrapEv+0x274>
                SemaphoreC* sem = (SemaphoreC*)arg1;
    8000637c:	fd043503          	ld	a0,-48(s0)
                int retVal = sem->close();
    80006380:	ffffb097          	auipc	ra,0xffffb
    80006384:	718080e7          	jalr	1816(ra) # 80001a98 <_ZN10SemaphoreC5closeEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    80006388:	04a43823          	sd	a0,80(s0)
                break;
    8000638c:	ee5ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                SemaphoreC* sem = (SemaphoreC*)arg1;
    80006390:	fd043503          	ld	a0,-48(s0)
                int retVal = sem->wait();
    80006394:	ffffb097          	auipc	ra,0xffffb
    80006398:	590080e7          	jalr	1424(ra) # 80001924 <_ZN10SemaphoreC4waitEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    8000639c:	04a43823          	sd	a0,80(s0)
                break;
    800063a0:	ed1ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                SemaphoreC* sem = (SemaphoreC*)arg1;
    800063a4:	fd043503          	ld	a0,-48(s0)
                int retVal = sem->signal();
    800063a8:	ffffb097          	auipc	ra,0xffffb
    800063ac:	654080e7          	jalr	1620(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    800063b0:	04a43823          	sd	a0,80(s0)
                break;
    800063b4:	ebdff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                int retVal = Sleeper::time_sleep((time_t) arg1);
    800063b8:	fd043503          	ld	a0,-48(s0)
    800063bc:	ffffe097          	auipc	ra,0xffffe
    800063c0:	014080e7          	jalr	20(ra) # 800043d0 <_ZN7Sleeper10time_sleepEm>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    800063c4:	04a43823          	sd	a0,80(s0)
                break;
    800063c8:	ea9ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                char retVal = ConsoleC::getc();
    800063cc:	ffffe097          	auipc	ra,0xffffe
    800063d0:	410080e7          	jalr	1040(ra) # 800047dc <_ZN8ConsoleC4getcEv>
                __asm__ volatile ("sd %0, 10*8(fp)" :: "r" (retVal));
    800063d4:	04a43823          	sd	a0,80(s0)
                break;
    800063d8:	e99ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                ConsoleC::putc((char)arg1);
    800063dc:	fd043503          	ld	a0,-48(s0)
    800063e0:	0ff57513          	andi	a0,a0,255
    800063e4:	ffffe097          	auipc	ra,0xffffe
    800063e8:	464080e7          	jalr	1124(ra) # 80004848 <_ZN8ConsoleC4putcEh>
                break;
    800063ec:	e85ff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
                TCB::timeSliceCounter = 0; //reset thread to 0, since new nit hasnt used time yet
    800063f0:	00006797          	auipc	a5,0x6
    800063f4:	7207b783          	ld	a5,1824(a5) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    800063f8:	0007b023          	sd	zero,0(a5)
				TCB::dispatch(); //assuming that the last nit also ended here - important to set up edge cases (new nit)
    800063fc:	fffff097          	auipc	ra,0xfffff
    80006400:	84c080e7          	jalr	-1972(ra) # 80004c48 <_ZN3TCB8dispatchEv>
                break;
    80006404:	e6dff06f          	j	80006270 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80006408:	00200793          	li	a5,2
    8000640c:	1447b073          	csrc	sip,a5
       Sleeper::awaken();
    80006410:	ffffe097          	auipc	ra,0xffffe
    80006414:	1ac080e7          	jalr	428(ra) # 800045bc <_ZN7Sleeper6awakenEv>
       TCB::timeSliceCounter++;
    80006418:	00006717          	auipc	a4,0x6
    8000641c:	6f873703          	ld	a4,1784(a4) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    80006420:	00073783          	ld	a5,0(a4)
    80006424:	00178793          	addi	a5,a5,1
    80006428:	00f73023          	sd	a5,0(a4)
       if(TCB::timeSliceCounter >= TCB::running->getTimeSlice())
    8000642c:	00006717          	auipc	a4,0x6
    80006430:	73473703          	ld	a4,1844(a4) # 8000cb60 <_GLOBAL_OFFSET_TABLE_+0x78>
    80006434:	00073703          	ld	a4,0(a4)
    uint64 getTimeSlice() const { return timeSlice; }
    80006438:	03073703          	ld	a4,48(a4)
    8000643c:	e4e7e2e3          	bltu	a5,a4,80006280 <_ZN5Riscv20handleSupervisorTrapEv+0x188>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80006440:	141027f3          	csrr	a5,sepc
    80006444:	faf43423          	sd	a5,-88(s0)
    return sepc;
    80006448:	fa843783          	ld	a5,-88(s0)
            uint64 volatile sepc = r_sepc();
    8000644c:	f6f43423          	sd	a5,-152(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80006450:	100027f3          	csrr	a5,sstatus
    80006454:	faf43023          	sd	a5,-96(s0)
    return sstatus;
    80006458:	fa043783          	ld	a5,-96(s0)
            uint64 volatile sstatus = r_sstatus();
    8000645c:	f6f43823          	sd	a5,-144(s0)
	        TCB::timeSliceCounter = 0; //reset thread to 0, since new nit hasnt used time yet
    80006460:	00006797          	auipc	a5,0x6
    80006464:	6b07b783          	ld	a5,1712(a5) # 8000cb10 <_GLOBAL_OFFSET_TABLE_+0x28>
    80006468:	0007b023          	sd	zero,0(a5)
	        TCB::dispatch(); //assuming that the last nit also ended here - important to set up edge cases (new nit)!!
    8000646c:	ffffe097          	auipc	ra,0xffffe
    80006470:	7dc080e7          	jalr	2012(ra) # 80004c48 <_ZN3TCB8dispatchEv>
            w_sstatus(sstatus);
    80006474:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80006478:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    8000647c:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80006480:	14179073          	csrw	sepc,a5
}
    80006484:	dfdff06f          	j	80006280 <_ZN5Riscv20handleSupervisorTrapEv+0x188>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80006488:	141027f3          	csrr	a5,sepc
    8000648c:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    80006490:	fb843783          	ld	a5,-72(s0)
        uint64 volatile sepc = r_sepc();
    80006494:	f6f43c23          	sd	a5,-136(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80006498:	100027f3          	csrr	a5,sstatus
    8000649c:	faf43823          	sd	a5,-80(s0)
    return sstatus;
    800064a0:	fb043783          	ld	a5,-80(s0)
        uint64 volatile sstatus = r_sstatus();
    800064a4:	f8f43023          	sd	a5,-128(s0)
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800064a8:	20000793          	li	a5,512
    800064ac:	1447b073          	csrc	sip,a5
        uint64 reason = plic_claim();
    800064b0:	00002097          	auipc	ra,0x2
    800064b4:	ae4080e7          	jalr	-1308(ra) # 80007f94 <plic_claim>
    800064b8:	00050493          	mv	s1,a0
		if(reason == CONSOLE_IRQ)
    800064bc:	00a00793          	li	a5,10
    800064c0:	02f50263          	beq	a0,a5,800064e4 <_ZN5Riscv20handleSupervisorTrapEv+0x3ec>
        plic_complete(reason);
    800064c4:	00048513          	mv	a0,s1
    800064c8:	00002097          	auipc	ra,0x2
    800064cc:	b04080e7          	jalr	-1276(ra) # 80007fcc <plic_complete>
        w_sstatus(sstatus);
    800064d0:	f8043783          	ld	a5,-128(s0)
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800064d4:	10079073          	csrw	sstatus,a5
        w_sepc(sepc);
    800064d8:	f7843783          	ld	a5,-136(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800064dc:	14179073          	csrw	sepc,a5
}
    800064e0:	da1ff06f          	j	80006280 <_ZN5Riscv20handleSupervisorTrapEv+0x188>
	        uint64 cntHardware = 0;
    800064e4:	00000913          	li	s2,0
    800064e8:	01c0006f          	j	80006504 <_ZN5Riscv20handleSupervisorTrapEv+0x40c>
	                ConsoleC::getSem->signal();
    800064ec:	00006797          	auipc	a5,0x6
    800064f0:	66c7b783          	ld	a5,1644(a5) # 8000cb58 <_GLOBAL_OFFSET_TABLE_+0x70>
    800064f4:	0007b503          	ld	a0,0(a5)
    800064f8:	ffffb097          	auipc	ra,0xffffb
    800064fc:	504080e7          	jalr	1284(ra) # 800019fc <_ZN10SemaphoreC6signalEv>
				cntHardware += 1;
    80006500:	00190913          	addi	s2,s2,1
	        while( ( *((char *)(CONSOLE_STATUS)) & CONSOLE_RX_STATUS_BIT ) && (cntHardware < (DEFAULT_BUFFER_SIZE/2) ) )
    80006504:	00006797          	auipc	a5,0x6
    80006508:	5f47b783          	ld	a5,1524(a5) # 8000caf8 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000650c:	0007b783          	ld	a5,0(a5)
    80006510:	0007c783          	lbu	a5,0(a5)
    80006514:	0017f793          	andi	a5,a5,1
    80006518:	fa0786e3          	beqz	a5,800064c4 <_ZN5Riscv20handleSupervisorTrapEv+0x3cc>
    8000651c:	00700793          	li	a5,7
    80006520:	fb27e2e3          	bltu	a5,s2,800064c4 <_ZN5Riscv20handleSupervisorTrapEv+0x3cc>
	            if(!ConsoleC::inputBuffer->isFull())
    80006524:	00006797          	auipc	a5,0x6
    80006528:	6447b783          	ld	a5,1604(a5) # 8000cb68 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000652c:	0007b783          	ld	a5,0(a5)
    {
        MemoryAllocator::mem_free(ptr);
        return;
    }

    bool isFull() const { return counter == cap; }
    80006530:	0007b683          	ld	a3,0(a5)
    80006534:	0087b703          	ld	a4,8(a5)
    80006538:	fce684e3          	beq	a3,a4,80006500 <_ZN5Riscv20handleSupervisorTrapEv+0x408>
					char c = (*(char*)CONSOLE_RX_DATA);
    8000653c:	00006617          	auipc	a2,0x6
    80006540:	5b463603          	ld	a2,1460(a2) # 8000caf0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80006544:	00063603          	ld	a2,0(a2)
    80006548:	00064603          	lbu	a2,0(a2)
        if (counter < cap) {
    8000654c:	fae6f0e3          	bgeu	a3,a4,800064ec <_ZN5Riscv20handleSupervisorTrapEv+0x3f4>
            c_buffer[head] = c;
    80006550:	0207b703          	ld	a4,32(a5)
    80006554:	0107b683          	ld	a3,16(a5)
    80006558:	00d70733          	add	a4,a4,a3
    8000655c:	00c70023          	sb	a2,0(a4)
            head = (head + 1) % cap;
    80006560:	0107b703          	ld	a4,16(a5)
    80006564:	00170713          	addi	a4,a4,1
    80006568:	0087b683          	ld	a3,8(a5)
    8000656c:	02d77733          	remu	a4,a4,a3
    80006570:	00e7b823          	sd	a4,16(a5)
            counter++;
    80006574:	0007b703          	ld	a4,0(a5)
    80006578:	00170713          	addi	a4,a4,1
    8000657c:	00e7b023          	sd	a4,0(a5)
    80006580:	f6dff06f          	j	800064ec <_ZN5Riscv20handleSupervisorTrapEv+0x3f4>

0000000080006584 <_Z41__static_initialization_and_destruction_0ii>:

void Scheduler::put(TCB *tcb)
{
    //printString("READY THREAD QUEUE ADD---\n");
    readyThreadQueue.addLast(tcb);
    80006584:	ff010113          	addi	sp,sp,-16
    80006588:	00813423          	sd	s0,8(sp)
    8000658c:	01010413          	addi	s0,sp,16
    80006590:	00100793          	li	a5,1
    80006594:	00f50863          	beq	a0,a5,800065a4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80006598:	00813403          	ld	s0,8(sp)
    8000659c:	01010113          	addi	sp,sp,16
    800065a0:	00008067          	ret
    800065a4:	000107b7          	lui	a5,0x10
    800065a8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800065ac:	fef596e3          	bne	a1,a5,80006598 <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(0), tail(0) {}
    800065b0:	00006797          	auipc	a5,0x6
    800065b4:	6e078793          	addi	a5,a5,1760 # 8000cc90 <_ZN9Scheduler16readyThreadQueueE>
    800065b8:	0007b023          	sd	zero,0(a5)
    800065bc:	0007b423          	sd	zero,8(a5)
    800065c0:	fd9ff06f          	j	80006598 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800065c4 <_ZN9Scheduler3getEv>:
{
    800065c4:	fe010113          	addi	sp,sp,-32
    800065c8:	00113c23          	sd	ra,24(sp)
    800065cc:	00813823          	sd	s0,16(sp)
    800065d0:	00913423          	sd	s1,8(sp)
    800065d4:	02010413          	addi	s0,sp,32
        if (!head) { return 0; }
    800065d8:	00006517          	auipc	a0,0x6
    800065dc:	6b853503          	ld	a0,1720(a0) # 8000cc90 <_ZN9Scheduler16readyThreadQueueE>
    800065e0:	04050263          	beqz	a0,80006624 <_ZN9Scheduler3getEv+0x60>
        head = head->next;
    800065e4:	00853783          	ld	a5,8(a0)
    800065e8:	00006717          	auipc	a4,0x6
    800065ec:	6af73423          	sd	a5,1704(a4) # 8000cc90 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    800065f0:	02078463          	beqz	a5,80006618 <_ZN9Scheduler3getEv+0x54>
        T *ret = elem->data;
    800065f4:	00053483          	ld	s1,0(a0)
            MemoryAllocator::mem_free(ptr);
    800065f8:	00001097          	auipc	ra,0x1
    800065fc:	9a4080e7          	jalr	-1628(ra) # 80006f9c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80006600:	00048513          	mv	a0,s1
    80006604:	01813083          	ld	ra,24(sp)
    80006608:	01013403          	ld	s0,16(sp)
    8000660c:	00813483          	ld	s1,8(sp)
    80006610:	02010113          	addi	sp,sp,32
    80006614:	00008067          	ret
        if (!head) { tail = 0; }
    80006618:	00006797          	auipc	a5,0x6
    8000661c:	6807b023          	sd	zero,1664(a5) # 8000cc98 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80006620:	fd5ff06f          	j	800065f4 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80006624:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80006628:	fd9ff06f          	j	80006600 <_ZN9Scheduler3getEv+0x3c>

000000008000662c <_ZN9Scheduler3putEP3TCB>:
{
    8000662c:	fe010113          	addi	sp,sp,-32
    80006630:	00113c23          	sd	ra,24(sp)
    80006634:	00813823          	sd	s0,16(sp)
    80006638:	00913423          	sd	s1,8(sp)
    8000663c:	02010413          	addi	s0,sp,32
    80006640:	00050493          	mv	s1,a0
            return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
    80006644:	01000513          	li	a0,16
    80006648:	00000097          	auipc	ra,0x0
    8000664c:	66c080e7          	jalr	1644(ra) # 80006cb4 <_ZN15MemoryAllocator9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80006650:	00953023          	sd	s1,0(a0)
    80006654:	00053423          	sd	zero,8(a0)
        if (tail)
    80006658:	00006797          	auipc	a5,0x6
    8000665c:	6407b783          	ld	a5,1600(a5) # 8000cc98 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80006660:	02078263          	beqz	a5,80006684 <_ZN9Scheduler3putEP3TCB+0x58>
            tail->next = elem;
    80006664:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80006668:	00006797          	auipc	a5,0x6
    8000666c:	62a7b823          	sd	a0,1584(a5) # 8000cc98 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80006670:	01813083          	ld	ra,24(sp)
    80006674:	01013403          	ld	s0,16(sp)
    80006678:	00813483          	ld	s1,8(sp)
    8000667c:	02010113          	addi	sp,sp,32
    80006680:	00008067          	ret
            head = tail = elem;
    80006684:	00006797          	auipc	a5,0x6
    80006688:	60c78793          	addi	a5,a5,1548 # 8000cc90 <_ZN9Scheduler16readyThreadQueueE>
    8000668c:	00a7b423          	sd	a0,8(a5)
    80006690:	00a7b023          	sd	a0,0(a5)
    80006694:	fddff06f          	j	80006670 <_ZN9Scheduler3putEP3TCB+0x44>

0000000080006698 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80006698:	ff010113          	addi	sp,sp,-16
    8000669c:	00113423          	sd	ra,8(sp)
    800066a0:	00813023          	sd	s0,0(sp)
    800066a4:	01010413          	addi	s0,sp,16
    800066a8:	000105b7          	lui	a1,0x10
    800066ac:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800066b0:	00100513          	li	a0,1
    800066b4:	00000097          	auipc	ra,0x0
    800066b8:	ed0080e7          	jalr	-304(ra) # 80006584 <_Z41__static_initialization_and_destruction_0ii>
    800066bc:	00813083          	ld	ra,8(sp)
    800066c0:	00013403          	ld	s0,0(sp)
    800066c4:	01010113          	addi	sp,sp,16
    800066c8:	00008067          	ret

00000000800066cc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800066cc:	fe010113          	addi	sp,sp,-32
    800066d0:	00113c23          	sd	ra,24(sp)
    800066d4:	00813823          	sd	s0,16(sp)
    800066d8:	00913423          	sd	s1,8(sp)
    800066dc:	01213023          	sd	s2,0(sp)
    800066e0:	02010413          	addi	s0,sp,32
    800066e4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800066e8:	00100793          	li	a5,1
    800066ec:	02a7f863          	bgeu	a5,a0,8000671c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800066f0:	00a00793          	li	a5,10
    800066f4:	02f577b3          	remu	a5,a0,a5
    800066f8:	02078e63          	beqz	a5,80006734 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800066fc:	fff48513          	addi	a0,s1,-1
    80006700:	00000097          	auipc	ra,0x0
    80006704:	fcc080e7          	jalr	-52(ra) # 800066cc <_ZL9fibonaccim>
    80006708:	00050913          	mv	s2,a0
    8000670c:	ffe48513          	addi	a0,s1,-2
    80006710:	00000097          	auipc	ra,0x0
    80006714:	fbc080e7          	jalr	-68(ra) # 800066cc <_ZL9fibonaccim>
    80006718:	00a90533          	add	a0,s2,a0
}
    8000671c:	01813083          	ld	ra,24(sp)
    80006720:	01013403          	ld	s0,16(sp)
    80006724:	00813483          	ld	s1,8(sp)
    80006728:	00013903          	ld	s2,0(sp)
    8000672c:	02010113          	addi	sp,sp,32
    80006730:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80006734:	ffffb097          	auipc	ra,0xffffb
    80006738:	b58080e7          	jalr	-1192(ra) # 8000128c <_Z15thread_dispatchv>
    8000673c:	fc1ff06f          	j	800066fc <_ZL9fibonaccim+0x30>

0000000080006740 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80006740:	fe010113          	addi	sp,sp,-32
    80006744:	00113c23          	sd	ra,24(sp)
    80006748:	00813823          	sd	s0,16(sp)
    8000674c:	00913423          	sd	s1,8(sp)
    80006750:	01213023          	sd	s2,0(sp)
    80006754:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80006758:	00a00493          	li	s1,10
    8000675c:	0400006f          	j	8000679c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006760:	00004517          	auipc	a0,0x4
    80006764:	a3050513          	addi	a0,a0,-1488 # 8000a190 <CONSOLE_STATUS+0x180>
    80006768:	ffffd097          	auipc	ra,0xffffd
    8000676c:	42c080e7          	jalr	1068(ra) # 80003b94 <_Z11printStringPKc>
    80006770:	00000613          	li	a2,0
    80006774:	00a00593          	li	a1,10
    80006778:	00048513          	mv	a0,s1
    8000677c:	ffffd097          	auipc	ra,0xffffd
    80006780:	5c8080e7          	jalr	1480(ra) # 80003d44 <_Z8printIntiii>
    80006784:	00004517          	auipc	a0,0x4
    80006788:	bfc50513          	addi	a0,a0,-1028 # 8000a380 <CONSOLE_STATUS+0x370>
    8000678c:	ffffd097          	auipc	ra,0xffffd
    80006790:	408080e7          	jalr	1032(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80006794:	0014849b          	addiw	s1,s1,1
    80006798:	0ff4f493          	andi	s1,s1,255
    8000679c:	00c00793          	li	a5,12
    800067a0:	fc97f0e3          	bgeu	a5,s1,80006760 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800067a4:	00004517          	auipc	a0,0x4
    800067a8:	9f450513          	addi	a0,a0,-1548 # 8000a198 <CONSOLE_STATUS+0x188>
    800067ac:	ffffd097          	auipc	ra,0xffffd
    800067b0:	3e8080e7          	jalr	1000(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800067b4:	00500313          	li	t1,5
    thread_dispatch();
    800067b8:	ffffb097          	auipc	ra,0xffffb
    800067bc:	ad4080e7          	jalr	-1324(ra) # 8000128c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800067c0:	01000513          	li	a0,16
    800067c4:	00000097          	auipc	ra,0x0
    800067c8:	f08080e7          	jalr	-248(ra) # 800066cc <_ZL9fibonaccim>
    800067cc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800067d0:	00004517          	auipc	a0,0x4
    800067d4:	9d850513          	addi	a0,a0,-1576 # 8000a1a8 <CONSOLE_STATUS+0x198>
    800067d8:	ffffd097          	auipc	ra,0xffffd
    800067dc:	3bc080e7          	jalr	956(ra) # 80003b94 <_Z11printStringPKc>
    800067e0:	00000613          	li	a2,0
    800067e4:	00a00593          	li	a1,10
    800067e8:	0009051b          	sext.w	a0,s2
    800067ec:	ffffd097          	auipc	ra,0xffffd
    800067f0:	558080e7          	jalr	1368(ra) # 80003d44 <_Z8printIntiii>
    800067f4:	00004517          	auipc	a0,0x4
    800067f8:	b8c50513          	addi	a0,a0,-1140 # 8000a380 <CONSOLE_STATUS+0x370>
    800067fc:	ffffd097          	auipc	ra,0xffffd
    80006800:	398080e7          	jalr	920(ra) # 80003b94 <_Z11printStringPKc>
    80006804:	0400006f          	j	80006844 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006808:	00004517          	auipc	a0,0x4
    8000680c:	98850513          	addi	a0,a0,-1656 # 8000a190 <CONSOLE_STATUS+0x180>
    80006810:	ffffd097          	auipc	ra,0xffffd
    80006814:	384080e7          	jalr	900(ra) # 80003b94 <_Z11printStringPKc>
    80006818:	00000613          	li	a2,0
    8000681c:	00a00593          	li	a1,10
    80006820:	00048513          	mv	a0,s1
    80006824:	ffffd097          	auipc	ra,0xffffd
    80006828:	520080e7          	jalr	1312(ra) # 80003d44 <_Z8printIntiii>
    8000682c:	00004517          	auipc	a0,0x4
    80006830:	b5450513          	addi	a0,a0,-1196 # 8000a380 <CONSOLE_STATUS+0x370>
    80006834:	ffffd097          	auipc	ra,0xffffd
    80006838:	360080e7          	jalr	864(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000683c:	0014849b          	addiw	s1,s1,1
    80006840:	0ff4f493          	andi	s1,s1,255
    80006844:	00f00793          	li	a5,15
    80006848:	fc97f0e3          	bgeu	a5,s1,80006808 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000684c:	00004517          	auipc	a0,0x4
    80006850:	96c50513          	addi	a0,a0,-1684 # 8000a1b8 <CONSOLE_STATUS+0x1a8>
    80006854:	ffffd097          	auipc	ra,0xffffd
    80006858:	340080e7          	jalr	832(ra) # 80003b94 <_Z11printStringPKc>
    finishedD = true;
    8000685c:	00100793          	li	a5,1
    80006860:	00006717          	auipc	a4,0x6
    80006864:	44f70023          	sb	a5,1088(a4) # 8000cca0 <_ZL9finishedD>
    thread_dispatch();
    80006868:	ffffb097          	auipc	ra,0xffffb
    8000686c:	a24080e7          	jalr	-1500(ra) # 8000128c <_Z15thread_dispatchv>
}
    80006870:	01813083          	ld	ra,24(sp)
    80006874:	01013403          	ld	s0,16(sp)
    80006878:	00813483          	ld	s1,8(sp)
    8000687c:	00013903          	ld	s2,0(sp)
    80006880:	02010113          	addi	sp,sp,32
    80006884:	00008067          	ret

0000000080006888 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80006888:	fe010113          	addi	sp,sp,-32
    8000688c:	00113c23          	sd	ra,24(sp)
    80006890:	00813823          	sd	s0,16(sp)
    80006894:	00913423          	sd	s1,8(sp)
    80006898:	01213023          	sd	s2,0(sp)
    8000689c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800068a0:	00000493          	li	s1,0
    800068a4:	0400006f          	j	800068e4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800068a8:	00004517          	auipc	a0,0x4
    800068ac:	8a850513          	addi	a0,a0,-1880 # 8000a150 <CONSOLE_STATUS+0x140>
    800068b0:	ffffd097          	auipc	ra,0xffffd
    800068b4:	2e4080e7          	jalr	740(ra) # 80003b94 <_Z11printStringPKc>
    800068b8:	00000613          	li	a2,0
    800068bc:	00a00593          	li	a1,10
    800068c0:	00048513          	mv	a0,s1
    800068c4:	ffffd097          	auipc	ra,0xffffd
    800068c8:	480080e7          	jalr	1152(ra) # 80003d44 <_Z8printIntiii>
    800068cc:	00004517          	auipc	a0,0x4
    800068d0:	ab450513          	addi	a0,a0,-1356 # 8000a380 <CONSOLE_STATUS+0x370>
    800068d4:	ffffd097          	auipc	ra,0xffffd
    800068d8:	2c0080e7          	jalr	704(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800068dc:	0014849b          	addiw	s1,s1,1
    800068e0:	0ff4f493          	andi	s1,s1,255
    800068e4:	00200793          	li	a5,2
    800068e8:	fc97f0e3          	bgeu	a5,s1,800068a8 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800068ec:	00004517          	auipc	a0,0x4
    800068f0:	86c50513          	addi	a0,a0,-1940 # 8000a158 <CONSOLE_STATUS+0x148>
    800068f4:	ffffd097          	auipc	ra,0xffffd
    800068f8:	2a0080e7          	jalr	672(ra) # 80003b94 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800068fc:	00700313          	li	t1,7
    thread_dispatch();
    80006900:	ffffb097          	auipc	ra,0xffffb
    80006904:	98c080e7          	jalr	-1652(ra) # 8000128c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80006908:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    8000690c:	00004517          	auipc	a0,0x4
    80006910:	85c50513          	addi	a0,a0,-1956 # 8000a168 <CONSOLE_STATUS+0x158>
    80006914:	ffffd097          	auipc	ra,0xffffd
    80006918:	280080e7          	jalr	640(ra) # 80003b94 <_Z11printStringPKc>
    8000691c:	00000613          	li	a2,0
    80006920:	00a00593          	li	a1,10
    80006924:	0009051b          	sext.w	a0,s2
    80006928:	ffffd097          	auipc	ra,0xffffd
    8000692c:	41c080e7          	jalr	1052(ra) # 80003d44 <_Z8printIntiii>
    80006930:	00004517          	auipc	a0,0x4
    80006934:	a5050513          	addi	a0,a0,-1456 # 8000a380 <CONSOLE_STATUS+0x370>
    80006938:	ffffd097          	auipc	ra,0xffffd
    8000693c:	25c080e7          	jalr	604(ra) # 80003b94 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80006940:	00c00513          	li	a0,12
    80006944:	00000097          	auipc	ra,0x0
    80006948:	d88080e7          	jalr	-632(ra) # 800066cc <_ZL9fibonaccim>
    8000694c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80006950:	00004517          	auipc	a0,0x4
    80006954:	82050513          	addi	a0,a0,-2016 # 8000a170 <CONSOLE_STATUS+0x160>
    80006958:	ffffd097          	auipc	ra,0xffffd
    8000695c:	23c080e7          	jalr	572(ra) # 80003b94 <_Z11printStringPKc>
    80006960:	00000613          	li	a2,0
    80006964:	00a00593          	li	a1,10
    80006968:	0009051b          	sext.w	a0,s2
    8000696c:	ffffd097          	auipc	ra,0xffffd
    80006970:	3d8080e7          	jalr	984(ra) # 80003d44 <_Z8printIntiii>
    80006974:	00004517          	auipc	a0,0x4
    80006978:	a0c50513          	addi	a0,a0,-1524 # 8000a380 <CONSOLE_STATUS+0x370>
    8000697c:	ffffd097          	auipc	ra,0xffffd
    80006980:	218080e7          	jalr	536(ra) # 80003b94 <_Z11printStringPKc>
    80006984:	0400006f          	j	800069c4 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80006988:	00003517          	auipc	a0,0x3
    8000698c:	7c850513          	addi	a0,a0,1992 # 8000a150 <CONSOLE_STATUS+0x140>
    80006990:	ffffd097          	auipc	ra,0xffffd
    80006994:	204080e7          	jalr	516(ra) # 80003b94 <_Z11printStringPKc>
    80006998:	00000613          	li	a2,0
    8000699c:	00a00593          	li	a1,10
    800069a0:	00048513          	mv	a0,s1
    800069a4:	ffffd097          	auipc	ra,0xffffd
    800069a8:	3a0080e7          	jalr	928(ra) # 80003d44 <_Z8printIntiii>
    800069ac:	00004517          	auipc	a0,0x4
    800069b0:	9d450513          	addi	a0,a0,-1580 # 8000a380 <CONSOLE_STATUS+0x370>
    800069b4:	ffffd097          	auipc	ra,0xffffd
    800069b8:	1e0080e7          	jalr	480(ra) # 80003b94 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800069bc:	0014849b          	addiw	s1,s1,1
    800069c0:	0ff4f493          	andi	s1,s1,255
    800069c4:	00500793          	li	a5,5
    800069c8:	fc97f0e3          	bgeu	a5,s1,80006988 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    800069cc:	00003517          	auipc	a0,0x3
    800069d0:	7b450513          	addi	a0,a0,1972 # 8000a180 <CONSOLE_STATUS+0x170>
    800069d4:	ffffd097          	auipc	ra,0xffffd
    800069d8:	1c0080e7          	jalr	448(ra) # 80003b94 <_Z11printStringPKc>
    finishedC = true;
    800069dc:	00100793          	li	a5,1
    800069e0:	00006717          	auipc	a4,0x6
    800069e4:	2cf700a3          	sb	a5,705(a4) # 8000cca1 <_ZL9finishedC>
    thread_dispatch();
    800069e8:	ffffb097          	auipc	ra,0xffffb
    800069ec:	8a4080e7          	jalr	-1884(ra) # 8000128c <_Z15thread_dispatchv>
}
    800069f0:	01813083          	ld	ra,24(sp)
    800069f4:	01013403          	ld	s0,16(sp)
    800069f8:	00813483          	ld	s1,8(sp)
    800069fc:	00013903          	ld	s2,0(sp)
    80006a00:	02010113          	addi	sp,sp,32
    80006a04:	00008067          	ret

0000000080006a08 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80006a08:	fe010113          	addi	sp,sp,-32
    80006a0c:	00113c23          	sd	ra,24(sp)
    80006a10:	00813823          	sd	s0,16(sp)
    80006a14:	00913423          	sd	s1,8(sp)
    80006a18:	01213023          	sd	s2,0(sp)
    80006a1c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80006a20:	00000913          	li	s2,0
    80006a24:	0400006f          	j	80006a64 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80006a28:	ffffb097          	auipc	ra,0xffffb
    80006a2c:	864080e7          	jalr	-1948(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006a30:	00148493          	addi	s1,s1,1
    80006a34:	000027b7          	lui	a5,0x2
    80006a38:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006a3c:	0097ee63          	bltu	a5,s1,80006a58 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006a40:	00000713          	li	a4,0
    80006a44:	000077b7          	lui	a5,0x7
    80006a48:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006a4c:	fce7eee3          	bltu	a5,a4,80006a28 <_ZL11workerBodyBPv+0x20>
    80006a50:	00170713          	addi	a4,a4,1
    80006a54:	ff1ff06f          	j	80006a44 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80006a58:	00a00793          	li	a5,10
    80006a5c:	04f90663          	beq	s2,a5,80006aa8 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80006a60:	00190913          	addi	s2,s2,1
    80006a64:	00f00793          	li	a5,15
    80006a68:	0527e463          	bltu	a5,s2,80006ab0 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80006a6c:	00003517          	auipc	a0,0x3
    80006a70:	6cc50513          	addi	a0,a0,1740 # 8000a138 <CONSOLE_STATUS+0x128>
    80006a74:	ffffd097          	auipc	ra,0xffffd
    80006a78:	120080e7          	jalr	288(ra) # 80003b94 <_Z11printStringPKc>
    80006a7c:	00000613          	li	a2,0
    80006a80:	00a00593          	li	a1,10
    80006a84:	0009051b          	sext.w	a0,s2
    80006a88:	ffffd097          	auipc	ra,0xffffd
    80006a8c:	2bc080e7          	jalr	700(ra) # 80003d44 <_Z8printIntiii>
    80006a90:	00004517          	auipc	a0,0x4
    80006a94:	8f050513          	addi	a0,a0,-1808 # 8000a380 <CONSOLE_STATUS+0x370>
    80006a98:	ffffd097          	auipc	ra,0xffffd
    80006a9c:	0fc080e7          	jalr	252(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006aa0:	00000493          	li	s1,0
    80006aa4:	f91ff06f          	j	80006a34 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80006aa8:	14102ff3          	csrr	t6,sepc
    80006aac:	fb5ff06f          	j	80006a60 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80006ab0:	00003517          	auipc	a0,0x3
    80006ab4:	69050513          	addi	a0,a0,1680 # 8000a140 <CONSOLE_STATUS+0x130>
    80006ab8:	ffffd097          	auipc	ra,0xffffd
    80006abc:	0dc080e7          	jalr	220(ra) # 80003b94 <_Z11printStringPKc>
    finishedB = true;
    80006ac0:	00100793          	li	a5,1
    80006ac4:	00006717          	auipc	a4,0x6
    80006ac8:	1cf70f23          	sb	a5,478(a4) # 8000cca2 <_ZL9finishedB>
    thread_dispatch();
    80006acc:	ffffa097          	auipc	ra,0xffffa
    80006ad0:	7c0080e7          	jalr	1984(ra) # 8000128c <_Z15thread_dispatchv>
}
    80006ad4:	01813083          	ld	ra,24(sp)
    80006ad8:	01013403          	ld	s0,16(sp)
    80006adc:	00813483          	ld	s1,8(sp)
    80006ae0:	00013903          	ld	s2,0(sp)
    80006ae4:	02010113          	addi	sp,sp,32
    80006ae8:	00008067          	ret

0000000080006aec <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80006aec:	fe010113          	addi	sp,sp,-32
    80006af0:	00113c23          	sd	ra,24(sp)
    80006af4:	00813823          	sd	s0,16(sp)
    80006af8:	00913423          	sd	s1,8(sp)
    80006afc:	01213023          	sd	s2,0(sp)
    80006b00:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006b04:	00000913          	li	s2,0
    80006b08:	0380006f          	j	80006b40 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80006b0c:	ffffa097          	auipc	ra,0xffffa
    80006b10:	780080e7          	jalr	1920(ra) # 8000128c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006b14:	00148493          	addi	s1,s1,1
    80006b18:	000027b7          	lui	a5,0x2
    80006b1c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006b20:	0097ee63          	bltu	a5,s1,80006b3c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006b24:	00000713          	li	a4,0
    80006b28:	000077b7          	lui	a5,0x7
    80006b2c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006b30:	fce7eee3          	bltu	a5,a4,80006b0c <_ZL11workerBodyAPv+0x20>
    80006b34:	00170713          	addi	a4,a4,1
    80006b38:	ff1ff06f          	j	80006b28 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80006b3c:	00190913          	addi	s2,s2,1
    80006b40:	00900793          	li	a5,9
    80006b44:	0527e063          	bltu	a5,s2,80006b84 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80006b48:	00003517          	auipc	a0,0x3
    80006b4c:	5d850513          	addi	a0,a0,1496 # 8000a120 <CONSOLE_STATUS+0x110>
    80006b50:	ffffd097          	auipc	ra,0xffffd
    80006b54:	044080e7          	jalr	68(ra) # 80003b94 <_Z11printStringPKc>
    80006b58:	00000613          	li	a2,0
    80006b5c:	00a00593          	li	a1,10
    80006b60:	0009051b          	sext.w	a0,s2
    80006b64:	ffffd097          	auipc	ra,0xffffd
    80006b68:	1e0080e7          	jalr	480(ra) # 80003d44 <_Z8printIntiii>
    80006b6c:	00004517          	auipc	a0,0x4
    80006b70:	81450513          	addi	a0,a0,-2028 # 8000a380 <CONSOLE_STATUS+0x370>
    80006b74:	ffffd097          	auipc	ra,0xffffd
    80006b78:	020080e7          	jalr	32(ra) # 80003b94 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006b7c:	00000493          	li	s1,0
    80006b80:	f99ff06f          	j	80006b18 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80006b84:	00003517          	auipc	a0,0x3
    80006b88:	5a450513          	addi	a0,a0,1444 # 8000a128 <CONSOLE_STATUS+0x118>
    80006b8c:	ffffd097          	auipc	ra,0xffffd
    80006b90:	008080e7          	jalr	8(ra) # 80003b94 <_Z11printStringPKc>
    finishedA = true;
    80006b94:	00100793          	li	a5,1
    80006b98:	00006717          	auipc	a4,0x6
    80006b9c:	10f705a3          	sb	a5,267(a4) # 8000cca3 <_ZL9finishedA>
}
    80006ba0:	01813083          	ld	ra,24(sp)
    80006ba4:	01013403          	ld	s0,16(sp)
    80006ba8:	00813483          	ld	s1,8(sp)
    80006bac:	00013903          	ld	s2,0(sp)
    80006bb0:	02010113          	addi	sp,sp,32
    80006bb4:	00008067          	ret

0000000080006bb8 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80006bb8:	fd010113          	addi	sp,sp,-48
    80006bbc:	02113423          	sd	ra,40(sp)
    80006bc0:	02813023          	sd	s0,32(sp)
    80006bc4:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006bc8:	00000613          	li	a2,0
    80006bcc:	00000597          	auipc	a1,0x0
    80006bd0:	f2058593          	addi	a1,a1,-224 # 80006aec <_ZL11workerBodyAPv>
    80006bd4:	fd040513          	addi	a0,s0,-48
    80006bd8:	ffffa097          	auipc	ra,0xffffa
    80006bdc:	60c080e7          	jalr	1548(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80006be0:	00003517          	auipc	a0,0x3
    80006be4:	5e850513          	addi	a0,a0,1512 # 8000a1c8 <CONSOLE_STATUS+0x1b8>
    80006be8:	ffffd097          	auipc	ra,0xffffd
    80006bec:	fac080e7          	jalr	-84(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006bf0:	00000613          	li	a2,0
    80006bf4:	00000597          	auipc	a1,0x0
    80006bf8:	e1458593          	addi	a1,a1,-492 # 80006a08 <_ZL11workerBodyBPv>
    80006bfc:	fd840513          	addi	a0,s0,-40
    80006c00:	ffffa097          	auipc	ra,0xffffa
    80006c04:	5e4080e7          	jalr	1508(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80006c08:	00003517          	auipc	a0,0x3
    80006c0c:	5d850513          	addi	a0,a0,1496 # 8000a1e0 <CONSOLE_STATUS+0x1d0>
    80006c10:	ffffd097          	auipc	ra,0xffffd
    80006c14:	f84080e7          	jalr	-124(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006c18:	00000613          	li	a2,0
    80006c1c:	00000597          	auipc	a1,0x0
    80006c20:	c6c58593          	addi	a1,a1,-916 # 80006888 <_ZL11workerBodyCPv>
    80006c24:	fe040513          	addi	a0,s0,-32
    80006c28:	ffffa097          	auipc	ra,0xffffa
    80006c2c:	5bc080e7          	jalr	1468(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80006c30:	00003517          	auipc	a0,0x3
    80006c34:	5c850513          	addi	a0,a0,1480 # 8000a1f8 <CONSOLE_STATUS+0x1e8>
    80006c38:	ffffd097          	auipc	ra,0xffffd
    80006c3c:	f5c080e7          	jalr	-164(ra) # 80003b94 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80006c40:	00000613          	li	a2,0
    80006c44:	00000597          	auipc	a1,0x0
    80006c48:	afc58593          	addi	a1,a1,-1284 # 80006740 <_ZL11workerBodyDPv>
    80006c4c:	fe840513          	addi	a0,s0,-24
    80006c50:	ffffa097          	auipc	ra,0xffffa
    80006c54:	594080e7          	jalr	1428(ra) # 800011e4 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80006c58:	00003517          	auipc	a0,0x3
    80006c5c:	5b850513          	addi	a0,a0,1464 # 8000a210 <CONSOLE_STATUS+0x200>
    80006c60:	ffffd097          	auipc	ra,0xffffd
    80006c64:	f34080e7          	jalr	-204(ra) # 80003b94 <_Z11printStringPKc>
    80006c68:	00c0006f          	j	80006c74 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80006c6c:	ffffa097          	auipc	ra,0xffffa
    80006c70:	620080e7          	jalr	1568(ra) # 8000128c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80006c74:	00006797          	auipc	a5,0x6
    80006c78:	02f7c783          	lbu	a5,47(a5) # 8000cca3 <_ZL9finishedA>
    80006c7c:	fe0788e3          	beqz	a5,80006c6c <_Z16System_Mode_testv+0xb4>
    80006c80:	00006797          	auipc	a5,0x6
    80006c84:	0227c783          	lbu	a5,34(a5) # 8000cca2 <_ZL9finishedB>
    80006c88:	fe0782e3          	beqz	a5,80006c6c <_Z16System_Mode_testv+0xb4>
    80006c8c:	00006797          	auipc	a5,0x6
    80006c90:	0157c783          	lbu	a5,21(a5) # 8000cca1 <_ZL9finishedC>
    80006c94:	fc078ce3          	beqz	a5,80006c6c <_Z16System_Mode_testv+0xb4>
    80006c98:	00006797          	auipc	a5,0x6
    80006c9c:	0087c783          	lbu	a5,8(a5) # 8000cca0 <_ZL9finishedD>
    80006ca0:	fc0786e3          	beqz	a5,80006c6c <_Z16System_Mode_testv+0xb4>
    }

}
    80006ca4:	02813083          	ld	ra,40(sp)
    80006ca8:	02013403          	ld	s0,32(sp)
    80006cac:	03010113          	addi	sp,sp,48
    80006cb0:	00008067          	ret

0000000080006cb4 <_ZN15MemoryAllocator9mem_allocEm>:


//QUARANTINE-------------------------------------------------------------------------------------------------------------


void* MemoryAllocator::mem_alloc(size_t size) {
    80006cb4:	fd010113          	addi	sp,sp,-48
    80006cb8:	02113423          	sd	ra,40(sp)
    80006cbc:	02813023          	sd	s0,32(sp)
    80006cc0:	00913c23          	sd	s1,24(sp)
    80006cc4:	01213823          	sd	s2,16(sp)
    80006cc8:	01313423          	sd	s3,8(sp)
    80006ccc:	01413023          	sd	s4,0(sp)
    80006cd0:	03010413          	addi	s0,sp,48
    if(size <= 0) return nullptr;
    80006cd4:	2c050063          	beqz	a0,80006f94 <_ZN15MemoryAllocator9mem_allocEm+0x2e0>
    80006cd8:	00050993          	mv	s3,a0
    //size outside of heap and all that-------------------------------------------------------------------------------------V
    size_t new_size;
    if(size%MEM_BLOCK_SIZE != 0){
    80006cdc:	03f57793          	andi	a5,a0,63
    80006ce0:	00078e63          	beqz	a5,80006cfc <_ZN15MemoryAllocator9mem_allocEm+0x48>
        //RUN A LOOP SUBTRACTING FROM 64 UNTIL YOU GET A POSITIVE, THEN ADD THAT POSITIVE TO SIZE AND GET PORAVNAT
       	if((uint64)size < MEM_BLOCK_SIZE) new_size = size + (MEM_BLOCK_SIZE - size);
    80006ce4:	03f00793          	li	a5,63
    80006ce8:	00a7f863          	bgeu	a5,a0,80006cf8 <_ZN15MemoryAllocator9mem_allocEm+0x44>
		else
        {
            new_size = (size - (size%MEM_BLOCK_SIZE)) + MEM_BLOCK_SIZE;
    80006cec:	fc057993          	andi	s3,a0,-64
    80006cf0:	04098993          	addi	s3,s3,64
    80006cf4:	0080006f          	j	80006cfc <_ZN15MemoryAllocator9mem_allocEm+0x48>
       	if((uint64)size < MEM_BLOCK_SIZE) new_size = size + (MEM_BLOCK_SIZE - size);
    80006cf8:	04000993          	li	s3,64
	printString("\nSIZE NEW_MEM: ");
	printInt((uint64)new_size);
    __putc('\n');
    __putc('\n');*/
    //UP UNTIL HERE CALCULATION OF SIZE SHOULD BE CORRECT, HEAP AND FREE MEM HEAD START OFF CORRECTLY
	    for(auto curr = free_mem_head; curr != nullptr; curr = curr->next){
    80006cfc:	00006497          	auipc	s1,0x6
    80006d00:	fac4b483          	ld	s1,-84(s1) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006d04:	0240006f          	j	80006d28 <_ZN15MemoryAllocator9mem_allocEm+0x74>
		//dont need to check for size + header, since header not included in the used space. sizeof remove
		//never mind, need a used list for tracking the size of the used blocks
		if( ( ( (uint64) curr )  + sizeof(mem_header) + new_size) >= (uint64)HEAP_END_ADDR )
		{
			printString("\nOUTSIDE1\n");
    80006d08:	00004517          	auipc	a0,0x4
    80006d0c:	a6850513          	addi	a0,a0,-1432 # 8000a770 <CONSOLE_STATUS+0x760>
    80006d10:	ffffd097          	auipc	ra,0xffffd
    80006d14:	e84080e7          	jalr	-380(ra) # 80003b94 <_Z11printStringPKc>
		}else if(( ( (uint64) curr )  + sizeof(mem_header) + new_size) <= (uint64)HEAP_START_ADDR)
		{
			printString("\nOUTSIDE2\n");
		}

        if((uint64)curr->size > (uint64)new_size ) //DOES IT ACCOUNT FOR MEM_HEADER HERE? NO, ITS ASKING CAN ITS CONTENTS, ASSUMING THE MEM HEADER IS ALREADY IN THERE AND CONVERTED
    80006d18:	0104b783          	ld	a5,16(s1)
    80006d1c:	04f9e863          	bltu	s3,a5,80006d6c <_ZN15MemoryAllocator9mem_allocEm+0xb8>
				new_used->next = used;
			}
			new_used->size = new_size;

            return (void*)( (uint64)curr + sizeof(mem_header) );
		}else if((uint64)curr->size == (uint64)new_size )
    80006d20:	17378263          	beq	a5,s3,80006e84 <_ZN15MemoryAllocator9mem_allocEm+0x1d0>
	    for(auto curr = free_mem_head; curr != nullptr; curr = curr->next){
    80006d24:	0004b483          	ld	s1,0(s1)
    80006d28:	10048463          	beqz	s1,80006e30 <_ZN15MemoryAllocator9mem_allocEm+0x17c>
		if( ( ( (uint64) curr )  + sizeof(mem_header) + new_size) >= (uint64)HEAP_END_ADDR )
    80006d2c:	00048a13          	mv	s4,s1
    80006d30:	01348933          	add	s2,s1,s3
    80006d34:	01890913          	addi	s2,s2,24
    80006d38:	00006797          	auipc	a5,0x6
    80006d3c:	e387b783          	ld	a5,-456(a5) # 8000cb70 <_GLOBAL_OFFSET_TABLE_+0x88>
    80006d40:	0007b783          	ld	a5,0(a5)
    80006d44:	fcf972e3          	bgeu	s2,a5,80006d08 <_ZN15MemoryAllocator9mem_allocEm+0x54>
		}else if(( ( (uint64) curr )  + sizeof(mem_header) + new_size) <= (uint64)HEAP_START_ADDR)
    80006d48:	00006797          	auipc	a5,0x6
    80006d4c:	db87b783          	ld	a5,-584(a5) # 8000cb00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80006d50:	0007b783          	ld	a5,0(a5)
    80006d54:	fd27e2e3          	bltu	a5,s2,80006d18 <_ZN15MemoryAllocator9mem_allocEm+0x64>
			printString("\nOUTSIDE2\n");
    80006d58:	00004517          	auipc	a0,0x4
    80006d5c:	a2850513          	addi	a0,a0,-1496 # 8000a780 <CONSOLE_STATUS+0x770>
    80006d60:	ffffd097          	auipc	ra,0xffffd
    80006d64:	e34080e7          	jalr	-460(ra) # 80003b94 <_Z11printStringPKc>
    80006d68:	fb1ff06f          	j	80006d18 <_ZN15MemoryAllocator9mem_allocEm+0x64>
			if(curr->prev)
    80006d6c:	0084b783          	ld	a5,8(s1)
    80006d70:	04078463          	beqz	a5,80006db8 <_ZN15MemoryAllocator9mem_allocEm+0x104>
				curr->prev->next = new_free;
    80006d74:	0127b023          	sd	s2,0(a5)
			if(curr->next)curr->next->prev = new_free;
    80006d78:	0004b783          	ld	a5,0(s1)
    80006d7c:	00078463          	beqz	a5,80006d84 <_ZN15MemoryAllocator9mem_allocEm+0xd0>
    80006d80:	0127b423          	sd	s2,8(a5)
			new_free->prev = curr->prev;
    80006d84:	0084b783          	ld	a5,8(s1)
    80006d88:	00f93423          	sd	a5,8(s2)
			new_free->next = curr->next;
    80006d8c:	0004b783          	ld	a5,0(s1)
    80006d90:	00f93023          	sd	a5,0(s2)
			new_free->size = curr->size - new_size - sizeof(mem_header);
    80006d94:	0104b783          	ld	a5,16(s1)
    80006d98:	413787b3          	sub	a5,a5,s3
    80006d9c:	fe878793          	addi	a5,a5,-24
    80006da0:	00f93823          	sd	a5,16(s2)
            auto used = used_mem_head;
    80006da4:	00006697          	auipc	a3,0x6
    80006da8:	f0c6b683          	ld	a3,-244(a3) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
			if(used_mem_head != nullptr)
    80006dac:	04068a63          	beqz	a3,80006e00 <_ZN15MemoryAllocator9mem_allocEm+0x14c>
            auto used = used_mem_head;
    80006db0:	00068793          	mv	a5,a3
    80006db4:	0140006f          	j	80006dc8 <_ZN15MemoryAllocator9mem_allocEm+0x114>
				free_mem_head = new_free;
    80006db8:	00006797          	auipc	a5,0x6
    80006dbc:	ef27b823          	sd	s2,-272(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006dc0:	fb9ff06f          	j	80006d78 <_ZN15MemoryAllocator9mem_allocEm+0xc4>
            	for(; ( (uint64)used < (uint64)curr ) && used->next; used = used->next){}
    80006dc4:	00070793          	mv	a5,a4
    80006dc8:	0147f663          	bgeu	a5,s4,80006dd4 <_ZN15MemoryAllocator9mem_allocEm+0x120>
    80006dcc:	0007b703          	ld	a4,0(a5)
    80006dd0:	fe071ae3          	bnez	a4,80006dc4 <_ZN15MemoryAllocator9mem_allocEm+0x110>
			if( (uint64)used < (uint64)new_used || used == nullptr)
    80006dd4:	0347ea63          	bltu	a5,s4,80006e08 <_ZN15MemoryAllocator9mem_allocEm+0x154>
    80006dd8:	02078863          	beqz	a5,80006e08 <_ZN15MemoryAllocator9mem_allocEm+0x154>
			}else if ( (uint64)used > (uint64)new_used )
    80006ddc:	04fa7663          	bgeu	s4,a5,80006e28 <_ZN15MemoryAllocator9mem_allocEm+0x174>
				if(used->prev)
    80006de0:	0087b703          	ld	a4,8(a5)
    80006de4:	08070863          	beqz	a4,80006e74 <_ZN15MemoryAllocator9mem_allocEm+0x1c0>
					used->prev->next = new_used;
    80006de8:	00973023          	sd	s1,0(a4)
					new_used->prev = used->prev;
    80006dec:	0087b703          	ld	a4,8(a5)
    80006df0:	00e4b423          	sd	a4,8(s1)
				used->prev = new_used;
    80006df4:	0097b423          	sd	s1,8(a5)
				new_used->next = used;
    80006df8:	00f4b023          	sd	a5,0(s1)
    80006dfc:	02c0006f          	j	80006e28 <_ZN15MemoryAllocator9mem_allocEm+0x174>
            auto used = used_mem_head;
    80006e00:	00068793          	mv	a5,a3
    80006e04:	fd1ff06f          	j	80006dd4 <_ZN15MemoryAllocator9mem_allocEm+0x120>
				new_used->prev = used;
    80006e08:	00f4b423          	sd	a5,8(s1)
				if(used)
    80006e0c:	04078463          	beqz	a5,80006e54 <_ZN15MemoryAllocator9mem_allocEm+0x1a0>
					new_used->next = used->next;
    80006e10:	0007b703          	ld	a4,0(a5)
    80006e14:	00e4b023          	sd	a4,0(s1)
					if(used->next)used->next->prev = new_used;
    80006e18:	00070463          	beqz	a4,80006e20 <_ZN15MemoryAllocator9mem_allocEm+0x16c>
    80006e1c:	00973423          	sd	s1,8(a4)
					used->next = new_used;
    80006e20:	0097b023          	sd	s1,0(a5)
                    new_used->prev = used;//DUPLICATE-------------------------------------------------------------------?
    80006e24:	00f4b423          	sd	a5,8(s1)
			new_used->size = new_size;
    80006e28:	0134b823          	sd	s3,16(s1)
            return (void*)( (uint64)curr + sizeof(mem_header) );
    80006e2c:	018a0493          	addi	s1,s4,24

            return (void*)( (uint64)curr + sizeof(mem_header) );
        }
    }
    return nullptr;
}
    80006e30:	00048513          	mv	a0,s1
    80006e34:	02813083          	ld	ra,40(sp)
    80006e38:	02013403          	ld	s0,32(sp)
    80006e3c:	01813483          	ld	s1,24(sp)
    80006e40:	01013903          	ld	s2,16(sp)
    80006e44:	00813983          	ld	s3,8(sp)
    80006e48:	00013a03          	ld	s4,0(sp)
    80006e4c:	03010113          	addi	sp,sp,48
    80006e50:	00008067          	ret
					if(used_mem_head != nullptr) new_used->next = used_mem_head;
    80006e54:	00068c63          	beqz	a3,80006e6c <_ZN15MemoryAllocator9mem_allocEm+0x1b8>
    80006e58:	00d4b023          	sd	a3,0(s1)
					used_mem_head = new_used;
    80006e5c:	00006797          	auipc	a5,0x6
    80006e60:	e497ba23          	sd	s1,-428(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
					new_used->prev = nullptr;//DUPLICATE----------------------------------------------------------------?
    80006e64:	0004b423          	sd	zero,8(s1)
    80006e68:	fc1ff06f          	j	80006e28 <_ZN15MemoryAllocator9mem_allocEm+0x174>
					else new_used->next = nullptr;
    80006e6c:	0004b023          	sd	zero,0(s1)
    80006e70:	fedff06f          	j	80006e5c <_ZN15MemoryAllocator9mem_allocEm+0x1a8>
                    used_mem_head = new_used;
    80006e74:	00006717          	auipc	a4,0x6
    80006e78:	e2973e23          	sd	s1,-452(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
                    new_used->prev = nullptr;
    80006e7c:	0004b423          	sd	zero,8(s1)
    80006e80:	f75ff06f          	j	80006df4 <_ZN15MemoryAllocator9mem_allocEm+0x140>
			if(curr->prev) curr->prev->next = curr->next;
    80006e84:	0084b783          	ld	a5,8(s1)
    80006e88:	00078663          	beqz	a5,80006e94 <_ZN15MemoryAllocator9mem_allocEm+0x1e0>
    80006e8c:	0004b703          	ld	a4,0(s1)
    80006e90:	00e7b023          	sd	a4,0(a5)
			if(curr->next)
    80006e94:	0004b783          	ld	a5,0(s1)
    80006e98:	00078863          	beqz	a5,80006ea8 <_ZN15MemoryAllocator9mem_allocEm+0x1f4>
				curr->next->prev = curr->prev;
    80006e9c:	0084b703          	ld	a4,8(s1)
    80006ea0:	00e7b423          	sd	a4,8(a5)
				if(curr->prev == nullptr) free_mem_head = curr->next;
    80006ea4:	02070e63          	beqz	a4,80006ee0 <_ZN15MemoryAllocator9mem_allocEm+0x22c>
			curr->next = curr->prev = nullptr;
    80006ea8:	0004b423          	sd	zero,8(s1)
    80006eac:	0004b023          	sd	zero,0(s1)
            if( ( (uint64)curr + sizeof(mem_header) + (uint64)new_size >= (uint64)HEAP_END_ADDR ) && free_mem_head == curr) free_mem_head = nullptr;
    80006eb0:	00006797          	auipc	a5,0x6
    80006eb4:	cc07b783          	ld	a5,-832(a5) # 8000cb70 <_GLOBAL_OFFSET_TABLE_+0x88>
    80006eb8:	0007b783          	ld	a5,0(a5)
    80006ebc:	00f96863          	bltu	s2,a5,80006ecc <_ZN15MemoryAllocator9mem_allocEm+0x218>
    80006ec0:	00006797          	auipc	a5,0x6
    80006ec4:	de87b783          	ld	a5,-536(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006ec8:	02978463          	beq	a5,s1,80006ef0 <_ZN15MemoryAllocator9mem_allocEm+0x23c>
            auto used = used_mem_head;
    80006ecc:	00006697          	auipc	a3,0x6
    80006ed0:	de46b683          	ld	a3,-540(a3) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
			if(used_mem_head != nullptr)
    80006ed4:	06068263          	beqz	a3,80006f38 <_ZN15MemoryAllocator9mem_allocEm+0x284>
            auto used = used_mem_head;
    80006ed8:	00068793          	mv	a5,a3
    80006edc:	0240006f          	j	80006f00 <_ZN15MemoryAllocator9mem_allocEm+0x24c>
				if(curr->prev == nullptr) free_mem_head = curr->next;
    80006ee0:	0004b783          	ld	a5,0(s1)
    80006ee4:	00006717          	auipc	a4,0x6
    80006ee8:	dcf73223          	sd	a5,-572(a4) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006eec:	fbdff06f          	j	80006ea8 <_ZN15MemoryAllocator9mem_allocEm+0x1f4>
            if( ( (uint64)curr + sizeof(mem_header) + (uint64)new_size >= (uint64)HEAP_END_ADDR ) && free_mem_head == curr) free_mem_head = nullptr;
    80006ef0:	00006797          	auipc	a5,0x6
    80006ef4:	da07bc23          	sd	zero,-584(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006ef8:	fd5ff06f          	j	80006ecc <_ZN15MemoryAllocator9mem_allocEm+0x218>
            	for(; ( (uint64)used < (uint64)curr ) && used->next; used = used->next){}
    80006efc:	00070793          	mv	a5,a4
    80006f00:	0147f663          	bgeu	a5,s4,80006f0c <_ZN15MemoryAllocator9mem_allocEm+0x258>
    80006f04:	0007b703          	ld	a4,0(a5)
    80006f08:	fe071ae3          	bnez	a4,80006efc <_ZN15MemoryAllocator9mem_allocEm+0x248>
			if( (uint64)used < (uint64)new_used || used == nullptr)
    80006f0c:	0347ea63          	bltu	a5,s4,80006f40 <_ZN15MemoryAllocator9mem_allocEm+0x28c>
    80006f10:	02078863          	beqz	a5,80006f40 <_ZN15MemoryAllocator9mem_allocEm+0x28c>
			}else if ( (uint64)used > (uint64)new_used)
    80006f14:	04fa7663          	bgeu	s4,a5,80006f60 <_ZN15MemoryAllocator9mem_allocEm+0x2ac>
				if(used->prev)
    80006f18:	0087b703          	ld	a4,8(a5)
    80006f1c:	06070663          	beqz	a4,80006f88 <_ZN15MemoryAllocator9mem_allocEm+0x2d4>
		 			used->prev->next = new_used;
    80006f20:	00973023          	sd	s1,0(a4)
					new_used->prev = used->prev;
    80006f24:	0087b703          	ld	a4,8(a5)
    80006f28:	00e4b423          	sd	a4,8(s1)
				used->prev = new_used;
    80006f2c:	0097b423          	sd	s1,8(a5)
				new_used->next = used;
    80006f30:	00f4b023          	sd	a5,0(s1)
    80006f34:	02c0006f          	j	80006f60 <_ZN15MemoryAllocator9mem_allocEm+0x2ac>
            auto used = used_mem_head;
    80006f38:	00068793          	mv	a5,a3
    80006f3c:	fd1ff06f          	j	80006f0c <_ZN15MemoryAllocator9mem_allocEm+0x258>
				new_used->prev = used;
    80006f40:	00f4b423          	sd	a5,8(s1)
				if(used)
    80006f44:	02078263          	beqz	a5,80006f68 <_ZN15MemoryAllocator9mem_allocEm+0x2b4>
					new_used->next = used->next;
    80006f48:	0007b703          	ld	a4,0(a5)
    80006f4c:	00e4b023          	sd	a4,0(s1)
					if(used->next)used->next->prev = new_used;
    80006f50:	00070463          	beqz	a4,80006f58 <_ZN15MemoryAllocator9mem_allocEm+0x2a4>
    80006f54:	00973423          	sd	s1,8(a4)
					used->next = new_used;
    80006f58:	0097b023          	sd	s1,0(a5)
                    new_used->prev = used;
    80006f5c:	00f4b423          	sd	a5,8(s1)
            return (void*)( (uint64)curr + sizeof(mem_header) );
    80006f60:	018a0493          	addi	s1,s4,24
    80006f64:	ecdff06f          	j	80006e30 <_ZN15MemoryAllocator9mem_allocEm+0x17c>
					if(used_mem_head != nullptr) new_used->next = used_mem_head;
    80006f68:	00068c63          	beqz	a3,80006f80 <_ZN15MemoryAllocator9mem_allocEm+0x2cc>
    80006f6c:	00d4b023          	sd	a3,0(s1)
					used_mem_head = new_used;
    80006f70:	00006797          	auipc	a5,0x6
    80006f74:	d497b023          	sd	s1,-704(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
					new_used->prev = nullptr;
    80006f78:	0004b423          	sd	zero,8(s1)
    80006f7c:	fe5ff06f          	j	80006f60 <_ZN15MemoryAllocator9mem_allocEm+0x2ac>
					else new_used->next = nullptr;
    80006f80:	0004b023          	sd	zero,0(s1)
    80006f84:	fedff06f          	j	80006f70 <_ZN15MemoryAllocator9mem_allocEm+0x2bc>
                    used_mem_head = new_used;
    80006f88:	00006717          	auipc	a4,0x6
    80006f8c:	d2973423          	sd	s1,-728(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
                    new_used->prev = nullptr;
    80006f90:	f9dff06f          	j	80006f2c <_ZN15MemoryAllocator9mem_allocEm+0x278>
    if(size <= 0) return nullptr;
    80006f94:	00000493          	li	s1,0
    80006f98:	e99ff06f          	j	80006e30 <_ZN15MemoryAllocator9mem_allocEm+0x17c>

0000000080006f9c <_ZN15MemoryAllocator8mem_freeEPv>:


int MemoryAllocator::mem_free(void* ptr) {
    80006f9c:	ff010113          	addi	sp,sp,-16
    80006fa0:	00813423          	sd	s0,8(sp)
    80006fa4:	01010413          	addi	s0,sp,16
    //1. the result you get matches the start of the pointer - in that case, join the two by increasing the size of the
    //free and restructuring used. Also make sure to check if the next connects to the freed memory, and join that too
    //2. The next is the only free memory, in that case make the used the new free memory, restructure used, and join
    //it with the ahead one if need be

    if(ptr == nullptr || (uint64)ptr < (uint64)HEAP_START_ADDR || (uint64)ptr > (uint64)HEAP_END_ADDR) return -1;
    80006fa8:	3c050c63          	beqz	a0,80007380 <_ZN15MemoryAllocator8mem_freeEPv+0x3e4>
    80006fac:	00006717          	auipc	a4,0x6
    80006fb0:	b5473703          	ld	a4,-1196(a4) # 8000cb00 <_GLOBAL_OFFSET_TABLE_+0x18>
    80006fb4:	00073703          	ld	a4,0(a4)
    80006fb8:	3ce56863          	bltu	a0,a4,80007388 <_ZN15MemoryAllocator8mem_freeEPv+0x3ec>
    80006fbc:	00006717          	auipc	a4,0x6
    80006fc0:	bb473703          	ld	a4,-1100(a4) # 8000cb70 <_GLOBAL_OFFSET_TABLE_+0x88>
    80006fc4:	00073703          	ld	a4,0(a4)
    80006fc8:	3ca76463          	bltu	a4,a0,80007390 <_ZN15MemoryAllocator8mem_freeEPv+0x3f4>
    if(used_mem_head == nullptr) return -2;
    80006fcc:	00006797          	auipc	a5,0x6
    80006fd0:	ce47b783          	ld	a5,-796(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80006fd4:	3c078263          	beqz	a5,80007398 <_ZN15MemoryAllocator8mem_freeEPv+0x3fc>
    //replace ptrs
    //need to check if the fuckin used has pointers, or is not null
    mem_header* ptr1 = (mem_header*)((uint64)ptr - sizeof(mem_header)); //shouldnt -sizeof(header), ptrs already start from there (WRONG!!!!)
    80006fd8:	fe850693          	addi	a3,a0,-24
    80006fdc:	00068813          	mv	a6,a3
    int used_size = ptr1->size;
    80006fe0:	0106a583          	lw	a1,16(a3)

    /*printString("\nptr1 location: ");
    printInt((uint64)ptr1);
    __putc('\n');*/

    auto free = free_mem_head;
    80006fe4:	00006797          	auipc	a5,0x6
    80006fe8:	cc47b783          	ld	a5,-828(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80006fec:	08c0006f          	j	80007078 <_ZN15MemoryAllocator8mem_freeEPv+0xdc>
            if(ptr1->next != nullptr)
			{
				ptr1->next->prev = ptr1->prev;
				//if(ptr1->prev == nullptr) used_mem_head = ptr1->next;
			}
			if(ptr1->prev == nullptr && ptr1->next == nullptr && used_mem_head == ptr1) used_mem_head = nullptr;
    80006ff0:	fe853703          	ld	a4,-24(a0)
    80006ff4:	0c071463          	bnez	a4,800070bc <_ZN15MemoryAllocator8mem_freeEPv+0x120>
    80006ff8:	00006717          	auipc	a4,0x6
    80006ffc:	cb873703          	ld	a4,-840(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007000:	0b071e63          	bne	a4,a6,800070bc <_ZN15MemoryAllocator8mem_freeEPv+0x120>
    80007004:	00006717          	auipc	a4,0x6
    80007008:	ca073623          	sd	zero,-852(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    8000700c:	0c00006f          	j	800070cc <_ZN15MemoryAllocator8mem_freeEPv+0x130>
            else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    80007010:	fe853303          	ld	t1,-24(a0)
    80007014:	0a030a63          	beqz	t1,800070c8 <_ZN15MemoryAllocator8mem_freeEPv+0x12c>
    80007018:	00006717          	auipc	a4,0x6
    8000701c:	c8673c23          	sd	t1,-872(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007020:	0ac0006f          	j	800070cc <_ZN15MemoryAllocator8mem_freeEPv+0x130>
            else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    80007024:	0a088463          	beqz	a7,800070cc <_ZN15MemoryAllocator8mem_freeEPv+0x130>
    80007028:	00006717          	auipc	a4,0x6
    8000702c:	c9173423          	sd	a7,-888(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007030:	09c0006f          	j	800070cc <_ZN15MemoryAllocator8mem_freeEPv+0x130>
            free->size += used_size + sizeof(mem_header); // PRESUMABLY CORRECT, BUT IS NEVER CALLED SO HARD TO CHECK-----------------------
            //check if next free mem can be added to this - do we have to though? yea

            if( ( (uint64)free + sizeof(mem_header) + (uint64)free->size ) == (uint64)free->next )
			{
                free->size += free->next->size + sizeof(mem_header);
    80007034:	0106b703          	ld	a4,16(a3)
    80007038:	00e58733          	add	a4,a1,a4
    8000703c:	01870713          	addi	a4,a4,24
    80007040:	00e7b823          	sd	a4,16(a5)
				mem_header* temp = free->next;
                if(free->next->next != nullptr) free->next->next->prev = free;//SOMETHING HERE CHANGED AND NOW INFINITE------------------------------------!!!
    80007044:	0006b703          	ld	a4,0(a3)
    80007048:	00070463          	beqz	a4,80007050 <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
    8000704c:	00f73423          	sd	a5,8(a4)
                if(free->next->next != nullptr) free->next = free->next->next;
    80007050:	0007b703          	ld	a4,0(a5)
    80007054:	00073703          	ld	a4,0(a4)
    80007058:	00070a63          	beqz	a4,8000706c <_ZN15MemoryAllocator8mem_freeEPv+0xd0>
    8000705c:	00e7b023          	sd	a4,0(a5)
				else free->next = nullptr;
                temp->prev = temp->next = nullptr;
    80007060:	0006b023          	sd	zero,0(a3)
    80007064:	0006b423          	sd	zero,8(a3)
    80007068:	08c0006f          	j	800070f4 <_ZN15MemoryAllocator8mem_freeEPv+0x158>
				else free->next = nullptr;
    8000706c:	0007b023          	sd	zero,0(a5)
    80007070:	ff1ff06f          	j	80007060 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
    for(; free != nullptr && ( (uint64)free < (uint64)ptr1 ); free = free->next) // find a free that exists before the ptr and see if it directly connects
    80007074:	0007b783          	ld	a5,0(a5)
    80007078:	08078263          	beqz	a5,800070fc <_ZN15MemoryAllocator8mem_freeEPv+0x160>
    8000707c:	00078613          	mv	a2,a5
    80007080:	06d7fe63          	bgeu	a5,a3,800070fc <_ZN15MemoryAllocator8mem_freeEPv+0x160>
        if( ( (uint64)free + sizeof(mem_header) + (uint64)free->size ) == (uint64)ptr1) //directly connects behind
    80007084:	0107b703          	ld	a4,16(a5)
    80007088:	00e78733          	add	a4,a5,a4
    8000708c:	01870713          	addi	a4,a4,24
    80007090:	fee692e3          	bne	a3,a4,80007074 <_ZN15MemoryAllocator8mem_freeEPv+0xd8>
            if(ptr1->prev != nullptr)
    80007094:	0086b703          	ld	a4,8(a3)
    80007098:	00070663          	beqz	a4,800070a4 <_ZN15MemoryAllocator8mem_freeEPv+0x108>
				ptr1->prev->next = ptr1->next;
    8000709c:	fe853883          	ld	a7,-24(a0)
    800070a0:	01173023          	sd	a7,0(a4)
            if(ptr1->next != nullptr)
    800070a4:	fe853703          	ld	a4,-24(a0)
    800070a8:	00070663          	beqz	a4,800070b4 <_ZN15MemoryAllocator8mem_freeEPv+0x118>
				ptr1->next->prev = ptr1->prev;
    800070ac:	0086b883          	ld	a7,8(a3)
    800070b0:	01173423          	sd	a7,8(a4)
			if(ptr1->prev == nullptr && ptr1->next == nullptr && used_mem_head == ptr1) used_mem_head = nullptr;
    800070b4:	0086b883          	ld	a7,8(a3)
    800070b8:	f2088ce3          	beqz	a7,80006ff0 <_ZN15MemoryAllocator8mem_freeEPv+0x54>
            else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    800070bc:	00006717          	auipc	a4,0x6
    800070c0:	bf473703          	ld	a4,-1036(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    800070c4:	f50706e3          	beq	a4,a6,80007010 <_ZN15MemoryAllocator8mem_freeEPv+0x74>
            else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    800070c8:	f5070ee3          	beq	a4,a6,80007024 <_ZN15MemoryAllocator8mem_freeEPv+0x88>
            ptr1->next = ptr1->prev = nullptr;
    800070cc:	0006b423          	sd	zero,8(a3)
    800070d0:	fe053423          	sd	zero,-24(a0)
            free->size += used_size + sizeof(mem_header); // PRESUMABLY CORRECT, BUT IS NEVER CALLED SO HARD TO CHECK-----------------------
    800070d4:	0107b703          	ld	a4,16(a5)
    800070d8:	00e585b3          	add	a1,a1,a4
    800070dc:	01858593          	addi	a1,a1,24
    800070e0:	00b7b823          	sd	a1,16(a5)
            if( ( (uint64)free + sizeof(mem_header) + (uint64)free->size ) == (uint64)free->next )
    800070e4:	00b60633          	add	a2,a2,a1
    800070e8:	01860613          	addi	a2,a2,24
    800070ec:	0007b683          	ld	a3,0(a5)
    800070f0:	f4d602e3          	beq	a2,a3,80007034 <_ZN15MemoryAllocator8mem_freeEPv+0x98>
            }
			// move free head here - no need since this is already behind the used memory
            return 0;
    800070f4:	00000513          	li	a0,0
    800070f8:	0840006f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
        }
    }
    if(free != nullptr) //what about a free that is before but doesnt connect to either the back of ptr, or ptr connects to the back of it
    800070fc:	1a078a63          	beqz	a5,800072b0 <_ZN15MemoryAllocator8mem_freeEPv+0x314>
          __putc('\n');*/

          //free exists so there is a free space, but it is after ptr
          // check if next can be added to the end of it, if not just make a new free block

          if( ( (uint64)ptr1 + sizeof(mem_header) + used_size ) == (uint64)free) // check if ptr directly connects to a free --- used size instead of ptr1->size here
    80007100:	00b685b3          	add	a1,a3,a1
    80007104:	01858593          	addi	a1,a1,24
    80007108:	08f58063          	beq	a1,a5,80007188 <_ZN15MemoryAllocator8mem_freeEPv+0x1ec>
				if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;

                return 0;
          }else //ptr doesnt connect to back of free, and free doesnt connect to back of ptr, so ptr becomes its own free block
		  {
	            if(ptr1->prev != nullptr)
    8000710c:	0086b703          	ld	a4,8(a3)
    80007110:	00070663          	beqz	a4,8000711c <_ZN15MemoryAllocator8mem_freeEPv+0x180>
				{
				 	ptr1->prev->next = ptr1->next;
    80007114:	fe853603          	ld	a2,-24(a0)
    80007118:	00c73023          	sd	a2,0(a4)
					//used_mem_head = ptr1->prev;
				}
	            if(ptr1->next != nullptr)
    8000711c:	fe853703          	ld	a4,-24(a0)
    80007120:	00070663          	beqz	a4,8000712c <_ZN15MemoryAllocator8mem_freeEPv+0x190>
				{
					ptr1->next->prev = ptr1->prev;
    80007124:	0086b603          	ld	a2,8(a3)
    80007128:	00c73423          	sd	a2,8(a4)
					//if(ptr1->prev == nullptr) used_mem_head = ptr1->next;
				}
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    8000712c:	0086b603          	ld	a2,8(a3)
    80007130:	12060e63          	beqz	a2,8000726c <_ZN15MemoryAllocator8mem_freeEPv+0x2d0>
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    80007134:	00006717          	auipc	a4,0x6
    80007138:	b7c73703          	ld	a4,-1156(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    8000713c:	15070863          	beq	a4,a6,8000728c <_ZN15MemoryAllocator8mem_freeEPv+0x2f0>
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    80007140:	17070063          	beq	a4,a6,800072a0 <_ZN15MemoryAllocator8mem_freeEPv+0x304>
	            ptr1->next = ptr1->prev = nullptr;
    80007144:	0006b423          	sd	zero,8(a3)
    80007148:	fe053423          	sd	zero,-24(a0)

	            ptr1->prev = free->prev;
    8000714c:	0087b703          	ld	a4,8(a5)
    80007150:	00e6b423          	sd	a4,8(a3)
	            if(free->prev != nullptr) free->prev->next = ptr1;
    80007154:	00070463          	beqz	a4,8000715c <_ZN15MemoryAllocator8mem_freeEPv+0x1c0>
    80007158:	00d73023          	sd	a3,0(a4)
	            ptr1->next = free;
    8000715c:	fef53423          	sd	a5,-24(a0)
	            free->prev = ptr1;
    80007160:	00d7b423          	sd	a3,8(a5)

				// move free head here - check if ANY instance of free behind our used memory, and if not, then set free mem head here
		        if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;
    80007164:	00006797          	auipc	a5,0x6
    80007168:	b447b783          	ld	a5,-1212(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    8000716c:	00f6f663          	bgeu	a3,a5,80007178 <_ZN15MemoryAllocator8mem_freeEPv+0x1dc>
    80007170:	00006797          	auipc	a5,0x6
    80007174:	b2d7bc23          	sd	a3,-1224(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>

	            return 0;
    80007178:	00000513          	li	a0,0
		if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;

        return 0;
    }

}
    8000717c:	00813403          	ld	s0,8(sp)
    80007180:	01010113          	addi	sp,sp,16
    80007184:	00008067          	ret
	            if(ptr1->prev != nullptr)
    80007188:	0086b703          	ld	a4,8(a3)
    8000718c:	00070663          	beqz	a4,80007198 <_ZN15MemoryAllocator8mem_freeEPv+0x1fc>
					ptr1->prev->next = ptr1->next;
    80007190:	fe853603          	ld	a2,-24(a0)
    80007194:	00c73023          	sd	a2,0(a4)
	            if(ptr1->next != nullptr)
    80007198:	fe853703          	ld	a4,-24(a0)
    8000719c:	00070663          	beqz	a4,800071a8 <_ZN15MemoryAllocator8mem_freeEPv+0x20c>
					ptr1->next->prev = ptr1->prev;
    800071a0:	0086b603          	ld	a2,8(a3)
    800071a4:	00c73423          	sd	a2,8(a4)
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    800071a8:	0086b603          	ld	a2,8(a3)
    800071ac:	06060e63          	beqz	a2,80007228 <_ZN15MemoryAllocator8mem_freeEPv+0x28c>
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    800071b0:	00006717          	auipc	a4,0x6
    800071b4:	b0073703          	ld	a4,-1280(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    800071b8:	09070863          	beq	a4,a6,80007248 <_ZN15MemoryAllocator8mem_freeEPv+0x2ac>
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    800071bc:	0b070063          	beq	a4,a6,8000725c <_ZN15MemoryAllocator8mem_freeEPv+0x2c0>
	            ptr1->next = ptr1->prev = nullptr;
    800071c0:	0006b423          	sd	zero,8(a3)
    800071c4:	fe053423          	sd	zero,-24(a0)
	            ptr1->prev = free->prev;
    800071c8:	0087b703          	ld	a4,8(a5)
    800071cc:	00e6b423          	sd	a4,8(a3)
	            ptr1->next = free->next;
    800071d0:	0007b703          	ld	a4,0(a5)
    800071d4:	fee53423          	sd	a4,-24(a0)
	            ptr1->size += ( free->size + sizeof(mem_header) ); //lets see here
    800071d8:	0107b703          	ld	a4,16(a5)
    800071dc:	0106b603          	ld	a2,16(a3)
    800071e0:	00c70733          	add	a4,a4,a2
    800071e4:	01870713          	addi	a4,a4,24
    800071e8:	00e6b823          	sd	a4,16(a3)
	            if(free->prev != nullptr)free->prev->next = ptr1;
    800071ec:	0087b703          	ld	a4,8(a5)
    800071f0:	00070463          	beqz	a4,800071f8 <_ZN15MemoryAllocator8mem_freeEPv+0x25c>
    800071f4:	00d73023          	sd	a3,0(a4)
	            if(free->next != nullptr)free->next->prev = ptr1;
    800071f8:	0007b703          	ld	a4,0(a5)
    800071fc:	00070463          	beqz	a4,80007204 <_ZN15MemoryAllocator8mem_freeEPv+0x268>
    80007200:	00d73423          	sd	a3,8(a4)
                free->next = free->prev = nullptr;
    80007204:	0007b423          	sd	zero,8(a5)
    80007208:	0007b023          	sd	zero,0(a5)
				if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;
    8000720c:	00006797          	auipc	a5,0x6
    80007210:	a9c7b783          	ld	a5,-1380(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    80007214:	00f6f663          	bgeu	a3,a5,80007220 <_ZN15MemoryAllocator8mem_freeEPv+0x284>
    80007218:	00006797          	auipc	a5,0x6
    8000721c:	a8d7b823          	sd	a3,-1392(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
                return 0;
    80007220:	00000513          	li	a0,0
    80007224:	f59ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    80007228:	fe853703          	ld	a4,-24(a0)
    8000722c:	f80712e3          	bnez	a4,800071b0 <_ZN15MemoryAllocator8mem_freeEPv+0x214>
    80007230:	00006717          	auipc	a4,0x6
    80007234:	a8073703          	ld	a4,-1408(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007238:	f7071ce3          	bne	a4,a6,800071b0 <_ZN15MemoryAllocator8mem_freeEPv+0x214>
    8000723c:	00006717          	auipc	a4,0x6
    80007240:	a6073a23          	sd	zero,-1420(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007244:	f7dff06f          	j	800071c0 <_ZN15MemoryAllocator8mem_freeEPv+0x224>
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    80007248:	fe853583          	ld	a1,-24(a0)
    8000724c:	f60588e3          	beqz	a1,800071bc <_ZN15MemoryAllocator8mem_freeEPv+0x220>
    80007250:	00006717          	auipc	a4,0x6
    80007254:	a6b73023          	sd	a1,-1440(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007258:	f69ff06f          	j	800071c0 <_ZN15MemoryAllocator8mem_freeEPv+0x224>
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    8000725c:	f60602e3          	beqz	a2,800071c0 <_ZN15MemoryAllocator8mem_freeEPv+0x224>
    80007260:	00006717          	auipc	a4,0x6
    80007264:	a4c73823          	sd	a2,-1456(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007268:	f59ff06f          	j	800071c0 <_ZN15MemoryAllocator8mem_freeEPv+0x224>
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    8000726c:	fe853703          	ld	a4,-24(a0)
    80007270:	ec0712e3          	bnez	a4,80007134 <_ZN15MemoryAllocator8mem_freeEPv+0x198>
    80007274:	00006717          	auipc	a4,0x6
    80007278:	a3c73703          	ld	a4,-1476(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    8000727c:	eb071ce3          	bne	a4,a6,80007134 <_ZN15MemoryAllocator8mem_freeEPv+0x198>
    80007280:	00006717          	auipc	a4,0x6
    80007284:	a2073823          	sd	zero,-1488(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007288:	ebdff06f          	j	80007144 <_ZN15MemoryAllocator8mem_freeEPv+0x1a8>
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    8000728c:	fe853583          	ld	a1,-24(a0)
    80007290:	ea0588e3          	beqz	a1,80007140 <_ZN15MemoryAllocator8mem_freeEPv+0x1a4>
    80007294:	00006717          	auipc	a4,0x6
    80007298:	a0b73e23          	sd	a1,-1508(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    8000729c:	ea9ff06f          	j	80007144 <_ZN15MemoryAllocator8mem_freeEPv+0x1a8>
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    800072a0:	ea0602e3          	beqz	a2,80007144 <_ZN15MemoryAllocator8mem_freeEPv+0x1a8>
    800072a4:	00006717          	auipc	a4,0x6
    800072a8:	a0c73623          	sd	a2,-1524(a4) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    800072ac:	e99ff06f          	j	80007144 <_ZN15MemoryAllocator8mem_freeEPv+0x1a8>
        if(ptr1->prev != nullptr)
    800072b0:	0086b783          	ld	a5,8(a3)
    800072b4:	00078663          	beqz	a5,800072c0 <_ZN15MemoryAllocator8mem_freeEPv+0x324>
			ptr1->prev->next = ptr1->next;
    800072b8:	fe853703          	ld	a4,-24(a0)
    800072bc:	00e7b023          	sd	a4,0(a5)
        if(ptr1->next != nullptr)
    800072c0:	fe853783          	ld	a5,-24(a0)
    800072c4:	00078663          	beqz	a5,800072d0 <_ZN15MemoryAllocator8mem_freeEPv+0x334>
			ptr1->next->prev = ptr1->prev;
    800072c8:	0086b703          	ld	a4,8(a3)
    800072cc:	00e7b423          	sd	a4,8(a5)
		if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    800072d0:	0086b703          	ld	a4,8(a3)
    800072d4:	04070e63          	beqz	a4,80007330 <_ZN15MemoryAllocator8mem_freeEPv+0x394>
        else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    800072d8:	00006797          	auipc	a5,0x6
    800072dc:	9d87b783          	ld	a5,-1576(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    800072e0:	07078863          	beq	a5,a6,80007350 <_ZN15MemoryAllocator8mem_freeEPv+0x3b4>
        else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    800072e4:	09078063          	beq	a5,a6,80007364 <_ZN15MemoryAllocator8mem_freeEPv+0x3c8>
        ptr1->next = ptr1->prev = nullptr;
    800072e8:	0006b423          	sd	zero,8(a3)
    800072ec:	fe053423          	sd	zero,-24(a0)
        if(free_mem_head != nullptr)
    800072f0:	00006797          	auipc	a5,0x6
    800072f4:	9b87b783          	ld	a5,-1608(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    800072f8:	06078e63          	beqz	a5,80007374 <_ZN15MemoryAllocator8mem_freeEPv+0x3d8>
            while(free->next != nullptr){ free = free->next; }
    800072fc:	00078713          	mv	a4,a5
    80007300:	0007b783          	ld	a5,0(a5)
    80007304:	fe079ce3          	bnez	a5,800072fc <_ZN15MemoryAllocator8mem_freeEPv+0x360>
            free->next = ptr1;
    80007308:	00d73023          	sd	a3,0(a4)
            ptr1->prev = free;
    8000730c:	00e6b423          	sd	a4,8(a3)
            ptr1->next = nullptr;
    80007310:	fe053423          	sd	zero,-24(a0)
		if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;
    80007314:	00006797          	auipc	a5,0x6
    80007318:	9947b783          	ld	a5,-1644(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    8000731c:	00f6f663          	bgeu	a3,a5,80007328 <_ZN15MemoryAllocator8mem_freeEPv+0x38c>
    80007320:	00006797          	auipc	a5,0x6
    80007324:	98d7b423          	sd	a3,-1656(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
        return 0;
    80007328:	00000513          	li	a0,0
    8000732c:	e51ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
		if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
    80007330:	fe853783          	ld	a5,-24(a0)
    80007334:	fa0792e3          	bnez	a5,800072d8 <_ZN15MemoryAllocator8mem_freeEPv+0x33c>
    80007338:	00006797          	auipc	a5,0x6
    8000733c:	9787b783          	ld	a5,-1672(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007340:	f9079ce3          	bne	a5,a6,800072d8 <_ZN15MemoryAllocator8mem_freeEPv+0x33c>
    80007344:	00006797          	auipc	a5,0x6
    80007348:	9607b623          	sd	zero,-1684(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    8000734c:	f9dff06f          	j	800072e8 <_ZN15MemoryAllocator8mem_freeEPv+0x34c>
        else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
    80007350:	fe853603          	ld	a2,-24(a0)
    80007354:	f80608e3          	beqz	a2,800072e4 <_ZN15MemoryAllocator8mem_freeEPv+0x348>
    80007358:	00006797          	auipc	a5,0x6
    8000735c:	94c7bc23          	sd	a2,-1704(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007360:	f89ff06f          	j	800072e8 <_ZN15MemoryAllocator8mem_freeEPv+0x34c>
        else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
    80007364:	f80702e3          	beqz	a4,800072e8 <_ZN15MemoryAllocator8mem_freeEPv+0x34c>
    80007368:	00006797          	auipc	a5,0x6
    8000736c:	94e7b423          	sd	a4,-1720(a5) # 8000ccb0 <_ZN15MemoryAllocator13used_mem_headE>
    80007370:	f79ff06f          	j	800072e8 <_ZN15MemoryAllocator8mem_freeEPv+0x34c>
            free_mem_head = ptr1;
    80007374:	00006797          	auipc	a5,0x6
    80007378:	92d7ba23          	sd	a3,-1740(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
    8000737c:	f99ff06f          	j	80007314 <_ZN15MemoryAllocator8mem_freeEPv+0x378>
    if(ptr == nullptr || (uint64)ptr < (uint64)HEAP_START_ADDR || (uint64)ptr > (uint64)HEAP_END_ADDR) return -1;
    80007380:	fff00513          	li	a0,-1
    80007384:	df9ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
    80007388:	fff00513          	li	a0,-1
    8000738c:	df1ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
    80007390:	fff00513          	li	a0,-1
    80007394:	de9ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>
    if(used_mem_head == nullptr) return -2;
    80007398:	ffe00513          	li	a0,-2
    8000739c:	de1ff06f          	j	8000717c <_ZN15MemoryAllocator8mem_freeEPv+0x1e0>

00000000800073a0 <_ZN15MemoryAllocator18mem_get_free_spaceEv>:

//QUARANTINE-------------------------------------------------------------------------------------------------------------


size_t MemoryAllocator::mem_get_free_space()
{
    800073a0:	ff010113          	addi	sp,sp,-16
    800073a4:	00813423          	sd	s0,8(sp)
    800073a8:	01010413          	addi	s0,sp,16
	size_t free_space = 0;
	mem_header* curr = free_mem_head;
    800073ac:	00006797          	auipc	a5,0x6
    800073b0:	8fc7b783          	ld	a5,-1796(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
	size_t free_space = 0;
    800073b4:	00000513          	li	a0,0
	while(curr != nullptr)
    800073b8:	00078a63          	beqz	a5,800073cc <_ZN15MemoryAllocator18mem_get_free_spaceEv+0x2c>
	{
		free_space += curr->size;
    800073bc:	0107b703          	ld	a4,16(a5)
    800073c0:	00e50533          	add	a0,a0,a4
		curr = curr->next;
    800073c4:	0007b783          	ld	a5,0(a5)
	while(curr != nullptr)
    800073c8:	ff1ff06f          	j	800073b8 <_ZN15MemoryAllocator18mem_get_free_spaceEv+0x18>
	}
	return free_space;
}
    800073cc:	00813403          	ld	s0,8(sp)
    800073d0:	01010113          	addi	sp,sp,16
    800073d4:	00008067          	ret

00000000800073d8 <_ZN15MemoryAllocator26mem_get_largest_free_blockEv>:
size_t MemoryAllocator::mem_get_largest_free_block()
{
    800073d8:	ff010113          	addi	sp,sp,-16
    800073dc:	00813423          	sd	s0,8(sp)
    800073e0:	01010413          	addi	s0,sp,16
	size_t largest_free_block = 0;
	mem_header* curr = free_mem_head;
    800073e4:	00006797          	auipc	a5,0x6
    800073e8:	8c47b783          	ld	a5,-1852(a5) # 8000cca8 <_ZN15MemoryAllocator13free_mem_headE>
	size_t largest_free_block = 0;
    800073ec:	00000513          	li	a0,0
    800073f0:	0080006f          	j	800073f8 <_ZN15MemoryAllocator26mem_get_largest_free_blockEv+0x20>
	while(curr != nullptr)
	{
		if(curr->size > largest_free_block) largest_free_block = curr->size;
		curr = curr->next;
    800073f4:	0007b783          	ld	a5,0(a5)
	while(curr != nullptr)
    800073f8:	00078a63          	beqz	a5,8000740c <_ZN15MemoryAllocator26mem_get_largest_free_blockEv+0x34>
		if(curr->size > largest_free_block) largest_free_block = curr->size;
    800073fc:	0107b703          	ld	a4,16(a5)
    80007400:	fee57ae3          	bgeu	a0,a4,800073f4 <_ZN15MemoryAllocator26mem_get_largest_free_blockEv+0x1c>
    80007404:	00070513          	mv	a0,a4
    80007408:	fedff06f          	j	800073f4 <_ZN15MemoryAllocator26mem_get_largest_free_blockEv+0x1c>
	}
	return largest_free_block;
    8000740c:	00813403          	ld	s0,8(sp)
    80007410:	01010113          	addi	sp,sp,16
    80007414:	00008067          	ret

0000000080007418 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80007418:	fe010113          	addi	sp,sp,-32
    8000741c:	00113c23          	sd	ra,24(sp)
    80007420:	00813823          	sd	s0,16(sp)
    80007424:	00913423          	sd	s1,8(sp)
    80007428:	01213023          	sd	s2,0(sp)
    8000742c:	02010413          	addi	s0,sp,32
    80007430:	00050493          	mv	s1,a0
    80007434:	00058913          	mv	s2,a1
    80007438:	0015879b          	addiw	a5,a1,1
    8000743c:	0007851b          	sext.w	a0,a5
    80007440:	00f4a023          	sw	a5,0(s1)
    80007444:	0004a823          	sw	zero,16(s1)
    80007448:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000744c:	00251513          	slli	a0,a0,0x2
    80007450:	ffffa097          	auipc	ra,0xffffa
    80007454:	cf4080e7          	jalr	-780(ra) # 80001144 <_Z9mem_allocm>
    80007458:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);//changing the values of the semaphores here to be increased all by one, so that we can check if the mutex is causing issues------!
    8000745c:	00000593          	li	a1,0
    80007460:	02048513          	addi	a0,s1,32
    80007464:	ffffa097          	auipc	ra,0xffffa
    80007468:	e48080e7          	jalr	-440(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
    sem_open(&spaceAvailable, _cap);
    8000746c:	00090593          	mv	a1,s2
    80007470:	01848513          	addi	a0,s1,24
    80007474:	ffffa097          	auipc	ra,0xffffa
    80007478:	e38080e7          	jalr	-456(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
    sem_open(&mutexHead, 1);
    8000747c:	00100593          	li	a1,1
    80007480:	02848513          	addi	a0,s1,40
    80007484:	ffffa097          	auipc	ra,0xffffa
    80007488:	e28080e7          	jalr	-472(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
    sem_open(&mutexTail, 1);
    8000748c:	00100593          	li	a1,1
    80007490:	03048513          	addi	a0,s1,48
    80007494:	ffffa097          	auipc	ra,0xffffa
    80007498:	e18080e7          	jalr	-488(ra) # 800012ac <_Z8sem_openPP10SemaphoreCj>
}
    8000749c:	01813083          	ld	ra,24(sp)
    800074a0:	01013403          	ld	s0,16(sp)
    800074a4:	00813483          	ld	s1,8(sp)
    800074a8:	00013903          	ld	s2,0(sp)
    800074ac:	02010113          	addi	sp,sp,32
    800074b0:	00008067          	ret

00000000800074b4 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800074b4:	fe010113          	addi	sp,sp,-32
    800074b8:	00113c23          	sd	ra,24(sp)
    800074bc:	00813823          	sd	s0,16(sp)
    800074c0:	00913423          	sd	s1,8(sp)
    800074c4:	01213023          	sd	s2,0(sp)
    800074c8:	02010413          	addi	s0,sp,32
    800074cc:	00050493          	mv	s1,a0
    800074d0:	00058913          	mv	s2,a1

    sem_wait(spaceAvailable);
    800074d4:	01853503          	ld	a0,24(a0)
    800074d8:	ffffa097          	auipc	ra,0xffffa
    800074dc:	e30080e7          	jalr	-464(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>

    sem_wait(mutexTail);
    800074e0:	0304b503          	ld	a0,48(s1)
    800074e4:	ffffa097          	auipc	ra,0xffffa
    800074e8:	e24080e7          	jalr	-476(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>

    buffer[tail] = val;
    800074ec:	0084b783          	ld	a5,8(s1)
    800074f0:	0144a703          	lw	a4,20(s1)
    800074f4:	00271713          	slli	a4,a4,0x2
    800074f8:	00e787b3          	add	a5,a5,a4
    800074fc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80007500:	0144a783          	lw	a5,20(s1)
    80007504:	0017879b          	addiw	a5,a5,1
    80007508:	0004a703          	lw	a4,0(s1)
    8000750c:	02e7e7bb          	remw	a5,a5,a4
    80007510:	00f4aa23          	sw	a5,20(s1)

    sem_signal(mutexTail);
    80007514:	0304b503          	ld	a0,48(s1)
    80007518:	ffffa097          	auipc	ra,0xffffa
    8000751c:	e1c080e7          	jalr	-484(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
    sem_signal(itemAvailable);
    80007520:	0204b503          	ld	a0,32(s1)
    80007524:	ffffa097          	auipc	ra,0xffffa
    80007528:	e10080e7          	jalr	-496(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>

}
    8000752c:	01813083          	ld	ra,24(sp)
    80007530:	01013403          	ld	s0,16(sp)
    80007534:	00813483          	ld	s1,8(sp)
    80007538:	00013903          	ld	s2,0(sp)
    8000753c:	02010113          	addi	sp,sp,32
    80007540:	00008067          	ret

0000000080007544 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80007544:	fe010113          	addi	sp,sp,-32
    80007548:	00113c23          	sd	ra,24(sp)
    8000754c:	00813823          	sd	s0,16(sp)
    80007550:	00913423          	sd	s1,8(sp)
    80007554:	01213023          	sd	s2,0(sp)
    80007558:	02010413          	addi	s0,sp,32
    8000755c:	00050493          	mv	s1,a0

    sem_wait(itemAvailable);
    80007560:	02053503          	ld	a0,32(a0)
    80007564:	ffffa097          	auipc	ra,0xffffa
    80007568:	da4080e7          	jalr	-604(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>
    sem_wait(mutexHead);
    8000756c:	0284b503          	ld	a0,40(s1)
    80007570:	ffffa097          	auipc	ra,0xffffa
    80007574:	d98080e7          	jalr	-616(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>

    int ret = buffer[head];
    80007578:	0084b703          	ld	a4,8(s1)
    8000757c:	0104a783          	lw	a5,16(s1)
    80007580:	00279693          	slli	a3,a5,0x2
    80007584:	00d70733          	add	a4,a4,a3
    80007588:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000758c:	0017879b          	addiw	a5,a5,1
    80007590:	0004a703          	lw	a4,0(s1)
    80007594:	02e7e7bb          	remw	a5,a5,a4
    80007598:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000759c:	0284b503          	ld	a0,40(s1)
    800075a0:	ffffa097          	auipc	ra,0xffffa
    800075a4:	d94080e7          	jalr	-620(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>

    sem_signal(spaceAvailable);
    800075a8:	0184b503          	ld	a0,24(s1)
    800075ac:	ffffa097          	auipc	ra,0xffffa
    800075b0:	d88080e7          	jalr	-632(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>

    return ret;
}
    800075b4:	00090513          	mv	a0,s2
    800075b8:	01813083          	ld	ra,24(sp)
    800075bc:	01013403          	ld	s0,16(sp)
    800075c0:	00813483          	ld	s1,8(sp)
    800075c4:	00013903          	ld	s2,0(sp)
    800075c8:	02010113          	addi	sp,sp,32
    800075cc:	00008067          	ret

00000000800075d0 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800075d0:	fe010113          	addi	sp,sp,-32
    800075d4:	00113c23          	sd	ra,24(sp)
    800075d8:	00813823          	sd	s0,16(sp)
    800075dc:	00913423          	sd	s1,8(sp)
    800075e0:	01213023          	sd	s2,0(sp)
    800075e4:	02010413          	addi	s0,sp,32
    800075e8:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800075ec:	02853503          	ld	a0,40(a0)
    800075f0:	ffffa097          	auipc	ra,0xffffa
    800075f4:	d18080e7          	jalr	-744(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>
    sem_wait(mutexTail);
    800075f8:	0304b503          	ld	a0,48(s1)
    800075fc:	ffffa097          	auipc	ra,0xffffa
    80007600:	d0c080e7          	jalr	-756(ra) # 80001308 <_Z8sem_waitP10SemaphoreC>

    if (tail >= head) {
    80007604:	0144a783          	lw	a5,20(s1)
    80007608:	0104a903          	lw	s2,16(s1)
    8000760c:	0327ce63          	blt	a5,s2,80007648 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80007610:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80007614:	0304b503          	ld	a0,48(s1)
    80007618:	ffffa097          	auipc	ra,0xffffa
    8000761c:	d1c080e7          	jalr	-740(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>
    sem_signal(mutexHead);
    80007620:	0284b503          	ld	a0,40(s1)
    80007624:	ffffa097          	auipc	ra,0xffffa
    80007628:	d10080e7          	jalr	-752(ra) # 80001334 <_Z10sem_signalP10SemaphoreC>

    return ret;
}
    8000762c:	00090513          	mv	a0,s2
    80007630:	01813083          	ld	ra,24(sp)
    80007634:	01013403          	ld	s0,16(sp)
    80007638:	00813483          	ld	s1,8(sp)
    8000763c:	00013903          	ld	s2,0(sp)
    80007640:	02010113          	addi	sp,sp,32
    80007644:	00008067          	ret
        ret = cap - head + tail;
    80007648:	0004a703          	lw	a4,0(s1)
    8000764c:	4127093b          	subw	s2,a4,s2
    80007650:	00f9093b          	addw	s2,s2,a5
    80007654:	fc1ff06f          	j	80007614 <_ZN6Buffer6getCntEv+0x44>

0000000080007658 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80007658:	fe010113          	addi	sp,sp,-32
    8000765c:	00113c23          	sd	ra,24(sp)
    80007660:	00813823          	sd	s0,16(sp)
    80007664:	00913423          	sd	s1,8(sp)
    80007668:	02010413          	addi	s0,sp,32
    8000766c:	00050493          	mv	s1,a0
    putc('\n');
    80007670:	00a00513          	li	a0,10
    80007674:	ffffa097          	auipc	ra,0xffffa
    80007678:	d40080e7          	jalr	-704(ra) # 800013b4 <_Z4putcc>
    printString("Buffer deleted!\n");
    8000767c:	00003517          	auipc	a0,0x3
    80007680:	bac50513          	addi	a0,a0,-1108 # 8000a228 <CONSOLE_STATUS+0x218>
    80007684:	ffffc097          	auipc	ra,0xffffc
    80007688:	510080e7          	jalr	1296(ra) # 80003b94 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000768c:	00048513          	mv	a0,s1
    80007690:	00000097          	auipc	ra,0x0
    80007694:	f40080e7          	jalr	-192(ra) # 800075d0 <_ZN6Buffer6getCntEv>
    80007698:	02a05c63          	blez	a0,800076d0 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000769c:	0084b783          	ld	a5,8(s1)
    800076a0:	0104a703          	lw	a4,16(s1)
    800076a4:	00271713          	slli	a4,a4,0x2
    800076a8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800076ac:	0007c503          	lbu	a0,0(a5)
    800076b0:	ffffa097          	auipc	ra,0xffffa
    800076b4:	d04080e7          	jalr	-764(ra) # 800013b4 <_Z4putcc>
        head = (head + 1) % cap;
    800076b8:	0104a783          	lw	a5,16(s1)
    800076bc:	0017879b          	addiw	a5,a5,1
    800076c0:	0004a703          	lw	a4,0(s1)
    800076c4:	02e7e7bb          	remw	a5,a5,a4
    800076c8:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800076cc:	fc1ff06f          	j	8000768c <_ZN6BufferD1Ev+0x34>
    putc('!');
    800076d0:	02100513          	li	a0,33
    800076d4:	ffffa097          	auipc	ra,0xffffa
    800076d8:	ce0080e7          	jalr	-800(ra) # 800013b4 <_Z4putcc>
    putc('\n');
    800076dc:	00a00513          	li	a0,10
    800076e0:	ffffa097          	auipc	ra,0xffffa
    800076e4:	cd4080e7          	jalr	-812(ra) # 800013b4 <_Z4putcc>
    mem_free(buffer);
    800076e8:	0084b503          	ld	a0,8(s1)
    800076ec:	ffffa097          	auipc	ra,0xffffa
    800076f0:	a84080e7          	jalr	-1404(ra) # 80001170 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800076f4:	0204b503          	ld	a0,32(s1)
    800076f8:	ffffa097          	auipc	ra,0xffffa
    800076fc:	be4080e7          	jalr	-1052(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
    sem_close(spaceAvailable);
    80007700:	0184b503          	ld	a0,24(s1)
    80007704:	ffffa097          	auipc	ra,0xffffa
    80007708:	bd8080e7          	jalr	-1064(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
    sem_close(mutexTail);
    8000770c:	0304b503          	ld	a0,48(s1)
    80007710:	ffffa097          	auipc	ra,0xffffa
    80007714:	bcc080e7          	jalr	-1076(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
    sem_close(mutexHead);
    80007718:	0284b503          	ld	a0,40(s1)
    8000771c:	ffffa097          	auipc	ra,0xffffa
    80007720:	bc0080e7          	jalr	-1088(ra) # 800012dc <_Z9sem_closeP10SemaphoreC>
}
    80007724:	01813083          	ld	ra,24(sp)
    80007728:	01013403          	ld	s0,16(sp)
    8000772c:	00813483          	ld	s1,8(sp)
    80007730:	02010113          	addi	sp,sp,32
    80007734:	00008067          	ret

0000000080007738 <start>:
    80007738:	ff010113          	addi	sp,sp,-16
    8000773c:	00813423          	sd	s0,8(sp)
    80007740:	01010413          	addi	s0,sp,16
    80007744:	300027f3          	csrr	a5,mstatus
    80007748:	ffffe737          	lui	a4,0xffffe
    8000774c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff08df>
    80007750:	00e7f7b3          	and	a5,a5,a4
    80007754:	00001737          	lui	a4,0x1
    80007758:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000775c:	00e7e7b3          	or	a5,a5,a4
    80007760:	30079073          	csrw	mstatus,a5
    80007764:	00000797          	auipc	a5,0x0
    80007768:	16078793          	addi	a5,a5,352 # 800078c4 <system_main>
    8000776c:	34179073          	csrw	mepc,a5
    80007770:	00000793          	li	a5,0
    80007774:	18079073          	csrw	satp,a5
    80007778:	000107b7          	lui	a5,0x10
    8000777c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80007780:	30279073          	csrw	medeleg,a5
    80007784:	30379073          	csrw	mideleg,a5
    80007788:	104027f3          	csrr	a5,sie
    8000778c:	2227e793          	ori	a5,a5,546
    80007790:	10479073          	csrw	sie,a5
    80007794:	fff00793          	li	a5,-1
    80007798:	00a7d793          	srli	a5,a5,0xa
    8000779c:	3b079073          	csrw	pmpaddr0,a5
    800077a0:	00f00793          	li	a5,15
    800077a4:	3a079073          	csrw	pmpcfg0,a5
    800077a8:	f14027f3          	csrr	a5,mhartid
    800077ac:	0200c737          	lui	a4,0x200c
    800077b0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800077b4:	0007869b          	sext.w	a3,a5
    800077b8:	00269713          	slli	a4,a3,0x2
    800077bc:	000f4637          	lui	a2,0xf4
    800077c0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800077c4:	00d70733          	add	a4,a4,a3
    800077c8:	0037979b          	slliw	a5,a5,0x3
    800077cc:	020046b7          	lui	a3,0x2004
    800077d0:	00d787b3          	add	a5,a5,a3
    800077d4:	00c585b3          	add	a1,a1,a2
    800077d8:	00371693          	slli	a3,a4,0x3
    800077dc:	00005717          	auipc	a4,0x5
    800077e0:	4e470713          	addi	a4,a4,1252 # 8000ccc0 <timer_scratch>
    800077e4:	00b7b023          	sd	a1,0(a5)
    800077e8:	00d70733          	add	a4,a4,a3
    800077ec:	00f73c23          	sd	a5,24(a4)
    800077f0:	02c73023          	sd	a2,32(a4)
    800077f4:	34071073          	csrw	mscratch,a4
    800077f8:	00000797          	auipc	a5,0x0
    800077fc:	6e878793          	addi	a5,a5,1768 # 80007ee0 <timervec>
    80007800:	30579073          	csrw	mtvec,a5
    80007804:	300027f3          	csrr	a5,mstatus
    80007808:	0087e793          	ori	a5,a5,8
    8000780c:	30079073          	csrw	mstatus,a5
    80007810:	304027f3          	csrr	a5,mie
    80007814:	0807e793          	ori	a5,a5,128
    80007818:	30479073          	csrw	mie,a5
    8000781c:	f14027f3          	csrr	a5,mhartid
    80007820:	0007879b          	sext.w	a5,a5
    80007824:	00078213          	mv	tp,a5
    80007828:	30200073          	mret
    8000782c:	00813403          	ld	s0,8(sp)
    80007830:	01010113          	addi	sp,sp,16
    80007834:	00008067          	ret

0000000080007838 <timerinit>:
    80007838:	ff010113          	addi	sp,sp,-16
    8000783c:	00813423          	sd	s0,8(sp)
    80007840:	01010413          	addi	s0,sp,16
    80007844:	f14027f3          	csrr	a5,mhartid
    80007848:	0200c737          	lui	a4,0x200c
    8000784c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80007850:	0007869b          	sext.w	a3,a5
    80007854:	00269713          	slli	a4,a3,0x2
    80007858:	000f4637          	lui	a2,0xf4
    8000785c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007860:	00d70733          	add	a4,a4,a3
    80007864:	0037979b          	slliw	a5,a5,0x3
    80007868:	020046b7          	lui	a3,0x2004
    8000786c:	00d787b3          	add	a5,a5,a3
    80007870:	00c585b3          	add	a1,a1,a2
    80007874:	00371693          	slli	a3,a4,0x3
    80007878:	00005717          	auipc	a4,0x5
    8000787c:	44870713          	addi	a4,a4,1096 # 8000ccc0 <timer_scratch>
    80007880:	00b7b023          	sd	a1,0(a5)
    80007884:	00d70733          	add	a4,a4,a3
    80007888:	00f73c23          	sd	a5,24(a4)
    8000788c:	02c73023          	sd	a2,32(a4)
    80007890:	34071073          	csrw	mscratch,a4
    80007894:	00000797          	auipc	a5,0x0
    80007898:	64c78793          	addi	a5,a5,1612 # 80007ee0 <timervec>
    8000789c:	30579073          	csrw	mtvec,a5
    800078a0:	300027f3          	csrr	a5,mstatus
    800078a4:	0087e793          	ori	a5,a5,8
    800078a8:	30079073          	csrw	mstatus,a5
    800078ac:	304027f3          	csrr	a5,mie
    800078b0:	0807e793          	ori	a5,a5,128
    800078b4:	30479073          	csrw	mie,a5
    800078b8:	00813403          	ld	s0,8(sp)
    800078bc:	01010113          	addi	sp,sp,16
    800078c0:	00008067          	ret

00000000800078c4 <system_main>:
    800078c4:	fe010113          	addi	sp,sp,-32
    800078c8:	00813823          	sd	s0,16(sp)
    800078cc:	00913423          	sd	s1,8(sp)
    800078d0:	00113c23          	sd	ra,24(sp)
    800078d4:	02010413          	addi	s0,sp,32
    800078d8:	00000097          	auipc	ra,0x0
    800078dc:	0c4080e7          	jalr	196(ra) # 8000799c <cpuid>
    800078e0:	00005497          	auipc	s1,0x5
    800078e4:	2d048493          	addi	s1,s1,720 # 8000cbb0 <started>
    800078e8:	02050263          	beqz	a0,8000790c <system_main+0x48>
    800078ec:	0004a783          	lw	a5,0(s1)
    800078f0:	0007879b          	sext.w	a5,a5
    800078f4:	fe078ce3          	beqz	a5,800078ec <system_main+0x28>
    800078f8:	0ff0000f          	fence
    800078fc:	00003517          	auipc	a0,0x3
    80007900:	ec450513          	addi	a0,a0,-316 # 8000a7c0 <CONSOLE_STATUS+0x7b0>
    80007904:	00001097          	auipc	ra,0x1
    80007908:	a78080e7          	jalr	-1416(ra) # 8000837c <panic>
    8000790c:	00001097          	auipc	ra,0x1
    80007910:	9cc080e7          	jalr	-1588(ra) # 800082d8 <consoleinit>
    80007914:	00001097          	auipc	ra,0x1
    80007918:	158080e7          	jalr	344(ra) # 80008a6c <printfinit>
    8000791c:	00003517          	auipc	a0,0x3
    80007920:	a6450513          	addi	a0,a0,-1436 # 8000a380 <CONSOLE_STATUS+0x370>
    80007924:	00001097          	auipc	ra,0x1
    80007928:	ab4080e7          	jalr	-1356(ra) # 800083d8 <__printf>
    8000792c:	00003517          	auipc	a0,0x3
    80007930:	e6450513          	addi	a0,a0,-412 # 8000a790 <CONSOLE_STATUS+0x780>
    80007934:	00001097          	auipc	ra,0x1
    80007938:	aa4080e7          	jalr	-1372(ra) # 800083d8 <__printf>
    8000793c:	00003517          	auipc	a0,0x3
    80007940:	a4450513          	addi	a0,a0,-1468 # 8000a380 <CONSOLE_STATUS+0x370>
    80007944:	00001097          	auipc	ra,0x1
    80007948:	a94080e7          	jalr	-1388(ra) # 800083d8 <__printf>
    8000794c:	00001097          	auipc	ra,0x1
    80007950:	4ac080e7          	jalr	1196(ra) # 80008df8 <kinit>
    80007954:	00000097          	auipc	ra,0x0
    80007958:	148080e7          	jalr	328(ra) # 80007a9c <trapinit>
    8000795c:	00000097          	auipc	ra,0x0
    80007960:	16c080e7          	jalr	364(ra) # 80007ac8 <trapinithart>
    80007964:	00000097          	auipc	ra,0x0
    80007968:	5bc080e7          	jalr	1468(ra) # 80007f20 <plicinit>
    8000796c:	00000097          	auipc	ra,0x0
    80007970:	5dc080e7          	jalr	1500(ra) # 80007f48 <plicinithart>
    80007974:	00000097          	auipc	ra,0x0
    80007978:	078080e7          	jalr	120(ra) # 800079ec <userinit>
    8000797c:	0ff0000f          	fence
    80007980:	00100793          	li	a5,1
    80007984:	00003517          	auipc	a0,0x3
    80007988:	e2450513          	addi	a0,a0,-476 # 8000a7a8 <CONSOLE_STATUS+0x798>
    8000798c:	00f4a023          	sw	a5,0(s1)
    80007990:	00001097          	auipc	ra,0x1
    80007994:	a48080e7          	jalr	-1464(ra) # 800083d8 <__printf>
    80007998:	0000006f          	j	80007998 <system_main+0xd4>

000000008000799c <cpuid>:
    8000799c:	ff010113          	addi	sp,sp,-16
    800079a0:	00813423          	sd	s0,8(sp)
    800079a4:	01010413          	addi	s0,sp,16
    800079a8:	00020513          	mv	a0,tp
    800079ac:	00813403          	ld	s0,8(sp)
    800079b0:	0005051b          	sext.w	a0,a0
    800079b4:	01010113          	addi	sp,sp,16
    800079b8:	00008067          	ret

00000000800079bc <mycpu>:
    800079bc:	ff010113          	addi	sp,sp,-16
    800079c0:	00813423          	sd	s0,8(sp)
    800079c4:	01010413          	addi	s0,sp,16
    800079c8:	00020793          	mv	a5,tp
    800079cc:	00813403          	ld	s0,8(sp)
    800079d0:	0007879b          	sext.w	a5,a5
    800079d4:	00779793          	slli	a5,a5,0x7
    800079d8:	00006517          	auipc	a0,0x6
    800079dc:	31850513          	addi	a0,a0,792 # 8000dcf0 <cpus>
    800079e0:	00f50533          	add	a0,a0,a5
    800079e4:	01010113          	addi	sp,sp,16
    800079e8:	00008067          	ret

00000000800079ec <userinit>:
    800079ec:	ff010113          	addi	sp,sp,-16
    800079f0:	00813423          	sd	s0,8(sp)
    800079f4:	01010413          	addi	s0,sp,16
    800079f8:	00813403          	ld	s0,8(sp)
    800079fc:	01010113          	addi	sp,sp,16
    80007a00:	ffffd317          	auipc	t1,0xffffd
    80007a04:	ca030067          	jr	-864(t1) # 800046a0 <main>

0000000080007a08 <either_copyout>:
    80007a08:	ff010113          	addi	sp,sp,-16
    80007a0c:	00813023          	sd	s0,0(sp)
    80007a10:	00113423          	sd	ra,8(sp)
    80007a14:	01010413          	addi	s0,sp,16
    80007a18:	02051663          	bnez	a0,80007a44 <either_copyout+0x3c>
    80007a1c:	00058513          	mv	a0,a1
    80007a20:	00060593          	mv	a1,a2
    80007a24:	0006861b          	sext.w	a2,a3
    80007a28:	00002097          	auipc	ra,0x2
    80007a2c:	c5c080e7          	jalr	-932(ra) # 80009684 <__memmove>
    80007a30:	00813083          	ld	ra,8(sp)
    80007a34:	00013403          	ld	s0,0(sp)
    80007a38:	00000513          	li	a0,0
    80007a3c:	01010113          	addi	sp,sp,16
    80007a40:	00008067          	ret
    80007a44:	00003517          	auipc	a0,0x3
    80007a48:	da450513          	addi	a0,a0,-604 # 8000a7e8 <CONSOLE_STATUS+0x7d8>
    80007a4c:	00001097          	auipc	ra,0x1
    80007a50:	930080e7          	jalr	-1744(ra) # 8000837c <panic>

0000000080007a54 <either_copyin>:
    80007a54:	ff010113          	addi	sp,sp,-16
    80007a58:	00813023          	sd	s0,0(sp)
    80007a5c:	00113423          	sd	ra,8(sp)
    80007a60:	01010413          	addi	s0,sp,16
    80007a64:	02059463          	bnez	a1,80007a8c <either_copyin+0x38>
    80007a68:	00060593          	mv	a1,a2
    80007a6c:	0006861b          	sext.w	a2,a3
    80007a70:	00002097          	auipc	ra,0x2
    80007a74:	c14080e7          	jalr	-1004(ra) # 80009684 <__memmove>
    80007a78:	00813083          	ld	ra,8(sp)
    80007a7c:	00013403          	ld	s0,0(sp)
    80007a80:	00000513          	li	a0,0
    80007a84:	01010113          	addi	sp,sp,16
    80007a88:	00008067          	ret
    80007a8c:	00003517          	auipc	a0,0x3
    80007a90:	d8450513          	addi	a0,a0,-636 # 8000a810 <CONSOLE_STATUS+0x800>
    80007a94:	00001097          	auipc	ra,0x1
    80007a98:	8e8080e7          	jalr	-1816(ra) # 8000837c <panic>

0000000080007a9c <trapinit>:
    80007a9c:	ff010113          	addi	sp,sp,-16
    80007aa0:	00813423          	sd	s0,8(sp)
    80007aa4:	01010413          	addi	s0,sp,16
    80007aa8:	00813403          	ld	s0,8(sp)
    80007aac:	00003597          	auipc	a1,0x3
    80007ab0:	d8c58593          	addi	a1,a1,-628 # 8000a838 <CONSOLE_STATUS+0x828>
    80007ab4:	00006517          	auipc	a0,0x6
    80007ab8:	2bc50513          	addi	a0,a0,700 # 8000dd70 <tickslock>
    80007abc:	01010113          	addi	sp,sp,16
    80007ac0:	00001317          	auipc	t1,0x1
    80007ac4:	5c830067          	jr	1480(t1) # 80009088 <initlock>

0000000080007ac8 <trapinithart>:
    80007ac8:	ff010113          	addi	sp,sp,-16
    80007acc:	00813423          	sd	s0,8(sp)
    80007ad0:	01010413          	addi	s0,sp,16
    80007ad4:	00000797          	auipc	a5,0x0
    80007ad8:	2fc78793          	addi	a5,a5,764 # 80007dd0 <kernelvec>
    80007adc:	10579073          	csrw	stvec,a5
    80007ae0:	00813403          	ld	s0,8(sp)
    80007ae4:	01010113          	addi	sp,sp,16
    80007ae8:	00008067          	ret

0000000080007aec <usertrap>:
    80007aec:	ff010113          	addi	sp,sp,-16
    80007af0:	00813423          	sd	s0,8(sp)
    80007af4:	01010413          	addi	s0,sp,16
    80007af8:	00813403          	ld	s0,8(sp)
    80007afc:	01010113          	addi	sp,sp,16
    80007b00:	00008067          	ret

0000000080007b04 <usertrapret>:
    80007b04:	ff010113          	addi	sp,sp,-16
    80007b08:	00813423          	sd	s0,8(sp)
    80007b0c:	01010413          	addi	s0,sp,16
    80007b10:	00813403          	ld	s0,8(sp)
    80007b14:	01010113          	addi	sp,sp,16
    80007b18:	00008067          	ret

0000000080007b1c <kerneltrap>:
    80007b1c:	fe010113          	addi	sp,sp,-32
    80007b20:	00813823          	sd	s0,16(sp)
    80007b24:	00113c23          	sd	ra,24(sp)
    80007b28:	00913423          	sd	s1,8(sp)
    80007b2c:	02010413          	addi	s0,sp,32
    80007b30:	142025f3          	csrr	a1,scause
    80007b34:	100027f3          	csrr	a5,sstatus
    80007b38:	0027f793          	andi	a5,a5,2
    80007b3c:	10079c63          	bnez	a5,80007c54 <kerneltrap+0x138>
    80007b40:	142027f3          	csrr	a5,scause
    80007b44:	0207ce63          	bltz	a5,80007b80 <kerneltrap+0x64>
    80007b48:	00003517          	auipc	a0,0x3
    80007b4c:	d3850513          	addi	a0,a0,-712 # 8000a880 <CONSOLE_STATUS+0x870>
    80007b50:	00001097          	auipc	ra,0x1
    80007b54:	888080e7          	jalr	-1912(ra) # 800083d8 <__printf>
    80007b58:	141025f3          	csrr	a1,sepc
    80007b5c:	14302673          	csrr	a2,stval
    80007b60:	00003517          	auipc	a0,0x3
    80007b64:	d3050513          	addi	a0,a0,-720 # 8000a890 <CONSOLE_STATUS+0x880>
    80007b68:	00001097          	auipc	ra,0x1
    80007b6c:	870080e7          	jalr	-1936(ra) # 800083d8 <__printf>
    80007b70:	00003517          	auipc	a0,0x3
    80007b74:	d3850513          	addi	a0,a0,-712 # 8000a8a8 <CONSOLE_STATUS+0x898>
    80007b78:	00001097          	auipc	ra,0x1
    80007b7c:	804080e7          	jalr	-2044(ra) # 8000837c <panic>
    80007b80:	0ff7f713          	andi	a4,a5,255
    80007b84:	00900693          	li	a3,9
    80007b88:	04d70063          	beq	a4,a3,80007bc8 <kerneltrap+0xac>
    80007b8c:	fff00713          	li	a4,-1
    80007b90:	03f71713          	slli	a4,a4,0x3f
    80007b94:	00170713          	addi	a4,a4,1
    80007b98:	fae798e3          	bne	a5,a4,80007b48 <kerneltrap+0x2c>
    80007b9c:	00000097          	auipc	ra,0x0
    80007ba0:	e00080e7          	jalr	-512(ra) # 8000799c <cpuid>
    80007ba4:	06050663          	beqz	a0,80007c10 <kerneltrap+0xf4>
    80007ba8:	144027f3          	csrr	a5,sip
    80007bac:	ffd7f793          	andi	a5,a5,-3
    80007bb0:	14479073          	csrw	sip,a5
    80007bb4:	01813083          	ld	ra,24(sp)
    80007bb8:	01013403          	ld	s0,16(sp)
    80007bbc:	00813483          	ld	s1,8(sp)
    80007bc0:	02010113          	addi	sp,sp,32
    80007bc4:	00008067          	ret
    80007bc8:	00000097          	auipc	ra,0x0
    80007bcc:	3cc080e7          	jalr	972(ra) # 80007f94 <plic_claim>
    80007bd0:	00a00793          	li	a5,10
    80007bd4:	00050493          	mv	s1,a0
    80007bd8:	06f50863          	beq	a0,a5,80007c48 <kerneltrap+0x12c>
    80007bdc:	fc050ce3          	beqz	a0,80007bb4 <kerneltrap+0x98>
    80007be0:	00050593          	mv	a1,a0
    80007be4:	00003517          	auipc	a0,0x3
    80007be8:	c7c50513          	addi	a0,a0,-900 # 8000a860 <CONSOLE_STATUS+0x850>
    80007bec:	00000097          	auipc	ra,0x0
    80007bf0:	7ec080e7          	jalr	2028(ra) # 800083d8 <__printf>
    80007bf4:	01013403          	ld	s0,16(sp)
    80007bf8:	01813083          	ld	ra,24(sp)
    80007bfc:	00048513          	mv	a0,s1
    80007c00:	00813483          	ld	s1,8(sp)
    80007c04:	02010113          	addi	sp,sp,32
    80007c08:	00000317          	auipc	t1,0x0
    80007c0c:	3c430067          	jr	964(t1) # 80007fcc <plic_complete>
    80007c10:	00006517          	auipc	a0,0x6
    80007c14:	16050513          	addi	a0,a0,352 # 8000dd70 <tickslock>
    80007c18:	00001097          	auipc	ra,0x1
    80007c1c:	494080e7          	jalr	1172(ra) # 800090ac <acquire>
    80007c20:	00005717          	auipc	a4,0x5
    80007c24:	f9470713          	addi	a4,a4,-108 # 8000cbb4 <ticks>
    80007c28:	00072783          	lw	a5,0(a4)
    80007c2c:	00006517          	auipc	a0,0x6
    80007c30:	14450513          	addi	a0,a0,324 # 8000dd70 <tickslock>
    80007c34:	0017879b          	addiw	a5,a5,1
    80007c38:	00f72023          	sw	a5,0(a4)
    80007c3c:	00001097          	auipc	ra,0x1
    80007c40:	53c080e7          	jalr	1340(ra) # 80009178 <release>
    80007c44:	f65ff06f          	j	80007ba8 <kerneltrap+0x8c>
    80007c48:	00001097          	auipc	ra,0x1
    80007c4c:	098080e7          	jalr	152(ra) # 80008ce0 <uartintr>
    80007c50:	fa5ff06f          	j	80007bf4 <kerneltrap+0xd8>
    80007c54:	00003517          	auipc	a0,0x3
    80007c58:	bec50513          	addi	a0,a0,-1044 # 8000a840 <CONSOLE_STATUS+0x830>
    80007c5c:	00000097          	auipc	ra,0x0
    80007c60:	720080e7          	jalr	1824(ra) # 8000837c <panic>

0000000080007c64 <clockintr>:
    80007c64:	fe010113          	addi	sp,sp,-32
    80007c68:	00813823          	sd	s0,16(sp)
    80007c6c:	00913423          	sd	s1,8(sp)
    80007c70:	00113c23          	sd	ra,24(sp)
    80007c74:	02010413          	addi	s0,sp,32
    80007c78:	00006497          	auipc	s1,0x6
    80007c7c:	0f848493          	addi	s1,s1,248 # 8000dd70 <tickslock>
    80007c80:	00048513          	mv	a0,s1
    80007c84:	00001097          	auipc	ra,0x1
    80007c88:	428080e7          	jalr	1064(ra) # 800090ac <acquire>
    80007c8c:	00005717          	auipc	a4,0x5
    80007c90:	f2870713          	addi	a4,a4,-216 # 8000cbb4 <ticks>
    80007c94:	00072783          	lw	a5,0(a4)
    80007c98:	01013403          	ld	s0,16(sp)
    80007c9c:	01813083          	ld	ra,24(sp)
    80007ca0:	00048513          	mv	a0,s1
    80007ca4:	0017879b          	addiw	a5,a5,1
    80007ca8:	00813483          	ld	s1,8(sp)
    80007cac:	00f72023          	sw	a5,0(a4)
    80007cb0:	02010113          	addi	sp,sp,32
    80007cb4:	00001317          	auipc	t1,0x1
    80007cb8:	4c430067          	jr	1220(t1) # 80009178 <release>

0000000080007cbc <devintr>:
    80007cbc:	142027f3          	csrr	a5,scause
    80007cc0:	00000513          	li	a0,0
    80007cc4:	0007c463          	bltz	a5,80007ccc <devintr+0x10>
    80007cc8:	00008067          	ret
    80007ccc:	fe010113          	addi	sp,sp,-32
    80007cd0:	00813823          	sd	s0,16(sp)
    80007cd4:	00113c23          	sd	ra,24(sp)
    80007cd8:	00913423          	sd	s1,8(sp)
    80007cdc:	02010413          	addi	s0,sp,32
    80007ce0:	0ff7f713          	andi	a4,a5,255
    80007ce4:	00900693          	li	a3,9
    80007ce8:	04d70c63          	beq	a4,a3,80007d40 <devintr+0x84>
    80007cec:	fff00713          	li	a4,-1
    80007cf0:	03f71713          	slli	a4,a4,0x3f
    80007cf4:	00170713          	addi	a4,a4,1
    80007cf8:	00e78c63          	beq	a5,a4,80007d10 <devintr+0x54>
    80007cfc:	01813083          	ld	ra,24(sp)
    80007d00:	01013403          	ld	s0,16(sp)
    80007d04:	00813483          	ld	s1,8(sp)
    80007d08:	02010113          	addi	sp,sp,32
    80007d0c:	00008067          	ret
    80007d10:	00000097          	auipc	ra,0x0
    80007d14:	c8c080e7          	jalr	-884(ra) # 8000799c <cpuid>
    80007d18:	06050663          	beqz	a0,80007d84 <devintr+0xc8>
    80007d1c:	144027f3          	csrr	a5,sip
    80007d20:	ffd7f793          	andi	a5,a5,-3
    80007d24:	14479073          	csrw	sip,a5
    80007d28:	01813083          	ld	ra,24(sp)
    80007d2c:	01013403          	ld	s0,16(sp)
    80007d30:	00813483          	ld	s1,8(sp)
    80007d34:	00200513          	li	a0,2
    80007d38:	02010113          	addi	sp,sp,32
    80007d3c:	00008067          	ret
    80007d40:	00000097          	auipc	ra,0x0
    80007d44:	254080e7          	jalr	596(ra) # 80007f94 <plic_claim>
    80007d48:	00a00793          	li	a5,10
    80007d4c:	00050493          	mv	s1,a0
    80007d50:	06f50663          	beq	a0,a5,80007dbc <devintr+0x100>
    80007d54:	00100513          	li	a0,1
    80007d58:	fa0482e3          	beqz	s1,80007cfc <devintr+0x40>
    80007d5c:	00048593          	mv	a1,s1
    80007d60:	00003517          	auipc	a0,0x3
    80007d64:	b0050513          	addi	a0,a0,-1280 # 8000a860 <CONSOLE_STATUS+0x850>
    80007d68:	00000097          	auipc	ra,0x0
    80007d6c:	670080e7          	jalr	1648(ra) # 800083d8 <__printf>
    80007d70:	00048513          	mv	a0,s1
    80007d74:	00000097          	auipc	ra,0x0
    80007d78:	258080e7          	jalr	600(ra) # 80007fcc <plic_complete>
    80007d7c:	00100513          	li	a0,1
    80007d80:	f7dff06f          	j	80007cfc <devintr+0x40>
    80007d84:	00006517          	auipc	a0,0x6
    80007d88:	fec50513          	addi	a0,a0,-20 # 8000dd70 <tickslock>
    80007d8c:	00001097          	auipc	ra,0x1
    80007d90:	320080e7          	jalr	800(ra) # 800090ac <acquire>
    80007d94:	00005717          	auipc	a4,0x5
    80007d98:	e2070713          	addi	a4,a4,-480 # 8000cbb4 <ticks>
    80007d9c:	00072783          	lw	a5,0(a4)
    80007da0:	00006517          	auipc	a0,0x6
    80007da4:	fd050513          	addi	a0,a0,-48 # 8000dd70 <tickslock>
    80007da8:	0017879b          	addiw	a5,a5,1
    80007dac:	00f72023          	sw	a5,0(a4)
    80007db0:	00001097          	auipc	ra,0x1
    80007db4:	3c8080e7          	jalr	968(ra) # 80009178 <release>
    80007db8:	f65ff06f          	j	80007d1c <devintr+0x60>
    80007dbc:	00001097          	auipc	ra,0x1
    80007dc0:	f24080e7          	jalr	-220(ra) # 80008ce0 <uartintr>
    80007dc4:	fadff06f          	j	80007d70 <devintr+0xb4>
	...

0000000080007dd0 <kernelvec>:
    80007dd0:	f0010113          	addi	sp,sp,-256
    80007dd4:	00113023          	sd	ra,0(sp)
    80007dd8:	00213423          	sd	sp,8(sp)
    80007ddc:	00313823          	sd	gp,16(sp)
    80007de0:	00413c23          	sd	tp,24(sp)
    80007de4:	02513023          	sd	t0,32(sp)
    80007de8:	02613423          	sd	t1,40(sp)
    80007dec:	02713823          	sd	t2,48(sp)
    80007df0:	02813c23          	sd	s0,56(sp)
    80007df4:	04913023          	sd	s1,64(sp)
    80007df8:	04a13423          	sd	a0,72(sp)
    80007dfc:	04b13823          	sd	a1,80(sp)
    80007e00:	04c13c23          	sd	a2,88(sp)
    80007e04:	06d13023          	sd	a3,96(sp)
    80007e08:	06e13423          	sd	a4,104(sp)
    80007e0c:	06f13823          	sd	a5,112(sp)
    80007e10:	07013c23          	sd	a6,120(sp)
    80007e14:	09113023          	sd	a7,128(sp)
    80007e18:	09213423          	sd	s2,136(sp)
    80007e1c:	09313823          	sd	s3,144(sp)
    80007e20:	09413c23          	sd	s4,152(sp)
    80007e24:	0b513023          	sd	s5,160(sp)
    80007e28:	0b613423          	sd	s6,168(sp)
    80007e2c:	0b713823          	sd	s7,176(sp)
    80007e30:	0b813c23          	sd	s8,184(sp)
    80007e34:	0d913023          	sd	s9,192(sp)
    80007e38:	0da13423          	sd	s10,200(sp)
    80007e3c:	0db13823          	sd	s11,208(sp)
    80007e40:	0dc13c23          	sd	t3,216(sp)
    80007e44:	0fd13023          	sd	t4,224(sp)
    80007e48:	0fe13423          	sd	t5,232(sp)
    80007e4c:	0ff13823          	sd	t6,240(sp)
    80007e50:	ccdff0ef          	jal	ra,80007b1c <kerneltrap>
    80007e54:	00013083          	ld	ra,0(sp)
    80007e58:	00813103          	ld	sp,8(sp)
    80007e5c:	01013183          	ld	gp,16(sp)
    80007e60:	02013283          	ld	t0,32(sp)
    80007e64:	02813303          	ld	t1,40(sp)
    80007e68:	03013383          	ld	t2,48(sp)
    80007e6c:	03813403          	ld	s0,56(sp)
    80007e70:	04013483          	ld	s1,64(sp)
    80007e74:	04813503          	ld	a0,72(sp)
    80007e78:	05013583          	ld	a1,80(sp)
    80007e7c:	05813603          	ld	a2,88(sp)
    80007e80:	06013683          	ld	a3,96(sp)
    80007e84:	06813703          	ld	a4,104(sp)
    80007e88:	07013783          	ld	a5,112(sp)
    80007e8c:	07813803          	ld	a6,120(sp)
    80007e90:	08013883          	ld	a7,128(sp)
    80007e94:	08813903          	ld	s2,136(sp)
    80007e98:	09013983          	ld	s3,144(sp)
    80007e9c:	09813a03          	ld	s4,152(sp)
    80007ea0:	0a013a83          	ld	s5,160(sp)
    80007ea4:	0a813b03          	ld	s6,168(sp)
    80007ea8:	0b013b83          	ld	s7,176(sp)
    80007eac:	0b813c03          	ld	s8,184(sp)
    80007eb0:	0c013c83          	ld	s9,192(sp)
    80007eb4:	0c813d03          	ld	s10,200(sp)
    80007eb8:	0d013d83          	ld	s11,208(sp)
    80007ebc:	0d813e03          	ld	t3,216(sp)
    80007ec0:	0e013e83          	ld	t4,224(sp)
    80007ec4:	0e813f03          	ld	t5,232(sp)
    80007ec8:	0f013f83          	ld	t6,240(sp)
    80007ecc:	10010113          	addi	sp,sp,256
    80007ed0:	10200073          	sret
    80007ed4:	00000013          	nop
    80007ed8:	00000013          	nop
    80007edc:	00000013          	nop

0000000080007ee0 <timervec>:
    80007ee0:	34051573          	csrrw	a0,mscratch,a0
    80007ee4:	00b53023          	sd	a1,0(a0)
    80007ee8:	00c53423          	sd	a2,8(a0)
    80007eec:	00d53823          	sd	a3,16(a0)
    80007ef0:	01853583          	ld	a1,24(a0)
    80007ef4:	02053603          	ld	a2,32(a0)
    80007ef8:	0005b683          	ld	a3,0(a1)
    80007efc:	00c686b3          	add	a3,a3,a2
    80007f00:	00d5b023          	sd	a3,0(a1)
    80007f04:	00200593          	li	a1,2
    80007f08:	14459073          	csrw	sip,a1
    80007f0c:	01053683          	ld	a3,16(a0)
    80007f10:	00853603          	ld	a2,8(a0)
    80007f14:	00053583          	ld	a1,0(a0)
    80007f18:	34051573          	csrrw	a0,mscratch,a0
    80007f1c:	30200073          	mret

0000000080007f20 <plicinit>:
    80007f20:	ff010113          	addi	sp,sp,-16
    80007f24:	00813423          	sd	s0,8(sp)
    80007f28:	01010413          	addi	s0,sp,16
    80007f2c:	00813403          	ld	s0,8(sp)
    80007f30:	0c0007b7          	lui	a5,0xc000
    80007f34:	00100713          	li	a4,1
    80007f38:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80007f3c:	00e7a223          	sw	a4,4(a5)
    80007f40:	01010113          	addi	sp,sp,16
    80007f44:	00008067          	ret

0000000080007f48 <plicinithart>:
    80007f48:	ff010113          	addi	sp,sp,-16
    80007f4c:	00813023          	sd	s0,0(sp)
    80007f50:	00113423          	sd	ra,8(sp)
    80007f54:	01010413          	addi	s0,sp,16
    80007f58:	00000097          	auipc	ra,0x0
    80007f5c:	a44080e7          	jalr	-1468(ra) # 8000799c <cpuid>
    80007f60:	0085171b          	slliw	a4,a0,0x8
    80007f64:	0c0027b7          	lui	a5,0xc002
    80007f68:	00e787b3          	add	a5,a5,a4
    80007f6c:	40200713          	li	a4,1026
    80007f70:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007f74:	00813083          	ld	ra,8(sp)
    80007f78:	00013403          	ld	s0,0(sp)
    80007f7c:	00d5151b          	slliw	a0,a0,0xd
    80007f80:	0c2017b7          	lui	a5,0xc201
    80007f84:	00a78533          	add	a0,a5,a0
    80007f88:	00052023          	sw	zero,0(a0)
    80007f8c:	01010113          	addi	sp,sp,16
    80007f90:	00008067          	ret

0000000080007f94 <plic_claim>:
    80007f94:	ff010113          	addi	sp,sp,-16
    80007f98:	00813023          	sd	s0,0(sp)
    80007f9c:	00113423          	sd	ra,8(sp)
    80007fa0:	01010413          	addi	s0,sp,16
    80007fa4:	00000097          	auipc	ra,0x0
    80007fa8:	9f8080e7          	jalr	-1544(ra) # 8000799c <cpuid>
    80007fac:	00813083          	ld	ra,8(sp)
    80007fb0:	00013403          	ld	s0,0(sp)
    80007fb4:	00d5151b          	slliw	a0,a0,0xd
    80007fb8:	0c2017b7          	lui	a5,0xc201
    80007fbc:	00a78533          	add	a0,a5,a0
    80007fc0:	00452503          	lw	a0,4(a0)
    80007fc4:	01010113          	addi	sp,sp,16
    80007fc8:	00008067          	ret

0000000080007fcc <plic_complete>:
    80007fcc:	fe010113          	addi	sp,sp,-32
    80007fd0:	00813823          	sd	s0,16(sp)
    80007fd4:	00913423          	sd	s1,8(sp)
    80007fd8:	00113c23          	sd	ra,24(sp)
    80007fdc:	02010413          	addi	s0,sp,32
    80007fe0:	00050493          	mv	s1,a0
    80007fe4:	00000097          	auipc	ra,0x0
    80007fe8:	9b8080e7          	jalr	-1608(ra) # 8000799c <cpuid>
    80007fec:	01813083          	ld	ra,24(sp)
    80007ff0:	01013403          	ld	s0,16(sp)
    80007ff4:	00d5179b          	slliw	a5,a0,0xd
    80007ff8:	0c201737          	lui	a4,0xc201
    80007ffc:	00f707b3          	add	a5,a4,a5
    80008000:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80008004:	00813483          	ld	s1,8(sp)
    80008008:	02010113          	addi	sp,sp,32
    8000800c:	00008067          	ret

0000000080008010 <consolewrite>:
    80008010:	fb010113          	addi	sp,sp,-80
    80008014:	04813023          	sd	s0,64(sp)
    80008018:	04113423          	sd	ra,72(sp)
    8000801c:	02913c23          	sd	s1,56(sp)
    80008020:	03213823          	sd	s2,48(sp)
    80008024:	03313423          	sd	s3,40(sp)
    80008028:	03413023          	sd	s4,32(sp)
    8000802c:	01513c23          	sd	s5,24(sp)
    80008030:	05010413          	addi	s0,sp,80
    80008034:	06c05c63          	blez	a2,800080ac <consolewrite+0x9c>
    80008038:	00060993          	mv	s3,a2
    8000803c:	00050a13          	mv	s4,a0
    80008040:	00058493          	mv	s1,a1
    80008044:	00000913          	li	s2,0
    80008048:	fff00a93          	li	s5,-1
    8000804c:	01c0006f          	j	80008068 <consolewrite+0x58>
    80008050:	fbf44503          	lbu	a0,-65(s0)
    80008054:	0019091b          	addiw	s2,s2,1
    80008058:	00148493          	addi	s1,s1,1
    8000805c:	00001097          	auipc	ra,0x1
    80008060:	a9c080e7          	jalr	-1380(ra) # 80008af8 <uartputc>
    80008064:	03298063          	beq	s3,s2,80008084 <consolewrite+0x74>
    80008068:	00048613          	mv	a2,s1
    8000806c:	00100693          	li	a3,1
    80008070:	000a0593          	mv	a1,s4
    80008074:	fbf40513          	addi	a0,s0,-65
    80008078:	00000097          	auipc	ra,0x0
    8000807c:	9dc080e7          	jalr	-1572(ra) # 80007a54 <either_copyin>
    80008080:	fd5518e3          	bne	a0,s5,80008050 <consolewrite+0x40>
    80008084:	04813083          	ld	ra,72(sp)
    80008088:	04013403          	ld	s0,64(sp)
    8000808c:	03813483          	ld	s1,56(sp)
    80008090:	02813983          	ld	s3,40(sp)
    80008094:	02013a03          	ld	s4,32(sp)
    80008098:	01813a83          	ld	s5,24(sp)
    8000809c:	00090513          	mv	a0,s2
    800080a0:	03013903          	ld	s2,48(sp)
    800080a4:	05010113          	addi	sp,sp,80
    800080a8:	00008067          	ret
    800080ac:	00000913          	li	s2,0
    800080b0:	fd5ff06f          	j	80008084 <consolewrite+0x74>

00000000800080b4 <consoleread>:
    800080b4:	f9010113          	addi	sp,sp,-112
    800080b8:	06813023          	sd	s0,96(sp)
    800080bc:	04913c23          	sd	s1,88(sp)
    800080c0:	05213823          	sd	s2,80(sp)
    800080c4:	05313423          	sd	s3,72(sp)
    800080c8:	05413023          	sd	s4,64(sp)
    800080cc:	03513c23          	sd	s5,56(sp)
    800080d0:	03613823          	sd	s6,48(sp)
    800080d4:	03713423          	sd	s7,40(sp)
    800080d8:	03813023          	sd	s8,32(sp)
    800080dc:	06113423          	sd	ra,104(sp)
    800080e0:	01913c23          	sd	s9,24(sp)
    800080e4:	07010413          	addi	s0,sp,112
    800080e8:	00060b93          	mv	s7,a2
    800080ec:	00050913          	mv	s2,a0
    800080f0:	00058c13          	mv	s8,a1
    800080f4:	00060b1b          	sext.w	s6,a2
    800080f8:	00006497          	auipc	s1,0x6
    800080fc:	ca048493          	addi	s1,s1,-864 # 8000dd98 <cons>
    80008100:	00400993          	li	s3,4
    80008104:	fff00a13          	li	s4,-1
    80008108:	00a00a93          	li	s5,10
    8000810c:	05705e63          	blez	s7,80008168 <consoleread+0xb4>
    80008110:	09c4a703          	lw	a4,156(s1)
    80008114:	0984a783          	lw	a5,152(s1)
    80008118:	0007071b          	sext.w	a4,a4
    8000811c:	08e78463          	beq	a5,a4,800081a4 <consoleread+0xf0>
    80008120:	07f7f713          	andi	a4,a5,127
    80008124:	00e48733          	add	a4,s1,a4
    80008128:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000812c:	0017869b          	addiw	a3,a5,1
    80008130:	08d4ac23          	sw	a3,152(s1)
    80008134:	00070c9b          	sext.w	s9,a4
    80008138:	0b370663          	beq	a4,s3,800081e4 <consoleread+0x130>
    8000813c:	00100693          	li	a3,1
    80008140:	f9f40613          	addi	a2,s0,-97
    80008144:	000c0593          	mv	a1,s8
    80008148:	00090513          	mv	a0,s2
    8000814c:	f8e40fa3          	sb	a4,-97(s0)
    80008150:	00000097          	auipc	ra,0x0
    80008154:	8b8080e7          	jalr	-1864(ra) # 80007a08 <either_copyout>
    80008158:	01450863          	beq	a0,s4,80008168 <consoleread+0xb4>
    8000815c:	001c0c13          	addi	s8,s8,1
    80008160:	fffb8b9b          	addiw	s7,s7,-1
    80008164:	fb5c94e3          	bne	s9,s5,8000810c <consoleread+0x58>
    80008168:	000b851b          	sext.w	a0,s7
    8000816c:	06813083          	ld	ra,104(sp)
    80008170:	06013403          	ld	s0,96(sp)
    80008174:	05813483          	ld	s1,88(sp)
    80008178:	05013903          	ld	s2,80(sp)
    8000817c:	04813983          	ld	s3,72(sp)
    80008180:	04013a03          	ld	s4,64(sp)
    80008184:	03813a83          	ld	s5,56(sp)
    80008188:	02813b83          	ld	s7,40(sp)
    8000818c:	02013c03          	ld	s8,32(sp)
    80008190:	01813c83          	ld	s9,24(sp)
    80008194:	40ab053b          	subw	a0,s6,a0
    80008198:	03013b03          	ld	s6,48(sp)
    8000819c:	07010113          	addi	sp,sp,112
    800081a0:	00008067          	ret
    800081a4:	00001097          	auipc	ra,0x1
    800081a8:	1d8080e7          	jalr	472(ra) # 8000937c <push_on>
    800081ac:	0984a703          	lw	a4,152(s1)
    800081b0:	09c4a783          	lw	a5,156(s1)
    800081b4:	0007879b          	sext.w	a5,a5
    800081b8:	fef70ce3          	beq	a4,a5,800081b0 <consoleread+0xfc>
    800081bc:	00001097          	auipc	ra,0x1
    800081c0:	234080e7          	jalr	564(ra) # 800093f0 <pop_on>
    800081c4:	0984a783          	lw	a5,152(s1)
    800081c8:	07f7f713          	andi	a4,a5,127
    800081cc:	00e48733          	add	a4,s1,a4
    800081d0:	01874703          	lbu	a4,24(a4)
    800081d4:	0017869b          	addiw	a3,a5,1
    800081d8:	08d4ac23          	sw	a3,152(s1)
    800081dc:	00070c9b          	sext.w	s9,a4
    800081e0:	f5371ee3          	bne	a4,s3,8000813c <consoleread+0x88>
    800081e4:	000b851b          	sext.w	a0,s7
    800081e8:	f96bf2e3          	bgeu	s7,s6,8000816c <consoleread+0xb8>
    800081ec:	08f4ac23          	sw	a5,152(s1)
    800081f0:	f7dff06f          	j	8000816c <consoleread+0xb8>

00000000800081f4 <consputc>:
    800081f4:	10000793          	li	a5,256
    800081f8:	00f50663          	beq	a0,a5,80008204 <consputc+0x10>
    800081fc:	00001317          	auipc	t1,0x1
    80008200:	9f430067          	jr	-1548(t1) # 80008bf0 <uartputc_sync>
    80008204:	ff010113          	addi	sp,sp,-16
    80008208:	00113423          	sd	ra,8(sp)
    8000820c:	00813023          	sd	s0,0(sp)
    80008210:	01010413          	addi	s0,sp,16
    80008214:	00800513          	li	a0,8
    80008218:	00001097          	auipc	ra,0x1
    8000821c:	9d8080e7          	jalr	-1576(ra) # 80008bf0 <uartputc_sync>
    80008220:	02000513          	li	a0,32
    80008224:	00001097          	auipc	ra,0x1
    80008228:	9cc080e7          	jalr	-1588(ra) # 80008bf0 <uartputc_sync>
    8000822c:	00013403          	ld	s0,0(sp)
    80008230:	00813083          	ld	ra,8(sp)
    80008234:	00800513          	li	a0,8
    80008238:	01010113          	addi	sp,sp,16
    8000823c:	00001317          	auipc	t1,0x1
    80008240:	9b430067          	jr	-1612(t1) # 80008bf0 <uartputc_sync>

0000000080008244 <consoleintr>:
    80008244:	fe010113          	addi	sp,sp,-32
    80008248:	00813823          	sd	s0,16(sp)
    8000824c:	00913423          	sd	s1,8(sp)
    80008250:	01213023          	sd	s2,0(sp)
    80008254:	00113c23          	sd	ra,24(sp)
    80008258:	02010413          	addi	s0,sp,32
    8000825c:	00006917          	auipc	s2,0x6
    80008260:	b3c90913          	addi	s2,s2,-1220 # 8000dd98 <cons>
    80008264:	00050493          	mv	s1,a0
    80008268:	00090513          	mv	a0,s2
    8000826c:	00001097          	auipc	ra,0x1
    80008270:	e40080e7          	jalr	-448(ra) # 800090ac <acquire>
    80008274:	02048c63          	beqz	s1,800082ac <consoleintr+0x68>
    80008278:	0a092783          	lw	a5,160(s2)
    8000827c:	09892703          	lw	a4,152(s2)
    80008280:	07f00693          	li	a3,127
    80008284:	40e7873b          	subw	a4,a5,a4
    80008288:	02e6e263          	bltu	a3,a4,800082ac <consoleintr+0x68>
    8000828c:	00d00713          	li	a4,13
    80008290:	04e48063          	beq	s1,a4,800082d0 <consoleintr+0x8c>
    80008294:	07f7f713          	andi	a4,a5,127
    80008298:	00e90733          	add	a4,s2,a4
    8000829c:	0017879b          	addiw	a5,a5,1
    800082a0:	0af92023          	sw	a5,160(s2)
    800082a4:	00970c23          	sb	s1,24(a4)
    800082a8:	08f92e23          	sw	a5,156(s2)
    800082ac:	01013403          	ld	s0,16(sp)
    800082b0:	01813083          	ld	ra,24(sp)
    800082b4:	00813483          	ld	s1,8(sp)
    800082b8:	00013903          	ld	s2,0(sp)
    800082bc:	00006517          	auipc	a0,0x6
    800082c0:	adc50513          	addi	a0,a0,-1316 # 8000dd98 <cons>
    800082c4:	02010113          	addi	sp,sp,32
    800082c8:	00001317          	auipc	t1,0x1
    800082cc:	eb030067          	jr	-336(t1) # 80009178 <release>
    800082d0:	00a00493          	li	s1,10
    800082d4:	fc1ff06f          	j	80008294 <consoleintr+0x50>

00000000800082d8 <consoleinit>:
    800082d8:	fe010113          	addi	sp,sp,-32
    800082dc:	00113c23          	sd	ra,24(sp)
    800082e0:	00813823          	sd	s0,16(sp)
    800082e4:	00913423          	sd	s1,8(sp)
    800082e8:	02010413          	addi	s0,sp,32
    800082ec:	00006497          	auipc	s1,0x6
    800082f0:	aac48493          	addi	s1,s1,-1364 # 8000dd98 <cons>
    800082f4:	00048513          	mv	a0,s1
    800082f8:	00002597          	auipc	a1,0x2
    800082fc:	5c058593          	addi	a1,a1,1472 # 8000a8b8 <CONSOLE_STATUS+0x8a8>
    80008300:	00001097          	auipc	ra,0x1
    80008304:	d88080e7          	jalr	-632(ra) # 80009088 <initlock>
    80008308:	00000097          	auipc	ra,0x0
    8000830c:	7ac080e7          	jalr	1964(ra) # 80008ab4 <uartinit>
    80008310:	01813083          	ld	ra,24(sp)
    80008314:	01013403          	ld	s0,16(sp)
    80008318:	00000797          	auipc	a5,0x0
    8000831c:	d9c78793          	addi	a5,a5,-612 # 800080b4 <consoleread>
    80008320:	0af4bc23          	sd	a5,184(s1)
    80008324:	00000797          	auipc	a5,0x0
    80008328:	cec78793          	addi	a5,a5,-788 # 80008010 <consolewrite>
    8000832c:	0cf4b023          	sd	a5,192(s1)
    80008330:	00813483          	ld	s1,8(sp)
    80008334:	02010113          	addi	sp,sp,32
    80008338:	00008067          	ret

000000008000833c <console_read>:
    8000833c:	ff010113          	addi	sp,sp,-16
    80008340:	00813423          	sd	s0,8(sp)
    80008344:	01010413          	addi	s0,sp,16
    80008348:	00813403          	ld	s0,8(sp)
    8000834c:	00006317          	auipc	t1,0x6
    80008350:	b0433303          	ld	t1,-1276(t1) # 8000de50 <devsw+0x10>
    80008354:	01010113          	addi	sp,sp,16
    80008358:	00030067          	jr	t1

000000008000835c <console_write>:
    8000835c:	ff010113          	addi	sp,sp,-16
    80008360:	00813423          	sd	s0,8(sp)
    80008364:	01010413          	addi	s0,sp,16
    80008368:	00813403          	ld	s0,8(sp)
    8000836c:	00006317          	auipc	t1,0x6
    80008370:	aec33303          	ld	t1,-1300(t1) # 8000de58 <devsw+0x18>
    80008374:	01010113          	addi	sp,sp,16
    80008378:	00030067          	jr	t1

000000008000837c <panic>:
    8000837c:	fe010113          	addi	sp,sp,-32
    80008380:	00113c23          	sd	ra,24(sp)
    80008384:	00813823          	sd	s0,16(sp)
    80008388:	00913423          	sd	s1,8(sp)
    8000838c:	02010413          	addi	s0,sp,32
    80008390:	00050493          	mv	s1,a0
    80008394:	00002517          	auipc	a0,0x2
    80008398:	52c50513          	addi	a0,a0,1324 # 8000a8c0 <CONSOLE_STATUS+0x8b0>
    8000839c:	00006797          	auipc	a5,0x6
    800083a0:	b407ae23          	sw	zero,-1188(a5) # 8000def8 <pr+0x18>
    800083a4:	00000097          	auipc	ra,0x0
    800083a8:	034080e7          	jalr	52(ra) # 800083d8 <__printf>
    800083ac:	00048513          	mv	a0,s1
    800083b0:	00000097          	auipc	ra,0x0
    800083b4:	028080e7          	jalr	40(ra) # 800083d8 <__printf>
    800083b8:	00002517          	auipc	a0,0x2
    800083bc:	fc850513          	addi	a0,a0,-56 # 8000a380 <CONSOLE_STATUS+0x370>
    800083c0:	00000097          	auipc	ra,0x0
    800083c4:	018080e7          	jalr	24(ra) # 800083d8 <__printf>
    800083c8:	00100793          	li	a5,1
    800083cc:	00004717          	auipc	a4,0x4
    800083d0:	7ef72623          	sw	a5,2028(a4) # 8000cbb8 <panicked>
    800083d4:	0000006f          	j	800083d4 <panic+0x58>

00000000800083d8 <__printf>:
    800083d8:	f3010113          	addi	sp,sp,-208
    800083dc:	08813023          	sd	s0,128(sp)
    800083e0:	07313423          	sd	s3,104(sp)
    800083e4:	09010413          	addi	s0,sp,144
    800083e8:	05813023          	sd	s8,64(sp)
    800083ec:	08113423          	sd	ra,136(sp)
    800083f0:	06913c23          	sd	s1,120(sp)
    800083f4:	07213823          	sd	s2,112(sp)
    800083f8:	07413023          	sd	s4,96(sp)
    800083fc:	05513c23          	sd	s5,88(sp)
    80008400:	05613823          	sd	s6,80(sp)
    80008404:	05713423          	sd	s7,72(sp)
    80008408:	03913c23          	sd	s9,56(sp)
    8000840c:	03a13823          	sd	s10,48(sp)
    80008410:	03b13423          	sd	s11,40(sp)
    80008414:	00006317          	auipc	t1,0x6
    80008418:	acc30313          	addi	t1,t1,-1332 # 8000dee0 <pr>
    8000841c:	01832c03          	lw	s8,24(t1)
    80008420:	00b43423          	sd	a1,8(s0)
    80008424:	00c43823          	sd	a2,16(s0)
    80008428:	00d43c23          	sd	a3,24(s0)
    8000842c:	02e43023          	sd	a4,32(s0)
    80008430:	02f43423          	sd	a5,40(s0)
    80008434:	03043823          	sd	a6,48(s0)
    80008438:	03143c23          	sd	a7,56(s0)
    8000843c:	00050993          	mv	s3,a0
    80008440:	4a0c1663          	bnez	s8,800088ec <__printf+0x514>
    80008444:	60098c63          	beqz	s3,80008a5c <__printf+0x684>
    80008448:	0009c503          	lbu	a0,0(s3)
    8000844c:	00840793          	addi	a5,s0,8
    80008450:	f6f43c23          	sd	a5,-136(s0)
    80008454:	00000493          	li	s1,0
    80008458:	22050063          	beqz	a0,80008678 <__printf+0x2a0>
    8000845c:	00002a37          	lui	s4,0x2
    80008460:	00018ab7          	lui	s5,0x18
    80008464:	000f4b37          	lui	s6,0xf4
    80008468:	00989bb7          	lui	s7,0x989
    8000846c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80008470:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80008474:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80008478:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000847c:	00148c9b          	addiw	s9,s1,1
    80008480:	02500793          	li	a5,37
    80008484:	01998933          	add	s2,s3,s9
    80008488:	38f51263          	bne	a0,a5,8000880c <__printf+0x434>
    8000848c:	00094783          	lbu	a5,0(s2)
    80008490:	00078c9b          	sext.w	s9,a5
    80008494:	1e078263          	beqz	a5,80008678 <__printf+0x2a0>
    80008498:	0024849b          	addiw	s1,s1,2
    8000849c:	07000713          	li	a4,112
    800084a0:	00998933          	add	s2,s3,s1
    800084a4:	38e78a63          	beq	a5,a4,80008838 <__printf+0x460>
    800084a8:	20f76863          	bltu	a4,a5,800086b8 <__printf+0x2e0>
    800084ac:	42a78863          	beq	a5,a0,800088dc <__printf+0x504>
    800084b0:	06400713          	li	a4,100
    800084b4:	40e79663          	bne	a5,a4,800088c0 <__printf+0x4e8>
    800084b8:	f7843783          	ld	a5,-136(s0)
    800084bc:	0007a603          	lw	a2,0(a5)
    800084c0:	00878793          	addi	a5,a5,8
    800084c4:	f6f43c23          	sd	a5,-136(s0)
    800084c8:	42064a63          	bltz	a2,800088fc <__printf+0x524>
    800084cc:	00a00713          	li	a4,10
    800084d0:	02e677bb          	remuw	a5,a2,a4
    800084d4:	00002d97          	auipc	s11,0x2
    800084d8:	414d8d93          	addi	s11,s11,1044 # 8000a8e8 <digits>
    800084dc:	00900593          	li	a1,9
    800084e0:	0006051b          	sext.w	a0,a2
    800084e4:	00000c93          	li	s9,0
    800084e8:	02079793          	slli	a5,a5,0x20
    800084ec:	0207d793          	srli	a5,a5,0x20
    800084f0:	00fd87b3          	add	a5,s11,a5
    800084f4:	0007c783          	lbu	a5,0(a5)
    800084f8:	02e656bb          	divuw	a3,a2,a4
    800084fc:	f8f40023          	sb	a5,-128(s0)
    80008500:	14c5d863          	bge	a1,a2,80008650 <__printf+0x278>
    80008504:	06300593          	li	a1,99
    80008508:	00100c93          	li	s9,1
    8000850c:	02e6f7bb          	remuw	a5,a3,a4
    80008510:	02079793          	slli	a5,a5,0x20
    80008514:	0207d793          	srli	a5,a5,0x20
    80008518:	00fd87b3          	add	a5,s11,a5
    8000851c:	0007c783          	lbu	a5,0(a5)
    80008520:	02e6d73b          	divuw	a4,a3,a4
    80008524:	f8f400a3          	sb	a5,-127(s0)
    80008528:	12a5f463          	bgeu	a1,a0,80008650 <__printf+0x278>
    8000852c:	00a00693          	li	a3,10
    80008530:	00900593          	li	a1,9
    80008534:	02d777bb          	remuw	a5,a4,a3
    80008538:	02079793          	slli	a5,a5,0x20
    8000853c:	0207d793          	srli	a5,a5,0x20
    80008540:	00fd87b3          	add	a5,s11,a5
    80008544:	0007c503          	lbu	a0,0(a5)
    80008548:	02d757bb          	divuw	a5,a4,a3
    8000854c:	f8a40123          	sb	a0,-126(s0)
    80008550:	48e5f263          	bgeu	a1,a4,800089d4 <__printf+0x5fc>
    80008554:	06300513          	li	a0,99
    80008558:	02d7f5bb          	remuw	a1,a5,a3
    8000855c:	02059593          	slli	a1,a1,0x20
    80008560:	0205d593          	srli	a1,a1,0x20
    80008564:	00bd85b3          	add	a1,s11,a1
    80008568:	0005c583          	lbu	a1,0(a1)
    8000856c:	02d7d7bb          	divuw	a5,a5,a3
    80008570:	f8b401a3          	sb	a1,-125(s0)
    80008574:	48e57263          	bgeu	a0,a4,800089f8 <__printf+0x620>
    80008578:	3e700513          	li	a0,999
    8000857c:	02d7f5bb          	remuw	a1,a5,a3
    80008580:	02059593          	slli	a1,a1,0x20
    80008584:	0205d593          	srli	a1,a1,0x20
    80008588:	00bd85b3          	add	a1,s11,a1
    8000858c:	0005c583          	lbu	a1,0(a1)
    80008590:	02d7d7bb          	divuw	a5,a5,a3
    80008594:	f8b40223          	sb	a1,-124(s0)
    80008598:	46e57663          	bgeu	a0,a4,80008a04 <__printf+0x62c>
    8000859c:	02d7f5bb          	remuw	a1,a5,a3
    800085a0:	02059593          	slli	a1,a1,0x20
    800085a4:	0205d593          	srli	a1,a1,0x20
    800085a8:	00bd85b3          	add	a1,s11,a1
    800085ac:	0005c583          	lbu	a1,0(a1)
    800085b0:	02d7d7bb          	divuw	a5,a5,a3
    800085b4:	f8b402a3          	sb	a1,-123(s0)
    800085b8:	46ea7863          	bgeu	s4,a4,80008a28 <__printf+0x650>
    800085bc:	02d7f5bb          	remuw	a1,a5,a3
    800085c0:	02059593          	slli	a1,a1,0x20
    800085c4:	0205d593          	srli	a1,a1,0x20
    800085c8:	00bd85b3          	add	a1,s11,a1
    800085cc:	0005c583          	lbu	a1,0(a1)
    800085d0:	02d7d7bb          	divuw	a5,a5,a3
    800085d4:	f8b40323          	sb	a1,-122(s0)
    800085d8:	3eeaf863          	bgeu	s5,a4,800089c8 <__printf+0x5f0>
    800085dc:	02d7f5bb          	remuw	a1,a5,a3
    800085e0:	02059593          	slli	a1,a1,0x20
    800085e4:	0205d593          	srli	a1,a1,0x20
    800085e8:	00bd85b3          	add	a1,s11,a1
    800085ec:	0005c583          	lbu	a1,0(a1)
    800085f0:	02d7d7bb          	divuw	a5,a5,a3
    800085f4:	f8b403a3          	sb	a1,-121(s0)
    800085f8:	42eb7e63          	bgeu	s6,a4,80008a34 <__printf+0x65c>
    800085fc:	02d7f5bb          	remuw	a1,a5,a3
    80008600:	02059593          	slli	a1,a1,0x20
    80008604:	0205d593          	srli	a1,a1,0x20
    80008608:	00bd85b3          	add	a1,s11,a1
    8000860c:	0005c583          	lbu	a1,0(a1)
    80008610:	02d7d7bb          	divuw	a5,a5,a3
    80008614:	f8b40423          	sb	a1,-120(s0)
    80008618:	42ebfc63          	bgeu	s7,a4,80008a50 <__printf+0x678>
    8000861c:	02079793          	slli	a5,a5,0x20
    80008620:	0207d793          	srli	a5,a5,0x20
    80008624:	00fd8db3          	add	s11,s11,a5
    80008628:	000dc703          	lbu	a4,0(s11)
    8000862c:	00a00793          	li	a5,10
    80008630:	00900c93          	li	s9,9
    80008634:	f8e404a3          	sb	a4,-119(s0)
    80008638:	00065c63          	bgez	a2,80008650 <__printf+0x278>
    8000863c:	f9040713          	addi	a4,s0,-112
    80008640:	00f70733          	add	a4,a4,a5
    80008644:	02d00693          	li	a3,45
    80008648:	fed70823          	sb	a3,-16(a4)
    8000864c:	00078c93          	mv	s9,a5
    80008650:	f8040793          	addi	a5,s0,-128
    80008654:	01978cb3          	add	s9,a5,s9
    80008658:	f7f40d13          	addi	s10,s0,-129
    8000865c:	000cc503          	lbu	a0,0(s9)
    80008660:	fffc8c93          	addi	s9,s9,-1
    80008664:	00000097          	auipc	ra,0x0
    80008668:	b90080e7          	jalr	-1136(ra) # 800081f4 <consputc>
    8000866c:	ffac98e3          	bne	s9,s10,8000865c <__printf+0x284>
    80008670:	00094503          	lbu	a0,0(s2)
    80008674:	e00514e3          	bnez	a0,8000847c <__printf+0xa4>
    80008678:	1a0c1663          	bnez	s8,80008824 <__printf+0x44c>
    8000867c:	08813083          	ld	ra,136(sp)
    80008680:	08013403          	ld	s0,128(sp)
    80008684:	07813483          	ld	s1,120(sp)
    80008688:	07013903          	ld	s2,112(sp)
    8000868c:	06813983          	ld	s3,104(sp)
    80008690:	06013a03          	ld	s4,96(sp)
    80008694:	05813a83          	ld	s5,88(sp)
    80008698:	05013b03          	ld	s6,80(sp)
    8000869c:	04813b83          	ld	s7,72(sp)
    800086a0:	04013c03          	ld	s8,64(sp)
    800086a4:	03813c83          	ld	s9,56(sp)
    800086a8:	03013d03          	ld	s10,48(sp)
    800086ac:	02813d83          	ld	s11,40(sp)
    800086b0:	0d010113          	addi	sp,sp,208
    800086b4:	00008067          	ret
    800086b8:	07300713          	li	a4,115
    800086bc:	1ce78a63          	beq	a5,a4,80008890 <__printf+0x4b8>
    800086c0:	07800713          	li	a4,120
    800086c4:	1ee79e63          	bne	a5,a4,800088c0 <__printf+0x4e8>
    800086c8:	f7843783          	ld	a5,-136(s0)
    800086cc:	0007a703          	lw	a4,0(a5)
    800086d0:	00878793          	addi	a5,a5,8
    800086d4:	f6f43c23          	sd	a5,-136(s0)
    800086d8:	28074263          	bltz	a4,8000895c <__printf+0x584>
    800086dc:	00002d97          	auipc	s11,0x2
    800086e0:	20cd8d93          	addi	s11,s11,524 # 8000a8e8 <digits>
    800086e4:	00f77793          	andi	a5,a4,15
    800086e8:	00fd87b3          	add	a5,s11,a5
    800086ec:	0007c683          	lbu	a3,0(a5)
    800086f0:	00f00613          	li	a2,15
    800086f4:	0007079b          	sext.w	a5,a4
    800086f8:	f8d40023          	sb	a3,-128(s0)
    800086fc:	0047559b          	srliw	a1,a4,0x4
    80008700:	0047569b          	srliw	a3,a4,0x4
    80008704:	00000c93          	li	s9,0
    80008708:	0ee65063          	bge	a2,a4,800087e8 <__printf+0x410>
    8000870c:	00f6f693          	andi	a3,a3,15
    80008710:	00dd86b3          	add	a3,s11,a3
    80008714:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80008718:	0087d79b          	srliw	a5,a5,0x8
    8000871c:	00100c93          	li	s9,1
    80008720:	f8d400a3          	sb	a3,-127(s0)
    80008724:	0cb67263          	bgeu	a2,a1,800087e8 <__printf+0x410>
    80008728:	00f7f693          	andi	a3,a5,15
    8000872c:	00dd86b3          	add	a3,s11,a3
    80008730:	0006c583          	lbu	a1,0(a3)
    80008734:	00f00613          	li	a2,15
    80008738:	0047d69b          	srliw	a3,a5,0x4
    8000873c:	f8b40123          	sb	a1,-126(s0)
    80008740:	0047d593          	srli	a1,a5,0x4
    80008744:	28f67e63          	bgeu	a2,a5,800089e0 <__printf+0x608>
    80008748:	00f6f693          	andi	a3,a3,15
    8000874c:	00dd86b3          	add	a3,s11,a3
    80008750:	0006c503          	lbu	a0,0(a3)
    80008754:	0087d813          	srli	a6,a5,0x8
    80008758:	0087d69b          	srliw	a3,a5,0x8
    8000875c:	f8a401a3          	sb	a0,-125(s0)
    80008760:	28b67663          	bgeu	a2,a1,800089ec <__printf+0x614>
    80008764:	00f6f693          	andi	a3,a3,15
    80008768:	00dd86b3          	add	a3,s11,a3
    8000876c:	0006c583          	lbu	a1,0(a3)
    80008770:	00c7d513          	srli	a0,a5,0xc
    80008774:	00c7d69b          	srliw	a3,a5,0xc
    80008778:	f8b40223          	sb	a1,-124(s0)
    8000877c:	29067a63          	bgeu	a2,a6,80008a10 <__printf+0x638>
    80008780:	00f6f693          	andi	a3,a3,15
    80008784:	00dd86b3          	add	a3,s11,a3
    80008788:	0006c583          	lbu	a1,0(a3)
    8000878c:	0107d813          	srli	a6,a5,0x10
    80008790:	0107d69b          	srliw	a3,a5,0x10
    80008794:	f8b402a3          	sb	a1,-123(s0)
    80008798:	28a67263          	bgeu	a2,a0,80008a1c <__printf+0x644>
    8000879c:	00f6f693          	andi	a3,a3,15
    800087a0:	00dd86b3          	add	a3,s11,a3
    800087a4:	0006c683          	lbu	a3,0(a3)
    800087a8:	0147d79b          	srliw	a5,a5,0x14
    800087ac:	f8d40323          	sb	a3,-122(s0)
    800087b0:	21067663          	bgeu	a2,a6,800089bc <__printf+0x5e4>
    800087b4:	02079793          	slli	a5,a5,0x20
    800087b8:	0207d793          	srli	a5,a5,0x20
    800087bc:	00fd8db3          	add	s11,s11,a5
    800087c0:	000dc683          	lbu	a3,0(s11)
    800087c4:	00800793          	li	a5,8
    800087c8:	00700c93          	li	s9,7
    800087cc:	f8d403a3          	sb	a3,-121(s0)
    800087d0:	00075c63          	bgez	a4,800087e8 <__printf+0x410>
    800087d4:	f9040713          	addi	a4,s0,-112
    800087d8:	00f70733          	add	a4,a4,a5
    800087dc:	02d00693          	li	a3,45
    800087e0:	fed70823          	sb	a3,-16(a4)
    800087e4:	00078c93          	mv	s9,a5
    800087e8:	f8040793          	addi	a5,s0,-128
    800087ec:	01978cb3          	add	s9,a5,s9
    800087f0:	f7f40d13          	addi	s10,s0,-129
    800087f4:	000cc503          	lbu	a0,0(s9)
    800087f8:	fffc8c93          	addi	s9,s9,-1
    800087fc:	00000097          	auipc	ra,0x0
    80008800:	9f8080e7          	jalr	-1544(ra) # 800081f4 <consputc>
    80008804:	ff9d18e3          	bne	s10,s9,800087f4 <__printf+0x41c>
    80008808:	0100006f          	j	80008818 <__printf+0x440>
    8000880c:	00000097          	auipc	ra,0x0
    80008810:	9e8080e7          	jalr	-1560(ra) # 800081f4 <consputc>
    80008814:	000c8493          	mv	s1,s9
    80008818:	00094503          	lbu	a0,0(s2)
    8000881c:	c60510e3          	bnez	a0,8000847c <__printf+0xa4>
    80008820:	e40c0ee3          	beqz	s8,8000867c <__printf+0x2a4>
    80008824:	00005517          	auipc	a0,0x5
    80008828:	6bc50513          	addi	a0,a0,1724 # 8000dee0 <pr>
    8000882c:	00001097          	auipc	ra,0x1
    80008830:	94c080e7          	jalr	-1716(ra) # 80009178 <release>
    80008834:	e49ff06f          	j	8000867c <__printf+0x2a4>
    80008838:	f7843783          	ld	a5,-136(s0)
    8000883c:	03000513          	li	a0,48
    80008840:	01000d13          	li	s10,16
    80008844:	00878713          	addi	a4,a5,8
    80008848:	0007bc83          	ld	s9,0(a5)
    8000884c:	f6e43c23          	sd	a4,-136(s0)
    80008850:	00000097          	auipc	ra,0x0
    80008854:	9a4080e7          	jalr	-1628(ra) # 800081f4 <consputc>
    80008858:	07800513          	li	a0,120
    8000885c:	00000097          	auipc	ra,0x0
    80008860:	998080e7          	jalr	-1640(ra) # 800081f4 <consputc>
    80008864:	00002d97          	auipc	s11,0x2
    80008868:	084d8d93          	addi	s11,s11,132 # 8000a8e8 <digits>
    8000886c:	03ccd793          	srli	a5,s9,0x3c
    80008870:	00fd87b3          	add	a5,s11,a5
    80008874:	0007c503          	lbu	a0,0(a5)
    80008878:	fffd0d1b          	addiw	s10,s10,-1
    8000887c:	004c9c93          	slli	s9,s9,0x4
    80008880:	00000097          	auipc	ra,0x0
    80008884:	974080e7          	jalr	-1676(ra) # 800081f4 <consputc>
    80008888:	fe0d12e3          	bnez	s10,8000886c <__printf+0x494>
    8000888c:	f8dff06f          	j	80008818 <__printf+0x440>
    80008890:	f7843783          	ld	a5,-136(s0)
    80008894:	0007bc83          	ld	s9,0(a5)
    80008898:	00878793          	addi	a5,a5,8
    8000889c:	f6f43c23          	sd	a5,-136(s0)
    800088a0:	000c9a63          	bnez	s9,800088b4 <__printf+0x4dc>
    800088a4:	1080006f          	j	800089ac <__printf+0x5d4>
    800088a8:	001c8c93          	addi	s9,s9,1
    800088ac:	00000097          	auipc	ra,0x0
    800088b0:	948080e7          	jalr	-1720(ra) # 800081f4 <consputc>
    800088b4:	000cc503          	lbu	a0,0(s9)
    800088b8:	fe0518e3          	bnez	a0,800088a8 <__printf+0x4d0>
    800088bc:	f5dff06f          	j	80008818 <__printf+0x440>
    800088c0:	02500513          	li	a0,37
    800088c4:	00000097          	auipc	ra,0x0
    800088c8:	930080e7          	jalr	-1744(ra) # 800081f4 <consputc>
    800088cc:	000c8513          	mv	a0,s9
    800088d0:	00000097          	auipc	ra,0x0
    800088d4:	924080e7          	jalr	-1756(ra) # 800081f4 <consputc>
    800088d8:	f41ff06f          	j	80008818 <__printf+0x440>
    800088dc:	02500513          	li	a0,37
    800088e0:	00000097          	auipc	ra,0x0
    800088e4:	914080e7          	jalr	-1772(ra) # 800081f4 <consputc>
    800088e8:	f31ff06f          	j	80008818 <__printf+0x440>
    800088ec:	00030513          	mv	a0,t1
    800088f0:	00000097          	auipc	ra,0x0
    800088f4:	7bc080e7          	jalr	1980(ra) # 800090ac <acquire>
    800088f8:	b4dff06f          	j	80008444 <__printf+0x6c>
    800088fc:	40c0053b          	negw	a0,a2
    80008900:	00a00713          	li	a4,10
    80008904:	02e576bb          	remuw	a3,a0,a4
    80008908:	00002d97          	auipc	s11,0x2
    8000890c:	fe0d8d93          	addi	s11,s11,-32 # 8000a8e8 <digits>
    80008910:	ff700593          	li	a1,-9
    80008914:	02069693          	slli	a3,a3,0x20
    80008918:	0206d693          	srli	a3,a3,0x20
    8000891c:	00dd86b3          	add	a3,s11,a3
    80008920:	0006c683          	lbu	a3,0(a3)
    80008924:	02e557bb          	divuw	a5,a0,a4
    80008928:	f8d40023          	sb	a3,-128(s0)
    8000892c:	10b65e63          	bge	a2,a1,80008a48 <__printf+0x670>
    80008930:	06300593          	li	a1,99
    80008934:	02e7f6bb          	remuw	a3,a5,a4
    80008938:	02069693          	slli	a3,a3,0x20
    8000893c:	0206d693          	srli	a3,a3,0x20
    80008940:	00dd86b3          	add	a3,s11,a3
    80008944:	0006c683          	lbu	a3,0(a3)
    80008948:	02e7d73b          	divuw	a4,a5,a4
    8000894c:	00200793          	li	a5,2
    80008950:	f8d400a3          	sb	a3,-127(s0)
    80008954:	bca5ece3          	bltu	a1,a0,8000852c <__printf+0x154>
    80008958:	ce5ff06f          	j	8000863c <__printf+0x264>
    8000895c:	40e007bb          	negw	a5,a4
    80008960:	00002d97          	auipc	s11,0x2
    80008964:	f88d8d93          	addi	s11,s11,-120 # 8000a8e8 <digits>
    80008968:	00f7f693          	andi	a3,a5,15
    8000896c:	00dd86b3          	add	a3,s11,a3
    80008970:	0006c583          	lbu	a1,0(a3)
    80008974:	ff100613          	li	a2,-15
    80008978:	0047d69b          	srliw	a3,a5,0x4
    8000897c:	f8b40023          	sb	a1,-128(s0)
    80008980:	0047d59b          	srliw	a1,a5,0x4
    80008984:	0ac75e63          	bge	a4,a2,80008a40 <__printf+0x668>
    80008988:	00f6f693          	andi	a3,a3,15
    8000898c:	00dd86b3          	add	a3,s11,a3
    80008990:	0006c603          	lbu	a2,0(a3)
    80008994:	00f00693          	li	a3,15
    80008998:	0087d79b          	srliw	a5,a5,0x8
    8000899c:	f8c400a3          	sb	a2,-127(s0)
    800089a0:	d8b6e4e3          	bltu	a3,a1,80008728 <__printf+0x350>
    800089a4:	00200793          	li	a5,2
    800089a8:	e2dff06f          	j	800087d4 <__printf+0x3fc>
    800089ac:	00002c97          	auipc	s9,0x2
    800089b0:	f1cc8c93          	addi	s9,s9,-228 # 8000a8c8 <CONSOLE_STATUS+0x8b8>
    800089b4:	02800513          	li	a0,40
    800089b8:	ef1ff06f          	j	800088a8 <__printf+0x4d0>
    800089bc:	00700793          	li	a5,7
    800089c0:	00600c93          	li	s9,6
    800089c4:	e0dff06f          	j	800087d0 <__printf+0x3f8>
    800089c8:	00700793          	li	a5,7
    800089cc:	00600c93          	li	s9,6
    800089d0:	c69ff06f          	j	80008638 <__printf+0x260>
    800089d4:	00300793          	li	a5,3
    800089d8:	00200c93          	li	s9,2
    800089dc:	c5dff06f          	j	80008638 <__printf+0x260>
    800089e0:	00300793          	li	a5,3
    800089e4:	00200c93          	li	s9,2
    800089e8:	de9ff06f          	j	800087d0 <__printf+0x3f8>
    800089ec:	00400793          	li	a5,4
    800089f0:	00300c93          	li	s9,3
    800089f4:	dddff06f          	j	800087d0 <__printf+0x3f8>
    800089f8:	00400793          	li	a5,4
    800089fc:	00300c93          	li	s9,3
    80008a00:	c39ff06f          	j	80008638 <__printf+0x260>
    80008a04:	00500793          	li	a5,5
    80008a08:	00400c93          	li	s9,4
    80008a0c:	c2dff06f          	j	80008638 <__printf+0x260>
    80008a10:	00500793          	li	a5,5
    80008a14:	00400c93          	li	s9,4
    80008a18:	db9ff06f          	j	800087d0 <__printf+0x3f8>
    80008a1c:	00600793          	li	a5,6
    80008a20:	00500c93          	li	s9,5
    80008a24:	dadff06f          	j	800087d0 <__printf+0x3f8>
    80008a28:	00600793          	li	a5,6
    80008a2c:	00500c93          	li	s9,5
    80008a30:	c09ff06f          	j	80008638 <__printf+0x260>
    80008a34:	00800793          	li	a5,8
    80008a38:	00700c93          	li	s9,7
    80008a3c:	bfdff06f          	j	80008638 <__printf+0x260>
    80008a40:	00100793          	li	a5,1
    80008a44:	d91ff06f          	j	800087d4 <__printf+0x3fc>
    80008a48:	00100793          	li	a5,1
    80008a4c:	bf1ff06f          	j	8000863c <__printf+0x264>
    80008a50:	00900793          	li	a5,9
    80008a54:	00800c93          	li	s9,8
    80008a58:	be1ff06f          	j	80008638 <__printf+0x260>
    80008a5c:	00002517          	auipc	a0,0x2
    80008a60:	e7450513          	addi	a0,a0,-396 # 8000a8d0 <CONSOLE_STATUS+0x8c0>
    80008a64:	00000097          	auipc	ra,0x0
    80008a68:	918080e7          	jalr	-1768(ra) # 8000837c <panic>

0000000080008a6c <printfinit>:
    80008a6c:	fe010113          	addi	sp,sp,-32
    80008a70:	00813823          	sd	s0,16(sp)
    80008a74:	00913423          	sd	s1,8(sp)
    80008a78:	00113c23          	sd	ra,24(sp)
    80008a7c:	02010413          	addi	s0,sp,32
    80008a80:	00005497          	auipc	s1,0x5
    80008a84:	46048493          	addi	s1,s1,1120 # 8000dee0 <pr>
    80008a88:	00048513          	mv	a0,s1
    80008a8c:	00002597          	auipc	a1,0x2
    80008a90:	e5458593          	addi	a1,a1,-428 # 8000a8e0 <CONSOLE_STATUS+0x8d0>
    80008a94:	00000097          	auipc	ra,0x0
    80008a98:	5f4080e7          	jalr	1524(ra) # 80009088 <initlock>
    80008a9c:	01813083          	ld	ra,24(sp)
    80008aa0:	01013403          	ld	s0,16(sp)
    80008aa4:	0004ac23          	sw	zero,24(s1)
    80008aa8:	00813483          	ld	s1,8(sp)
    80008aac:	02010113          	addi	sp,sp,32
    80008ab0:	00008067          	ret

0000000080008ab4 <uartinit>:
    80008ab4:	ff010113          	addi	sp,sp,-16
    80008ab8:	00813423          	sd	s0,8(sp)
    80008abc:	01010413          	addi	s0,sp,16
    80008ac0:	100007b7          	lui	a5,0x10000
    80008ac4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008ac8:	f8000713          	li	a4,-128
    80008acc:	00e781a3          	sb	a4,3(a5)
    80008ad0:	00300713          	li	a4,3
    80008ad4:	00e78023          	sb	a4,0(a5)
    80008ad8:	000780a3          	sb	zero,1(a5)
    80008adc:	00e781a3          	sb	a4,3(a5)
    80008ae0:	00700693          	li	a3,7
    80008ae4:	00d78123          	sb	a3,2(a5)
    80008ae8:	00e780a3          	sb	a4,1(a5)
    80008aec:	00813403          	ld	s0,8(sp)
    80008af0:	01010113          	addi	sp,sp,16
    80008af4:	00008067          	ret

0000000080008af8 <uartputc>:
    80008af8:	00004797          	auipc	a5,0x4
    80008afc:	0c07a783          	lw	a5,192(a5) # 8000cbb8 <panicked>
    80008b00:	00078463          	beqz	a5,80008b08 <uartputc+0x10>
    80008b04:	0000006f          	j	80008b04 <uartputc+0xc>
    80008b08:	fd010113          	addi	sp,sp,-48
    80008b0c:	02813023          	sd	s0,32(sp)
    80008b10:	00913c23          	sd	s1,24(sp)
    80008b14:	01213823          	sd	s2,16(sp)
    80008b18:	01313423          	sd	s3,8(sp)
    80008b1c:	02113423          	sd	ra,40(sp)
    80008b20:	03010413          	addi	s0,sp,48
    80008b24:	00004917          	auipc	s2,0x4
    80008b28:	09c90913          	addi	s2,s2,156 # 8000cbc0 <uart_tx_r>
    80008b2c:	00093783          	ld	a5,0(s2)
    80008b30:	00004497          	auipc	s1,0x4
    80008b34:	09848493          	addi	s1,s1,152 # 8000cbc8 <uart_tx_w>
    80008b38:	0004b703          	ld	a4,0(s1)
    80008b3c:	02078693          	addi	a3,a5,32
    80008b40:	00050993          	mv	s3,a0
    80008b44:	02e69c63          	bne	a3,a4,80008b7c <uartputc+0x84>
    80008b48:	00001097          	auipc	ra,0x1
    80008b4c:	834080e7          	jalr	-1996(ra) # 8000937c <push_on>
    80008b50:	00093783          	ld	a5,0(s2)
    80008b54:	0004b703          	ld	a4,0(s1)
    80008b58:	02078793          	addi	a5,a5,32
    80008b5c:	00e79463          	bne	a5,a4,80008b64 <uartputc+0x6c>
    80008b60:	0000006f          	j	80008b60 <uartputc+0x68>
    80008b64:	00001097          	auipc	ra,0x1
    80008b68:	88c080e7          	jalr	-1908(ra) # 800093f0 <pop_on>
    80008b6c:	00093783          	ld	a5,0(s2)
    80008b70:	0004b703          	ld	a4,0(s1)
    80008b74:	02078693          	addi	a3,a5,32
    80008b78:	fce688e3          	beq	a3,a4,80008b48 <uartputc+0x50>
    80008b7c:	01f77693          	andi	a3,a4,31
    80008b80:	00005597          	auipc	a1,0x5
    80008b84:	38058593          	addi	a1,a1,896 # 8000df00 <uart_tx_buf>
    80008b88:	00d586b3          	add	a3,a1,a3
    80008b8c:	00170713          	addi	a4,a4,1
    80008b90:	01368023          	sb	s3,0(a3)
    80008b94:	00e4b023          	sd	a4,0(s1)
    80008b98:	10000637          	lui	a2,0x10000
    80008b9c:	02f71063          	bne	a4,a5,80008bbc <uartputc+0xc4>
    80008ba0:	0340006f          	j	80008bd4 <uartputc+0xdc>
    80008ba4:	00074703          	lbu	a4,0(a4)
    80008ba8:	00f93023          	sd	a5,0(s2)
    80008bac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008bb0:	00093783          	ld	a5,0(s2)
    80008bb4:	0004b703          	ld	a4,0(s1)
    80008bb8:	00f70e63          	beq	a4,a5,80008bd4 <uartputc+0xdc>
    80008bbc:	00564683          	lbu	a3,5(a2)
    80008bc0:	01f7f713          	andi	a4,a5,31
    80008bc4:	00e58733          	add	a4,a1,a4
    80008bc8:	0206f693          	andi	a3,a3,32
    80008bcc:	00178793          	addi	a5,a5,1
    80008bd0:	fc069ae3          	bnez	a3,80008ba4 <uartputc+0xac>
    80008bd4:	02813083          	ld	ra,40(sp)
    80008bd8:	02013403          	ld	s0,32(sp)
    80008bdc:	01813483          	ld	s1,24(sp)
    80008be0:	01013903          	ld	s2,16(sp)
    80008be4:	00813983          	ld	s3,8(sp)
    80008be8:	03010113          	addi	sp,sp,48
    80008bec:	00008067          	ret

0000000080008bf0 <uartputc_sync>:
    80008bf0:	ff010113          	addi	sp,sp,-16
    80008bf4:	00813423          	sd	s0,8(sp)
    80008bf8:	01010413          	addi	s0,sp,16
    80008bfc:	00004717          	auipc	a4,0x4
    80008c00:	fbc72703          	lw	a4,-68(a4) # 8000cbb8 <panicked>
    80008c04:	02071663          	bnez	a4,80008c30 <uartputc_sync+0x40>
    80008c08:	00050793          	mv	a5,a0
    80008c0c:	100006b7          	lui	a3,0x10000
    80008c10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008c14:	02077713          	andi	a4,a4,32
    80008c18:	fe070ce3          	beqz	a4,80008c10 <uartputc_sync+0x20>
    80008c1c:	0ff7f793          	andi	a5,a5,255
    80008c20:	00f68023          	sb	a5,0(a3)
    80008c24:	00813403          	ld	s0,8(sp)
    80008c28:	01010113          	addi	sp,sp,16
    80008c2c:	00008067          	ret
    80008c30:	0000006f          	j	80008c30 <uartputc_sync+0x40>

0000000080008c34 <uartstart>:
    80008c34:	ff010113          	addi	sp,sp,-16
    80008c38:	00813423          	sd	s0,8(sp)
    80008c3c:	01010413          	addi	s0,sp,16
    80008c40:	00004617          	auipc	a2,0x4
    80008c44:	f8060613          	addi	a2,a2,-128 # 8000cbc0 <uart_tx_r>
    80008c48:	00004517          	auipc	a0,0x4
    80008c4c:	f8050513          	addi	a0,a0,-128 # 8000cbc8 <uart_tx_w>
    80008c50:	00063783          	ld	a5,0(a2)
    80008c54:	00053703          	ld	a4,0(a0)
    80008c58:	04f70263          	beq	a4,a5,80008c9c <uartstart+0x68>
    80008c5c:	100005b7          	lui	a1,0x10000
    80008c60:	00005817          	auipc	a6,0x5
    80008c64:	2a080813          	addi	a6,a6,672 # 8000df00 <uart_tx_buf>
    80008c68:	01c0006f          	j	80008c84 <uartstart+0x50>
    80008c6c:	0006c703          	lbu	a4,0(a3)
    80008c70:	00f63023          	sd	a5,0(a2)
    80008c74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008c78:	00063783          	ld	a5,0(a2)
    80008c7c:	00053703          	ld	a4,0(a0)
    80008c80:	00f70e63          	beq	a4,a5,80008c9c <uartstart+0x68>
    80008c84:	01f7f713          	andi	a4,a5,31
    80008c88:	00e806b3          	add	a3,a6,a4
    80008c8c:	0055c703          	lbu	a4,5(a1)
    80008c90:	00178793          	addi	a5,a5,1
    80008c94:	02077713          	andi	a4,a4,32
    80008c98:	fc071ae3          	bnez	a4,80008c6c <uartstart+0x38>
    80008c9c:	00813403          	ld	s0,8(sp)
    80008ca0:	01010113          	addi	sp,sp,16
    80008ca4:	00008067          	ret

0000000080008ca8 <uartgetc>:
    80008ca8:	ff010113          	addi	sp,sp,-16
    80008cac:	00813423          	sd	s0,8(sp)
    80008cb0:	01010413          	addi	s0,sp,16
    80008cb4:	10000737          	lui	a4,0x10000
    80008cb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80008cbc:	0017f793          	andi	a5,a5,1
    80008cc0:	00078c63          	beqz	a5,80008cd8 <uartgetc+0x30>
    80008cc4:	00074503          	lbu	a0,0(a4)
    80008cc8:	0ff57513          	andi	a0,a0,255
    80008ccc:	00813403          	ld	s0,8(sp)
    80008cd0:	01010113          	addi	sp,sp,16
    80008cd4:	00008067          	ret
    80008cd8:	fff00513          	li	a0,-1
    80008cdc:	ff1ff06f          	j	80008ccc <uartgetc+0x24>

0000000080008ce0 <uartintr>:
    80008ce0:	100007b7          	lui	a5,0x10000
    80008ce4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008ce8:	0017f793          	andi	a5,a5,1
    80008cec:	0a078463          	beqz	a5,80008d94 <uartintr+0xb4>
    80008cf0:	fe010113          	addi	sp,sp,-32
    80008cf4:	00813823          	sd	s0,16(sp)
    80008cf8:	00913423          	sd	s1,8(sp)
    80008cfc:	00113c23          	sd	ra,24(sp)
    80008d00:	02010413          	addi	s0,sp,32
    80008d04:	100004b7          	lui	s1,0x10000
    80008d08:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80008d0c:	0ff57513          	andi	a0,a0,255
    80008d10:	fffff097          	auipc	ra,0xfffff
    80008d14:	534080e7          	jalr	1332(ra) # 80008244 <consoleintr>
    80008d18:	0054c783          	lbu	a5,5(s1)
    80008d1c:	0017f793          	andi	a5,a5,1
    80008d20:	fe0794e3          	bnez	a5,80008d08 <uartintr+0x28>
    80008d24:	00004617          	auipc	a2,0x4
    80008d28:	e9c60613          	addi	a2,a2,-356 # 8000cbc0 <uart_tx_r>
    80008d2c:	00004517          	auipc	a0,0x4
    80008d30:	e9c50513          	addi	a0,a0,-356 # 8000cbc8 <uart_tx_w>
    80008d34:	00063783          	ld	a5,0(a2)
    80008d38:	00053703          	ld	a4,0(a0)
    80008d3c:	04f70263          	beq	a4,a5,80008d80 <uartintr+0xa0>
    80008d40:	100005b7          	lui	a1,0x10000
    80008d44:	00005817          	auipc	a6,0x5
    80008d48:	1bc80813          	addi	a6,a6,444 # 8000df00 <uart_tx_buf>
    80008d4c:	01c0006f          	j	80008d68 <uartintr+0x88>
    80008d50:	0006c703          	lbu	a4,0(a3)
    80008d54:	00f63023          	sd	a5,0(a2)
    80008d58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008d5c:	00063783          	ld	a5,0(a2)
    80008d60:	00053703          	ld	a4,0(a0)
    80008d64:	00f70e63          	beq	a4,a5,80008d80 <uartintr+0xa0>
    80008d68:	01f7f713          	andi	a4,a5,31
    80008d6c:	00e806b3          	add	a3,a6,a4
    80008d70:	0055c703          	lbu	a4,5(a1)
    80008d74:	00178793          	addi	a5,a5,1
    80008d78:	02077713          	andi	a4,a4,32
    80008d7c:	fc071ae3          	bnez	a4,80008d50 <uartintr+0x70>
    80008d80:	01813083          	ld	ra,24(sp)
    80008d84:	01013403          	ld	s0,16(sp)
    80008d88:	00813483          	ld	s1,8(sp)
    80008d8c:	02010113          	addi	sp,sp,32
    80008d90:	00008067          	ret
    80008d94:	00004617          	auipc	a2,0x4
    80008d98:	e2c60613          	addi	a2,a2,-468 # 8000cbc0 <uart_tx_r>
    80008d9c:	00004517          	auipc	a0,0x4
    80008da0:	e2c50513          	addi	a0,a0,-468 # 8000cbc8 <uart_tx_w>
    80008da4:	00063783          	ld	a5,0(a2)
    80008da8:	00053703          	ld	a4,0(a0)
    80008dac:	04f70263          	beq	a4,a5,80008df0 <uartintr+0x110>
    80008db0:	100005b7          	lui	a1,0x10000
    80008db4:	00005817          	auipc	a6,0x5
    80008db8:	14c80813          	addi	a6,a6,332 # 8000df00 <uart_tx_buf>
    80008dbc:	01c0006f          	j	80008dd8 <uartintr+0xf8>
    80008dc0:	0006c703          	lbu	a4,0(a3)
    80008dc4:	00f63023          	sd	a5,0(a2)
    80008dc8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008dcc:	00063783          	ld	a5,0(a2)
    80008dd0:	00053703          	ld	a4,0(a0)
    80008dd4:	02f70063          	beq	a4,a5,80008df4 <uartintr+0x114>
    80008dd8:	01f7f713          	andi	a4,a5,31
    80008ddc:	00e806b3          	add	a3,a6,a4
    80008de0:	0055c703          	lbu	a4,5(a1)
    80008de4:	00178793          	addi	a5,a5,1
    80008de8:	02077713          	andi	a4,a4,32
    80008dec:	fc071ae3          	bnez	a4,80008dc0 <uartintr+0xe0>
    80008df0:	00008067          	ret
    80008df4:	00008067          	ret

0000000080008df8 <kinit>:
    80008df8:	fc010113          	addi	sp,sp,-64
    80008dfc:	02913423          	sd	s1,40(sp)
    80008e00:	fffff7b7          	lui	a5,0xfffff
    80008e04:	00006497          	auipc	s1,0x6
    80008e08:	11b48493          	addi	s1,s1,283 # 8000ef1f <end+0xfff>
    80008e0c:	02813823          	sd	s0,48(sp)
    80008e10:	01313c23          	sd	s3,24(sp)
    80008e14:	00f4f4b3          	and	s1,s1,a5
    80008e18:	02113c23          	sd	ra,56(sp)
    80008e1c:	03213023          	sd	s2,32(sp)
    80008e20:	01413823          	sd	s4,16(sp)
    80008e24:	01513423          	sd	s5,8(sp)
    80008e28:	04010413          	addi	s0,sp,64
    80008e2c:	000017b7          	lui	a5,0x1
    80008e30:	01100993          	li	s3,17
    80008e34:	00f487b3          	add	a5,s1,a5
    80008e38:	01b99993          	slli	s3,s3,0x1b
    80008e3c:	06f9e063          	bltu	s3,a5,80008e9c <kinit+0xa4>
    80008e40:	00005a97          	auipc	s5,0x5
    80008e44:	0e0a8a93          	addi	s5,s5,224 # 8000df20 <end>
    80008e48:	0754ec63          	bltu	s1,s5,80008ec0 <kinit+0xc8>
    80008e4c:	0734fa63          	bgeu	s1,s3,80008ec0 <kinit+0xc8>
    80008e50:	00088a37          	lui	s4,0x88
    80008e54:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008e58:	00004917          	auipc	s2,0x4
    80008e5c:	d7890913          	addi	s2,s2,-648 # 8000cbd0 <kmem>
    80008e60:	00ca1a13          	slli	s4,s4,0xc
    80008e64:	0140006f          	j	80008e78 <kinit+0x80>
    80008e68:	000017b7          	lui	a5,0x1
    80008e6c:	00f484b3          	add	s1,s1,a5
    80008e70:	0554e863          	bltu	s1,s5,80008ec0 <kinit+0xc8>
    80008e74:	0534f663          	bgeu	s1,s3,80008ec0 <kinit+0xc8>
    80008e78:	00001637          	lui	a2,0x1
    80008e7c:	00100593          	li	a1,1
    80008e80:	00048513          	mv	a0,s1
    80008e84:	00000097          	auipc	ra,0x0
    80008e88:	5e4080e7          	jalr	1508(ra) # 80009468 <__memset>
    80008e8c:	00093783          	ld	a5,0(s2)
    80008e90:	00f4b023          	sd	a5,0(s1)
    80008e94:	00993023          	sd	s1,0(s2)
    80008e98:	fd4498e3          	bne	s1,s4,80008e68 <kinit+0x70>
    80008e9c:	03813083          	ld	ra,56(sp)
    80008ea0:	03013403          	ld	s0,48(sp)
    80008ea4:	02813483          	ld	s1,40(sp)
    80008ea8:	02013903          	ld	s2,32(sp)
    80008eac:	01813983          	ld	s3,24(sp)
    80008eb0:	01013a03          	ld	s4,16(sp)
    80008eb4:	00813a83          	ld	s5,8(sp)
    80008eb8:	04010113          	addi	sp,sp,64
    80008ebc:	00008067          	ret
    80008ec0:	00002517          	auipc	a0,0x2
    80008ec4:	a4050513          	addi	a0,a0,-1472 # 8000a900 <digits+0x18>
    80008ec8:	fffff097          	auipc	ra,0xfffff
    80008ecc:	4b4080e7          	jalr	1204(ra) # 8000837c <panic>

0000000080008ed0 <freerange>:
    80008ed0:	fc010113          	addi	sp,sp,-64
    80008ed4:	000017b7          	lui	a5,0x1
    80008ed8:	02913423          	sd	s1,40(sp)
    80008edc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008ee0:	009504b3          	add	s1,a0,s1
    80008ee4:	fffff537          	lui	a0,0xfffff
    80008ee8:	02813823          	sd	s0,48(sp)
    80008eec:	02113c23          	sd	ra,56(sp)
    80008ef0:	03213023          	sd	s2,32(sp)
    80008ef4:	01313c23          	sd	s3,24(sp)
    80008ef8:	01413823          	sd	s4,16(sp)
    80008efc:	01513423          	sd	s5,8(sp)
    80008f00:	01613023          	sd	s6,0(sp)
    80008f04:	04010413          	addi	s0,sp,64
    80008f08:	00a4f4b3          	and	s1,s1,a0
    80008f0c:	00f487b3          	add	a5,s1,a5
    80008f10:	06f5e463          	bltu	a1,a5,80008f78 <freerange+0xa8>
    80008f14:	00005a97          	auipc	s5,0x5
    80008f18:	00ca8a93          	addi	s5,s5,12 # 8000df20 <end>
    80008f1c:	0954e263          	bltu	s1,s5,80008fa0 <freerange+0xd0>
    80008f20:	01100993          	li	s3,17
    80008f24:	01b99993          	slli	s3,s3,0x1b
    80008f28:	0734fc63          	bgeu	s1,s3,80008fa0 <freerange+0xd0>
    80008f2c:	00058a13          	mv	s4,a1
    80008f30:	00004917          	auipc	s2,0x4
    80008f34:	ca090913          	addi	s2,s2,-864 # 8000cbd0 <kmem>
    80008f38:	00002b37          	lui	s6,0x2
    80008f3c:	0140006f          	j	80008f50 <freerange+0x80>
    80008f40:	000017b7          	lui	a5,0x1
    80008f44:	00f484b3          	add	s1,s1,a5
    80008f48:	0554ec63          	bltu	s1,s5,80008fa0 <freerange+0xd0>
    80008f4c:	0534fa63          	bgeu	s1,s3,80008fa0 <freerange+0xd0>
    80008f50:	00001637          	lui	a2,0x1
    80008f54:	00100593          	li	a1,1
    80008f58:	00048513          	mv	a0,s1
    80008f5c:	00000097          	auipc	ra,0x0
    80008f60:	50c080e7          	jalr	1292(ra) # 80009468 <__memset>
    80008f64:	00093703          	ld	a4,0(s2)
    80008f68:	016487b3          	add	a5,s1,s6
    80008f6c:	00e4b023          	sd	a4,0(s1)
    80008f70:	00993023          	sd	s1,0(s2)
    80008f74:	fcfa76e3          	bgeu	s4,a5,80008f40 <freerange+0x70>
    80008f78:	03813083          	ld	ra,56(sp)
    80008f7c:	03013403          	ld	s0,48(sp)
    80008f80:	02813483          	ld	s1,40(sp)
    80008f84:	02013903          	ld	s2,32(sp)
    80008f88:	01813983          	ld	s3,24(sp)
    80008f8c:	01013a03          	ld	s4,16(sp)
    80008f90:	00813a83          	ld	s5,8(sp)
    80008f94:	00013b03          	ld	s6,0(sp)
    80008f98:	04010113          	addi	sp,sp,64
    80008f9c:	00008067          	ret
    80008fa0:	00002517          	auipc	a0,0x2
    80008fa4:	96050513          	addi	a0,a0,-1696 # 8000a900 <digits+0x18>
    80008fa8:	fffff097          	auipc	ra,0xfffff
    80008fac:	3d4080e7          	jalr	980(ra) # 8000837c <panic>

0000000080008fb0 <kfree>:
    80008fb0:	fe010113          	addi	sp,sp,-32
    80008fb4:	00813823          	sd	s0,16(sp)
    80008fb8:	00113c23          	sd	ra,24(sp)
    80008fbc:	00913423          	sd	s1,8(sp)
    80008fc0:	02010413          	addi	s0,sp,32
    80008fc4:	03451793          	slli	a5,a0,0x34
    80008fc8:	04079c63          	bnez	a5,80009020 <kfree+0x70>
    80008fcc:	00005797          	auipc	a5,0x5
    80008fd0:	f5478793          	addi	a5,a5,-172 # 8000df20 <end>
    80008fd4:	00050493          	mv	s1,a0
    80008fd8:	04f56463          	bltu	a0,a5,80009020 <kfree+0x70>
    80008fdc:	01100793          	li	a5,17
    80008fe0:	01b79793          	slli	a5,a5,0x1b
    80008fe4:	02f57e63          	bgeu	a0,a5,80009020 <kfree+0x70>
    80008fe8:	00001637          	lui	a2,0x1
    80008fec:	00100593          	li	a1,1
    80008ff0:	00000097          	auipc	ra,0x0
    80008ff4:	478080e7          	jalr	1144(ra) # 80009468 <__memset>
    80008ff8:	00004797          	auipc	a5,0x4
    80008ffc:	bd878793          	addi	a5,a5,-1064 # 8000cbd0 <kmem>
    80009000:	0007b703          	ld	a4,0(a5)
    80009004:	01813083          	ld	ra,24(sp)
    80009008:	01013403          	ld	s0,16(sp)
    8000900c:	00e4b023          	sd	a4,0(s1)
    80009010:	0097b023          	sd	s1,0(a5)
    80009014:	00813483          	ld	s1,8(sp)
    80009018:	02010113          	addi	sp,sp,32
    8000901c:	00008067          	ret
    80009020:	00002517          	auipc	a0,0x2
    80009024:	8e050513          	addi	a0,a0,-1824 # 8000a900 <digits+0x18>
    80009028:	fffff097          	auipc	ra,0xfffff
    8000902c:	354080e7          	jalr	852(ra) # 8000837c <panic>

0000000080009030 <kalloc>:
    80009030:	fe010113          	addi	sp,sp,-32
    80009034:	00813823          	sd	s0,16(sp)
    80009038:	00913423          	sd	s1,8(sp)
    8000903c:	00113c23          	sd	ra,24(sp)
    80009040:	02010413          	addi	s0,sp,32
    80009044:	00004797          	auipc	a5,0x4
    80009048:	b8c78793          	addi	a5,a5,-1140 # 8000cbd0 <kmem>
    8000904c:	0007b483          	ld	s1,0(a5)
    80009050:	02048063          	beqz	s1,80009070 <kalloc+0x40>
    80009054:	0004b703          	ld	a4,0(s1)
    80009058:	00001637          	lui	a2,0x1
    8000905c:	00500593          	li	a1,5
    80009060:	00048513          	mv	a0,s1
    80009064:	00e7b023          	sd	a4,0(a5)
    80009068:	00000097          	auipc	ra,0x0
    8000906c:	400080e7          	jalr	1024(ra) # 80009468 <__memset>
    80009070:	01813083          	ld	ra,24(sp)
    80009074:	01013403          	ld	s0,16(sp)
    80009078:	00048513          	mv	a0,s1
    8000907c:	00813483          	ld	s1,8(sp)
    80009080:	02010113          	addi	sp,sp,32
    80009084:	00008067          	ret

0000000080009088 <initlock>:
    80009088:	ff010113          	addi	sp,sp,-16
    8000908c:	00813423          	sd	s0,8(sp)
    80009090:	01010413          	addi	s0,sp,16
    80009094:	00813403          	ld	s0,8(sp)
    80009098:	00b53423          	sd	a1,8(a0)
    8000909c:	00052023          	sw	zero,0(a0)
    800090a0:	00053823          	sd	zero,16(a0)
    800090a4:	01010113          	addi	sp,sp,16
    800090a8:	00008067          	ret

00000000800090ac <acquire>:
    800090ac:	fe010113          	addi	sp,sp,-32
    800090b0:	00813823          	sd	s0,16(sp)
    800090b4:	00913423          	sd	s1,8(sp)
    800090b8:	00113c23          	sd	ra,24(sp)
    800090bc:	01213023          	sd	s2,0(sp)
    800090c0:	02010413          	addi	s0,sp,32
    800090c4:	00050493          	mv	s1,a0
    800090c8:	10002973          	csrr	s2,sstatus
    800090cc:	100027f3          	csrr	a5,sstatus
    800090d0:	ffd7f793          	andi	a5,a5,-3
    800090d4:	10079073          	csrw	sstatus,a5
    800090d8:	fffff097          	auipc	ra,0xfffff
    800090dc:	8e4080e7          	jalr	-1820(ra) # 800079bc <mycpu>
    800090e0:	07852783          	lw	a5,120(a0)
    800090e4:	06078e63          	beqz	a5,80009160 <acquire+0xb4>
    800090e8:	fffff097          	auipc	ra,0xfffff
    800090ec:	8d4080e7          	jalr	-1836(ra) # 800079bc <mycpu>
    800090f0:	07852783          	lw	a5,120(a0)
    800090f4:	0004a703          	lw	a4,0(s1)
    800090f8:	0017879b          	addiw	a5,a5,1
    800090fc:	06f52c23          	sw	a5,120(a0)
    80009100:	04071063          	bnez	a4,80009140 <acquire+0x94>
    80009104:	00100713          	li	a4,1
    80009108:	00070793          	mv	a5,a4
    8000910c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80009110:	0007879b          	sext.w	a5,a5
    80009114:	fe079ae3          	bnez	a5,80009108 <acquire+0x5c>
    80009118:	0ff0000f          	fence
    8000911c:	fffff097          	auipc	ra,0xfffff
    80009120:	8a0080e7          	jalr	-1888(ra) # 800079bc <mycpu>
    80009124:	01813083          	ld	ra,24(sp)
    80009128:	01013403          	ld	s0,16(sp)
    8000912c:	00a4b823          	sd	a0,16(s1)
    80009130:	00013903          	ld	s2,0(sp)
    80009134:	00813483          	ld	s1,8(sp)
    80009138:	02010113          	addi	sp,sp,32
    8000913c:	00008067          	ret
    80009140:	0104b903          	ld	s2,16(s1)
    80009144:	fffff097          	auipc	ra,0xfffff
    80009148:	878080e7          	jalr	-1928(ra) # 800079bc <mycpu>
    8000914c:	faa91ce3          	bne	s2,a0,80009104 <acquire+0x58>
    80009150:	00001517          	auipc	a0,0x1
    80009154:	7b850513          	addi	a0,a0,1976 # 8000a908 <digits+0x20>
    80009158:	fffff097          	auipc	ra,0xfffff
    8000915c:	224080e7          	jalr	548(ra) # 8000837c <panic>
    80009160:	00195913          	srli	s2,s2,0x1
    80009164:	fffff097          	auipc	ra,0xfffff
    80009168:	858080e7          	jalr	-1960(ra) # 800079bc <mycpu>
    8000916c:	00197913          	andi	s2,s2,1
    80009170:	07252e23          	sw	s2,124(a0)
    80009174:	f75ff06f          	j	800090e8 <acquire+0x3c>

0000000080009178 <release>:
    80009178:	fe010113          	addi	sp,sp,-32
    8000917c:	00813823          	sd	s0,16(sp)
    80009180:	00113c23          	sd	ra,24(sp)
    80009184:	00913423          	sd	s1,8(sp)
    80009188:	01213023          	sd	s2,0(sp)
    8000918c:	02010413          	addi	s0,sp,32
    80009190:	00052783          	lw	a5,0(a0)
    80009194:	00079a63          	bnez	a5,800091a8 <release+0x30>
    80009198:	00001517          	auipc	a0,0x1
    8000919c:	77850513          	addi	a0,a0,1912 # 8000a910 <digits+0x28>
    800091a0:	fffff097          	auipc	ra,0xfffff
    800091a4:	1dc080e7          	jalr	476(ra) # 8000837c <panic>
    800091a8:	01053903          	ld	s2,16(a0)
    800091ac:	00050493          	mv	s1,a0
    800091b0:	fffff097          	auipc	ra,0xfffff
    800091b4:	80c080e7          	jalr	-2036(ra) # 800079bc <mycpu>
    800091b8:	fea910e3          	bne	s2,a0,80009198 <release+0x20>
    800091bc:	0004b823          	sd	zero,16(s1)
    800091c0:	0ff0000f          	fence
    800091c4:	0f50000f          	fence	iorw,ow
    800091c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800091cc:	ffffe097          	auipc	ra,0xffffe
    800091d0:	7f0080e7          	jalr	2032(ra) # 800079bc <mycpu>
    800091d4:	100027f3          	csrr	a5,sstatus
    800091d8:	0027f793          	andi	a5,a5,2
    800091dc:	04079a63          	bnez	a5,80009230 <release+0xb8>
    800091e0:	07852783          	lw	a5,120(a0)
    800091e4:	02f05e63          	blez	a5,80009220 <release+0xa8>
    800091e8:	fff7871b          	addiw	a4,a5,-1
    800091ec:	06e52c23          	sw	a4,120(a0)
    800091f0:	00071c63          	bnez	a4,80009208 <release+0x90>
    800091f4:	07c52783          	lw	a5,124(a0)
    800091f8:	00078863          	beqz	a5,80009208 <release+0x90>
    800091fc:	100027f3          	csrr	a5,sstatus
    80009200:	0027e793          	ori	a5,a5,2
    80009204:	10079073          	csrw	sstatus,a5
    80009208:	01813083          	ld	ra,24(sp)
    8000920c:	01013403          	ld	s0,16(sp)
    80009210:	00813483          	ld	s1,8(sp)
    80009214:	00013903          	ld	s2,0(sp)
    80009218:	02010113          	addi	sp,sp,32
    8000921c:	00008067          	ret
    80009220:	00001517          	auipc	a0,0x1
    80009224:	71050513          	addi	a0,a0,1808 # 8000a930 <digits+0x48>
    80009228:	fffff097          	auipc	ra,0xfffff
    8000922c:	154080e7          	jalr	340(ra) # 8000837c <panic>
    80009230:	00001517          	auipc	a0,0x1
    80009234:	6e850513          	addi	a0,a0,1768 # 8000a918 <digits+0x30>
    80009238:	fffff097          	auipc	ra,0xfffff
    8000923c:	144080e7          	jalr	324(ra) # 8000837c <panic>

0000000080009240 <holding>:
    80009240:	00052783          	lw	a5,0(a0)
    80009244:	00079663          	bnez	a5,80009250 <holding+0x10>
    80009248:	00000513          	li	a0,0
    8000924c:	00008067          	ret
    80009250:	fe010113          	addi	sp,sp,-32
    80009254:	00813823          	sd	s0,16(sp)
    80009258:	00913423          	sd	s1,8(sp)
    8000925c:	00113c23          	sd	ra,24(sp)
    80009260:	02010413          	addi	s0,sp,32
    80009264:	01053483          	ld	s1,16(a0)
    80009268:	ffffe097          	auipc	ra,0xffffe
    8000926c:	754080e7          	jalr	1876(ra) # 800079bc <mycpu>
    80009270:	01813083          	ld	ra,24(sp)
    80009274:	01013403          	ld	s0,16(sp)
    80009278:	40a48533          	sub	a0,s1,a0
    8000927c:	00153513          	seqz	a0,a0
    80009280:	00813483          	ld	s1,8(sp)
    80009284:	02010113          	addi	sp,sp,32
    80009288:	00008067          	ret

000000008000928c <push_off>:
    8000928c:	fe010113          	addi	sp,sp,-32
    80009290:	00813823          	sd	s0,16(sp)
    80009294:	00113c23          	sd	ra,24(sp)
    80009298:	00913423          	sd	s1,8(sp)
    8000929c:	02010413          	addi	s0,sp,32
    800092a0:	100024f3          	csrr	s1,sstatus
    800092a4:	100027f3          	csrr	a5,sstatus
    800092a8:	ffd7f793          	andi	a5,a5,-3
    800092ac:	10079073          	csrw	sstatus,a5
    800092b0:	ffffe097          	auipc	ra,0xffffe
    800092b4:	70c080e7          	jalr	1804(ra) # 800079bc <mycpu>
    800092b8:	07852783          	lw	a5,120(a0)
    800092bc:	02078663          	beqz	a5,800092e8 <push_off+0x5c>
    800092c0:	ffffe097          	auipc	ra,0xffffe
    800092c4:	6fc080e7          	jalr	1788(ra) # 800079bc <mycpu>
    800092c8:	07852783          	lw	a5,120(a0)
    800092cc:	01813083          	ld	ra,24(sp)
    800092d0:	01013403          	ld	s0,16(sp)
    800092d4:	0017879b          	addiw	a5,a5,1
    800092d8:	06f52c23          	sw	a5,120(a0)
    800092dc:	00813483          	ld	s1,8(sp)
    800092e0:	02010113          	addi	sp,sp,32
    800092e4:	00008067          	ret
    800092e8:	0014d493          	srli	s1,s1,0x1
    800092ec:	ffffe097          	auipc	ra,0xffffe
    800092f0:	6d0080e7          	jalr	1744(ra) # 800079bc <mycpu>
    800092f4:	0014f493          	andi	s1,s1,1
    800092f8:	06952e23          	sw	s1,124(a0)
    800092fc:	fc5ff06f          	j	800092c0 <push_off+0x34>

0000000080009300 <pop_off>:
    80009300:	ff010113          	addi	sp,sp,-16
    80009304:	00813023          	sd	s0,0(sp)
    80009308:	00113423          	sd	ra,8(sp)
    8000930c:	01010413          	addi	s0,sp,16
    80009310:	ffffe097          	auipc	ra,0xffffe
    80009314:	6ac080e7          	jalr	1708(ra) # 800079bc <mycpu>
    80009318:	100027f3          	csrr	a5,sstatus
    8000931c:	0027f793          	andi	a5,a5,2
    80009320:	04079663          	bnez	a5,8000936c <pop_off+0x6c>
    80009324:	07852783          	lw	a5,120(a0)
    80009328:	02f05a63          	blez	a5,8000935c <pop_off+0x5c>
    8000932c:	fff7871b          	addiw	a4,a5,-1
    80009330:	06e52c23          	sw	a4,120(a0)
    80009334:	00071c63          	bnez	a4,8000934c <pop_off+0x4c>
    80009338:	07c52783          	lw	a5,124(a0)
    8000933c:	00078863          	beqz	a5,8000934c <pop_off+0x4c>
    80009340:	100027f3          	csrr	a5,sstatus
    80009344:	0027e793          	ori	a5,a5,2
    80009348:	10079073          	csrw	sstatus,a5
    8000934c:	00813083          	ld	ra,8(sp)
    80009350:	00013403          	ld	s0,0(sp)
    80009354:	01010113          	addi	sp,sp,16
    80009358:	00008067          	ret
    8000935c:	00001517          	auipc	a0,0x1
    80009360:	5d450513          	addi	a0,a0,1492 # 8000a930 <digits+0x48>
    80009364:	fffff097          	auipc	ra,0xfffff
    80009368:	018080e7          	jalr	24(ra) # 8000837c <panic>
    8000936c:	00001517          	auipc	a0,0x1
    80009370:	5ac50513          	addi	a0,a0,1452 # 8000a918 <digits+0x30>
    80009374:	fffff097          	auipc	ra,0xfffff
    80009378:	008080e7          	jalr	8(ra) # 8000837c <panic>

000000008000937c <push_on>:
    8000937c:	fe010113          	addi	sp,sp,-32
    80009380:	00813823          	sd	s0,16(sp)
    80009384:	00113c23          	sd	ra,24(sp)
    80009388:	00913423          	sd	s1,8(sp)
    8000938c:	02010413          	addi	s0,sp,32
    80009390:	100024f3          	csrr	s1,sstatus
    80009394:	100027f3          	csrr	a5,sstatus
    80009398:	0027e793          	ori	a5,a5,2
    8000939c:	10079073          	csrw	sstatus,a5
    800093a0:	ffffe097          	auipc	ra,0xffffe
    800093a4:	61c080e7          	jalr	1564(ra) # 800079bc <mycpu>
    800093a8:	07852783          	lw	a5,120(a0)
    800093ac:	02078663          	beqz	a5,800093d8 <push_on+0x5c>
    800093b0:	ffffe097          	auipc	ra,0xffffe
    800093b4:	60c080e7          	jalr	1548(ra) # 800079bc <mycpu>
    800093b8:	07852783          	lw	a5,120(a0)
    800093bc:	01813083          	ld	ra,24(sp)
    800093c0:	01013403          	ld	s0,16(sp)
    800093c4:	0017879b          	addiw	a5,a5,1
    800093c8:	06f52c23          	sw	a5,120(a0)
    800093cc:	00813483          	ld	s1,8(sp)
    800093d0:	02010113          	addi	sp,sp,32
    800093d4:	00008067          	ret
    800093d8:	0014d493          	srli	s1,s1,0x1
    800093dc:	ffffe097          	auipc	ra,0xffffe
    800093e0:	5e0080e7          	jalr	1504(ra) # 800079bc <mycpu>
    800093e4:	0014f493          	andi	s1,s1,1
    800093e8:	06952e23          	sw	s1,124(a0)
    800093ec:	fc5ff06f          	j	800093b0 <push_on+0x34>

00000000800093f0 <pop_on>:
    800093f0:	ff010113          	addi	sp,sp,-16
    800093f4:	00813023          	sd	s0,0(sp)
    800093f8:	00113423          	sd	ra,8(sp)
    800093fc:	01010413          	addi	s0,sp,16
    80009400:	ffffe097          	auipc	ra,0xffffe
    80009404:	5bc080e7          	jalr	1468(ra) # 800079bc <mycpu>
    80009408:	100027f3          	csrr	a5,sstatus
    8000940c:	0027f793          	andi	a5,a5,2
    80009410:	04078463          	beqz	a5,80009458 <pop_on+0x68>
    80009414:	07852783          	lw	a5,120(a0)
    80009418:	02f05863          	blez	a5,80009448 <pop_on+0x58>
    8000941c:	fff7879b          	addiw	a5,a5,-1
    80009420:	06f52c23          	sw	a5,120(a0)
    80009424:	07853783          	ld	a5,120(a0)
    80009428:	00079863          	bnez	a5,80009438 <pop_on+0x48>
    8000942c:	100027f3          	csrr	a5,sstatus
    80009430:	ffd7f793          	andi	a5,a5,-3
    80009434:	10079073          	csrw	sstatus,a5
    80009438:	00813083          	ld	ra,8(sp)
    8000943c:	00013403          	ld	s0,0(sp)
    80009440:	01010113          	addi	sp,sp,16
    80009444:	00008067          	ret
    80009448:	00001517          	auipc	a0,0x1
    8000944c:	51050513          	addi	a0,a0,1296 # 8000a958 <digits+0x70>
    80009450:	fffff097          	auipc	ra,0xfffff
    80009454:	f2c080e7          	jalr	-212(ra) # 8000837c <panic>
    80009458:	00001517          	auipc	a0,0x1
    8000945c:	4e050513          	addi	a0,a0,1248 # 8000a938 <digits+0x50>
    80009460:	fffff097          	auipc	ra,0xfffff
    80009464:	f1c080e7          	jalr	-228(ra) # 8000837c <panic>

0000000080009468 <__memset>:
    80009468:	ff010113          	addi	sp,sp,-16
    8000946c:	00813423          	sd	s0,8(sp)
    80009470:	01010413          	addi	s0,sp,16
    80009474:	1a060e63          	beqz	a2,80009630 <__memset+0x1c8>
    80009478:	40a007b3          	neg	a5,a0
    8000947c:	0077f793          	andi	a5,a5,7
    80009480:	00778693          	addi	a3,a5,7
    80009484:	00b00813          	li	a6,11
    80009488:	0ff5f593          	andi	a1,a1,255
    8000948c:	fff6071b          	addiw	a4,a2,-1
    80009490:	1b06e663          	bltu	a3,a6,8000963c <__memset+0x1d4>
    80009494:	1cd76463          	bltu	a4,a3,8000965c <__memset+0x1f4>
    80009498:	1a078e63          	beqz	a5,80009654 <__memset+0x1ec>
    8000949c:	00b50023          	sb	a1,0(a0)
    800094a0:	00100713          	li	a4,1
    800094a4:	1ae78463          	beq	a5,a4,8000964c <__memset+0x1e4>
    800094a8:	00b500a3          	sb	a1,1(a0)
    800094ac:	00200713          	li	a4,2
    800094b0:	1ae78a63          	beq	a5,a4,80009664 <__memset+0x1fc>
    800094b4:	00b50123          	sb	a1,2(a0)
    800094b8:	00300713          	li	a4,3
    800094bc:	18e78463          	beq	a5,a4,80009644 <__memset+0x1dc>
    800094c0:	00b501a3          	sb	a1,3(a0)
    800094c4:	00400713          	li	a4,4
    800094c8:	1ae78263          	beq	a5,a4,8000966c <__memset+0x204>
    800094cc:	00b50223          	sb	a1,4(a0)
    800094d0:	00500713          	li	a4,5
    800094d4:	1ae78063          	beq	a5,a4,80009674 <__memset+0x20c>
    800094d8:	00b502a3          	sb	a1,5(a0)
    800094dc:	00700713          	li	a4,7
    800094e0:	18e79e63          	bne	a5,a4,8000967c <__memset+0x214>
    800094e4:	00b50323          	sb	a1,6(a0)
    800094e8:	00700e93          	li	t4,7
    800094ec:	00859713          	slli	a4,a1,0x8
    800094f0:	00e5e733          	or	a4,a1,a4
    800094f4:	01059e13          	slli	t3,a1,0x10
    800094f8:	01c76e33          	or	t3,a4,t3
    800094fc:	01859313          	slli	t1,a1,0x18
    80009500:	006e6333          	or	t1,t3,t1
    80009504:	02059893          	slli	a7,a1,0x20
    80009508:	40f60e3b          	subw	t3,a2,a5
    8000950c:	011368b3          	or	a7,t1,a7
    80009510:	02859813          	slli	a6,a1,0x28
    80009514:	0108e833          	or	a6,a7,a6
    80009518:	03059693          	slli	a3,a1,0x30
    8000951c:	003e589b          	srliw	a7,t3,0x3
    80009520:	00d866b3          	or	a3,a6,a3
    80009524:	03859713          	slli	a4,a1,0x38
    80009528:	00389813          	slli	a6,a7,0x3
    8000952c:	00f507b3          	add	a5,a0,a5
    80009530:	00e6e733          	or	a4,a3,a4
    80009534:	000e089b          	sext.w	a7,t3
    80009538:	00f806b3          	add	a3,a6,a5
    8000953c:	00e7b023          	sd	a4,0(a5)
    80009540:	00878793          	addi	a5,a5,8
    80009544:	fed79ce3          	bne	a5,a3,8000953c <__memset+0xd4>
    80009548:	ff8e7793          	andi	a5,t3,-8
    8000954c:	0007871b          	sext.w	a4,a5
    80009550:	01d787bb          	addw	a5,a5,t4
    80009554:	0ce88e63          	beq	a7,a4,80009630 <__memset+0x1c8>
    80009558:	00f50733          	add	a4,a0,a5
    8000955c:	00b70023          	sb	a1,0(a4)
    80009560:	0017871b          	addiw	a4,a5,1
    80009564:	0cc77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009568:	00e50733          	add	a4,a0,a4
    8000956c:	00b70023          	sb	a1,0(a4)
    80009570:	0027871b          	addiw	a4,a5,2
    80009574:	0ac77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009578:	00e50733          	add	a4,a0,a4
    8000957c:	00b70023          	sb	a1,0(a4)
    80009580:	0037871b          	addiw	a4,a5,3
    80009584:	0ac77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009588:	00e50733          	add	a4,a0,a4
    8000958c:	00b70023          	sb	a1,0(a4)
    80009590:	0047871b          	addiw	a4,a5,4
    80009594:	08c77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009598:	00e50733          	add	a4,a0,a4
    8000959c:	00b70023          	sb	a1,0(a4)
    800095a0:	0057871b          	addiw	a4,a5,5
    800095a4:	08c77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095a8:	00e50733          	add	a4,a0,a4
    800095ac:	00b70023          	sb	a1,0(a4)
    800095b0:	0067871b          	addiw	a4,a5,6
    800095b4:	06c77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095b8:	00e50733          	add	a4,a0,a4
    800095bc:	00b70023          	sb	a1,0(a4)
    800095c0:	0077871b          	addiw	a4,a5,7
    800095c4:	06c77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095c8:	00e50733          	add	a4,a0,a4
    800095cc:	00b70023          	sb	a1,0(a4)
    800095d0:	0087871b          	addiw	a4,a5,8
    800095d4:	04c77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095d8:	00e50733          	add	a4,a0,a4
    800095dc:	00b70023          	sb	a1,0(a4)
    800095e0:	0097871b          	addiw	a4,a5,9
    800095e4:	04c77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095e8:	00e50733          	add	a4,a0,a4
    800095ec:	00b70023          	sb	a1,0(a4)
    800095f0:	00a7871b          	addiw	a4,a5,10
    800095f4:	02c77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    800095f8:	00e50733          	add	a4,a0,a4
    800095fc:	00b70023          	sb	a1,0(a4)
    80009600:	00b7871b          	addiw	a4,a5,11
    80009604:	02c77663          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009608:	00e50733          	add	a4,a0,a4
    8000960c:	00b70023          	sb	a1,0(a4)
    80009610:	00c7871b          	addiw	a4,a5,12
    80009614:	00c77e63          	bgeu	a4,a2,80009630 <__memset+0x1c8>
    80009618:	00e50733          	add	a4,a0,a4
    8000961c:	00b70023          	sb	a1,0(a4)
    80009620:	00d7879b          	addiw	a5,a5,13
    80009624:	00c7f663          	bgeu	a5,a2,80009630 <__memset+0x1c8>
    80009628:	00f507b3          	add	a5,a0,a5
    8000962c:	00b78023          	sb	a1,0(a5)
    80009630:	00813403          	ld	s0,8(sp)
    80009634:	01010113          	addi	sp,sp,16
    80009638:	00008067          	ret
    8000963c:	00b00693          	li	a3,11
    80009640:	e55ff06f          	j	80009494 <__memset+0x2c>
    80009644:	00300e93          	li	t4,3
    80009648:	ea5ff06f          	j	800094ec <__memset+0x84>
    8000964c:	00100e93          	li	t4,1
    80009650:	e9dff06f          	j	800094ec <__memset+0x84>
    80009654:	00000e93          	li	t4,0
    80009658:	e95ff06f          	j	800094ec <__memset+0x84>
    8000965c:	00000793          	li	a5,0
    80009660:	ef9ff06f          	j	80009558 <__memset+0xf0>
    80009664:	00200e93          	li	t4,2
    80009668:	e85ff06f          	j	800094ec <__memset+0x84>
    8000966c:	00400e93          	li	t4,4
    80009670:	e7dff06f          	j	800094ec <__memset+0x84>
    80009674:	00500e93          	li	t4,5
    80009678:	e75ff06f          	j	800094ec <__memset+0x84>
    8000967c:	00600e93          	li	t4,6
    80009680:	e6dff06f          	j	800094ec <__memset+0x84>

0000000080009684 <__memmove>:
    80009684:	ff010113          	addi	sp,sp,-16
    80009688:	00813423          	sd	s0,8(sp)
    8000968c:	01010413          	addi	s0,sp,16
    80009690:	0e060863          	beqz	a2,80009780 <__memmove+0xfc>
    80009694:	fff6069b          	addiw	a3,a2,-1
    80009698:	0006881b          	sext.w	a6,a3
    8000969c:	0ea5e863          	bltu	a1,a0,8000978c <__memmove+0x108>
    800096a0:	00758713          	addi	a4,a1,7
    800096a4:	00a5e7b3          	or	a5,a1,a0
    800096a8:	40a70733          	sub	a4,a4,a0
    800096ac:	0077f793          	andi	a5,a5,7
    800096b0:	00f73713          	sltiu	a4,a4,15
    800096b4:	00174713          	xori	a4,a4,1
    800096b8:	0017b793          	seqz	a5,a5
    800096bc:	00e7f7b3          	and	a5,a5,a4
    800096c0:	10078863          	beqz	a5,800097d0 <__memmove+0x14c>
    800096c4:	00900793          	li	a5,9
    800096c8:	1107f463          	bgeu	a5,a6,800097d0 <__memmove+0x14c>
    800096cc:	0036581b          	srliw	a6,a2,0x3
    800096d0:	fff8081b          	addiw	a6,a6,-1
    800096d4:	02081813          	slli	a6,a6,0x20
    800096d8:	01d85893          	srli	a7,a6,0x1d
    800096dc:	00858813          	addi	a6,a1,8
    800096e0:	00058793          	mv	a5,a1
    800096e4:	00050713          	mv	a4,a0
    800096e8:	01088833          	add	a6,a7,a6
    800096ec:	0007b883          	ld	a7,0(a5)
    800096f0:	00878793          	addi	a5,a5,8
    800096f4:	00870713          	addi	a4,a4,8
    800096f8:	ff173c23          	sd	a7,-8(a4)
    800096fc:	ff0798e3          	bne	a5,a6,800096ec <__memmove+0x68>
    80009700:	ff867713          	andi	a4,a2,-8
    80009704:	02071793          	slli	a5,a4,0x20
    80009708:	0207d793          	srli	a5,a5,0x20
    8000970c:	00f585b3          	add	a1,a1,a5
    80009710:	40e686bb          	subw	a3,a3,a4
    80009714:	00f507b3          	add	a5,a0,a5
    80009718:	06e60463          	beq	a2,a4,80009780 <__memmove+0xfc>
    8000971c:	0005c703          	lbu	a4,0(a1)
    80009720:	00e78023          	sb	a4,0(a5)
    80009724:	04068e63          	beqz	a3,80009780 <__memmove+0xfc>
    80009728:	0015c603          	lbu	a2,1(a1)
    8000972c:	00100713          	li	a4,1
    80009730:	00c780a3          	sb	a2,1(a5)
    80009734:	04e68663          	beq	a3,a4,80009780 <__memmove+0xfc>
    80009738:	0025c603          	lbu	a2,2(a1)
    8000973c:	00200713          	li	a4,2
    80009740:	00c78123          	sb	a2,2(a5)
    80009744:	02e68e63          	beq	a3,a4,80009780 <__memmove+0xfc>
    80009748:	0035c603          	lbu	a2,3(a1)
    8000974c:	00300713          	li	a4,3
    80009750:	00c781a3          	sb	a2,3(a5)
    80009754:	02e68663          	beq	a3,a4,80009780 <__memmove+0xfc>
    80009758:	0045c603          	lbu	a2,4(a1)
    8000975c:	00400713          	li	a4,4
    80009760:	00c78223          	sb	a2,4(a5)
    80009764:	00e68e63          	beq	a3,a4,80009780 <__memmove+0xfc>
    80009768:	0055c603          	lbu	a2,5(a1)
    8000976c:	00500713          	li	a4,5
    80009770:	00c782a3          	sb	a2,5(a5)
    80009774:	00e68663          	beq	a3,a4,80009780 <__memmove+0xfc>
    80009778:	0065c703          	lbu	a4,6(a1)
    8000977c:	00e78323          	sb	a4,6(a5)
    80009780:	00813403          	ld	s0,8(sp)
    80009784:	01010113          	addi	sp,sp,16
    80009788:	00008067          	ret
    8000978c:	02061713          	slli	a4,a2,0x20
    80009790:	02075713          	srli	a4,a4,0x20
    80009794:	00e587b3          	add	a5,a1,a4
    80009798:	f0f574e3          	bgeu	a0,a5,800096a0 <__memmove+0x1c>
    8000979c:	02069613          	slli	a2,a3,0x20
    800097a0:	02065613          	srli	a2,a2,0x20
    800097a4:	fff64613          	not	a2,a2
    800097a8:	00e50733          	add	a4,a0,a4
    800097ac:	00c78633          	add	a2,a5,a2
    800097b0:	fff7c683          	lbu	a3,-1(a5)
    800097b4:	fff78793          	addi	a5,a5,-1
    800097b8:	fff70713          	addi	a4,a4,-1
    800097bc:	00d70023          	sb	a3,0(a4)
    800097c0:	fec798e3          	bne	a5,a2,800097b0 <__memmove+0x12c>
    800097c4:	00813403          	ld	s0,8(sp)
    800097c8:	01010113          	addi	sp,sp,16
    800097cc:	00008067          	ret
    800097d0:	02069713          	slli	a4,a3,0x20
    800097d4:	02075713          	srli	a4,a4,0x20
    800097d8:	00170713          	addi	a4,a4,1
    800097dc:	00e50733          	add	a4,a0,a4
    800097e0:	00050793          	mv	a5,a0
    800097e4:	0005c683          	lbu	a3,0(a1)
    800097e8:	00178793          	addi	a5,a5,1
    800097ec:	00158593          	addi	a1,a1,1
    800097f0:	fed78fa3          	sb	a3,-1(a5)
    800097f4:	fee798e3          	bne	a5,a4,800097e4 <__memmove+0x160>
    800097f8:	f89ff06f          	j	80009780 <__memmove+0xfc>

00000000800097fc <__putc>:
    800097fc:	fe010113          	addi	sp,sp,-32
    80009800:	00813823          	sd	s0,16(sp)
    80009804:	00113c23          	sd	ra,24(sp)
    80009808:	02010413          	addi	s0,sp,32
    8000980c:	00050793          	mv	a5,a0
    80009810:	fef40593          	addi	a1,s0,-17
    80009814:	00100613          	li	a2,1
    80009818:	00000513          	li	a0,0
    8000981c:	fef407a3          	sb	a5,-17(s0)
    80009820:	fffff097          	auipc	ra,0xfffff
    80009824:	b3c080e7          	jalr	-1220(ra) # 8000835c <console_write>
    80009828:	01813083          	ld	ra,24(sp)
    8000982c:	01013403          	ld	s0,16(sp)
    80009830:	02010113          	addi	sp,sp,32
    80009834:	00008067          	ret

0000000080009838 <__getc>:
    80009838:	fe010113          	addi	sp,sp,-32
    8000983c:	00813823          	sd	s0,16(sp)
    80009840:	00113c23          	sd	ra,24(sp)
    80009844:	02010413          	addi	s0,sp,32
    80009848:	fe840593          	addi	a1,s0,-24
    8000984c:	00100613          	li	a2,1
    80009850:	00000513          	li	a0,0
    80009854:	fffff097          	auipc	ra,0xfffff
    80009858:	ae8080e7          	jalr	-1304(ra) # 8000833c <console_read>
    8000985c:	fe844503          	lbu	a0,-24(s0)
    80009860:	01813083          	ld	ra,24(sp)
    80009864:	01013403          	ld	s0,16(sp)
    80009868:	02010113          	addi	sp,sp,32
    8000986c:	00008067          	ret

0000000080009870 <console_handler>:
    80009870:	fe010113          	addi	sp,sp,-32
    80009874:	00813823          	sd	s0,16(sp)
    80009878:	00113c23          	sd	ra,24(sp)
    8000987c:	00913423          	sd	s1,8(sp)
    80009880:	02010413          	addi	s0,sp,32
    80009884:	14202773          	csrr	a4,scause
    80009888:	100027f3          	csrr	a5,sstatus
    8000988c:	0027f793          	andi	a5,a5,2
    80009890:	06079e63          	bnez	a5,8000990c <console_handler+0x9c>
    80009894:	00074c63          	bltz	a4,800098ac <console_handler+0x3c>
    80009898:	01813083          	ld	ra,24(sp)
    8000989c:	01013403          	ld	s0,16(sp)
    800098a0:	00813483          	ld	s1,8(sp)
    800098a4:	02010113          	addi	sp,sp,32
    800098a8:	00008067          	ret
    800098ac:	0ff77713          	andi	a4,a4,255
    800098b0:	00900793          	li	a5,9
    800098b4:	fef712e3          	bne	a4,a5,80009898 <console_handler+0x28>
    800098b8:	ffffe097          	auipc	ra,0xffffe
    800098bc:	6dc080e7          	jalr	1756(ra) # 80007f94 <plic_claim>
    800098c0:	00a00793          	li	a5,10
    800098c4:	00050493          	mv	s1,a0
    800098c8:	02f50c63          	beq	a0,a5,80009900 <console_handler+0x90>
    800098cc:	fc0506e3          	beqz	a0,80009898 <console_handler+0x28>
    800098d0:	00050593          	mv	a1,a0
    800098d4:	00001517          	auipc	a0,0x1
    800098d8:	f8c50513          	addi	a0,a0,-116 # 8000a860 <CONSOLE_STATUS+0x850>
    800098dc:	fffff097          	auipc	ra,0xfffff
    800098e0:	afc080e7          	jalr	-1284(ra) # 800083d8 <__printf>
    800098e4:	01013403          	ld	s0,16(sp)
    800098e8:	01813083          	ld	ra,24(sp)
    800098ec:	00048513          	mv	a0,s1
    800098f0:	00813483          	ld	s1,8(sp)
    800098f4:	02010113          	addi	sp,sp,32
    800098f8:	ffffe317          	auipc	t1,0xffffe
    800098fc:	6d430067          	jr	1748(t1) # 80007fcc <plic_complete>
    80009900:	fffff097          	auipc	ra,0xfffff
    80009904:	3e0080e7          	jalr	992(ra) # 80008ce0 <uartintr>
    80009908:	fddff06f          	j	800098e4 <console_handler+0x74>
    8000990c:	00001517          	auipc	a0,0x1
    80009910:	05450513          	addi	a0,a0,84 # 8000a960 <digits+0x78>
    80009914:	fffff097          	auipc	ra,0xfffff
    80009918:	a68080e7          	jalr	-1432(ra) # 8000837c <panic>
	...
