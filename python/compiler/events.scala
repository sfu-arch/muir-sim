package memGen.memory.cache

    import chisel3._
    import chisel3.util._

    object Events {

    	val StateArray = Map(
		(s"From", 0x0), 
		(s"Load", 0x1), 
		(s"Ifetch", 0x2), 
		(s"Store", 0x3), 
		(s"Data", 0x4), 
		(s"Fwd_GETX", 0x5), 
		(s"Inv", 0x6), 
		(s"Replacement", 0x7), 
		(s"Writeback_Ack", 0x8), 
		(s"Writeback_Nack", 0x9)
	)
	val eventLen =  if (EventArray.size == 1 ) 1 else log2Ceil(EventArray.size)
}