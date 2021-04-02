rm -rf hardware/chisel/build
python3 run.py --accel-config examples/memGenTest.json --nWays 4 --nSets 8 --tbe-depth 8 --lock-depth 8
