PY_DIR=python

nw=8
ns=8
tbe=8
lock=8
np=1
nc=1
nword=1



#libhw_8_256_6_8_2_1_16
bm=$1 #blackscholes axpy GEMM
#for ns in 64 
#do
#    for nw in 4 
#    do
	for np in  1
	do
	    for tbe in 10
	    do
#                for nc in 1
#                do
#                   for nword in 8 
#	           do

        python3 $PY_DIR/memGenAccel_Walker.py 0 $bm $nw $ns $tbe $lock $np $nc $nword
#done
done
done
#done 
#done 
#done
