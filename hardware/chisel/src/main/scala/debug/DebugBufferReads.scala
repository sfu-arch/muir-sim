package dandelion.generator

import chisel3._
import chipsalliance.rocketchip.config._
import dandelion.accel.{DandelionAccelDebugModule, DandelionAccelReadDebugModule}
import dandelion.node._
import chisel3.MultiIOModule
import chisel3.util.experimental.BoringUtils
import interfaces.inStreamDMA
/**
 * DebugBufferReads
 *
 * This module is responsible to connect nodes debug IOs to DME.
 * The connection between buffer nodes with the actual nodes is implicit using Bore feature
 * Bore_ID is the same as the ID of the node_to_be_logged and node_cnt for memory spaces from 0
 * @param numDebug number of debug nodes
 * @param boreIDsList list of node IDs
 * @param p
 */
class DebugBufferReads(numDebug: Int, val boreIDsList: Seq[Int])
                      (implicit p: Parameters) extends DandelionAccelReadDebugModule(numDebug, boreIDsList)(p)  {

  //TODO: Default buffer size is 5, make it parameterized
  val read_debug_buffer_size = 32 // 8 * 5 bytes
//  val read_buffers = List.fill(numDebug)(Module(new inStreamDMA(bufSize = read_debug_buffer_size)))
  val read_buffers = Seq.tabulate(numDebug) {i => Module(new DebugVMELoadBufferNode(ID = i))}

  val read_buf_data = List.fill(numDebug)(Wire(UInt(xlen.W)))
  val read_buf_valid = List.fill(numDebug)(Wire(Bool()))
  val read_buf_ready = List.fill(numDebug)(Wire(Bool()))
//  val read_buf_start = List.fill(numDebug)(Wire(Bool()))

  read_buf_data.foreach(_ := 0.U)
  read_buf_valid.foreach(_ := false.B)
  read_buf_ready.foreach(_ := false.B)
//  read_buf_start.foreach(_ := false.B)


  for(i <- 0 until numDebug){
    read_buffers(i).io.addrDebug := io.addrDebug(i)
    io.vmeIn(i) <> read_buffers(i).io.vmeOut


    read_buf_data(i) := read_buffers(i).io.out.bits
    read_buf_valid(i) := read_buffers(i).io.out.valid
    read_buffers(i).io.out.ready := read_buf_ready(i)

    BoringUtils.addSource(read_buf_data(i), s"in_log_data${boreIDsList(i)}")
    BoringUtils.addSource(read_buf_valid(i), s"in_log_Buffer_valid${boreIDsList(i)}")

    BoringUtils.addSink(read_buf_ready(i), s"in_log_Buffer_ready${boreIDsList(i)}")
  }

}
