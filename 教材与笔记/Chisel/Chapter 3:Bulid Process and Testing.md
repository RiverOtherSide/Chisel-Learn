# Chapter 3:Bulid Process and Testing

### 3.1 Building Project with sbt

##### 3.1.1 Source Organization

在```./src/main/scala```中写项目的主要Scala代码，```./src/test/scala```写测试代码

![image-20231016115008091](./assets/image-20231016115008091.png)

如果想要构造包文件可以用以下代码

 ```scala
 package mypack
 import chisel3._
 
 class Abc extends Module{
   val io = IO(new Bundle{})
 }
 ```

可以用以下代码调用```mypack```包

```scala
import mypack._
class AbcUser extends Module{
  val io = IO(new Bundle{})
  val abc = new Abc()
}
```



##### 3.1.2 Running sbt

```shell	
sbt run # 编译执行整个项目
sbt "runMain mypacket.MyObject"  # 编译执行某一个MyObject
sbt test # 编译执行test目录下的代码
sbt "test:runMain mypacket.MyMainTest" # 
sbt "testOnly ExampleTest" # 只测试一个
sbt "testOnly SimpleTest -- -DwriteVcd=1" # 生成波形文件
```

也可以使用```Makefile```来构建

```makefile
# Generate Verilog code
doit:
	sbt run
# Run the test
test:
	sbt test
clean:
	git clean -fd
```

```build.sbt```文件

```scala
ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.12.13"

lazy val root = (project in file("."))
  .settings(
    name := "Chisel"
  )

// Chisel 3.5
addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.6" cross CrossVersion.full)
libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.5.6"
libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "0.5.6"
```





##### 3.1.3 Generating Verilog

为了生成Verilog描述，需要使用一个app。extends APP是一个Scala对象，其隐式的生成应用程序启动的主函数。使用```emitVerilog()```可以将Chisel翻译成硬件描述语言Verilog。默认的```emitVerilog()```将生成的文件放在项目根目录下。下边的代码将生成一个Hello.v的Verilog文件并放在generated子文件夹下。

```scala
object HelloOption extends App {
emitVerilog(new Hello(), Array("--target -dir",
"generated"))
}
```

也可以直接生成成Verilog代码的字符串打印出来

```scala
object HelloString extends App {
val s = getVerilogString(new Hello())
println(s)
}
```



##### Tool Flow

![image-20231016232347610](/Users/tangzhijiang/Desktop/我/研究生/大四上/Chisel-Learn/笔记/assets/image-20231016232347610.png)



### 3.2 Test with Chisel

##### 3.2.1 ScalaTest

在bulid.sbt中加入

```scala
libraryDependencies += "org. scalatest " %% " scalatest " % "3.1.4" % "test"
```



##### 3.2.2 ChiselTest

在bulid.sbt中加入

```scala
libraryDependencies += "edu. berkeley.cs" %% " chiseltest " % "0.5.6"
```

使用ChiselTest需要导入

```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
```

测试电路包括两部分：

- the device under test(DUT)

  - ```scala
    class DeviceUnderTest extends Module {
    val io = IO(new Bundle {
    val a = Input(UInt(2.W))
    val b = Input(UInt(2.W))
    val out = Output(UInt(2.W))
    val equ = Output(Bool())
    })
    io.out := io.a & io.b
    io.equ := io.a === io.b
    }
    ```

- The testing logic(test bench)

  - 拓展AnyFlatSpec和ChiselScalatestTester得到SimpleTest类。调用test()方法时，将DUT作为参数传入进行测试。

    - dut.io.a.poke(0.U)为DUT输入端口设置值
    - dut.io.out.peekInt()和dut.io.out.peekBoolean()得到DUT端口的输出并转为Scala类型的值
    - dut.clock.step()步进到下一时钟
    - dut.io.out.expect(0.U)将期望值作为参数的方式与输出值进行比较

    ```scala
    class SimpleTest extends AnyFlatSpec with
    ChiselScalatestTester {
    "DUT" should "pass" in {
    test(new DeviceUnderTest) { dut =>
    dut.io.a.poke(0.U)
    dut.io.b.poke(1.U)
    dut.clock.step()
    //测试方法1:打印出来
    println("Result is: " + dut.io.out.peekInt())
    //测试方法2:expect
    dut.io.out.expect(0.U)
    //测试方法3:assert断言
    val res = dut.io.out.peekInt()
    assert(res == 0)
    
    dut.io.a.poke(3.U)
    dut.io.b.poke(2.U)
    dut.clock.step()
    println("Result is: " + dut.io.out.peekInt())
    }}}
    ```



##### 3.2.3 Waveforms

- 使用sbt生成波形文件

  ```shell
  sbt "testOnly SimpleTest -- -DwriteVcd=1"
  ```

- 用test()函数的withAnnotations来生成波形

  ```scala
  class WaveformTest extends AnyFlatSpec with
  ChiselScalatestTester {
  "Waveform" should "pass" in {
  test(new DeviceUnderTest)
  .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  dut.io.a.poke(0.U)
  dut.io.b.poke(0.U)
  dut.clock.step()
  }}}
  ```

  

可以用Scala代码来枚举所有值

```scala
class WaveformCounterTest extends AnyFlatSpec with
ChiselScalatestTester {
"WaveformCounter" should "pass" in {
test(new DeviceUnderTest)
.withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
for (a <- 0 until 4) {
for (b <- 0 until 4) {
dut.io.a.poke(a.U)
dut.io.b.poke(b.U)
dut.clock.step()
}}}}}
```



##### 3.2.4 Printf调试

```scala
class DeviceUnderTestPrintf extends Module {
val io = IO(new Bundle {
val a = Input(UInt(2.W))
val b = Input(UInt(2.W))
val out = Output(UInt(2.W))
})
io.out := io.a & io.b
printf("dut: %d %d %d\n", io.a, io.b, io.out)
}
```



