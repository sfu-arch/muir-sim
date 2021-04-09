import numpy as np
import platform
import dsim
import csv
import sys
import os




nw   = int(sys.argv[3])
ns   = int(sys.argv[4])
tbe  = int(sys.argv[5])
lock = int(sys.argv[6])
nparal   = int(sys.argv[7])
numLine = int(sys.argv[1])
bm= sys.argv[2]


mainMem = np.zeros(10000000, dtype = np.uint64) #10 Milions 
if platform.system() == 'Linux':
    if(nparal == 0):
        hw_lib_path = "./python/build/libhw_{}_{}_{}_{}.so".format(nw,ns,tbe,lock)
    else:
        hw_lib_path = "./python/build/libhw_{}_{}_{}_{}_{}.so".format(nw,ns,tbe,lock,nparal)
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

print(hw_lib_path)

mainMem = dsim.DArray(mainMem ,  dsim.DArray.DType.UInt64)

nVals = numLine
input_inst = []
input_addr = []
input_data = [] 

#vals = [list(inst) for inst in zip(input_inst, input_addr, input_data)]
#vals = [item  for sublist in vals for item in sublist  ]
# print(vals)

# LD 0x1000
# LD 0x1020
# ACK 2 // COMP
# NOP // because comp takes one cycle
# ST 0x3000
# LD 0x1040
# NOP // for non-vector ops e.g. computing pointer
# LD 0x1060
# ACK 2 // wait for data
# NOP // because comp takes one cycle
# ST 0x3020


                            #        inst|addr|data
#events = dsim.sim(ptrs = [mainMem ], vars= [0, 4, 2,
 #                                    0,128,2], debugs=[], numRets=0, numEvents=1, hwlib = hw_lib_path)

with open(sys.argv[2]) as trace:
    trigger = csv.reader(trace)
    for i, row in enumerate(trigger):
        if(int(row[0]) == 2 ):
            input_inst.append(int(row[0]))
            input_addr.append(0)
            input_data.append(int(row[1]))
        if (int(row[0]) == 4 ):
            input_inst.append(int(row[0]))
            input_addr.append(int(row[1],16))
            input_data.append(int(row[2]))
        else:
            input_inst.append(int(row[0],16))
            input_addr.append(int(row[1],16))
            input_data.append(0)
        if (i == nVals - 1):
            break


# print(input_inst)
# print(input_addr)
# print(input_data)

input_inst = dsim.DArray(input_inst ,  dsim.DArray.DType.UInt64)
input_addr = dsim.DArray(input_addr ,  dsim.DArray.DType.UInt64)
input_data = dsim.DArray(input_data ,  dsim.DArray.DType.UInt64)

events = dsim.sim(ptrs = [mainMem,input_inst,input_addr,input_data ], vars= [nVals], debugs=[], numRets=0, numEvents=17, hwlib = hw_lib_path)

#print(localMem)
Events = ["Cycles","missLD","hitLD", "InstCount", "CPUReq", "memCtrlReq", "numLoadReq", "numReplace"] + [""]*9
print("\nDone!\n")
for i in range(17):
    if(Events[i] != ""):
        print("\n{},{}".format(Events[i], events[i]))


header = ["numLine", "bm", "nw", "ns", "tbe", "lock", "nParal", 
            "cycles", "nHit", "nMiss", "nLoadInst","nInst","cpuReq","mmReqs"]
file =open ("{}_Ran.csv".format(bm),'a')
with file:
    fnames = header   
    writer = csv.DictWriter(file, fieldnames=fnames)    
    if (os.stat("{}_Ran.csv".format(bm)).st_size == 0):
        writer.writeheader()
    
    writer.writerow({ 'numLine': numLine,
        'bm': bm,
        'nw': nw,
        'ns': ns,
        'tbe':tbe,
        'lock':lock,
        'nParal':nparal,
        'cycles':events[0],
        'nMiss':events[1],
        'nHit':events[2],
        'nLoadInst':events[6],
        'nInst':events[3],
        'cpuReq':events[4],
        'mmReqs':events[5]
    })


#if events[1] == test01(5,3):
#    print("Success!\nRet: " + str(events[1]))
#else:
#    print("Failed!\nRet: " + str(events[1]))
