package test

import chisel3.MultiIOModule
import chipsalliance.rocketchip.config._
import dandelion.config._
import dandelion.generator._
import dandelion.accel.{DandelionAccelDCRModule, DandelionAccelModule}


/**
 * This is an abstract class that contains all the dandelion test cases
 * @param p
 * @tparam T
 */
abstract class DandelionTestDCRAccel[T <: DandelionAccelDCRModule](implicit val p: Parameters) extends MultiIOModule with HasAccelShellParams

object DandelionTestDCRAccel {

  /**
   * Please make sure to add your new test case in the apply function
   * @param testName
   * @param p
   * @return
   */
  def apply(testName: String)(implicit p: Parameters): () => DandelionAccelDCRModule = {
    testName match {
      case "test01" => () => new test01DF()
      case "test02" => () => new test02DF()
      case "test03" => () => new test03DF()
      case "test04" => () => new test04DF()
      case "test05" => () => new test05DF()
      case "test06" => () => new test06DF()
      case "test07" => () => new test07DF()
      case "test08" => () => new test08DF()
      case "test09" => () => new test09DF()
      case _ => throw new Exception(s"[EXCEPTION] The accel's name is not defined -- " +
        s"Please check the accel name you have passed: ${testName}")
    }
  }

}
