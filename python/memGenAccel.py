import numpy as np
import platform
import dsim
import csv
import sys




mainMem = np.zeros(10000000, dtype = np.uint64) #10 Milions 
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

with open("python/" + sys.argv[2]+".csv") as trace:
    trigger = csv.reader(trace)
    for i, row in enumerate(trigger):
        if(int(row[0]) != 2 ):
            input_inst.append(int(row[0],16))
            input_addr.append(int(row[1],16))
            input_data.append(0)
        else:
            input_inst.append(int(row[0]))
            input_addr.append(0)
            input_data.append(int(row[1]))
        if (i == nVals - 1):
            break


print(input_inst)
print(input_addr)
print(input_data)

input_inst = dsim.DArray(input_inst ,  dsim.DArray.DType.UInt64)
input_addr = dsim.DArray(input_addr ,  dsim.DArray.DType.UInt64)
input_data = dsim.DArray(input_data ,  dsim.DArray.DType.UInt64)

events = dsim.sim(ptrs = [mainMem,input_inst,input_addr,input_data ], vars= [nVals], debugs=[], numRets=0, numEvents=17, hwlib = hw_lib_path)

#print(localMem)
Events = ["missLD","hitLD", "InstCount", "CPUReq", "memCtrlReq"] + [""]*11
print("\nDone!\n")
print("Cycle: " + str(events[0]))
for i in range(16):
    if(Events[i] != ""):
        print("\n{},{}".format(Events[i], events[i+1]))


#if events[1] == test01(5,3):
#    print("Success!\nRet: " + str(events[1]))
#else:
#    print("Failed!\nRet: " + str(events[1]))
