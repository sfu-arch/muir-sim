from utils import read_index_table
import numpy as np
import platform
import dsim
import csv
import sys
import os
import ntpath

ntpath.basename("a/b/c")

def path_leaf(path):
    head, tail = ntpath.split(path)
    _, prev_head = ntpath.split(head)
    return str(prev_head) + "_" + str(tail)


nw   = int(sys.argv[3])
ns   = int(sys.argv[4])
tbe  = int(sys.argv[5])
lock = int(sys.argv[6])
nparal   = int(sys.argv[7])
nc = int(sys.argv[8])
nword = int(sys.argv[9])
numLine = int(sys.argv[1])
bm= path_leaf(sys.argv[2])[:-4] #remove csv
print(bm)


mainMem = np.zeros(300, dtype = np.uint32) #10 Milions 

if (__name__ == "__main__"):
    read_index_table(mainMem, file_name= "python/walker/queries/22/index_info.txt")
print(mainMem)

if platform.system() == 'Linux':
        hw_lib_path = "./python/build/libhw_walker_{}_{}_{}_{}_{}_{}_{}.so".format(nw,ns,tbe,lock,nparal,nc,nword)
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

print(hw_lib_path)

mainMem = dsim.DArray(mainMem ,  dsim.DArray.DType.UInt32)

print(mainMem)
input_inst = []
input_addr = []
input_data = [] 


with open(sys.argv[2]) as trace:
    trigger = csv.DictReader(trace)
    for (i,row) in enumerate(trigger):
        if(str(row['Inst']) == "LONG" or str(row['Inst']) == "INT" ):
            input_inst.append(0)
            input_addr.append(row['orig'])
            input_data.append(0)
            nVals = i + 1


input_inst = dsim.DArray(input_inst ,  dsim.DArray.DType.UInt64)
input_addr = dsim.DArray(input_addr ,  dsim.DArray.DType.UInt64)
input_data = dsim.DArray(input_data ,  dsim.DArray.DType.UInt64)

events = dsim.sim(ptrs = [mainMem,input_inst,input_addr,input_data ], vars= [nVals], debugs=[], numRets=0, numEvents=17, hwlib = hw_lib_path)

Events = ["Cycles","missLD","hitLD", "InstCount", "CPUReq", "memCtrlReq", "numLoadReq", "numReplace"] + [""]*9
print("\nDone!\n")

for i in range(17):
    if(Events[i] != ""):
        print("\n{},{}".format(Events[i], events[i]))

header = ["numLine", "bm", "nw", "ns", "tbe", "lock", "nParal","nc", "nword", 
            "cycles", "nHit", "nMiss", "nLoadInst","nInst","cpuReq","mmReqs"]
file =open ("python/{}_sweep_analysis.csv".format(bm),'a')
with file:
    fnames = header   
    writer = csv.DictWriter(file, fieldnames=fnames)    
    # if (os.stat("python/{}_sweep_analysis.csv".format(bm)).st_size == 0):
        # writer.writeheader()
    
    # writer.writerow({ 'numLine': numLine,
    #     'bm': bm,
    #     'nw': nw,
    #     'ns': ns,
    #     'tbe':tbe,
    #     'lock':lock,
    #     'nParal':nparal,
	#     'nc':nc,
	#     'nword':nword,
    #     'cycles':events[0],
    #     'nMiss':events[1],
    #     'nHit':events[2],
    #     'nLoadInst':events[6],
    #     'nInst':events[3],
    #     'cpuReq':events[4],
    #     'mmReqs':events[5]
    # })
