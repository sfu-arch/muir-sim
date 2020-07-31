import numpy as np
import platform
import dsim

def branch(a, b):
    if a < b:
        return a * b
    else:
        return a / b


if platform.system() == 'Linux':
    hw_lib_path = "./hardware/chisel/build/libhw.so"
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

a = 10
b = 5

events = dsim.sim(ptrs = [  ], vars= [a, b], debugs=[], numRets=1, numEvents=1, hwlib = hw_lib_path)

print("Cycle: " + str(events[0]))

if events[1] == branch(a, b):
    print("Success!\nRet: " + str(events[1]))
else:
    print("Failed!\nRet: " + str(events[1]))
