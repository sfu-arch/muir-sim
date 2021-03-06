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


class test08DF(PtrsIn: Seq[Int] = List(32), ValsIn: Seq[Int] = List(32), Returns: Seq[Int] = List(32))
			(implicit p: Parameters) extends DandelionAccelDCRModule(PtrsIn, ValsIn, Returns){


  /* ================================================================== *
   *                   PRINTING MEMORY MODULES                          *
   * ================================================================== */

  val MemCtrl = Module(new UnifiedController(ID = 0, Size = 32, NReads = 3, NWrites = 3)
  (WControl = new WriteMemoryController(NumOps = 3, BaseSize = 2, NumEntries = 2, Serialize = true))
  (RControl = new ReadMemoryController(NumOps = 3, BaseSize = 2, NumEntries = 2, Serialize = true))
  (RWArbiter = new ReadWriteArbiter()))

  io.MemReq <> MemCtrl.io.MemReq
  MemCtrl.io.MemResp <> io.MemResp

  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(3), valsArgTypes = List(6)))
  ArgSplitter.io.In <> io.in



  /* ================================================================== *
   *                   PRINTING LOOP HEADERS                            *
   * ================================================================== */

  val Loop_0 = Module(new LoopBlockNode(NumIns = List(1, 1), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 0))

  val Loop_1 = Module(new LoopBlockNode(NumIns = List(1, 1, 1, 1, 2), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 1))

  val Loop_2 = Module(new LoopBlockNode(NumIns = List(1, 1, 1, 1, 1, 1, 2), NumOuts = List(1), NumCarry = List(1, 1), NumExits = 1, ID = 2))



  /* ================================================================== *
   *                   PRINTING BASICBLOCK NODES                        *
   * ================================================================== */

  val bb_entry0 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 14, BID = 0))

  val bb_for_cond_cleanup1 = Module(new BasicBlockNode(NumInputs = 1, NumOuts = 4, NumPhi = 1, BID = 1))

  val bb_for_body2 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 5, NumPhi = 2, BID = 2))

  val bb_for_body4_preheader3 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 3))

  val bb_for_cond_cleanup3_loopexit4 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 4))

  val bb_for_cond_cleanup35 = Module(new BasicBlockNoMaskFastNode(NumInputs = 2, NumOuts = 10, BID = 5))

  val bb_for_body46 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 3, NumPhi = 1, BID = 6))

  val bb_for_body8_preheader7 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 7))

  val bb_for_cond_cleanup7_loopexit8 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 8))

  val bb_for_cond_cleanup79 = Module(new BasicBlockNoMaskFastNode(NumInputs = 2, NumOuts = 8, BID = 9))

  val bb_for_body810 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 11, NumPhi = 1, BID = 10))



  /* ================================================================== *
   *                   PRINTING INSTRUCTION NODES                       *
   * ================================================================== */

  //  %cmp248 = icmp eq i32 %n, 0, !UID !32
  val icmp_cmp2480 = Module(new ComputeNode(NumOuts = 1, ID = 0, opCode = "eq")(sign = false, Debug = false))

  //  %cmp646 = icmp eq i32 %n, 0, !UID !33
  val icmp_cmp6461 = Module(new ComputeNode(NumOuts = 1, ID = 1, opCode = "eq")(sign = false, Debug = false))

  //  %sub = add i32 %n, -1, !UID !34
  val binaryOp_sub2 = Module(new ComputeNode(NumOuts = 1, ID = 2, opCode = "add")(sign = false, Debug = false))

  //  %idxprom11 = zext i32 %sub to i64, !UID !35
  val sextidxprom113 = Module(new ZextNode(NumOuts = 1))

  //  %arrayidx12 = getelementptr inbounds i32, i32* %a, i64 %idxprom11, !UID !36
  val Gep_arrayidx124 = Module(new GepNode(NumIns = 1, NumOuts = 1, ID = 4)(ElementSize = 8, ArraySize = List()))

  //  %sub17 = add i32 %n, -1, !UID !37
  val binaryOp_sub175 = Module(new ComputeNode(NumOuts = 1, ID = 5, opCode = "add")(sign = false, Debug = false))

  //  %idxprom18 = zext i32 %sub17 to i64, !UID !38
  val sextidxprom186 = Module(new ZextNode(NumOuts = 1))

  //  %arrayidx19 = getelementptr inbounds i32, i32* %a, i64 %idxprom18, !UID !39
  val Gep_arrayidx197 = Module(new GepNode(NumIns = 1, NumOuts = 1, ID = 7)(ElementSize = 8, ArraySize = List()))

  //  %wide.trip.count = zext i32 %n to i64, !UID !40
  val sextwide_trip_count8 = Module(new ZextNode(NumOuts = 1))

  //  br label %for.body, !dbg !41, !UID !42, !BB_UID !43
  val br_9 = Module(new UBranchNode(ID = 9))

  //  %add.lcssa = phi i32 [ %add, %for.cond.cleanup3 ], !UID !44
  val phiadd_lcssa10 = Module(new PhiFastNode(NumInputs = 1, NumOutputs = 1, ID = 10, Res = false))

  //  %div = sdiv i32 %add.lcssa, 2, !dbg !45, !UID !46
  val binaryOp_div11 = Module(new ComputeNode(NumOuts = 1, ID = 11, opCode = "sdiv")(sign = false, Debug = false))

  //  ret i32 %div, !dbg !47, !UID !48, !BB_UID !49
  val ret_12 = Module(new RetNode2(retTypes = List(32), ID = 12))

  //  %i.051 = phi i32 [ 0, %entry ], [ %inc25, %for.cond.cleanup3 ], !UID !50
  val phii_05113 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 1, ID = 13, Res = true))

  //  %result.050 = phi i32 [ 0, %entry ], [ %add, %for.cond.cleanup3 ], !UID !51
  val phiresult_05014 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 1, ID = 14, Res = true))

  //  br i1 %cmp248, label %for.cond.cleanup3, label %for.body4.preheader, !dbg !53, !UID !54, !BB_UID !55
  val br_15 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 15))

  //  br label %for.body4, !dbg !56, !UID !57, !BB_UID !58
  val br_16 = Module(new UBranchNode(ID = 16))

  //  br label %for.cond.cleanup3, !dbg !59
  val br_17 = Module(new UBranchNode(ID = 17))

  //  %0 = load i32, i32* %arrayidx19, align 4, !dbg !59, !tbaa !60, !UID !64
  val ld_18 = Module(new UnTypLoad(NumPredOps = 0, NumSuccOps = 0, NumOuts = 2, ID = 18, RouteID = 0))

  //  %add = add i32 %0, %result.050, !dbg !65, !UID !66
  val binaryOp_add19 = Module(new ComputeNode(NumOuts = 2, ID = 19, opCode = "add")(sign = false, Debug = false))

  //  %inc23 = add i32 %0, 1, !dbg !67, !UID !68
  val binaryOp_inc2320 = Module(new ComputeNode(NumOuts = 1, ID = 20, opCode = "add")(sign = false, Debug = false))

  //  store i32 %inc23, i32* %arrayidx19, align 4, !dbg !67, !tbaa !60, !UID !69
  val st_21 = Module(new UnTypStore(NumPredOps = 0, NumSuccOps = 1, ID = 21, RouteID = 0))

  //  %inc25 = add nuw nsw i32 %i.051, 1, !dbg !70, !UID !71
  val binaryOp_inc2522 = Module(new ComputeNode(NumOuts = 2, ID = 22, opCode = "add")(sign = false, Debug = false))

  //  %exitcond53 = icmp eq i32 %inc25, 3, !dbg !72, !UID !73
  val icmp_exitcond5323 = Module(new ComputeNode(NumOuts = 1, ID = 23, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond53, label %for.cond.cleanup, label %for.body, !dbg !41, !llvm.loop !74, !UID !76, !BB_UID !77
  val br_24 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 1, ID = 24))

  //  %j.049 = phi i32 [ %inc15, %for.cond.cleanup7 ], [ 0, %for.body4.preheader ], !UID !78
  val phij_04925 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 1, ID = 25, Res = false))

  //  br i1 %cmp646, label %for.cond.cleanup7, label %for.body8.preheader, !dbg !56, !UID !80, !BB_UID !81
  val br_26 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 26))

  //  br label %for.body8, !dbg !82, !UID !85, !BB_UID !86
  val br_27 = Module(new UBranchNode(ID = 27))

  //  br label %for.cond.cleanup7, !dbg !87
  val br_28 = Module(new UBranchNode(ID = 28))

  //  %1 = load i32, i32* %arrayidx12, align 4, !dbg !87, !tbaa !60, !UID !88
  val ld_29 = Module(new UnTypLoad(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 29, RouteID = 1))

  //  %inc13 = add i32 %1, 1, !dbg !87, !UID !89
  val binaryOp_inc1330 = Module(new ComputeNode(NumOuts = 1, ID = 30, opCode = "add")(sign = false, Debug = false))

  //  store i32 %inc13, i32* %arrayidx12, align 4, !dbg !87, !tbaa !60, !UID !90
  val st_31 = Module(new UnTypStore(NumPredOps = 0, NumSuccOps = 1, ID = 31, RouteID = 1))

  //  %inc15 = add nuw i32 %j.049, 1, !dbg !91, !UID !92
  val binaryOp_inc1532 = Module(new ComputeNode(NumOuts = 2, ID = 32, opCode = "add")(sign = false, Debug = false))

  //  %exitcond52 = icmp eq i32 %inc15, %n, !dbg !93, !UID !94
  val icmp_exitcond5233 = Module(new ComputeNode(NumOuts = 1, ID = 33, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond52, label %for.cond.cleanup3.loopexit, label %for.body4, !dbg !53, !llvm.loop !95, !UID !97, !BB_UID !98
  val br_34 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 1, ID = 34))

  //  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body8 ], [ 0, %for.body8.preheader ], !UID !99
  val phiindvars_iv35 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 2, ID = 35, Res = false))

  //  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv, !dbg !82, !UID !100
  val Gep_arrayidx36 = Module(new GepNode(NumIns = 1, NumOuts = 2, ID = 36)(ElementSize = 8, ArraySize = List()))

  //  %2 = load i32, i32* %arrayidx, align 4, !dbg !82, !tbaa !60, !UID !101
  val ld_37 = Module(new UnTypLoad(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 37, RouteID = 2))

  //  %mul = shl i32 %2, 1, !dbg !102, !UID !103
  val binaryOp_mul38 = Module(new ComputeNode(NumOuts = 1, ID = 38, opCode = "shl")(sign = false, Debug = false))

  //  store i32 %mul, i32* %arrayidx, align 4, !dbg !104, !tbaa !60, !UID !105
  val st_39 = Module(new UnTypStore(NumPredOps = 0, NumSuccOps = 1, ID = 39, RouteID = 2))

  //  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !106, !UID !107
  val binaryOp_indvars_iv_next40 = Module(new ComputeNode(NumOuts = 2, ID = 40, opCode = "add")(sign = false, Debug = false))

  //  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !108, !UID !109
  val icmp_exitcond41 = Module(new ComputeNode(NumOuts = 1, ID = 41, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond, label %for.cond.cleanup7.loopexit, label %for.body8, !dbg !56, !llvm.loop !110, !UID !112, !BB_UID !113
  val br_42 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 1, ID = 42))



  /* ================================================================== *
   *                   PRINTING CONSTANTS NODES                         *
   * ================================================================== */

  //i32 0
  val const0 = Module(new ConstFastNode(value = 0, ID = 0))

  //i32 0
  val const1 = Module(new ConstFastNode(value = 0, ID = 1))

  //i32 -1
  val const2 = Module(new ConstFastNode(value = -1, ID = 2))

  //i32 -1
  val const3 = Module(new ConstFastNode(value = -1, ID = 3))

  //i32 2
  val const4 = Module(new ConstFastNode(value = 2, ID = 4))

  //i32 0
  val const5 = Module(new ConstFastNode(value = 0, ID = 5))

  //i32 0
  val const6 = Module(new ConstFastNode(value = 0, ID = 6))

  //i32 1
  val const7 = Module(new ConstFastNode(value = 1, ID = 7))

  //i32 1
  val const8 = Module(new ConstFastNode(value = 1, ID = 8))

  //i32 3
  val const9 = Module(new ConstFastNode(value = 3, ID = 9))

  //i32 0
  val const10 = Module(new ConstFastNode(value = 0, ID = 10))

  //i32 1
  val const11 = Module(new ConstFastNode(value = 1, ID = 11))

  //i32 1
  val const12 = Module(new ConstFastNode(value = 1, ID = 12))

  //i64 0
  val const13 = Module(new ConstFastNode(value = 0, ID = 13))

  //i32 1
  val const14 = Module(new ConstFastNode(value = 1, ID = 14))

  //i64 1
  val const15 = Module(new ConstFastNode(value = 1, ID = 15))



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE INSTRUCTION              *
   * ================================================================== */

  bb_entry0.io.predicateIn(0) <> ArgSplitter.io.Out.enable

  bb_for_body4_preheader3.io.predicateIn(0) <> br_15.io.FalseOutput(0)

  bb_for_cond_cleanup35.io.predicateIn(1) <> br_15.io.TrueOutput(0)

  bb_for_cond_cleanup35.io.predicateIn(0) <> br_17.io.Out(0)

  bb_for_body8_preheader7.io.predicateIn(0) <> br_26.io.FalseOutput(0)

  bb_for_cond_cleanup79.io.predicateIn(1) <> br_26.io.TrueOutput(0)

  bb_for_cond_cleanup79.io.predicateIn(0) <> br_28.io.Out(0)



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE LOOP                     *
   * ================================================================== */

  bb_for_cond_cleanup1.io.predicateIn(0) <> Loop_2.io.loopExit(0)

  bb_for_body2.io.predicateIn(1) <> Loop_2.io.activate_loop_start

  bb_for_body2.io.predicateIn(0) <> Loop_2.io.activate_loop_back

  bb_for_cond_cleanup3_loopexit4.io.predicateIn(0) <> Loop_1.io.loopExit(0)

  bb_for_body46.io.predicateIn(1) <> Loop_1.io.activate_loop_start

  bb_for_body46.io.predicateIn(0) <> Loop_1.io.activate_loop_back

  bb_for_cond_cleanup7_loopexit8.io.predicateIn(0) <> Loop_0.io.loopExit(0)

  bb_for_body810.io.predicateIn(1) <> Loop_0.io.activate_loop_start

  bb_for_body810.io.predicateIn(0) <> Loop_0.io.activate_loop_back



  /* ================================================================== *
   *                   PRINTING PARALLEL CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP -> PREDICATE INSTRUCTION                    *
   * ================================================================== */

  Loop_0.io.enable <> br_27.io.Out(0)

  Loop_0.io.loopBack(0) <> br_42.io.FalseOutput(0)

  Loop_0.io.loopFinish(0) <> br_42.io.TrueOutput(0)

  Loop_1.io.enable <> br_16.io.Out(0)

  Loop_1.io.loopBack(0) <> br_34.io.FalseOutput(0)

  Loop_1.io.loopFinish(0) <> br_34.io.TrueOutput(0)

  Loop_2.io.enable <> br_9.io.Out(0)

  Loop_2.io.loopBack(0) <> br_24.io.FalseOutput(0)

  Loop_2.io.loopFinish(0) <> br_24.io.TrueOutput(0)



  /* ================================================================== *
   *                   ENDING INSTRUCTIONS                              *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP INPUT DATA DEPENDENCIES                     *
   * ================================================================== */

  Loop_0.io.InLiveIn(0) <> Loop_1.io.OutLiveIn.elements("field0")(0)

  Loop_0.io.InLiveIn(1) <> Loop_1.io.OutLiveIn.elements("field1")(0)

  Loop_1.io.InLiveIn(0) <> Loop_2.io.OutLiveIn.elements("field3")(0)

  Loop_1.io.InLiveIn(1) <> Loop_2.io.OutLiveIn.elements("field2")(0)

  Loop_1.io.InLiveIn(2) <> Loop_2.io.OutLiveIn.elements("field1")(0)

  Loop_1.io.InLiveIn(3) <> Loop_2.io.OutLiveIn.elements("field5")(0)

  Loop_1.io.InLiveIn(4) <> Loop_2.io.OutLiveIn.elements("field4")(0)

  Loop_2.io.InLiveIn(0) <> icmp_cmp2480.io.Out(0)

  Loop_2.io.InLiveIn(1) <> icmp_cmp6461.io.Out(0)

  Loop_2.io.InLiveIn(2) <> ArgSplitter.io.Out.dataPtrs.elements("field0")(0)

  Loop_2.io.InLiveIn(3) <> sextwide_trip_count8.io.Out(0)

  Loop_2.io.InLiveIn(4) <> Gep_arrayidx124.io.Out(0)

  Loop_2.io.InLiveIn(5) <> ArgSplitter.io.Out.dataVals.elements("field0")(0)

  Loop_2.io.InLiveIn(6) <> Gep_arrayidx197.io.Out(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-IN DEPENDENCIES                   *
   * ================================================================== */

  icmp_exitcond41.io.RightIO <> Loop_0.io.OutLiveIn.elements("field0")(0)

  Gep_arrayidx36.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field1")(0)

  br_26.io.CmpIO <> Loop_1.io.OutLiveIn.elements("field2")(0)

  icmp_exitcond5233.io.RightIO <> Loop_1.io.OutLiveIn.elements("field3")(0)

  ld_29.io.GepAddr <> Loop_1.io.OutLiveIn.elements("field4")(0)

  st_31.io.GepAddr <> Loop_1.io.OutLiveIn.elements("field4")(1)

  br_15.io.CmpIO <> Loop_2.io.OutLiveIn.elements("field0")(0)

  ld_18.io.GepAddr <> Loop_2.io.OutLiveIn.elements("field6")(0)

  st_21.io.GepAddr <> Loop_2.io.OutLiveIn.elements("field6")(1)



  /* ================================================================== *
   *                   LOOP DATA LIVE-OUT DEPENDENCIES                  *
   * ================================================================== */

  Loop_2.io.InLiveOut(0) <> binaryOp_add19.io.Out(0)



  /* ================================================================== *
   *                   LOOP LIVE OUT DEPENDENCIES                       *
   * ================================================================== */

  phiadd_lcssa10.io.InData(0) <> Loop_2.io.OutLiveOut.elements("field0")(0)



  /* ================================================================== *
   *                   LOOP CARRY DEPENDENCIES                          *
   * ================================================================== */

  Loop_0.io.CarryDepenIn(0) <> binaryOp_indvars_iv_next40.io.Out(0)

  Loop_1.io.CarryDepenIn(0) <> binaryOp_inc1532.io.Out(0)

  Loop_2.io.CarryDepenIn(0) <> binaryOp_inc2522.io.Out(0)

  Loop_2.io.CarryDepenIn(1) <> binaryOp_add19.io.Out(1)



  /* ================================================================== *
   *                   LOOP DATA CARRY DEPENDENCIES                     *
   * ================================================================== */

  phiindvars_iv35.io.InData(0) <> Loop_0.io.CarryDepenOut.elements("field0")(0)

  phij_04925.io.InData(0) <> Loop_1.io.CarryDepenOut.elements("field0")(0)

  phii_05113.io.InData(1) <> Loop_2.io.CarryDepenOut.elements("field0")(0)

  phiresult_05014.io.InData(1) <> Loop_2.io.CarryDepenOut.elements("field1")(0)



  /* ================================================================== *
   *                   BASICBLOCK -> ENABLE INSTRUCTION                 *
   * ================================================================== */

  const0.io.enable <> bb_entry0.io.Out(0)

  const1.io.enable <> bb_entry0.io.Out(1)

  const2.io.enable <> bb_entry0.io.Out(2)

  const3.io.enable <> bb_entry0.io.Out(3)

  icmp_cmp2480.io.enable <> bb_entry0.io.Out(4)


  icmp_cmp6461.io.enable <> bb_entry0.io.Out(5)


  binaryOp_sub2.io.enable <> bb_entry0.io.Out(6)


  sextidxprom113.io.enable <> bb_entry0.io.Out(7)


  Gep_arrayidx124.io.enable <> bb_entry0.io.Out(8)


  binaryOp_sub175.io.enable <> bb_entry0.io.Out(9)


  sextidxprom186.io.enable <> bb_entry0.io.Out(10)


  Gep_arrayidx197.io.enable <> bb_entry0.io.Out(11)


  sextwide_trip_count8.io.enable <> bb_entry0.io.Out(12)


  br_9.io.enable <> bb_entry0.io.Out(13)


  const4.io.enable <> bb_for_cond_cleanup1.io.Out(0)

  phiadd_lcssa10.io.enable <> bb_for_cond_cleanup1.io.Out(1)


  binaryOp_div11.io.enable <> bb_for_cond_cleanup1.io.Out(2)


  ret_12.io.In.enable <> bb_for_cond_cleanup1.io.Out(3)


  const5.io.enable <> bb_for_body2.io.Out(0)

  const6.io.enable <> bb_for_body2.io.Out(1)

  phii_05113.io.enable <> bb_for_body2.io.Out(2)


  phiresult_05014.io.enable <> bb_for_body2.io.Out(3)


  br_15.io.enable <> bb_for_body2.io.Out(4)


  br_16.io.enable <> bb_for_body4_preheader3.io.Out(0)


  br_17.io.enable <> bb_for_cond_cleanup3_loopexit4.io.Out(0)


  const7.io.enable <> bb_for_cond_cleanup35.io.Out(0)

  const8.io.enable <> bb_for_cond_cleanup35.io.Out(1)

  const9.io.enable <> bb_for_cond_cleanup35.io.Out(2)

  ld_18.io.enable <> bb_for_cond_cleanup35.io.Out(3)


  binaryOp_add19.io.enable <> bb_for_cond_cleanup35.io.Out(4)


  binaryOp_inc2320.io.enable <> bb_for_cond_cleanup35.io.Out(5)


  st_21.io.enable <> bb_for_cond_cleanup35.io.Out(6)


  binaryOp_inc2522.io.enable <> bb_for_cond_cleanup35.io.Out(7)


  icmp_exitcond5323.io.enable <> bb_for_cond_cleanup35.io.Out(8)


  br_24.io.enable <> bb_for_cond_cleanup35.io.Out(9)


  const10.io.enable <> bb_for_body46.io.Out(0)

  phij_04925.io.enable <> bb_for_body46.io.Out(1)


  br_26.io.enable <> bb_for_body46.io.Out(2)


  br_27.io.enable <> bb_for_body8_preheader7.io.Out(0)


  br_28.io.enable <> bb_for_cond_cleanup7_loopexit8.io.Out(0)


  const11.io.enable <> bb_for_cond_cleanup79.io.Out(0)

  const12.io.enable <> bb_for_cond_cleanup79.io.Out(1)

  ld_29.io.enable <> bb_for_cond_cleanup79.io.Out(2)


  binaryOp_inc1330.io.enable <> bb_for_cond_cleanup79.io.Out(3)


  st_31.io.enable <> bb_for_cond_cleanup79.io.Out(4)


  binaryOp_inc1532.io.enable <> bb_for_cond_cleanup79.io.Out(5)


  icmp_exitcond5233.io.enable <> bb_for_cond_cleanup79.io.Out(6)


  br_34.io.enable <> bb_for_cond_cleanup79.io.Out(7)


  const13.io.enable <> bb_for_body810.io.Out(0)

  const14.io.enable <> bb_for_body810.io.Out(1)

  const15.io.enable <> bb_for_body810.io.Out(2)

  phiindvars_iv35.io.enable <> bb_for_body810.io.Out(3)


  Gep_arrayidx36.io.enable <> bb_for_body810.io.Out(4)


  ld_37.io.enable <> bb_for_body810.io.Out(5)


  binaryOp_mul38.io.enable <> bb_for_body810.io.Out(6)


  st_39.io.enable <> bb_for_body810.io.Out(7)


  binaryOp_indvars_iv_next40.io.enable <> bb_for_body810.io.Out(8)


  icmp_exitcond41.io.enable <> bb_for_body810.io.Out(9)


  br_42.io.enable <> bb_for_body810.io.Out(10)




  /* ================================================================== *
   *                   CONNECTING PHI NODES                             *
   * ================================================================== */

  phiadd_lcssa10.io.Mask <> bb_for_cond_cleanup1.io.MaskBB(0)

  phii_05113.io.Mask <> bb_for_body2.io.MaskBB(0)

  phiresult_05014.io.Mask <> bb_for_body2.io.MaskBB(1)

  phij_04925.io.Mask <> bb_for_body46.io.MaskBB(0)

  phiindvars_iv35.io.Mask <> bb_for_body810.io.MaskBB(0)



  /* ================================================================== *
   *                   PRINT ALLOCA OFFSET                              *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING MEMORY CONNECTIONS                    *
   * ================================================================== */

  MemCtrl.io.ReadIn(0) <> ld_18.io.memReq

  ld_18.io.memResp <> MemCtrl.io.ReadOut(0)

  MemCtrl.io.WriteIn(0) <> st_21.io.memReq

  st_21.io.memResp <> MemCtrl.io.WriteOut(0)

  MemCtrl.io.ReadIn(1) <> ld_29.io.memReq

  ld_29.io.memResp <> MemCtrl.io.ReadOut(1)

  MemCtrl.io.WriteIn(1) <> st_31.io.memReq

  st_31.io.memResp <> MemCtrl.io.WriteOut(1)

  MemCtrl.io.ReadIn(2) <> ld_37.io.memReq

  ld_37.io.memResp <> MemCtrl.io.ReadOut(2)

  MemCtrl.io.WriteIn(2) <> st_39.io.memReq

  st_39.io.memResp <> MemCtrl.io.WriteOut(2)



  /* ================================================================== *
   *                   PRINT SHARED CONNECTIONS                         *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  icmp_cmp2480.io.RightIO <> const0.io.Out

  icmp_cmp6461.io.RightIO <> const1.io.Out

  binaryOp_sub2.io.RightIO <> const2.io.Out

  binaryOp_sub175.io.RightIO <> const3.io.Out

  binaryOp_div11.io.RightIO <> const4.io.Out

  phii_05113.io.InData(0) <> const5.io.Out

  phiresult_05014.io.InData(0) <> const6.io.Out

  binaryOp_inc2320.io.RightIO <> const7.io.Out

  binaryOp_inc2522.io.RightIO <> const8.io.Out

  icmp_exitcond5323.io.RightIO <> const9.io.Out

  phij_04925.io.InData(1) <> const10.io.Out

  binaryOp_inc1330.io.RightIO <> const11.io.Out

  binaryOp_inc1532.io.RightIO <> const12.io.Out

  phiindvars_iv35.io.InData(1) <> const13.io.Out

  binaryOp_mul38.io.RightIO <> const14.io.Out

  binaryOp_indvars_iv_next40.io.RightIO <> const15.io.Out

  sextidxprom113.io.Input <> binaryOp_sub2.io.Out(0)

  Gep_arrayidx124.io.idx(0) <> sextidxprom113.io.Out(0)

  sextidxprom186.io.Input <> binaryOp_sub175.io.Out(0)

  Gep_arrayidx197.io.idx(0) <> sextidxprom186.io.Out(0)

  binaryOp_div11.io.LeftIO <> phiadd_lcssa10.io.Out(0)

  ret_12.io.In.data("field0") <> binaryOp_div11.io.Out(0)

  binaryOp_inc2522.io.LeftIO <> phii_05113.io.Out(0)

  binaryOp_add19.io.RightIO <> phiresult_05014.io.Out(0)

  binaryOp_add19.io.LeftIO <> ld_18.io.Out(0)

  binaryOp_inc2320.io.LeftIO <> ld_18.io.Out(1)

  st_21.io.inData <> binaryOp_inc2320.io.Out(0)

  icmp_exitcond5323.io.LeftIO <> binaryOp_inc2522.io.Out(1)

  br_24.io.CmpIO <> icmp_exitcond5323.io.Out(0)

  binaryOp_inc1532.io.LeftIO <> phij_04925.io.Out(0)

  binaryOp_inc1330.io.LeftIO <> ld_29.io.Out(0)

  st_31.io.inData <> binaryOp_inc1330.io.Out(0)

  icmp_exitcond5233.io.LeftIO <> binaryOp_inc1532.io.Out(1)

  br_34.io.CmpIO <> icmp_exitcond5233.io.Out(0)

  Gep_arrayidx36.io.idx(0) <> phiindvars_iv35.io.Out(0)

  binaryOp_indvars_iv_next40.io.LeftIO <> phiindvars_iv35.io.Out(1)

  ld_37.io.GepAddr <> Gep_arrayidx36.io.Out(0)

  st_39.io.GepAddr <> Gep_arrayidx36.io.Out(1)

  binaryOp_mul38.io.LeftIO <> ld_37.io.Out(0)

  st_39.io.inData <> binaryOp_mul38.io.Out(0)

  icmp_exitcond41.io.LeftIO <> binaryOp_indvars_iv_next40.io.Out(1)

  br_42.io.CmpIO <> icmp_exitcond41.io.Out(0)

  Gep_arrayidx124.io.baseAddress <> ArgSplitter.io.Out.dataPtrs.elements("field0")(1)

  Gep_arrayidx197.io.baseAddress <> ArgSplitter.io.Out.dataPtrs.elements("field0")(2)

  icmp_cmp2480.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(1)

  icmp_cmp6461.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(2)

  binaryOp_sub2.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(3)

  binaryOp_sub175.io.LeftIO <> ArgSplitter.io.Out.dataVals.elements("field0")(4)

  sextwide_trip_count8.io.Input <> ArgSplitter.io.Out.dataVals.elements("field0")(5)

  st_21.io.Out(0).ready := true.B

  st_31.io.Out(0).ready := true.B

  st_39.io.Out(0).ready := true.B



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  br_24.io.PredOp(0) <> st_21.io.SuccOp(0)

  br_34.io.PredOp(0) <> st_31.io.SuccOp(0)

  br_42.io.PredOp(0) <> st_39.io.SuccOp(0)



  /* ================================================================== *
   *                   PRINTING OUTPUT INTERFACE                        *
   * ================================================================== */

  io.out <> ret_12.io.Out

}

