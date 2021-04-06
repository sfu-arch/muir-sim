from common import Timer
import numpy as np
import platform
import dsim

data_size = 2048

def initData(test_size):
    data = np.random.randint(255, size = test_size)
    return [x - 127 for x in data]

Type = dsim.DArray.DType

# a = np.array([1, 2, 3, 4, 5])
# b = np.array([1, 2, 3, 4, 5])
# c = np.array([0, 0, 0, 0, 0])

a = initData(data_size)
b = initData(data_size)
c = np.zeros(data_size)

a_s = dsim.DArray(a, Type.UInt64)
b_s = dsim.DArray(b, Type.UInt64)
c_s = dsim.DArray(c, Type.UInt64)

if platform.system() == 'Linux':
    hw_lib_path = "./hardware/chisel/build/libhw.so"
elif platform.system() == 'Darwin':
    hw_lib_path = "./hardware/chisel/build/libhw.dylib"


time = Timer()
time.start()
events = dsim.sim(ptrs = [a_s, b_s, c_s], vars= [  ], debugs = [], numRets=0, numEvents=1, hwlib = hw_lib_path)
time.stop()

cycle = events[0]
print("Cycle: " + str(cycle))
print("Simulation time: " + str(time.elapsed * (10 ** 9)) + "ns")
print(a_s.getData_UInt64())
print(b_s.getData_UInt64())
print(c_s.getData_UInt64())
