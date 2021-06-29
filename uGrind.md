# Boring Utils

We use the Non-hierarchical boring tool involves connections from sources to sinks within different modules. The following is an example from [title](https://github.com/chipsalliance/chisel3/blob/master/src/main/scala/chisel3/util/experimental/BoringUtils.scala)
Here, `x` is described as a source and given a name, `uniqueId`, and `y` is described as a sink with the same name. This is equivalent to the hierarchical boring example above, but requires no modifications to `Top`.


`class Constant extends Module {
     val io = IO(new Bundle{})
     val x = Wire(UInt(6.W))
     x := 42.U
     BoringUtils.addSource(x, "uniqueId")
   }
   class Expect extends Module {
     val io = IO(new Bundle{})
     val y = Wire(UInt(6.W))
     y := 0.U
     BoringUtils.addSink(y, "uniqueId")
   }
   class Top extends Module {
    val io = IO(new Bundle{})
     val constant = Module(new Constant)
     val expect = Module(new Expect)
}`
   
   
 This feature allows us to set conditional guard definitions. Each guard has 3 parts:
 
 * A reader that reads the golden values or patch values
 * A guard function that takes the golden/patch values and performs the guarding function
 * A writer side that logs the data that needs to be stored to either A)present the user B)process for next iteration 
 
# muGrind 
 
## muir-lib:

**DebugLoad.scala : DebugVMELoadBufferNode**
Reads the golden/patch values from main memory, these values have been extracted from the intermidiate software during the software (llvm) instrumentation.
Each node has an ID that matches with node ID this ID is the same as BoreID, we use the node's ID +"string" as the Boring string. This way, each node will uniquely conncet to its own unique reader.

**DebugWrite.scala: DebugVMEBufferNode**
Writers write the debug packets to main memory, these packets are generated during the guard function run, queued inside the writer node and written to memory.
Each node has an ID that matches with node ID this ID is the same as BoreID, we use the node's ID +"string" as the Boring string. This way, each node will uniquely conncet to its own unique writer.

**DebugBufferReads:**
A collection of DebugVMELoadBufferNode, this module acts as a wrapper and generates the exact number of guard readers as needed with the passed in BoreID

**DebugBufferWriters:** 
A collection of DebugVMEBufferNode, this module acts as a wrapper and generates the exact number of guard writers as needed with the passed in BoreID

## muIR-Sim:
**DandelionStreamDebugShell:**
The top module that instantiates main DF, VCR, VME, Cache, DebugBufferReads and Debug BufferWrites


## muIR:
lib/debug-info
Add debug info library to embed boreID info to each node
