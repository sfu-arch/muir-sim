mkdir python/build

nw=1
ns=4
tbe=16
lock=16
np=4
nc=1
nword=1
#for ns in 1024
#do
#    for nw in 4
#    do
#	for np in 1
#	do
#	    for tbe in 256
#	    do
#                for nc in 4 8 
#                do
#                   for nword in 8
#	           do
#
	rm -rf hardware/chisel/build
       python3 run.py --accel-config examples/memGenTest.json --nWays $nw --nSets $ns --tbe-depth $tbe --lock-depth $lock --num-paral $np --num-cache $nc --num-word $nword --benchmark "sparch"
	mv hardware/chisel/build/libhw.so python/build/libhw_sparch_$nw\_$ns\_$tbe\_$lock\_$np\_$nc\_$nword.so
#done
#done
#done 
#done
#done
#done

