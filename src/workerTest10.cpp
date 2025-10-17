//
// Created by os on 10/16/25.
//

#include "../h/syscall_c.h"
#include "printing.hpp"

static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

static void workerBodyA(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }

            thread_dispatch();
            //printString("Tsuji\n");
        }
    }
    printString("A finished!\n");
    finishedA = true;
}

static void workerBodyB(void* arg) {
    for (uint64 i = 0; i < 16; i++) {
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
            //printString("Anjin\n");
        }
    }
    printString("B finished!\n");
    finishedB = true;
    thread_dispatch();
}

static void workerBodyC(void* arg) {
    uint8 i = 0;
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    }

    printString("C: dispatch\n");
    __asm__ ("li t1, 7");
    thread_dispatch();

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("C: t1="); printInt(t1); printString("\n");

    uint64 result = fibonacci(12);
    printString("C: fibonaci="); printInt(result); printString("\n");

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    }

    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    uint8 i = 10;
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    }

    printString("D: dispatch\n");
    __asm__ ("li t1, 5");
    thread_dispatch();

    uint64 result = fibonacci(16);
    printString("D: fibonaci="); printInt(result); printString("\n");

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    }

    printString("D finished!\n");
    finishedD = true;
    thread_dispatch();
}
static volatile bool finishedE = false;
static volatile bool finishedF = false;
static volatile bool finishedG = false;
static volatile bool finishedH = false;

static void workerBodyE(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("E: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }

            thread_dispatch();
            //printString("Tsuji\n");
        }
    }
    printString("E finished!\n");
    finishedE = true;
}

static void workerBodyF(void* arg) {
    for (uint64 i = 0; i < 16; i++) {
        printString("F: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
            //printString("Anjin\n");
        }
    }
    printString("F finished!\n");
    finishedF = true;
    thread_dispatch();
}

static void workerBodyG(void* arg) {
    uint8 i = 0;
    for (; i < 3; i++) {
        printString("G: i="); printInt(i); printString("\n");
    }

    printString("G: dispatch\n");
    __asm__ ("li t1, 7");
    thread_dispatch();

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("G: t1="); printInt(t1); printString("\n");

    uint64 result = fibonacci(12);
    printString("G: fibonaci="); printInt(result); printString("\n");

    for (; i < 6; i++) {
        printString("G: i="); printInt(i); printString("\n");
    }

    printString("G finished!\n");
    finishedG = true;
    thread_dispatch();
}

static void workerBodyH(void* arg) {
    uint8 i = 10;
    for (; i < 13; i++) {
        printString("H: i="); printInt(i); printString("\n");
    }

    printString("H: dispatch\n");
    __asm__ ("li t1, 5");
    thread_dispatch();

    uint64 result = fibonacci(16);
    printString("H: fibonaci="); printInt(result); printString("\n");

    for (; i < 16; i++) {
        printString("H: i="); printInt(i); printString("\n");
    }

    printString("H finished!\n");
    finishedH = true;
    thread_dispatch();
}
static volatile bool finishedI = false;
static volatile bool finishedJ = false;



static void workerBodyI(void* arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("I: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }

            thread_dispatch();
            //printString("Tsuji\n");
        }
    }
    printString("I finished!\n");
    finishedI = true;
}

static void workerBodyJ(void* arg) {
    for (uint64 i = 0; i < 16; i++) {
        printString("J: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
            //printString("Anjin\n");
        }
    }
    printString("J finished!\n");
    finishedJ = true;
    thread_dispatch();
}

void workerTest10() {
    thread_t threads[10];
    thread_create(&threads[0], workerBodyA, nullptr);
    printString("ThreadA created\n");

    thread_create(&threads[1], workerBodyB, nullptr);
    printString("ThreadB created\n");

    thread_create(&threads[2], workerBodyC, nullptr);
    printString("ThreadC created\n");

    thread_create(&threads[3], workerBodyD, nullptr);
    printString("ThreadD created\n");

    thread_create(&threads[4], workerBodyE, nullptr);
    printString("ThreadE created\n");

    thread_create(&threads[5], workerBodyF, nullptr);
    printString("ThreadF created\n");

    thread_create(&threads[6], workerBodyG, nullptr);
    printString("ThreadG created\n");

    thread_create(&threads[7], workerBodyH, nullptr);
    printString("ThreadH created\n");

    thread_create(&threads[8], workerBodyI, nullptr);
    printString("ThreadI created\n");

    thread_create(&threads[9], workerBodyJ, nullptr);
    printString("ThreadJ created\n");

    while (!(finishedA && finishedB && finishedC && finishedD && finishedE && finishedF && finishedG && finishedH && finishedI && finishedJ ) ) {
        //printString("Thread Dispatched CAPITEST\n");s
        thread_dispatch();
    }

}

