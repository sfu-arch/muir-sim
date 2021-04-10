mkdir python/build

nw=4
ns=8
tbe=32
lock=8
np=1
nc=2
nword=8
for ns in 128 256 512
do
    for nw in 4 8
    do
	for np in 1 2 4 8
	do
	    for tbe in 8 16 32
	    do
                for nc in 1 2
                do
                   for nword in 8 16 32
	           do

	rm -rf hardware/chisel/build
        python3 run.py --accel-config examples/memGenTest.json --nWays $nw --nSets $ns --tbe-depth $tbe --lock-depth $lock --num-paral $np --num-cache $nc --num-word $nword 
	
	mv hardware/chisel/build/libhw.so python/build/libhw_$nw\_$ns\_$tbe\_$lock\_$np\_$nc\_$nword.so
done
done
done 
done
done
done

