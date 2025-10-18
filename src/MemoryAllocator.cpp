//
// Created by os on 8/10/25.
//

#include "../h/MemoryAllocator.h"
mem_header* MemoryAllocator::free_mem_head = nullptr;
mem_header* MemoryAllocator::used_mem_head = nullptr;

void* MemoryAllocator::mem_alloc(size_t size) {
    if(size <= 0) return nullptr;
    size_t new_size;
    if(size%MEM_BLOCK_SIZE != 0){
        // given the size, check if poravnat sa memblock. ako manji, uvecaj do mem block, u suprotnosti povecaj ga za mem block iznad
       	if((uint64)size < MEM_BLOCK_SIZE) new_size = size + (MEM_BLOCK_SIZE - size);
		else
        {
            new_size = (size - (size%MEM_BLOCK_SIZE)) + MEM_BLOCK_SIZE;
        }
    }else{
        new_size = size;
    }
	for(auto curr = free_mem_head; curr != nullptr; curr = curr->next){
		//check if each memory block ulancan u listu je veci, ili jednak po velicini koliko treba
        if((uint64)curr->size > (uint64)new_size )
		{
            //return the address that curr is pointing to, but detach its next and prev pointers so it cant jump
            //if it has a prev and next, reattach those so that they point to each other instead of curr
            //create a next and prev if those are nu
			//adjust free and used mem heads
			mem_header* new_free = (mem_header*) ( ( (uint64) curr )  + sizeof(mem_header) + new_size);
            mem_header* new_used = (mem_header*)curr;
			//if no prev and next
			if(curr->prev)
 			{
				curr->prev->next = new_free;
			}
			else
			{
				free_mem_head = new_free;
			 }

			if(curr->next)curr->next->prev = new_free;

			new_free->prev = curr->prev;
			new_free->next = curr->next;
			new_free->size = curr->size - new_size - sizeof(mem_header);
            //iterate through used until you find the previous one and link it to this
            auto used = used_mem_head;
			if(used_mem_head != nullptr)
			{
            	for(; ( (uint64)used < (uint64)curr ) && used->next; used = used->next){}
			}
			if( (uint64)used < (uint64)new_used || used == nullptr)
			{
				new_used->prev = used;
				if(used)
				{
					new_used->next = used->next;
					if(used->next)used->next->prev = new_used;
					used->next = new_used;
                    new_used->prev = used;//DUPLICATE
				}
            	else
				{
					if(used_mem_head != nullptr) new_used->next = used_mem_head;
					else new_used->next = nullptr;
					used_mem_head = new_used;
					new_used->prev = nullptr;//DUPLICATE
				}
			}else if ( (uint64)used > (uint64)new_used )
			{
				if(used->prev)
				{
					used->prev->next = new_used;
					new_used->prev = used->prev;
				}
				else
                {
                    used_mem_head = new_used;
                    new_used->prev = nullptr;
                }
				used->prev = new_used;
				new_used->next = used;
			}
			new_used->size = new_size;

            return (void*)( (uint64)curr + sizeof(mem_header) );
		}else if((uint64)curr->size == (uint64)new_size )
		{
			//if exact samee size, only need to close the curr mem block pointing to
			// reshuffle used mem head here, and free mem

			if(curr->prev) curr->prev->next = curr->next;
			if(curr->next)
			{
				curr->next->prev = curr->prev;
				if(curr->prev == nullptr) free_mem_head = curr->next;
			}
			curr->next = curr->prev = nullptr;
            if( ( (uint64)curr + sizeof(mem_header) + (uint64)new_size >= (uint64)HEAP_END_ADDR ) && free_mem_head == curr) free_mem_head = nullptr;

            mem_header* new_used = (mem_header*)curr;

            //iterate through used until you find the previous one and link it to this
            auto used = used_mem_head;
			if(used_mem_head != nullptr)
			{
            	for(; ( (uint64)used < (uint64)curr ) && used->next; used = used->next){}
			}
			if( (uint64)used < (uint64)new_used || used == nullptr)
			{
				new_used->prev = used;
				if(used)
				{
					new_used->next = used->next;
					if(used->next)used->next->prev = new_used;
					used->next = new_used;
                    new_used->prev = used;
				}
            	else
				{
					if(used_mem_head != nullptr) new_used->next = used_mem_head;
					else new_used->next = nullptr;
					used_mem_head = new_used;
					new_used->prev = nullptr;
				}
			}else if ( (uint64)used > (uint64)new_used)
			{
				if(used->prev)
				{
		 			used->prev->next = new_used;
					new_used->prev = used->prev;
				}
				else
                {
                    used_mem_head = new_used;
                    new_used->prev = nullptr;
                }
				used->prev = new_used;
				new_used->next = used;
			}
			//new_used->size = new_size; uneeded here since they are exactly the same
            return (void*)( (uint64)curr + sizeof(mem_header) );
        }
    }
    return nullptr;
}


int MemoryAllocator::mem_free(void* ptr) {
	//check if pointer is not a the right initial location
    //iterate through used until you find pointer, and get its size
    //iterate through free (And add its size to it) until either two things:
    //1. the result you get matches the start of the pointer - in that case, join the two by increasing the size of the
    //free and restructuring used. Also make sure to check if the next connects to the freed memory, and join that too
    //2. The next is the only free memory, in that case make the used the new free memory, restructure used, and join
    //it with the ahead one if need be

    if(ptr == nullptr || (uint64)ptr < (uint64)HEAP_START_ADDR || (uint64)ptr > (uint64)HEAP_END_ADDR) return -1;
    if(used_mem_head == nullptr) return -2;
    //replace ptrs
    mem_header* ptr1 = (mem_header*)((uint64)ptr - sizeof(mem_header)); //shouldnt -sizeof(header), ptrs already start from there (WRONG!!!!)
    int used_size = ptr1->size;

    auto free = free_mem_head;
    for(; free != nullptr && ( (uint64)free < (uint64)ptr1 ); free = free->next) // find a free that exists before the ptr and see if it directly connects
	{
        if( ( (uint64)free + sizeof(mem_header) + (uint64)free->size ) == (uint64)ptr1) //directly connects behind
		{
            if(ptr1->prev != nullptr)
			{
				ptr1->prev->next = ptr1->next;
			}
            if(ptr1->next != nullptr)
			{
				ptr1->next->prev = ptr1->prev;
			}
			if(ptr1->prev == nullptr && ptr1->next == nullptr && used_mem_head == ptr1) used_mem_head = nullptr;
            else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
            else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
            ptr1->next = ptr1->prev = nullptr;


            free->size += used_size + sizeof(mem_header);

            if( ( (uint64)free + sizeof(mem_header) + (uint64)free->size ) == (uint64)free->next )
			{
                free->size += free->next->size + sizeof(mem_header);
				mem_header* temp = free->next;
                if(free->next->next != nullptr) free->next->next->prev = free;
                if(free->next->next != nullptr) free->next = free->next->next;
				else free->next = nullptr;
                temp->prev = temp->next = nullptr;
            }
            return 0;
        }
    }
    if(free != nullptr)
	{
          //free exists so there is a free space, but it is after ptr
          // check if next can be added to the end of it, if not just make a new free block
          if( ( (uint64)ptr1 + sizeof(mem_header) + used_size ) == (uint64)free) // check if ptr directly connects to a free --- used size instead of ptr1->size here
		  {
	            if(ptr1->prev != nullptr)
				{
					ptr1->prev->next = ptr1->next;
				}
	            if(ptr1->next != nullptr)
				{
					ptr1->next->prev = ptr1->prev;
				}
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
	            ptr1->next = ptr1->prev = nullptr;

	            ptr1->prev = free->prev;
	            ptr1->next = free->next;
	            ptr1->size += ( free->size + sizeof(mem_header) );

	            if(free->prev != nullptr)free->prev->next = ptr1;
	            if(free->next != nullptr)free->next->prev = ptr1;
                free->next = free->prev = nullptr;

				// move free head here - check if ANY instance of free behind our used memory, and if not, then set free mem head here
				if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;

                return 0;
          }else //ptr doesnt connect to back of free, and free doesnt connect to back of ptr, so ptr becomes its own free block
		  {
	            if(ptr1->prev != nullptr)
				{
				 	ptr1->prev->next = ptr1->next;
				}
	            if(ptr1->next != nullptr)
				{
					ptr1->next->prev = ptr1->prev;
				}
				if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
                else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
                else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
	            ptr1->next = ptr1->prev = nullptr;

	            ptr1->prev = free->prev;
	            if(free->prev != nullptr) free->prev->next = ptr1;
	            ptr1->next = free;
	            free->prev = ptr1;

				// move free head here - check if ANY instance of free behind our used memory, and if not, then set free mem head here
		        if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;

	            return 0;
        }
    }else{ // free reached end of list and was still smaller than the used head
        //make new free block at the end here
        if(ptr1->prev != nullptr)
		{
			ptr1->prev->next = ptr1->next;
		}
        if(ptr1->next != nullptr)
		{
			ptr1->next->prev = ptr1->prev;
		}
		if(ptr1->prev == nullptr && ptr1->next == nullptr && ptr1 == used_mem_head) used_mem_head = nullptr;
        else if(ptr1 == used_mem_head && ptr1->next != nullptr) used_mem_head = ptr1->next;
        else if(ptr1 == used_mem_head && ptr1->prev != nullptr) used_mem_head = ptr1->prev;
        ptr1->next = ptr1->prev = nullptr;

        if(free_mem_head != nullptr)
        {
            auto free = free_mem_head;
            while(free->next != nullptr){ free = free->next; }
            free->next = ptr1;
            ptr1->prev = free;
            ptr1->next = nullptr;
        }
        else
        {
            free_mem_head = ptr1;
        }
		// move free head here - check if ANY instance of free behind our used memory, and if not, then set free mem head here
		if((uint64)free_mem_head > (uint64)ptr1) free_mem_head = ptr1;

        return 0;
    }

}

size_t MemoryAllocator::mem_get_free_space()
{
	size_t free_space = 0;
	mem_header* curr = free_mem_head;
	while(curr != nullptr)
	{
		free_space += curr->size;
		curr = curr->next;
	}
	return free_space;
}
size_t MemoryAllocator::mem_get_largest_free_block()
{
	size_t largest_free_block = 0;
	mem_header* curr = free_mem_head;
	while(curr != nullptr)
	{
		if(curr->size > largest_free_block) largest_free_block = curr->size;
		curr = curr->next;
	}
	return largest_free_block;
}