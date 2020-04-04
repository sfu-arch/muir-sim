import numpy as np
import platform
import dsim

def test05(a):
    a_len = 10
    for i in range(0, a_len):
        a[i] = 2 * a[i]
    return a



if platform.system() == 'Linux':
    hw_lib_path = "./hardware/chisel/build/libhw.so"
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"

val_a = list(range(1, 11))
print(val_a)
a_s = dsim.DArray(val_a, dsim.DArray.DType.DWord)

events = dsim.sim(ptrs = [a_s], vars= [], numRets=1, numEvents=1, hwlib = hw_lib_path)

print("Cycle: " + str(events[0]))

if list(a_s.getData() == test05):
    print("Sucessful Run!")
    print("Output array:\t")
    print(list(a_s.getData()))
else:
    print("Filed Run!")
    print("Expected data:")
    print(test05(val_a))
    print("Return Data:")
    print(list(a_s.getData()))
