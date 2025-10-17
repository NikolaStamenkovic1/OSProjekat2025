//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_SLEEP_LIST_H
#define PROJECT_BASE_SLEEP_LIST_H

#include "MemoryAllocator.h"
#include "tcb.h"
#include "../lib/console.h"

class Sleep_list
{
private:
    struct Elem
    {
        TCB *data;
        Elem *next;
        Elem *prev;
        time_t time;

        void* operator new(size_t size)
       {
           return MemoryAllocator::mem_alloc(size); // alocira u broju blokova
       }
        void operator delete(void* ptr)
        {
            MemoryAllocator::mem_free(ptr);
        }

        Elem(TCB *data, Elem *next, Elem *prev, time_t time) : data(data), next(next), prev(prev), time(time) {}
    };

    Elem *curr, *head, *tail;

public:
    Sleep_list() : curr(0), head(0), tail(0) {}

    Sleep_list(const Sleep_list &) = delete;

    Sleep_list &operator=(const Sleep_list &) = delete;

    void add(TCB* data, time_t time)//subtract time properly
    {

        time_t time_test = time;
        if(head == 0)
        {
            Elem *elem = new Elem(data, 0, 0, time);
            head = elem;
            if (!tail) { tail = head; }
            return;
        } else if( head->time > time ) {
            Elem *elem = new Elem(data, head, 0, time);
            head->prev = elem;
            head->time -= time;
            head = elem;
            return;
        } else {
            curr = head;
            while(curr && ( curr->time <= time_test) ) {
                time_test -= curr->time;
                curr = curr->next;
            }

            if(curr){
                Elem *elem = new Elem(data, curr, curr->prev, time_test);
                if(curr->prev) curr->prev->next = elem;
                curr->prev = elem;
                curr->time -= time_test;
                return;
            }else{
                Elem *elem = new Elem(data, 0, tail, time_test);
                tail->next = elem;
                tail = elem;
                return;
            }
        }
    }

    TCB *removeFirst()
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        TCB *ret = elem->data;
        delete elem;
        return ret;
    }

    TCB *peekFirst()
    {
        if (!head) { return 0; }
        return head->data;
    }

    friend class Sleeper;

};

#endif //PROJECT_BASE_SLEEP_LIST_H