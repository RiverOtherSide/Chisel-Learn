import chisel3._
import chisel3.util._

// 电梯厢
class elevator extends Module{
  val io = IO(new Bundle() {
    val stop_next = Input(Bool())   // 下层是否停靠
    val continue = Input(Bool())
    val random_push = Input(UInt(4.W))
    val random = Input(Bool())
    val r_stop = Input(Bool())     //什么参数？是否停
//
//    val init = Input(UInt(2.W))

    val inc = Output(Bool())
    val dec = Output(Bool())
    val location = Output(UInt(2.W))
    val door = Output(UInt(2.W))
    val movement = Output(Bool())
    val open_next = Output(Bool())
    val direction0 = Output(Bool())
  })
  val up :: down :: Nil = Enum(2)
  val stopped :: moving :: Nil = Enum(2)
  val open :: opening :: closed :: closing::Nil = Enum(4)
  val on :: off :: Nil = Enum(2)

  val inc = RegInit(true.B)
  io.inc := inc
  val dec = RegInit(false.B)
  io.dec := dec

//  电梯厢内部按钮
  val buttons = RegInit(VecInit.fill(4)(off))
//  无法使用input对reg进行初始化，要用常数进行初始化
  val location = RegInit(UInt(2.W),0.U)
  io.location := location
  val direction = RegInit(Bool(),up)
  io.direction0 := direction
  val door = RegInit(UInt(2.W),open)
  io.door := door
  val open_next = RegInit(Bool(),false.B)
  io.open_next := open_next
  val movement = RegInit(Bool(),stopped)
  io.movement := movement

  //
  val bottom = Wire(Vec(3,UInt(1.W)))
  bottom(0) := buttons(0)===on
  bottom(1) := bottom(0) | buttons(1)===on
  bottom(2) := bottom(1) | buttons(2)===on

  //
  val top = Wire(Vec(3,UInt(1.W)))
  top(2) := buttons(3)===on
  top(1) := top(2) | buttons(2)===on
  top(0) := top(1) | buttons(1)===on

  val button_above, button_below = Wire(Bool())
  button_below := (location === 3.U && bottom(2).asBool) ||
                  (location === 2.U && bottom(1).asBool) ||
                  (location === 1.U && bottom(0).asBool)
  button_above := (location === 0.U && top(0).asBool) ||
                  (location === 1.U && top(1).asBool) ||
                  (location === 2.U && top(2).asBool)

  buttons(location) := off
  when(io.random_push(0).asBool){buttons(0):=on}
  when(io.random_push(1).asBool){buttons(1):=on}
  when(io.random_push(2).asBool){buttons(2):=on}
  when(io.random_push(3).asBool){buttons(3):=on}

  //
  when(io.stop_next){
    when(direction===up){
      buttons(location+1.U) := on
    }.otherwise{
      buttons(location-1.U) := on
    }
  }

  // 判断下一层是否需要停
  when(door=/=closed){
    open_next := false.B
  }.elsewhen(movement === moving &&
              (io.stop_next ||
                (direction===up && buttons(location+1.U)===on) ||
                (direction===down && buttons(location-1.U)===on))){
    open_next := true.B
  }

  //
  switch(door){
    is(closed){when(open_next && movement===stopped){door:=opening}}
    is(opening){when(io.random){door:=open}}
    is(open){when(io.random){door:=closing}}
    is(closing){when(io.random){door:=closed}}
  }

  //
  val stop_moving,start_moving = Wire(Bool())
  start_moving := (io.continue || button_above && direction===up) ||
                 (button_below & direction===down)
  stop_moving := io.r_stop&&(movement===moving)
  inc := (stop_moving)&&(direction===up)
  dec := (stop_moving)&&(direction===down)

  //
  when(door===closed){
    switch(movement){
      is(stopped){when(door===closed&&start_moving&& !open_next){movement:=moving}}
      is(moving){
        when(stop_moving){movement:=stopped}
        when(direction === up) {location := location + 1.U}
        when(direction === down) {location := location - 1.U}
      }
    }
  }

  //
  switch(direction){
    is(up){when((!button_above)&& !io.continue){direction:=down}}
    is(down){when((!button_below)&& !io.continue){direction:=up}}
  }
  when(location===3.U){direction:=down}
  when(location===0.U){direction:=up}
}

class main_control extends Module{
  val io = IO(new Bundle(){
    val inc = Input(Bool())
    val dec = Input(Bool())
    val random_up = Input(UInt(4.W))
    val random_down = Input(UInt(4.W))

    val stop_next = Output(Bool())
    val continue = Output(Bool())
  })
  val up :: down :: Nil = Enum(2)
  val off :: on :: Nil = Enum(2)

  val stop_next = RegInit(false.B)
  io.stop_next := stop_next
  val continue = RegInit(false.B)
  io.continue := continue

  val locations = RegInit(UInt(2.W),0.U)
  val directions = RegInit(Bool(),up)
  val up_floor_buttons = RegInit(VecInit.fill(4)(off))
  val down_floor_buttons = RegInit(VecInit.fill(4)(off))

  val buttons = Wire(Vec(4,Bool()))
  buttons(0) := up_floor_buttons(0)===on || down_floor_buttons(0)===on
  buttons(1) := up_floor_buttons(1)===on || down_floor_buttons(1)===on
  buttons(2) := up_floor_buttons(2)===on || down_floor_buttons(2)===on
  buttons(3) := up_floor_buttons(3)===on || down_floor_buttons(3)===on

  val bottom, top = Wire(Vec(3,Bool()))
  bottom(0) := buttons(0)
  bottom(1) := bottom(0) || buttons(1)
  bottom(2) := bottom(1) || buttons(2)
  top(2) := buttons(3)
  top(1) := top(2) || buttons(2)
  top(0) := top(1) || buttons(1)

  val button_below,button_above = Wire(Bool())
  button_below := ((locations===3.U && bottom(2)) ||
                   (locations===2.U && bottom(1)) ||
                   (locations===1.U && bottom(0)))
  button_above := ((locations === 0.U && top(0)) ||
                   (locations === 1.U && top(1)) ||
                   (locations === 2.U && top(2)))

  continue := (button_above && directions === up) ||
              (button_below && directions === down)
  stop_next := Mux((locations =/= 3.U) && directions===up
                       ,Mux(up_floor_buttons(locations+1.U)===on,true.B,false.B)
                       ,Mux(locations=/=0.U && directions===down
                           ,Mux(down_floor_buttons(locations-1.U)===on,true.B,false.B)
                           ,false.B))

  for(i<-0 to 3){
    when(io.random_up(i.U).asBool){up_floor_buttons(i.U):=on}
    when(io.random_down(i.U).asBool){down_floor_buttons(i.U):=on}
  }

  when(locations=/=3.U && directions===up){
    when(up_floor_buttons(locations+1.U)===on){
      up_floor_buttons(locations+1.U):=off
    }
  }
  when(locations=/=0.U&&directions===down){
    when(down_floor_buttons(locations-1.U)===on){
      down_floor_buttons(locations-1.U) := off
    }
  }

  when(locations===3.U){directions := down}
  when(locations===0.U){directions := up}
  when(io.inc){
    locations := locations+1.U
    directions := up
  }
  when(io.dec){
    locations := locations-1.U
    directions := down
  }
}


class main extends Module{
  val io = IO(new Bundle() {
    val random_up = Input(UInt(4.W))
    val random_down = Input(UInt(4.W))
    val random = Input(Bool())
    val r_stop = Input(Bool())
    val random_push1 = Input(UInt(4.W))
//    val init1 = Input(UInt(4.W))

    val stop_next = Output(Bool())
    val continue = Output(Bool())

    val inc = Output(Bool())
    val dec = Output(Bool())

    val location = Output(UInt(2.W))
    val door = Output(UInt(2.W))
    val movement = Output(Bool())
    val open_next = Output(Bool())
    val direction0 = Output(Bool())
  })

  val e1 = Module(new elevator())
  val ec = Module(new main_control())
  ec.io.dec := e1.io.dec
  ec.io.inc := e1.io.inc
  ec.io.random_up := io.random_up
  ec.io.random_down := io.random_down

  e1.io.stop_next := ec.io.stop_next
  e1.io.continue := ec.io.continue
  e1.io.random_push := io.random_push1
  e1.io.r_stop := io.r_stop
  e1.io.random := io.random

  io.stop_next := ec.io.continue
  io.continue := ec.io.continue
  io.inc := e1.io.inc
  io.dec := e1.io.dec
  io.location := e1.io.location
  io.door := e1.io.door
  io.movement := e1.io.movement
  io.open_next := e1.io.open_next
  io.direction0 := e1.io.direction0

}

object elevatorMain extends App{
  emitVerilog(new elevator(), Array("--target-dir", "generated"))
  println("end")
}



