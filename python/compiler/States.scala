package memGen.memory.cache

    import chisel3._
    import chisel3.util._

    object States{

    	val StateArray = Map(
		(s"I", 0x0), 
		(s"II", 0x1), 
		(s"M", 0x2), 
		(s"MI", 0x3), 
		(s"MII", 0x4), 
		(s"IS", 0x5), 
		(s"IM", 0x6)
	)
	val stateLen =  if (StateArray.size == 1 ) 1 else log2Ceil(StateArray.size)
}