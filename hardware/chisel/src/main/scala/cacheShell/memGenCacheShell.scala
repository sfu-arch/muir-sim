package dandelion.shell

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import dandelion.config._
import dandelion.interfaces.{ControlBundle, DataBundle}
import dandelion.interfaces.axi._
import dandelion.memory.cache._
import dandelion.junctions._
import dandelion.accel._
import memGen.memory.cache._
import memGen.shell._




class memGenAccel ( PtrsIn: Seq[Int] = List(),
                               ValsIn: Seq[Int] = List(64, 64, 64),
                               RetsOut: Seq[Int] = List(8,32,256))
                             (implicit p:Parameters) extends  memGenModule (PtrsIn, ValsIn, RetsOut){

  
  val accel = Module (new memGenTopLevel())

//  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(1, 1, 1, 1), valsArgTypes = List()))
//  ArgSplitter.io.In <> io.in
  val is_wideLd = WireInit(4.U)
  val dstNode = Wire(UInt(8.W))
  val numCache = accel.numCache


  val outArb = Module(new Arbiter(UInt(), n = numCache))

  val outAddrQueue = for (i <- 0 until accel.numCache) yield {
    val Q = Module(new Queue(UInt(), entries = 16, pipe = true, flow = true))
    Q
  }
  accel.io.instruction.map(i => i.valid := false.B)
  accel.io.instruction.map(i => i.bits.inst := 0.U)
  accel.io.instruction.map(i => i.bits.addr := 0.U)
  accel.io.instruction.map(i => i.bits.data := 0.U)


  io.in.ready := false.B

    when(io.in.bits.dataVals("field0").data.asUInt() === is_wideLd){
      // printf(p"Wide LD ${dstNode}\n")
      dstNode := io.in.bits.dataVals("field2").data.asUInt()
      accel.io.instruction(dstNode).bits.inst := 0.U // Load
    }.otherwise{
        accel.io.instruction(dstNode).bits.inst := io.in.bits.dataVals("field0").data.asUInt() // Load
        dstNode := 0.U
    }

    io.in.ready := accel.io.instruction(dstNode).ready
    accel.io.instruction(dstNode).valid := io.in.valid
    accel.io.instruction(dstNode).bits.addr := io.in.bits.dataVals("field1").data.asUInt()
    accel.io.instruction(dstNode).bits.data := io.in.bits.dataVals("field2").data.asTypeOf(UInt((accelParams.cacheBlockBits).W))
 
    io.out <> DontCare
  
    io.out.bits.data("field0").data := accel.io.resp(0).bits.inst
    io.out.bits.data("field2").data := accel.io.resp(0).bits.data

  for (i <- 0 until numCache){
    outAddrQueue(i).io.enq.bits := Mux(accel.io.resp(i).valid, accel.io.resp(i).bits.addr,0.U)
    outAddrQueue(i).io.enq.valid := accel.io.resp(i).valid
    accel.io.resp(i).ready := outAddrQueue(i).io.enq.ready

    outArb.io.in(i) <> outAddrQueue(i).io.deq
  }

  io.out.valid := outArb.io.out.valid
  io.out.bits.data("field1").data := outArb.io.out.bits
  outArb.io.out.ready := io.out.ready

  io.events <> accel.io.events

  io.mem <> accel.io.mem
}