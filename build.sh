mkdir python/build

nw=4
ns=8
tbe=8
lock=8
np=1
nc=1
nword=8
rm -rf hardware/chisel/build
#for ns in 256, 512, 1024, 2048
#do
#    for nw in 4, 8, 16
#    do
        python3 run.py --accel-config examples/memGenTest.json --nWays $nw --nSets $ns --tbe-depth $tbe --lock-depth $lock --num-paral $np --num-cache $nc --num-word $nword 
#done
#done

mv hardware/chisel/build/libhw.so python/build/libhw_$nw\_$ns\_$tbe\_$lock\_$np\_$nc\_$nword.so
