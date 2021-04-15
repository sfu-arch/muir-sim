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


class vaddDF(PtrsIn: Seq[Int] = List(64, 64, 64), ValsIn: Seq[Int] = List(64), Returns: Seq[Int] = List())
			(implicit p: Parameters) extends DandelionAccelDCRModule(PtrsIn, ValsIn, Returns){


  /* ================================================================== *
   *                   PRINTING MEMORY MODULES                          *
   * ================================================================== */

  //Cache
  val mem_ctrl_cache = Module(new CacheMemoryEngine(ID = 0, NumRead = 2, NumWrite = 1))

  io.MemReq <> mem_ctrl_cache.io.cache.MemReq
  mem_ctrl_cache.io.cache.MemResp <> io.MemResp

  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(1, 1, 1), valsArgTypes = List(2)))
  ArgSplitter.io.In <> io.in



  /* ================================================================== *
   *                   PRINTING LOOP HEADERS                            *
   * ================================================================== */

  val Loop_0 = Module(new LoopBlockNode(NumIns = List(1, 1, 1, 1), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 0))



  /* ================================================================== *
   *                   PRINTING BASICBLOCK NODES                        *
   * ================================================================== */

  val bb_entry1 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 3, BID = 1))

  val bb_for_body_lr_ph4 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 2, BID = 4))

  val bb_for_cond_cleanup_loopexit7 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 7))

  val bb_for_cond_cleanup9 = Module(new BasicBlockNoMaskFastNode(NumInputs = 2, NumOuts = 1, BID = 9))

  val bb_for_body11 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 13, NumPhi = 1, BID = 11))



  /* ================================================================== *
   *                   PRINTING INSTRUCTION NODES                       *
   * ================================================================== */

  //  %cmp10 = icmp eq i32 %n, 0, !dbg !25, !UID !27
  val icmp_cmp102 = Module(new ComputeNode(NumOuts = 1, ID = 2, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %cmp10, label %for.cond.cleanup, label %for.body.lr.ph, !dbg !28, !UID !29, !BB_UID !30
  val br_3 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 3))

  //  %wide.trip.count = zext i32 %n to i64, !UID !31
  val sextwide_trip_count5 = Module(new ZextNode(NumOuts = 1))

  //  br label %for.body, !dbg !28, !UID !32, !BB_UID !33
  val br_6 = Module(new UBranchNode(ID = 6))

  //  br label %for.cond.cleanup, !dbg !34, !UID !35, !BB_UID !36
  val br_8 = Module(new UBranchNode(ID = 8))

  //  ret void, !dbg !34, !UID !37, !BB_UID !38
  val ret_10 = Module(new RetNode2(retTypes = List(), ID = 10))

  //  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ], !UID !39
  val phiindvars_iv12 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 4, ID = 12, Res = true))

  //  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv, !dbg !40, !UID !42
  val Gep_arrayidx13 = Module(new GepNode(NumIns = 1, NumOuts = 1, ID = 13)(ElementSize = 8, ArraySize = List()))

  //  %0 = load i32, i32* %arrayidx, align 4, !dbg !40, !tbaa !43, !UID !47
  val ld_14 = Module(new UnTypLoadCache(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 14, RouteID = 0))

  //  %arrayidx2 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv, !dbg !48, !UID !49
  val Gep_arrayidx215 = Module(new GepNode(NumIns = 1, NumOuts = 1, ID = 15)(ElementSize = 8, ArraySize = List()))

  //  %1 = load i32, i32* %arrayidx2, align 4, !dbg !48, !tbaa !43, !UID !50
  val ld_16 = Module(new UnTypLoadCache(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 16, RouteID = 1))

  //  %add = add i32 %1, %0, !dbg !51, !UID !52
  val binaryOp_add17 = Module(new ComputeNode(NumOuts = 1, ID = 17, opCode = "add")(sign = false, Debug = false))

  //  %arrayidx4 = getelementptr inbounds i32, i32* %c, i64 %indvars.iv, !dbg !53, !UID !54
  val Gep_arrayidx418 = Module(new GepNode(NumIns = 1, NumOuts = 1, ID = 18)(ElementSize = 8, ArraySize = List()))

  //  store i32 %add, i32* %arrayidx4, align 4, !dbg !55, !tbaa !43, !UID !56
  val st_19 = Module(new UnTypStoreCache(NumPredOps = 0, NumSuccOps = 1, ID = 19, RouteID = 2))

  //  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !57, !UID !58
  val binaryOp_indvars_iv_next20 = Module(new ComputeNode(NumOuts = 2, ID = 20, opCode = "add")(sign = false, Debug = false))

  //  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !25, !UID !59
  val icmp_exitcond21 = Module(new ComputeNode(NumOuts = 1, ID = 21, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body, !dbg !28, !llvm.loop !60, !UID !62, !BB_UID !63
  val br_22 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 1, ID = 22))



  /* ================================================================== *
   *                   PRINTING CONSTANTS NODES                         *
   * ================================================================== */

  //i32 0
  val const0 = Module(new ConstFastNode(value = 0, ID = 0))

  //i64 0
  val const1 = Module(new ConstFastNode(value = 0, ID = 1))

  //i64 1
  val const2 = Module(new ConstFastNode(value = 1, ID = 2))



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE INSTRUCTION              *
   * ================================================================== */

  bb_entry1.io.predicateIn(0) <> ArgSplitter.io.Out.enable

  bb_for_body_lr_ph4.io.predicateIn(0) <> br_3.io.FalseOutput(0)

  bb_for_cond_cleanup9.io.predicateIn(1) <> br_3.io.TrueOutput(0)

  bb_for_cond_cleanup9.io.predicateIn(0) <> br_8.io.Out(0)



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE LOOP                     *
   * ================================================================== */

  bb_for_cond_cleanup_loopexit7.io.predicateIn(0) <> Loop_0.io.loopExit(0)

  bb_for_body11.io.predicateIn(1) <> Loop_0.io.activate_loop_start

  bb_for_body11.io.predicateIn(0) <> Loop_0.io.activate_loop_back



  /* ================================================================== *
   *                   PRINTING PARALLEL CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP -> PREDICATE INSTRUCTION                    *
   * ================================================================== */

  Loop_0.io.enable <> br_6.io.Out(0)

  Loop_0.io.loopBack(0) <> br_22.io.FalseOutput(0)

  Loop_0.io.loopFinish(0) <> br_22.io.TrueOutput(0)



  /* ================================================================== *
   *                   ENDING INSTRUCTIONS                              *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP INPUT DATA DEPENDENCIES                     *
   * ================================================================== */

  Loop_0.io.InLiveIn(0) <> ArgSplitter.io.Out.dataPtrs.elements("field0")(0)

  Loop_0.io.InLiveIn(1) <> ArgSplitter.io.Out.dataPtrs.elements("field1")(0)

  Loop_0.io.InLiveIn(2) <> ArgSplitter.io.Out.dataPtrs.elements("field2")(0)

  Loop_0.io.InLiveIn(3) <> sextwide_trip_count5.io.Out(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-IN DEPENDENCIES                   *
   * ================================================================== */

  Gep_arrayidx13.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field0")(0)

  Gep_arrayidx215.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field1")(0)

  Gep_arrayidx418.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field2")(0)

  icmp_exitcond21.io.RightIO <> Loop_0.io.OutLiveIn.elements("field3")(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-OUT DEPENDENCIES                  *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP LIVE OUT DEPENDENCIES                       *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP CARRY DEPENDENCIES                          *
   * ================================================================== */

  Loop_0.io.CarryDepenIn(0) <> binaryOp_indvars_iv_next20.io.Out(0)



  /* ================================================================== *
   *                   LOOP DATA CARRY DEPENDENCIES                     *
   * ================================================================== */

  phiindvars_iv12.io.InData(1) <> Loop_0.io.CarryDepenOut.elements("field0")(0)



  /* ================================================================== *
   *                   BASICBLOCK -> ENABLE INSTRUCTION                 *
   * ================================================================== */

  const0.io.enable <> bb_entry1.io.Out(0)

  icmp_cmp102.io.enable <> bb_entry1.io.Out(1)


  br_3.io.enable <> bb_entry1.io.Out(2)


  sextwide_trip_count5.io.enable <> bb_for_body_lr_ph4.io.Out(0)


  br_6.io.enable <> bb_for_body_lr_ph4.io.Out(1)


  br_8.io.enable <> bb_for_cond_cleanup_loopexit7.io.Out(0)


  ret_10.io.In.enable <> bb_for_cond_cleanup9.io.Out(0)


  const1.io.enable <> bb_for_body11.io.Out(0)

  const2.io.enable <> bb_for_body11.io.Out(1)

  phiindvars_iv12.io.enable <> bb_for_body11.io.Out(2)


  Gep_arrayidx13.io.enable <> bb_for_body11.io.Out(3)


  ld_14.io.enable <> bb_for_body11.io.Out(4)


  Gep_arrayidx215.io.enable <> bb_for_body11.io.Out(5)


  ld_16.io.enable <> bb_for_body11.io.Out(6)


  binaryOp_add17.io.enable <> bb_for_body11.io.Out(7)


  Gep_arrayidx418.io.enable <> bb_for_body11.io.Out(8)


  st_19.io.enable <> bb_for_body11.io.Out(9)


  binaryOp_indvars_iv_next20.io.enable <> bb_for_body11.io.Out(10)


  icmp_exitcond21.io.enable <> bb_for_body11.io.Out(11)


  br_22.io.enable <> bb_for_body11.io.Out(12)




  /* ================================================================== *
   *                   CONNECTING PHI NODES                             *
   * ================================================================== */

  phiindvars_iv12.io.Mask <> bb_for_body11.io.MaskBB(0)



  /* ================================================================== *
   *                   CONNECTING MEMORY CONNECTIONS                    *
   * ================================================================== */

  mem_ctrl_cache.io.rd.mem(0).MemReq <> ld_14.io.MemReq
  ld_14.io.MemResp <> mem_ctrl_cache.io.rd.mem(0).MemResp
  mem_ctrl_cache.io.rd.mem(1).MemReq <> ld_16.io.MemReq
  ld_16.io.MemResp <> mem_ctrl_cache.io.rd.mem(1).MemResp
  mem_ctrl_cache.io.wr.mem(0).MemReq <> st_19.io.MemReq
  st_19.io.MemResp <> mem_ctrl_cache.io.wr.mem(0).MemResp



  /* ================================================================== *
   *                   PRINT SHARED CONNECTIONS                         *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  icmp_cmp102.io.RightIO <> const0.io.Out

  phiindvars_iv12.io.InData(0) <> const1.io.Out

  binaryOp_indvars_iv_next20.io.RightIO <> const2.io.Out

  br_3.io.CmpIO <> icmp_cmp102.io.Out(0)

  Gep_arrayidx13.io.idx(0) <> phiindvars_iv12.io.Out(0)

  Gep_arrayidx215.io.idx(0) <> phiindvars_iv12.io.Out(1)

  Gep_arrayidx418.io.idx(0) <> phiindvars_iv12.io.Out(2)

  binaryOp_indvars_iv_next20.io.LeftIO <> phiindvars_iv12.io.Out(3)

  ld_14.io.GepAddr <> Gep_arrayidx13.io.Out(0)

  binaryOp_add17.io.RightIO <> ld_14.io.Out(0)

  ld_16.io.GepAddr <> Gep_arrayidx215.io.Out(0)

  binaryOp_add17.io.LeftIO <> ld_16.io.Out(0)

  st_19.io.inData <> binaryOp_add17.io.Out(0)

  st_19.io.GepAddr <> Gep_arrayidx418.io.Out(0)

  icmp_exitcond21.io.LeftIO <> binaryOp_indvars_iv_next20.io.Out(1)

  br_22.io.CmpIO <> icmp_exitcond21.io.Out(0)

  icmp_cmp102.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(0)

  sextwide_trip_count5.io.Input <> ArgSplitter.io.Out.dataVals.elements("field0")(1)

  st_19.io.Out(0).ready := true.B



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  br_22.io.PredOp(0) <> st_19.io.SuccOp(0)



  /* ================================================================== *
   *                   PRINTING OUTPUT INTERFACE                        *
   * ================================================================== */

  io.out <> ret_10.io.Out

}

