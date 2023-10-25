# Chapter 4:Components

### 4.1 Components in Chisel are Modules

### 4.2 Nested Components

### 4.3 An Arithmetic Logic Unit : Switch



```scala
import chisel3.util._

class Alu extends Module{
  val io = IO(new Bundle){
    val a = Input(Uint(16.W))
    val b = Input(Uint(16.W))
    val fn = Input(Uint(2.w))
    val o = Output(Uint(16.W))
  }
  
  switch(io.fn){
    is(0.U){io.o := io.a+io.b}
    is(1.U){io.o := io.a-io.b}
    is(2.U){io.o := io.a*io.b}
    is(3.U){io.o := io.a/io.b}
  }
}
```



![image-20231024234029285](/Users/tangzhijiang/Desktop/我/研究生/大四上/Chisel-Learn/笔记/assets/image-20231024234029285.png)



### 4.4 Bulk Connection 

使用```<>```可以将两个```Module```模块的```IO```快速连接在一起

```scala
fetch.io<>decode.io
```



### 4.5 External Modules

有时想在Chisel中写入Verilog代码