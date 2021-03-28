import numpy as np
import platform
import dsim
import csv
import sys




mainMem = np.array([i for i in range (100000)], dtype = np.uint64)
if platform.system() == 'Linux':
    hw_lib_path = "./hardware/chisel/build/libhw.so"
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

mainMem = dsim.DArray(mainMem ,  dsim.DArray.DType.UInt64)

nVals = int(sys.argv[1])
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

vals = []
with open("python/" + sys.argv[2]+".csv") as trace:
    trigger = csv.reader(trace)
    for i, row in enumerate(trigger):
        if(int(row[0]) != 2 ):
            for item in row:
                vals.append(int(item,16))
            vals.append(0)
        else:
            vals.append(int(row[0]))
            vals.append(0)
            vals.append(int(row[1]))
        if (i == nVals - 1):
            break


vals = np.array(vals, dtype=np.uint64)
print(vals)

events = dsim.sim(ptrs = [mainMem ], vars= vals, debugs=[], numRets=0, numEvents=4, hwlib = hw_lib_path)

#print(localMem)
print("Cycle: " + str(events[0]))
#for i in range(3):
    #print("field{}".format(i+1))
    #print(events[i+1])


#if events[1] == test01(5,3):
#    print("Success!\nRet: " + str(events[1]))
#else:
#    print("Failed!\nRet: " + str(events[1]))
