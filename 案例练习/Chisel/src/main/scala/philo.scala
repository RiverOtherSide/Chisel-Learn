

import chisel3._
import chisel3.util._

class philosopher(state_init:UInt) extends Module{
  val io=IO{new Bundle{
//    val go = Input(Bool())
    val left = Input(UInt(2.W))
    val right = Input(UInt(2.W))
//    val state_init = Input(UInt(2.W))
    val out = Output(UInt(2.W))
  }}
  val busy::leftbusy::rightbusy::idle::Nil = Enum(4)
  val state = RegInit(UInt(2.W),state_init)

  io.out := state

    switch(state){
      is(idle){when(io.left=/=rightbusy && io.left=/=busy){state := leftbusy}}
      is(leftbusy){when(io.right=/=leftbusy && io.right=/=busy){state := rightbusy}}
      is(rightbusy){state := busy}
      is(busy){state := idle}
  }
}


class philo extends Module {
  val io = IO(new Bundle {
    val ph1_init = Input(UInt(2.W))
    val ph2_init = Input(UInt(2.W))
    val ph3_init = Input(UInt(2.W))
    val ph4_init = Input(UInt(2.W))
    val ph1_out = Output(UInt(2.W))
    val ph2_out = Output(UInt(2.W))
    val ph3_out = Output(UInt(2.W))
    val ph4_out = Output(UInt(2.W))
  })
  val busy::leftbusy::rightbusy::idle::Nil = Enum(4)
// 这么写会报错
//  val ph1 = Module(new philosopher(io.ph1_init))
//  val ph2 = Module(new philosopher(io.ph2_init))
//  val ph3 = Module(new philosopher(io.ph3_init))
//  val ph4 = Module(new philosopher(io.ph4_init))

  val ph1 = Module(new philosopher(busy))
  val ph2 = Module(new philosopher(idle))
  val ph3 = Module(new philosopher(leftbusy))
  val ph4 = Module(new philosopher(idle))


  ph1.io.right := ph4.io.out
  ph1.io.left := ph2.io.out
  ph2.io.right := ph1.io.out
  ph2.io.left := ph3.io.out
  ph3.io.right := ph2.io.out
  ph3.io.left := ph4.io.out
  ph4.io.right := ph3.io.out
  ph4.io.left := ph1.io.out

  io.ph1_out := ph1.io.out
  io.ph2_out := ph2.io.out
  io.ph3_out := ph3.io.out
  io.ph4_out := ph4.io.out
}

object philoMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new philo(), Array("--target-dir", "generated"))
}