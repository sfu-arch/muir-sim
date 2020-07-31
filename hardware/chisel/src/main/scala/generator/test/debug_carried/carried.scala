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


class carriedDF(PtrsIn: Seq[Int] = List(), ValsIn: Seq[Int] = List(64, 64), Returns: Seq[Int] = List(64))
			(implicit p: Parameters) extends DandelionAccelDCRModule(PtrsIn, ValsIn, Returns){


  /* ================================================================== *
   *                   PRINTING MEMORY MODULES                          *
   * ================================================================== */

  //Remember if there is no mem operation io memreq/memresp should be grounded
  io.MemReq <> DontCare
  io.MemResp <> DontCare

  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(), valsArgTypes = List(1, 1)))
  ArgSplitter.io.In <> io.in



  /* ================================================================== *
   *                   PRINTING LOOP HEADERS                            *
   * ================================================================== */

  val Loop_0 = Module(new LoopBlockNode(NumIns = List(1, 1), NumOuts = List(1), NumCarry = List(1, 1), NumExits = 1, ID = 0))



  /* ================================================================== *
   *                   PRINTING BASICBLOCK NODES                        *
   * ================================================================== */

  val bb_entry0 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 0))

  val bb_for_body1 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 12, NumPhi = 2, BID = 1))

  val bb_for_end2 = Module(new BasicBlockNode(NumInputs = 1, NumOuts = 2, NumPhi = 1, BID = 2))



  /* ================================================================== *
   *                   PRINTING INSTRUCTION NODES                       *
   * ================================================================== */

  //  br label %for.body, !dbg !23, !UID !25, !BB_UID !26
  val br_0 = Module(new UBranchNode(ID = 0))

  //  %sum.08 = phi i32 [ 0, %entry ], [ %add1, %for.body ], !UID !27
  val phisum_081 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 2, ID = 1, Res = true))

  //  %i.07 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !UID !28
  val phii_072 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 1, ID = 2, Res = true))

  //  %mul = mul nsw i32 %sum.08, %b, !dbg !29, !UID !32
  val binaryOp_mul3 = Module(new ComputeNode(NumOuts = 1, ID = 3, opCode = "mul")(sign = false, Debug = false))

  //  %add = add i32 %sum.08, %a, !dbg !33, !UID !34
  val binaryOp_add4 = Module(new ComputeNode(NumOuts = 1, ID = 4, opCode = "add")(sign = false, Debug = false))

  //  %add1 = add i32 %add, %mul, !dbg !35, !UID !36
  val binaryOp_add15 = Module(new ComputeNode(NumOuts = 2, ID = 5, opCode = "add")(sign = false, Debug = false))

  //  %inc = add nuw nsw i32 %i.07, 1, !dbg !37, !UID !38
  val binaryOp_inc6 = Module(new ComputeNode(NumOuts = 2, ID = 6, opCode = "add")(sign = false, Debug = false))

  //  %exitcond = icmp eq i32 %inc, 12, !dbg !39, !UID !40
  val icmp_exitcond7 = Module(new ComputeNode(NumOuts = 1, ID = 7, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond, label %for.end, label %for.body, !dbg !23, !llvm.loop !41, !UID !43, !BB_UID !44
  val br_8 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 8))

  //  %add1.lcssa = phi i32 [ %add1, %for.body ], !UID !45
  val phiadd1_lcssa9 = Module(new PhiFastNode(NumInputs = 1, NumOutputs = 1, ID = 9, Res = false))

  //  ret i32 %add1.lcssa, !dbg !46, !UID !47, !BB_UID !48
  val ret_10 = Module(new RetNode2(retTypes = List(32), ID = 10))



  /* ================================================================== *
   *                   PRINTING CONSTANTS NODES                         *
   * ================================================================== */

  //i32 0
  val const0 = Module(new ConstFastNode(value = 0, ID = 0))

  //i32 0
  val const1 = Module(new ConstFastNode(value = 0, ID = 1))

  //i32 1
  val const2 = Module(new ConstFastNode(value = 1, ID = 2))

  //i32 12
  val const3 = Module(new ConstFastNode(value = 12, ID = 3))



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE INSTRUCTION              *
   * ================================================================== */

  bb_entry0.io.predicateIn(0) <> ArgSplitter.io.Out.enable



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE LOOP                     *
   * ================================================================== */

  bb_for_body1.io.predicateIn(1) <> Loop_0.io.activate_loop_start

  bb_for_body1.io.predicateIn(0) <> Loop_0.io.activate_loop_back

  bb_for_end2.io.predicateIn(0) <> Loop_0.io.loopExit(0)



  /* ================================================================== *
   *                   PRINTING PARALLEL CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP -> PREDICATE INSTRUCTION                    *
   * ================================================================== */

  Loop_0.io.enable <> br_0.io.Out(0)

  Loop_0.io.loopBack(0) <> br_8.io.FalseOutput(0)

  Loop_0.io.loopFinish(0) <> br_8.io.TrueOutput(0)



  /* ================================================================== *
   *                   ENDING INSTRUCTIONS                              *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP INPUT DATA DEPENDENCIES                     *
   * ================================================================== */

  Loop_0.io.InLiveIn(0) <> ArgSplitter.io.Out.dataVals.elements("field1")(0)

  Loop_0.io.InLiveIn(1) <> ArgSplitter.io.Out.dataVals.elements("field0")(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-IN DEPENDENCIES                   *
   * ================================================================== */

  binaryOp_mul3.io.RightIO <> Loop_0.io.OutLiveIn.elements("field0")(0)

  binaryOp_add4.io.RightIO <> Loop_0.io.OutLiveIn.elements("field1")(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-OUT DEPENDENCIES                  *
   * ================================================================== */

  Loop_0.io.InLiveOut(0) <> binaryOp_add15.io.Out(0)



  /* ================================================================== *
   *                   LOOP LIVE OUT DEPENDENCIES                       *
   * ================================================================== */

  phiadd1_lcssa9.io.InData(0) <> Loop_0.io.OutLiveOut.elements("field0")(0)



  /* ================================================================== *
   *                   LOOP CARRY DEPENDENCIES                          *
   * ================================================================== */

  Loop_0.io.CarryDepenIn(0) <> binaryOp_inc6.io.Out(0)

  Loop_0.io.CarryDepenIn(1) <> binaryOp_add15.io.Out(1)



  /* ================================================================== *
   *                   LOOP DATA CARRY DEPENDENCIES                     *
   * ================================================================== */

  phii_072.io.InData(1) <> Loop_0.io.CarryDepenOut.elements("field0")(0)

  phisum_081.io.InData(1) <> Loop_0.io.CarryDepenOut.elements("field1")(0)



  /* ================================================================== *
   *                   BASICBLOCK -> ENABLE INSTRUCTION                 *
   * ================================================================== */

  br_0.io.enable <> bb_entry0.io.Out(0)


  const0.io.enable <> bb_for_body1.io.Out(0)

  const1.io.enable <> bb_for_body1.io.Out(1)

  const2.io.enable <> bb_for_body1.io.Out(2)

  const3.io.enable <> bb_for_body1.io.Out(3)

  phisum_081.io.enable <> bb_for_body1.io.Out(4)


  phii_072.io.enable <> bb_for_body1.io.Out(5)


  binaryOp_mul3.io.enable <> bb_for_body1.io.Out(6)


  binaryOp_add4.io.enable <> bb_for_body1.io.Out(7)


  binaryOp_add15.io.enable <> bb_for_body1.io.Out(8)


  binaryOp_inc6.io.enable <> bb_for_body1.io.Out(9)


  icmp_exitcond7.io.enable <> bb_for_body1.io.Out(10)


  br_8.io.enable <> bb_for_body1.io.Out(11)


  phiadd1_lcssa9.io.enable <> bb_for_end2.io.Out(0)


  ret_10.io.In.enable <> bb_for_end2.io.Out(1)




  /* ================================================================== *
   *                   CONNECTING PHI NODES                             *
   * ================================================================== */

  phisum_081.io.Mask <> bb_for_body1.io.MaskBB(0)

  phii_072.io.Mask <> bb_for_body1.io.MaskBB(1)

  phiadd1_lcssa9.io.Mask <> bb_for_end2.io.MaskBB(0)



  /* ================================================================== *
   *                   CONNECTING MEMORY CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINT SHARED CONNECTIONS                         *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  phisum_081.io.InData(0) <> const0.io.Out

  phii_072.io.InData(0) <> const1.io.Out

  binaryOp_inc6.io.RightIO <> const2.io.Out

  icmp_exitcond7.io.RightIO <> const3.io.Out

  binaryOp_mul3.io.LeftIO <> phisum_081.io.Out(0)

  binaryOp_add4.io.LeftIO <> phisum_081.io.Out(1)

  binaryOp_inc6.io.LeftIO <> phii_072.io.Out(0)

  binaryOp_add15.io.RightIO <> binaryOp_mul3.io.Out(0)

  binaryOp_add15.io.LeftIO <> binaryOp_add4.io.Out(0)

  icmp_exitcond7.io.LeftIO <> binaryOp_inc6.io.Out(1)

  br_8.io.CmpIO <> icmp_exitcond7.io.Out(0)

  ret_10.io.In.data("field0") <> phiadd1_lcssa9.io.Out(0)



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */



  /* ================================================================== *
   *                   PRINTING OUTPUT INTERFACE                        *
   * ================================================================== */

  io.out <> ret_10.io.Out

}

