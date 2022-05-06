PY_DIR=python

nw=4
ns=1024
tbe=64
lock=32
np=1
nc=1
nword=1



#libhw_8_256_6_8_2_1_16
bm=$1 #blackscholes axpy GEMM
#for ns in 64 
#do
#    for nw in 4 
#    do
	for np in 1
	do
	    for tbe in 256
	    do
#                for nc in 1
#                do
#                   for nword in 8 
#	           do

        python3 $PY_DIR/memGenAccel_sparch.py 0 $bm $nw $ns $tbe $lock $np $nc $nword
#done
done
done
#done 
#done 
#done
