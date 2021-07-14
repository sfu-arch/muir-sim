################################### INSTRUCTION ###########################
# This method is for loading the graph into the memory
# it reads the graph from 'filename' and write in to 'mem'
# This is how to use it:
#
# from graphpulse.utilities import write_nodes_to_mem
# write_node_to_mem(mainMem, './graphpulse/node_data_trace.txt')
#

def write_nodes_to_mem(mem, filename):
    file = open(filename, 'r')
    for i in file:
        splitted = i.split(',')
        if len(splitted) <= 1:
            continue

        address = int(splitted[0])
        for index, value in enumerate(splitted[1: ]):
            int_val = int(value)
            mem[address + index] = int_val