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


class parallelDF(PtrsIn: Seq[Int] = List(64, 64, 64), ValsIn: Seq[Int] = List(), Returns: Seq[Int] = List())
			(implicit p: Parameters) extends DandelionAccelDCRModule(PtrsIn, ValsIn, Returns){


  /* ================================================================== *
   *                   PRINTING MEMORY MODULES                          *
   * ================================================================== */

  //Cache
  val mem_ctrl_cache = Module(new CacheMemoryEngine(ID = 0, NumRead = 3, NumWrite = 2))

  io.MemReq <> mem_ctrl_cache.io.cache.MemReq
  mem_ctrl_cache.io.cache.MemResp <> io.MemResp

  val ArgSplitter = Module(new SplitCallDCR(ptrsArgTypes = List(1, 1, 1), valsArgTypes = List()))
  ArgSplitter.io.In <> io.in



  /* ================================================================== *
   *                   PRINTING LOOP HEADERS                            *
   * ================================================================== */

  val Loop_0 = Module(new LoopBlockNode(NumIns = List(1, 2, 1, 1, 1), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 0))

  val Loop_1 = Module(new LoopBlockNode(NumIns = List(2, 1, 1, 1), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 1))

  val Loop_2 = Module(new LoopBlockNode(NumIns = List(1, 1, 1), NumOuts = List(), NumCarry = List(1), NumExits = 1, ID = 2))



  /* ================================================================== *
   *                   PRINTING BASICBLOCK NODES                        *
   * ================================================================== */

  val bb_entry0 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 0))

  val bb_for_body1 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 3, NumPhi = 1, BID = 1))

  val bb_for_body32 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 8, NumPhi = 1, BID = 2))

  val bb_for_body83 = Module(new BasicBlockNode(NumInputs = 2, NumOuts = 19, NumPhi = 1, BID = 3))

  val bb_for_inc214 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 5, BID = 4))

  val bb_for_inc245 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 5, BID = 5))

  val bb_for_end266 = Module(new BasicBlockNoMaskFastNode(NumInputs = 1, NumOuts = 1, BID = 6))



  /* ================================================================== *
   *                   PRINTING INSTRUCTION NODES                       *
   * ================================================================== */

  //  br label %for.body, !dbg !27, !UID !29, !BB_UID !30
  val br_0 = Module(new UBranchNode(ID = 0))

  //  %indvar = phi i64 [ 0, %entry ], [ %indvar.next, %for.inc24 ], !UID !31
  val phiindvar1 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 2, ID = 1, Res = true))

  //  br label %for.body3, !dbg !33, !UID !37, !BB_UID !38
  val br_2 = Module(new UBranchNode(ID = 2))

  //  %indvars.iv45 = phi i64 [ 0, %for.body ], [ %indvars.iv.next46, %for.inc21 ], !UID !39
  val phiindvars_iv453 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 3, ID = 3, Res = true))

  //  %tmp = getelementptr [2 x i32], [2 x i32]* %res, i64 %indvar, !UID !40
  val Gep_tmp4 = Module(new GepNode(NumIns = 2, NumOuts = 1, ID = 4)(ElementSize = 8, ArraySize = List(8)))

  //  %tmp1 = getelementptr [2 x i32], [2 x i32]* %tmp, i64 0, i64 %indvars.iv45, !UID !41
  val Gep_tmp15 = Module(new GepNode(NumIns = 2, NumOuts = 2, ID = 5)(ElementSize = 8, ArraySize = List(8)))

  //  store i32 0, i32* %tmp1, align 4, !dbg !42, !tbaa !45, !UID !49
  val st_6 = Module(new UnTypStoreCache(NumPredOps = 0, NumSuccOps = 1, ID = 6, RouteID = 3))

  //  br label %for.body8, !dbg !51, !UID !53, !BB_UID !54
  val br_7 = Module(new UBranchNode(NumPredOps=1, ID = 7))

  //  %indvars.iv = phi i64 [ 0, %for.body3 ], [ %indvars.iv.next, %for.body8 ], !UID !55
  val phiindvars_iv8 = Module(new PhiFastNode(NumInputs = 2, NumOutputs = 3, ID = 8, Res = true))

  //  %tmp2 = getelementptr [2 x i32], [2 x i32]* %mat1, i64 %indvar, !UID !56
  val Gep_tmp29 = Module(new GepNode(NumIns = 2, NumOuts = 1, ID = 9)(ElementSize = 8, ArraySize = List(8)))

  //  %tmp3 = getelementptr [2 x i32], [2 x i32]* %tmp2, i64 0, i64 %indvars.iv, !UID !57
  val Gep_tmp310 = Module(new GepNode(NumIns = 2, NumOuts = 1, ID = 10)(ElementSize = 8, ArraySize = List(8)))

  //  %0 = load i32, i32* %tmp3, align 4, !dbg !58, !tbaa !45, !UID !60
  val ld_11 = Module(new UnTypLoadCache(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 11, RouteID = 0))

  //  %tmp4 = getelementptr [2 x i32], [2 x i32]* %mat2, i64 %indvars.iv, !UID !61
  val Gep_tmp412 = Module(new GepNode(NumIns = 2, NumOuts = 1, ID = 12)(ElementSize = 8, ArraySize = List(8)))

  //  %tmp5 = getelementptr [2 x i32], [2 x i32]* %tmp4, i64 0, i64 %indvars.iv45, !UID !62
  val Gep_tmp513 = Module(new GepNode(NumIns = 2, NumOuts = 1, ID = 13)(ElementSize = 8, ArraySize = List(8)))

  //  %1 = load i32, i32* %tmp5, align 4, !dbg !63, !tbaa !45, !UID !64
  val ld_14 = Module(new UnTypLoadCache(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 14, RouteID = 1))

  //  %mul = mul nsw i32 %1, %0, !dbg !65, !UID !66
  val binaryOp_mul15 = Module(new ComputeNode(NumOuts = 1, ID = 15, opCode = "mul")(sign = false, Debug = false))

  //  %2 = load i32, i32* %tmp1, align 4, !dbg !67, !tbaa !45, !UID !68
  val ld_16 = Module(new UnTypLoadCache(NumPredOps = 0, NumSuccOps = 0, NumOuts = 1, ID = 16, RouteID = 2))

  //  %add = add nsw i32 %2, %mul, !dbg !67, !UID !69
  val binaryOp_add17 = Module(new ComputeNode(NumOuts = 1, ID = 17, opCode = "add")(sign = false, Debug = false))

  //  store i32 %add, i32* %tmp1, align 4, !dbg !67, !tbaa !45, !UID !70
  val st_18 = Module(new UnTypStoreCache(NumPredOps = 0, NumSuccOps = 1, ID = 18, RouteID = 4))

  //  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !71, !UID !72
  val binaryOp_indvars_iv_next19 = Module(new ComputeNode(NumOuts = 2, ID = 19, opCode = "add")(sign = false, Debug = false))

  //  %exitcond = icmp eq i64 %indvars.iv.next, 2, !dbg !73, !UID !74
  val icmp_exitcond20 = Module(new ComputeNode(NumOuts = 1, ID = 20, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond, label %for.inc21, label %for.body8, !dbg !51, !llvm.loop !75, !UID !77, !BB_UID !78
  val br_21 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 1, ID = 21))

  //  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1, !dbg !79, !UID !80
  val binaryOp_indvars_iv_next4622 = Module(new ComputeNode(NumOuts = 2, ID = 22, opCode = "add")(sign = false, Debug = false))

  //  %exitcond47 = icmp eq i64 %indvars.iv.next46, 2, !dbg !81, !UID !82
  val icmp_exitcond4723 = Module(new ComputeNode(NumOuts = 1, ID = 23, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond47, label %for.inc24, label %for.body3, !dbg !33, !llvm.loop !83, !UID !85, !BB_UID !86
  val br_24 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 24))

  //  %indvar.next = add nuw nsw i64 %indvar, 1, !dbg !87, !UID !88
  val binaryOp_indvar_next25 = Module(new ComputeNode(NumOuts = 2, ID = 25, opCode = "add")(sign = false, Debug = false))

  //  %exitcond49 = icmp eq i64 %indvar.next, 2, !dbg !89, !UID !90
  val icmp_exitcond4926 = Module(new ComputeNode(NumOuts = 1, ID = 26, opCode = "eq")(sign = false, Debug = false))

  //  br i1 %exitcond49, label %for.end26, label %for.body, !dbg !27, !llvm.loop !91, !UID !93, !BB_UID !94
  val br_27 = Module(new CBranchNodeVariable(NumTrue = 1, NumFalse = 1, NumPredecessor = 0, ID = 27))

  //  ret void, !dbg !95, !UID !96, !BB_UID !97
  val ret_28 = Module(new RetNode2(retTypes = List(), ID = 28))



  /* ================================================================== *
   *                   PRINTING CONSTANTS NODES                         *
   * ================================================================== */

  //i64 0
  val const0 = Module(new ConstFastNode(value = 0, ID = 0))

  //i64 0
  val const1 = Module(new ConstFastNode(value = 0, ID = 1))

  //i64 0
  val const2 = Module(new ConstFastNode(value = 0, ID = 2))

  //i32 0
  val const3 = Module(new ConstFastNode(value = 0, ID = 3))

  //i64 0
  val const4 = Module(new ConstFastNode(value = 0, ID = 4))

  //i64 0
  val const5 = Module(new ConstFastNode(value = 0, ID = 5))

  //i64 0
  val const6 = Module(new ConstFastNode(value = 0, ID = 6))

  //i64 1
  val const7 = Module(new ConstFastNode(value = 1, ID = 7))

  //i64 2
  val const8 = Module(new ConstFastNode(value = 2, ID = 8))

  //i64 1
  val const9 = Module(new ConstFastNode(value = 1, ID = 9))

  //i64 2
  val const10 = Module(new ConstFastNode(value = 2, ID = 10))

  //i64 1
  val const11 = Module(new ConstFastNode(value = 1, ID = 11))

  //i64 2
  val const12 = Module(new ConstFastNode(value = 2, ID = 12))



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE INSTRUCTION              *
   * ================================================================== */

  bb_entry0.io.predicateIn(0) <> ArgSplitter.io.Out.enable



  /* ================================================================== *
   *                   BASICBLOCK -> PREDICATE LOOP                     *
   * ================================================================== */

  bb_for_body1.io.predicateIn(1) <> Loop_2.io.activate_loop_start

  bb_for_body1.io.predicateIn(0) <> Loop_2.io.activate_loop_back

  bb_for_body32.io.predicateIn(1) <> Loop_1.io.activate_loop_start

  bb_for_body32.io.predicateIn(0) <> Loop_1.io.activate_loop_back

  bb_for_body83.io.predicateIn(1) <> Loop_0.io.activate_loop_start

  bb_for_body83.io.predicateIn(0) <> Loop_0.io.activate_loop_back

  bb_for_inc214.io.predicateIn(0) <> Loop_0.io.loopExit(0)

  bb_for_inc245.io.predicateIn(0) <> Loop_1.io.loopExit(0)

  bb_for_end266.io.predicateIn(0) <> Loop_2.io.loopExit(0)



  /* ================================================================== *
   *                   PRINTING PARALLEL CONNECTIONS                    *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP -> PREDICATE INSTRUCTION                    *
   * ================================================================== */

  Loop_0.io.enable <> br_7.io.Out(0)

  Loop_0.io.loopBack(0) <> br_21.io.FalseOutput(0)

  Loop_0.io.loopFinish(0) <> br_21.io.TrueOutput(0)

  Loop_1.io.enable <> br_2.io.Out(0)

  Loop_1.io.loopBack(0) <> br_24.io.FalseOutput(0)

  Loop_1.io.loopFinish(0) <> br_24.io.TrueOutput(0)

  Loop_2.io.enable <> br_0.io.Out(0)

  Loop_2.io.loopBack(0) <> br_27.io.FalseOutput(0)

  Loop_2.io.loopFinish(0) <> br_27.io.TrueOutput(0)



  /* ================================================================== *
   *                   ENDING INSTRUCTIONS                              *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP INPUT DATA DEPENDENCIES                     *
   * ================================================================== */

  Loop_0.io.InLiveIn(0) <> phiindvars_iv453.io.Out(0)

  Loop_0.io.InLiveIn(1) <> Gep_tmp15.io.Out(0)

  Loop_0.io.InLiveIn(2) <> Loop_1.io.OutLiveIn.elements("field0")(0)

  Loop_0.io.InLiveIn(3) <> Loop_1.io.OutLiveIn.elements("field1")(0)

  Loop_0.io.InLiveIn(4) <> Loop_1.io.OutLiveIn.elements("field2")(0)

  Loop_1.io.InLiveIn(0) <> phiindvar1.io.Out(0)

  Loop_1.io.InLiveIn(1) <> Loop_2.io.OutLiveIn.elements("field2")(0)

  Loop_1.io.InLiveIn(2) <> Loop_2.io.OutLiveIn.elements("field1")(0)

  Loop_1.io.InLiveIn(3) <> Loop_2.io.OutLiveIn.elements("field0")(0)

  Loop_2.io.InLiveIn(0) <> ArgSplitter.io.Out.dataPtrs.elements("field2")(0)

  Loop_2.io.InLiveIn(1) <> ArgSplitter.io.Out.dataPtrs.elements("field0")(0)

  Loop_2.io.InLiveIn(2) <> ArgSplitter.io.Out.dataPtrs.elements("field1")(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-IN DEPENDENCIES                   *
   * ================================================================== */

  Gep_tmp513.io.idx(1) <> Loop_0.io.OutLiveIn.elements("field0")(0)

  ld_16.io.GepAddr <> Loop_0.io.OutLiveIn.elements("field1")(0)

  st_18.io.GepAddr <> Loop_0.io.OutLiveIn.elements("field1")(1)

  Gep_tmp29.io.idx(0) <> Loop_0.io.OutLiveIn.elements("field2")(0)

  Gep_tmp412.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field3")(0)

  Gep_tmp29.io.baseAddress <> Loop_0.io.OutLiveIn.elements("field4")(0)

  Gep_tmp4.io.idx(0) <> Loop_1.io.OutLiveIn.elements("field0")(1)

  Gep_tmp4.io.baseAddress <> Loop_1.io.OutLiveIn.elements("field3")(0)



  /* ================================================================== *
   *                   LOOP DATA LIVE-OUT DEPENDENCIES                  *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP LIVE OUT DEPENDENCIES                       *
   * ================================================================== */



  /* ================================================================== *
   *                   LOOP CARRY DEPENDENCIES                          *
   * ================================================================== */

  Loop_0.io.CarryDepenIn(0) <> binaryOp_indvars_iv_next19.io.Out(0)

  Loop_1.io.CarryDepenIn(0) <> binaryOp_indvars_iv_next4622.io.Out(0)

  Loop_2.io.CarryDepenIn(0) <> binaryOp_indvar_next25.io.Out(0)



  /* ================================================================== *
   *                   LOOP DATA CARRY DEPENDENCIES                     *
   * ================================================================== */

  phiindvars_iv8.io.InData(1) <> Loop_0.io.CarryDepenOut.elements("field0")(0)

  phiindvars_iv453.io.InData(1) <> Loop_1.io.CarryDepenOut.elements("field0")(0)

  phiindvar1.io.InData(1) <> Loop_2.io.CarryDepenOut.elements("field0")(0)



  /* ================================================================== *
   *                   BASICBLOCK -> ENABLE INSTRUCTION                 *
   * ================================================================== */

  br_0.io.enable <> bb_entry0.io.Out(0)


  const0.io.enable <> bb_for_body1.io.Out(0)

  phiindvar1.io.enable <> bb_for_body1.io.Out(1)


  br_2.io.enable <> bb_for_body1.io.Out(2)


  const1.io.enable <> bb_for_body32.io.Out(0)

  const2.io.enable <> bb_for_body32.io.Out(1)

  const3.io.enable <> bb_for_body32.io.Out(2)

  phiindvars_iv453.io.enable <> bb_for_body32.io.Out(3)


  Gep_tmp4.io.enable <> bb_for_body32.io.Out(4)


  Gep_tmp15.io.enable <> bb_for_body32.io.Out(5)


  st_6.io.enable <> bb_for_body32.io.Out(6)


  br_7.io.enable <> bb_for_body32.io.Out(7)


  const4.io.enable <> bb_for_body83.io.Out(0)

  const5.io.enable <> bb_for_body83.io.Out(1)

  const6.io.enable <> bb_for_body83.io.Out(2)

  const7.io.enable <> bb_for_body83.io.Out(3)

  const8.io.enable <> bb_for_body83.io.Out(4)

  phiindvars_iv8.io.enable <> bb_for_body83.io.Out(5)


  Gep_tmp29.io.enable <> bb_for_body83.io.Out(6)


  Gep_tmp310.io.enable <> bb_for_body83.io.Out(7)


  ld_11.io.enable <> bb_for_body83.io.Out(8)


  Gep_tmp412.io.enable <> bb_for_body83.io.Out(9)


  Gep_tmp513.io.enable <> bb_for_body83.io.Out(10)


  ld_14.io.enable <> bb_for_body83.io.Out(11)


  binaryOp_mul15.io.enable <> bb_for_body83.io.Out(12)


  ld_16.io.enable <> bb_for_body83.io.Out(13)


  binaryOp_add17.io.enable <> bb_for_body83.io.Out(14)


  st_18.io.enable <> bb_for_body83.io.Out(15)


  binaryOp_indvars_iv_next19.io.enable <> bb_for_body83.io.Out(16)


  icmp_exitcond20.io.enable <> bb_for_body83.io.Out(17)


  br_21.io.enable <> bb_for_body83.io.Out(18)


  const9.io.enable <> bb_for_inc214.io.Out(0)

  const10.io.enable <> bb_for_inc214.io.Out(1)

  binaryOp_indvars_iv_next4622.io.enable <> bb_for_inc214.io.Out(2)


  icmp_exitcond4723.io.enable <> bb_for_inc214.io.Out(3)


  br_24.io.enable <> bb_for_inc214.io.Out(4)


  const11.io.enable <> bb_for_inc245.io.Out(0)

  const12.io.enable <> bb_for_inc245.io.Out(1)

  binaryOp_indvar_next25.io.enable <> bb_for_inc245.io.Out(2)


  icmp_exitcond4926.io.enable <> bb_for_inc245.io.Out(3)


  br_27.io.enable <> bb_for_inc245.io.Out(4)


  ret_28.io.In.enable <> bb_for_end266.io.Out(0)




  /* ================================================================== *
   *                   CONNECTING PHI NODES                             *
   * ================================================================== */

  phiindvar1.io.Mask <> bb_for_body1.io.MaskBB(0)

  phiindvars_iv453.io.Mask <> bb_for_body32.io.MaskBB(0)

  phiindvars_iv8.io.Mask <> bb_for_body83.io.MaskBB(0)



  /* ================================================================== *
   *                   CONNECTING MEMORY CONNECTIONS                    *
   * ================================================================== */

  mem_ctrl_cache.io.rd.mem(0).MemReq <> ld_11.io.MemReq
  ld_11.io.MemResp <> mem_ctrl_cache.io.rd.mem(0).MemResp
  mem_ctrl_cache.io.rd.mem(1).MemReq <> ld_14.io.MemReq
  ld_14.io.MemResp <> mem_ctrl_cache.io.rd.mem(1).MemResp
  mem_ctrl_cache.io.rd.mem(2).MemReq <> ld_16.io.MemReq
  ld_16.io.MemResp <> mem_ctrl_cache.io.rd.mem(2).MemResp
  mem_ctrl_cache.io.wr.mem(0).MemReq <> st_6.io.MemReq
  st_6.io.MemResp <> mem_ctrl_cache.io.wr.mem(0).MemResp

  mem_ctrl_cache.io.wr.mem(1).MemReq <> st_18.io.MemReq
  st_18.io.MemResp <> mem_ctrl_cache.io.wr.mem(1).MemResp



  /* ================================================================== *
   *                   PRINT SHARED CONNECTIONS                         *
   * ================================================================== */



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  phiindvar1.io.InData(0) <> const0.io.Out

  phiindvars_iv453.io.InData(0) <> const1.io.Out

  Gep_tmp15.io.idx(0) <> const2.io.Out

  st_6.io.inData <> const3.io.Out

  phiindvars_iv8.io.InData(0) <> const4.io.Out

  Gep_tmp310.io.idx(0) <> const5.io.Out

  Gep_tmp513.io.idx(0) <> const6.io.Out

  binaryOp_indvars_iv_next19.io.RightIO <> const7.io.Out

  icmp_exitcond20.io.RightIO <> const8.io.Out

  binaryOp_indvars_iv_next4622.io.RightIO <> const9.io.Out

  icmp_exitcond4723.io.RightIO <> const10.io.Out

  binaryOp_indvar_next25.io.RightIO <> const11.io.Out

  icmp_exitcond4926.io.RightIO <> const12.io.Out

  binaryOp_indvar_next25.io.LeftIO <> phiindvar1.io.Out(1)

  Gep_tmp15.io.idx(1) <> phiindvars_iv453.io.Out(1)

  binaryOp_indvars_iv_next4622.io.LeftIO <> phiindvars_iv453.io.Out(2)

  Gep_tmp15.io.baseAddress <> Gep_tmp4.io.Out(0)

  st_6.io.GepAddr <> Gep_tmp15.io.Out(1)

  Gep_tmp310.io.idx(1) <> phiindvars_iv8.io.Out(0)

  Gep_tmp412.io.idx(0) <> phiindvars_iv8.io.Out(1)

  binaryOp_indvars_iv_next19.io.LeftIO <> phiindvars_iv8.io.Out(2)

  Gep_tmp310.io.baseAddress <> Gep_tmp29.io.Out(0)

  ld_11.io.GepAddr <> Gep_tmp310.io.Out(0)

  binaryOp_mul15.io.RightIO <> ld_11.io.Out(0)

  Gep_tmp513.io.baseAddress <> Gep_tmp412.io.Out(0)

  ld_14.io.GepAddr <> Gep_tmp513.io.Out(0)

  binaryOp_mul15.io.LeftIO <> ld_14.io.Out(0)

  binaryOp_add17.io.RightIO <> binaryOp_mul15.io.Out(0)

  binaryOp_add17.io.LeftIO <> ld_16.io.Out(0)

  st_18.io.inData <> binaryOp_add17.io.Out(0)

  icmp_exitcond20.io.LeftIO <> binaryOp_indvars_iv_next19.io.Out(1)

  br_21.io.CmpIO <> icmp_exitcond20.io.Out(0)

  icmp_exitcond4723.io.LeftIO <> binaryOp_indvars_iv_next4622.io.Out(1)

  br_24.io.CmpIO <> icmp_exitcond4723.io.Out(0)

  icmp_exitcond4926.io.LeftIO <> binaryOp_indvar_next25.io.Out(1)

  br_27.io.CmpIO <> icmp_exitcond4926.io.Out(0)

  st_6.io.Out(0).ready := true.B

  st_18.io.Out(0).ready := true.B



  /* ================================================================== *
   *                   CONNECTING DATA DEPENDENCIES                     *
   * ================================================================== */

  br_7.io.PredOp(0) <> st_6.io.SuccOp(0)

  br_21.io.PredOp(0) <> st_18.io.SuccOp(0)



  /* ================================================================== *
   *                   PRINTING OUTPUT INTERFACE                        *
   * ================================================================== */

  io.out <> ret_28.io.Out

}

