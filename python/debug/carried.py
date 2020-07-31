import numpy as np
import platform
import dsim

def carried(a, b):
    sum = 0
    n = 12
    for i in range(0,n):
        sum += (sum*b) + a
    return sum


if platform.system() == 'Linux':
    hw_lib_path = "./hardware/chisel/build/libhw.so"
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

a = 8
b = 5

events = dsim.sim(ptrs = [  ], vars= [a, b], debugs=[], numRets=1, numEvents=1, hwlib = hw_lib_path)

print("Cycle: " + str(events[0]))

if events[1] == carried(a, b):
    print("Success!\nRet: " + str(events[1]))
else:
    print("Failed!\nRet: " + str(events[1]))
