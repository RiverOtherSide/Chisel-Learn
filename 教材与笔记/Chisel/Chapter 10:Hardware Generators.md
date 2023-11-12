# Chapter 10:Hardware Generators



硬件生成器是Chisel的一大优势



### 10.1 A Little Bit of Scala

我们需要Scala var来编写硬件生成器，但永远不需要var来命名硬件组件

##### 10.1.1 Loop

使用循环来生成shift register（移位寄存器）

```scala
val regVec = Reg(Vec(8,UInt(1.W)))
regVec(0) := io.din
for(i <- 1 until 8){regVec(i) := regVec(i-1)}
```



##### 10.1.2 Tuple





### 10.2 Lightweight Components with Functions

Module是构建硬件描述的标准方法。但是也可以使用函数构建样板代码，Scala函数可以获取Chisel（和Scala）参数，并返回生成的硬件。

```scala
def add(x:UInt,y:UInt):UInt={
  x+y
}
```



### 10.3 Configuration with Parameters

Chisel组件和功能可以用参数配置。参数可以像整数常数一样简单，但也可以是Chisel硬件类型

##### 10.3.1 Simple Parameters

```scala
class ParamAdder (n: Int) extends Module {
val io = IO(new Bundle{
val a = Input(UInt(n.W))
val b = Input(UInt(n.W))
val c = Output(UInt(n.W))
})
  io.c := io.a + io.b
}
```





##### 10.3.2 Case Classes

