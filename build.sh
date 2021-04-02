mkdir python/build

nw=4
ns=8
tbe=8
lock=8
np=1

rm -rf hardware/chisel/build
#for ns in 256, 512, 1024, 2048
#do
#    for nw in 4, 8, 16
#    do
        python3 run.py --accel-config examples/memGenTest.json --nWays $nw --nSets $ns --tbe-depth $tbe --lock-depth $lock --num-paral $np
#done
#done

mv hardware/chisel/build/libhw.so python/build/libhw_$nw\_$ns\_$tbe\_$lock\_$np.so
