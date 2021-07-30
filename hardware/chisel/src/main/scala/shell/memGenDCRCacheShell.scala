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

  val chunk = 1
  val WAIT_TIME = 30000 

  val numInputs  = 3
  val is_data = 2
  val is_addr = 1
  val is_inst = 0
  val is_ack = 2
  val is_nop = 3

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
  val last = state === sDone
  val is_busy = state === sBusy

  val goToBusy = Wire(Bool())

 val lastCycle = Reg(UInt(32.W))


  /**
    * Connecting event controls and return values
    * Event zero always contains the cycle count
    */

  if (numEvents > 0) {
    for (i <- 1 until numEvents) {
      vcr.io.dcr.ecnt(i).bits := accel.io.events.bits(i - 1)
      vcr.io.dcr.ecnt(i).valid := accel.io.events.valid
    }
  }

  /**
    * @note This part needs to be changes for each function
    */
  
    val (cycle,stopSim) = Counter(state === sDone, WAIT_TIME)
 
  val vals = VecInit(Seq.tabulate(numVals) { i => RegEnable(next = vcr.io.dcr.vals(i), init = 0.U(ptrBits.W), enable =  (state === sIdle)) })
  val ptrs = VecInit(Seq.tabulate(numPtrs) { i => RegEnable(next = vcr.io.dcr.ptrs(i), init = 0.U(ptrBits.W), enable =  (state === sIdle)) })  

  val (nextChunk,_) = Counter(incChunkCounter, 10000000)
  val (ackCounter,_ ) = CounterWithReset(accel.io.out.valid ,1000000, resetAckCounter )
  val fillCounter = RegInit(0.U(32.W))
  val fillWrap = Wire(Bool())

  resetAckCounter := false.B
  incChunkCounter := false.B

  when (fillWrap && dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last){
    fillCounter := 0.U
  }.elsewhen(dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last){
    fillCounter := fillCounter + 1.U
  }

  //  
  fillWrap := RegNext(fillCounter) === ((vals(0) / chunk.U) - 1.U)
  val (numQ, _) = Counter(fillWrap && dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last , 4 )

  goToBusy := (dmem.io.mem.r.fire() && dmem.io.mem.r.bits.last && numQ === 2.U && fillWrap )

  when(goToBusy) {
    cycles := 0.U
  }.otherwise {
    cycles := cycles + 1.U
  }

 vcr.io.dcr.ecnt(0).valid := last
 vcr.io.dcr.ecnt(0).bits := lastCycle

  when(accel.io.out.fire()){
      printf(p"Data back for addr ${accel.io.out.bits.data("field1").data} cycle ${cycles} \n") 
      printf(p"ackCounter :${ ackCounter}\n")
      lastCycle := cycles
  }

    val inputQ = for (i <- 0 until numInputs) yield {
      val queue = Module(new Queue(new DataBundle, entries = 1000000, pipe  =true, flow = true))
      queue
    }

    
    // Connecting dmem read port to input queues
    for (i <- 0 until numInputs){
      dmem.io.dme.rd(i).cmd.bits.addr := vcr.io.dcr.ptrs(1 + i) + fillCounter * chunk.U * 8.U
      dmem.io.dme.rd(i).cmd.bits.len  := (chunk - 1).U
      dmem.io.dme.rd(i).cmd.valid     := false.B
      dmem.io.dme.rd(i).data.ready := inputQ(i).io.enq.ready

      inputQ(i).io.enq.bits := DataBundle(dmem.io.dme.rd(i).data.bits)
      inputQ(i).io.enq.valid :=  dmem.io.dme.rd(i).data.valid
      inputQ(i).io.deq.ready := incChunkCounter
    }

    dmem.io.dme.wr := DontCare
    dmem.io.dme.rd(numQ).cmd.valid :=  (state === sReq)

  // field_0 => is_inst
  // field_1 => is_addr
  // field_2 => is_data


  // connecting input queues to accel input
  for (i <- 0 until 2) {
    accel.io.in.bits.dataVals(s"field${i}") := inputQ(i).io.deq.bits
  }

  when (inputQ(0).io.deq.bits.data === 0.U){// when Find in Walker
    accel.io.in.bits.dataVals(s"field2").data := ptrs(0) // mainMem
  }.otherwise{
    accel.io.in.bits.dataVals(s"field2") := inputQ(2).io.deq.bits
  }

  accel.io.in.bits.enable := ControlBundle.active()
  accel.io.in.valid := false.B
  accel.io.out.ready := is_busy | state === sDone | state === sAck


  
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
()
        when(inputQ(0).io.deq.valid === false.B || inputQ(1).io.deq.bits.data === 0.U ) {
          state := sDone
        }.elsewhen( inputQ(is_inst).io.deq.bits.data === is_ack.U) {
          state := sAck
          printf(p"Ack \n")
        }.elsewhen(inputQ(is_inst).io.deq.bits.data === is_nop.U){
          incChunkCounter := true.B
        }.otherwise {
            accel.io.in.valid := true.B
            when(accel.io.in.fire){
              printf(p"\nInst : ${inputQ(is_inst).io.deq.bits.data} for addr ${inputQ(is_addr).io.deq.bits.data} cycle ${cycles} \n")
              incChunkCounter := true.B
            }
        }

    }
    is(sAck){
      when (  ackCounter >= (inputQ(is_data).io.deq.bits.data)){
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

  vcr.io.dcr.finish := last && stopSim

  when(state === sReq){
    io.mem <> dmem.io.mem
    accel.io.mem <> DontCare
  }.otherwise{
     io.mem <> accel.io.mem
     dmem.io.mem <> DontCare
  }

  io.host <> vcr.io.host

}

