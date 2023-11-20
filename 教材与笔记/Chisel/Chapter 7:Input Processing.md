# Chapter 7:Input Processing

输入信号可能是有噪声的尖峰，这可能会在我们的同步电路中触发一个过渡。本章描述了处理这种输入条件的电路。

### 7.1 Asynchronous Input（异步输入）

与系统时钟不同步的输入信号被称为异步信号。这些信号可能会违反触发器输入的设置和保持时间。这种违反行为可能会导致 触发器的亚稳态。亚稳态可能导致输出值在0到1之间，也可能导致振荡。然而，在一段时间后，触发器将稳定在0或1

我们不能避免亚稳态，但我们可以控制它的影响。一个经典的解决方案是在输入端使用两个 flip-flops。假设当第一个触发器变得亚稳态时，它就会重新出现 在时钟周期内求解到一个稳定的状态，从而不会违反第二个触发器的设置和保持时间。



### 7.2 Debouncing



### 7.3 Filtering of the Input Signal



### 7.4 Combining the Input Processing with Functions

第10.2节展示了我们如何用轻量级的Chisel函数来抽象小的构建块，而不是完整的模块

### 7.5 Synchronizing Reset

任何数字电路都需要一个复位信号来将寄存器重置到一个定义的状态。重置状态是在Chisel中使用RegInit构造函数进行设置的。一个复位信号通常是一个异步输入到电路。

复位和时钟信号通常被隐藏在Chisel Design中，每个module都有一个隐式字段reset。使用方法是使用一个顶层模块来控制底层模块的复位信号。

```scala
class SyncReset extends Module {
val io = IO(new Bundle () {
val value = Output(UInt ())
})
val syncReset = RegNext(RegNext(reset))
val cnt = Module(new WhenCounter (5))
cnt.reset := syncReset
io.value := cnt.io.cnt
}

```

