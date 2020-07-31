package dandelion.generator

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.Module._
import chisel3.testers._
import chisel3.iotesters._
import dandelion.accel._
import dandelion.arbiters._
import dandelion.config._
import dandelion.control._
import dandelion.fpu._
import dandelion.interfaces._
import dandelion.junctions._
import dandelion.loop._
import dandelion.memory._
import dandelion.memory.stack._
import dandelion.node._
import muxes._
import org.scalatest._
import regfile._
import util._


class branchDF(PtrsIn: Seq[Int] = List(), ValsIn: Seq[Int] = List(64, 64), Returns: Seq[Int] = List(64))
			(implicit p: Parameters) extends DandelionAccelDCRModule(PtrsIn, ValsIn, Returns){


  /* ================================================================== *
   *                   PRINTING MEMORY MODULES                          *
   * ================================================================== */

  //Remember if there is no mem operation io memreq/memresp should be grounded
  io.MemReq <> DontCare
  io.MemResp <> DontCare

  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(), valsArgTypes = List(3, 3)))
  ArgSplitter.io.In <> io.in



  /* ================================================================== *
   *                   PRINTING LOOP HEADERS                            *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINTING BASICBLOCK NODES                        *
   * ================================================================== */

  val bb_entry0 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 2, BID = 0))

  val bb_if_then1 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 2, BID = 1))

  val bb_if_else2 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 2, BID = 2))

  val bb_if_end3 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 2, NumPhi = 1, BID = 3))



  /* ================================================================== *
   *                   PRINTING INSTRUCTION NODES                       *
   * ================================================================== */

  //  %cmp = icmp slt i32 %a, %b, !dbg !19, !UID !21
  val icmp_cmp0 = Module(new ComputeNode(NumOuts = 1, ID = 0, opCode = "slt")(sign = true, Debug = false))

  //  br i1 %cmp, label %if.then, label %if.else, !dbg !22, !UID !23, !BB_UID !24
  val br_1 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 1))

  //  %mul = mul nsw i32 %b, %a, !dbg !25, !UID !27
  val binaryOp_mul2 = Module(new ComputeNode(NumOuts = 1, ID = 2, opCode = "mul")(sign = false, Debug = false))

  //  br label %if.end, !dbg !28, !UID !29, !BB_UID !30
  val br_3 = Module(new UBranchNode(ID = 3))

  //  %div = sdiv i32 %a, %b, !dbg !31, !UID !33
  val binaryOp_div4 = Module(new ComputeNode(NumOuts = 1, ID = 4, opCode = "sdiv")(sign = false, Debug = false))

  //  br label %if.end, !UID !34, !BB_UID !35
  val br_5 = Module(new UBranchNode(ID = 5))

  //  %res.0 = phi i32 [ %mul, %if.then ], [ %div, %if.else ], !UID !36
  val phires_06 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 1, ID = 6, Res = true))

  //  ret i32 %res.0, !dbg !37, !UID !38, !BB_UID !39
  val ret_7 = Module(new RetNode2(retTypes = List(32), ID = 7))



  /* ================================================================== *
   *                   PRINTING CONSTANTS NODES                         *
   * ================================================================== */



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE INSTRUCTION              *
   * ================================================================== */

  bb_entry0.io.predicateIn(0) <> ArgSplitter.io.Out.enable

  bb_if_then1.io.predicateIn(0) <> br_1.io.TrueOutput(0)

  bb_if_else2.io.predicateIn(0) <> br_1.io.FalseOutput(0)

  bb_if_end3.io.predicateIn(1) <> br_3.io.Out(0)

  bb_if_end3.io.predicateIn(0) <> br_5.io.Out(0)



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE LOOP                     *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINTING PARALLEL CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP -> PREDICATE INSTRUCTION                    *
   * ================================================================== */



  /* ================================================================== *
   *                   ENDING INSTRUCTIONS                              *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP INPUT DATA DEPENDENCIES                     *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP DATA LIVE-IN DEPENDENCIES                   *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP DATA LIVE-OUT DEPENDENCIES                  *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP LIVE OUT DEPENDENCIES                       *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP CARRY DEPENDENCIES                          *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP DATA CARRY DEPENDENCIES                     *
   * ================================================================== */



  /* ================================================================== *
   *                   BASICBLOCK -> ENABLE INSTRUCTION                 *
   * ================================================================== */

  icmp_cmp0.io.enable <> bb_entry0.io.Out(0)


  br_1.io.enable <> bb_entry0.io.Out(1)


  binaryOp_mul2.io.enable <> bb_if_then1.io.Out(0)


  br_3.io.enable <> bb_if_then1.io.Out(1)


  binaryOp_div4.io.enable <> bb_if_else2.io.Out(0)


  br_5.io.enable <> bb_if_else2.io.Out(1)


  phires_06.io.enable <> bb_if_end3.io.Out(0)


  ret_7.io.In.enable <> bb_if_end3.io.Out(1)




  /* ================================================================== *
   *                   CONNECTING PHI NODES                             *
   * ================================================================== */

  phires_06.io.Mask <> bb_if_end3.io.MaskBB(0)



  /* ================================================================== *
   *                   CONNECTING MEMORY CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINT SHARED CONNECTIONS                         *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  br_1.io.CmpIO <> icmp_cmp0.io.Out(0)

  phires_06.io.InData(0) <> binaryOp_mul2.io.Out(0)

  phires_06.io.InData(1) <> binaryOp_div4.io.Out(0)

  ret_7.io.In.data("field0") <> phires_06.io.Out(0)

  icmp_cmp0.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(0)

  binaryOp_mul2.io.RightIO <> ArgSplitter.io.Out.dataVals.elements("field0")(1)

  binaryOp_div4.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(2)

  icmp_cmp0.io.RightIO <> ArgSplitter.io.Out.dataVals.elements("field1")(0)

  binaryOp_mul2.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field1")(1)

  binaryOp_div4.io.RightIO <> ArgSplitter.io.Out.dataVals.elements("field1")(2)



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINTING OUTPUT INTERFACE                        *
   * ================================================================== */

  io.out <> ret_7.io.Out

}

