PY_DIR=python

nw=4
ns=8
tbe=32
lock=32
np=1
nc=1
nword=8

line=100000
bm=GEMV #blackscholes axpy GEMM

for ns in 256 512 1024
do
    for nw in 4 8 16
    do
	for np in 1 2 4 8
	do
        python3 $PY_DIR/memGenAccel.py $line $bm $nw $ns $tbe $lock $np $nc $nword
done
done
done

