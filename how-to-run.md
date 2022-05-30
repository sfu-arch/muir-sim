# How to run:



## Installing dependencies:

Installing `verilator`, `jdk8`, `sbt`


## Installing simulator

```
python3 -m pip install .
```


## Config the chisel file

```
vim muir-sim/examples/test04_config.json
```


## Building the accelerator

```
python3 run.py --accel-config examples/test04_config.json
```


## Running the simulation

```
python3 python/test04.py
```


## Getting desing for aws

```
python3 run.py --f1 examples/test04_config.json
```