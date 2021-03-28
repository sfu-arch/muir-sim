package dandelion.shell

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import dandelion.config._
import dandelion.interfaces.{ControlBundle, DataBundle}
import dandelion.interfaces.axi._
import dandelion.memory.cache._
import dandelion.accel._
import dsptools.counters.CounterWithReset
import memGen.memory._
import memGen.shell._

class memGenDCRCacheShell [T <: memGenModule](accelModule: () => T)
                                             (numPtrs: Int = 0, numVals: Int = 6, numRets: Int = 0, numEvents: Int = 0, numCtrls: Int = 0)
                                             (implicit val p: Parameters) extends Module with HasAccelShellParams {
  val io = IO(new Bundle {
    val host = new AXILiteClient(hostParams)
    val mem = new AXIMaster(memParams)
  })


  val numInputs  = 3
  val is_data = 2
  val is_addr = 1
  val is_inst = 0
  val is_ack = 2
  val is_nop = 3
  // comment test

  val regBits = dcrParams.regBits
  val ptrBits = regBits * 2

  val vcr = Module(new DCR)
  val dmem = Module(new DME)


  val accel = Module(accelModule())

  val sIdle :: sReq:: sBusy :: sFlush :: sAck :: sDone :: Nil = Enum(6)

  val resetAckCounter = WireInit(false.B)
  val incChunkCounter = WireInit(false.B)
  val state = RegInit(sIdle)
  val cycles = RegInit(0.U(regBits.W))
  val cnt = RegInit(0.U(regBits.W))
  val last = state === sDone
  val is_busy = state === sBusy

  val (nextChunk,_) = Counter(incChunkCounter, 1000000)
  val (ackCounter,_ ) = CounterWithReset(accel.io.out.valid ,1000000, resetAckCounter )
  val (fillCounter,_) = Counter(dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last , 4)

  val goToBusy = Wire(Bool())
  goToBusy := (dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last && fillCounter === 2.U)


  when(goToBusy) {
    cycles := 0.U
  }.otherwise {
    cycles := cycles + 1.U
  }

  /**
    * Connecting event controls and return values
    * Event zero always contains the cycle count
    */

  if (accel.RetsOut.size > 0) {
    for (i <- 1 to accel.RetsOut.size) {
      vcr.io.dcr.ecnt(i).bits := accel.io.out.bits.data(s"field${i - 1}").data
      vcr.io.dcr.ecnt(i).valid := accel.io.out.valid
    }
  }

 vcr.io.dcr.ecnt(0).valid := last
 vcr.io.dcr.ecnt(0).bits := cycles

  /**
    * @note This part needs to be changes for each function
    */
  
    val (cycle,stopSim) = Counter(true.B, 300000)
 
  val vals = VecInit(Seq.tabulate(numVals) { i => RegEnable(next = vcr.io.dcr.vals(i), init = 0.U(ptrBits.W), enable =  (state === sIdle)) })
  val ptrs = VecInit(Seq.tabulate(numPtrs) { i => RegEnable(next = vcr.io.dcr.ptrs(i), init = 0.U(ptrBits.W), enable =  (state === sIdle)) })  

  when(accel.io.out.fire()){
      printf(p"Data back for addr ${accel.io.out.bits.data("field1").data} cycle ${cycles} \n") 
  }

    val inputQ = for (i <- 0 until numInputs) yield {
      val queue = Module(new Queue(new DataBundle, entries = 1000000, pipe  =true, flow = true))
      queue
    }

    for (i <- 0 until numInputs){
      dmem.io.dme.rd(i).cmd.bits.addr := vcr.io.dcr.ptrs(1 + i)
      dmem.io.dme.rd(i).cmd.bits.len  := vcr.io.dcr.vals(0)
      dmem.io.dme.rd(i).cmd.valid := false.B

      inputQ(i).io.enq.bits := DataBundle(dmem.io.dme.rd(i).data.bits)
      dmem.io.dme.rd(i).data.ready := inputQ(i).io.enq.ready
    }
    dmem.io.dme.wr := DontCare
    dmem.io.dme.rd(fillCounter).cmd.valid :=  (state === sReq)

  for (i <- 0 until numInputs){
    inputQ(i).io.enq.valid :=  dmem.io.dme.rd(i).data.valid
    inputQ(i).io.deq.ready := incChunkCounter
  }

  // field_0 => is_inst
  // field_1 => is_addr
  // field_2 => is_data

  for (i <- 0 until numInputs) {
    accel.io.in.bits.dataVals(s"field${i}") := inputQ(i).io.deq.bits
  }

  accel.io.in.bits.enable := ControlBundle.active()
  accel.io.in.valid := false.B
  accel.io.out.ready := is_busy | state === sDone | state === sAck
  resetAckCounter := false.B
  incChunkCounter := false.B

  
  switch(state) {
    is(sIdle) {
      when(vcr.io.dcr.launch) {
        state := sReq
      }
    }
    is(sReq){
      when(goToBusy){
        state := sBusy
      }
    }

    is(sBusy) {

        when(inputQ(0).io.deq.valid === false.B ) {
          state := sDone
        }.elsewhen( inputQ(is_inst).io.deq.bits.data === is_ack.U) {
          state := sAck
          printf(p"Ack \n")
        }.elsewhen(inputQ(is_inst).io.deq.bits.data === is_nop.U){
          incChunkCounter := true.B
        }.otherwise {
            printf(p"\nInst : ${inputQ(is_inst).io.deq.bits.data} for addr ${inputQ(is_addr).io.deq.bits.data} cycle ${cycles} \n")
            accel.io.in.valid := true.B
            incChunkCounter := true.B
        }

    }
    is(sAck){
      when (ackCounter === (inputQ(is_data).io.deq.bits.data)){
        state := sBusy
        resetAckCounter := true.B
        incChunkCounter := true.B
      }
    }

    is(sDone) {
      when(stopSim) {
        state := sIdle
      }
    }
  }

  vcr.io.dcr.finish := last

  when(state === sReq){
    io.mem <> dmem.io.mem
    accel.io.mem <> DontCare
  }.otherwise{
     io.mem <> accel.io.mem
     dmem.io.mem <> DontCare
  }

  io.host <> vcr.io.host

}

