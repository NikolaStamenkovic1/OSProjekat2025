//
// Created by os on 9/15/25.
//

#ifndef PROJECT_BASE_SLEEP_LIST_H
#define PROJECT_BASE_SLEEP_LIST_H

#include "MemoryAllocator.h"
#include "tcb.h"

class Sleep_list // close to a normal list but uses tcb and tracks time
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
           return MemoryAllocator::mem_alloc(size);
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

    void add(TCB* data, time_t time)
    {
        time_t time_test = time;
        if(head == 0) //first, check if list is empty, and add appropriately
        {
            Elem *elem = new Elem(data, 0, 0, time);
            head = elem;
            if (!tail) { tail = head; }
            return;
        } else if( head->time > time ) { //if list isnt empty, but the head's time is longer than what we are given
            Elem *elem = new Elem(data, head, 0, time); //put new head in front and subtract previous head's time
            head->prev = elem;
            head->time -= time;
            head = elem;
            return;
        } else { //else, somewhere in the middle or end of the list
            curr = head;
            while(curr && ( curr->time <= time_test) ) { //iterate through list subtracting time until we get to the point where current time is
                time_test -= curr->time; //bigger than the time given (subtracted), or at end of list
                curr = curr->next;
            }

            if(curr){ //if not at the end of the list, slot the element before the curr iterated and link in properly, and subtract currs time
                Elem *elem = new Elem(data, curr, curr->prev, time_test);
                if(curr->prev) curr->prev->next = elem;
                curr->prev = elem;
                curr->time -= time_test;
                return;
            }else{ //else, put that bad boy at the end of the list
                Elem *elem = new Elem(data, 0, tail, time_test);
                tail->next = elem;
                tail = elem;
                return;
            }
        }
    }

    TCB *removeFirst() //the rest of these 2 functions funkcionisu kao u normaljnoj listi
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