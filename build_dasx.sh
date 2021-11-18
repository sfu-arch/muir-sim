mkdir python/build

nw=12
ns=64
tbe=10
lock=8
np=2
nc=1
nword=8
#for ns in 128
#do
#    for nw in 4
#    do
	for np in  1
	do
	    for tbe in 14
	    do
#                for nc in 4 8 
#                do
#                   for nword in 8
#	           do
#
	rm -rf hardware/chisel/build
       python3 run.py --accel-config examples/memGenTest.json --nWays $nw --nSets $ns --tbe-depth $tbe --lock-depth $lock --num-paral $np --num-cache $nc --num-word $nword --benchmark "dasxarray"
	mv hardware/chisel/build/libhw.so python/build/libhw_dasx_$nw\_$ns\_$tbe\_$lock\_$np\_$nc\_$nword.so
#done
#done
done 
done
#done
#done

