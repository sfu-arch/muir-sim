CACHE_SIZE = 1024 # bytes
CACHE_BLOCK_SIZE = 64
PE_COUNT = 4
DATA_SIZE = 8 # bytes
VECOTR_COUNT = 7

BYTES_PER_ITER = DATA_SIZE * VECOTR_COUNT
TASKS_PER_ITER = CACHE_SIZE // BYTES_PER_ITER


if __name__ == '__main__':
    file = open('trace.csv', 'r')
    tasks = 0
    task_loads = []
    index = 0
    vector_index = 0
    collectors = {}
    tasks_list = []
    task_stores = []

    for line in file:
        data = line.split(',')
        if int(data[0]) == 2:
            if vector_index == 6:
                tasks += 1            
                vector_index = 0
            
            tasks_list.append(task_loads)
            task_loads = []

        if int(data[0]) == 1:
            task_stores.append(int(data[1], 16))

        if int(data[0]) == 0:
            address = int(data[1], 16)
            task_loads.append(address)
            if vector_index not in collectors:
                collectors[vector_index] = (address, address)
            else:
                curr_col = collectors[vector_index] 
                curr_col = (min(curr_col[0], address), max(curr_col[1], address))
            
            vector_index += 1
    
    # tasks = 1000
    iter_num = int(tasks / TASKS_PER_ITER)
    res = 'opcode, address\n'

    for iter in range(iter_num):
        inner_index = 0
        # request load from collectors
        for col in collectors:
            res += '3, ' + str(collectors[col][0] + inner_index * CACHE_BLOCK_SIZE)  + ', ' + str(TASKS_PER_ITER)+ '\n'

        res += '2, ' + str(len(collectors)) + '\n'
        while True:
            # request load from PE
            for j in range(PE_COUNT):
                if inner_index * PE_COUNT + j >= TASKS_PER_ITER:
                    break
                current_task_index = iter * TASKS_PER_ITER + inner_index * PE_COUNT + j
                curr_load = tasks_list[current_task_index]
                curr_store = task_stores[current_task_index]

                for t in curr_load:
                    res += '0, ' + str(t) + '\n'
                res += '1, ' + str(curr_store + 16 * current_task_index) + '\n'

            inner_index += 1
            if inner_index * PE_COUNT >= TASKS_PER_ITER:
                break

        res += "6, 0\n"

    print(res)
