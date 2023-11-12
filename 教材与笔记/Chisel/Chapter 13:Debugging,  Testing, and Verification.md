# Chapter 13:Debugging,  Testing, and Verification



### 13.1 Debugging

### 13.2 Testing in Chisel

##### 13.2.1 peek and poke

可以将Chisel测试定义为使用ChiselScalatestTester扩展AnyFlatSpec的类，利用```peek```、```poke```、```expect```和```step```方法来进行测试

```scala
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class addTester extends AnyFlatSpec with ChiselScalatestTester {
  "Add" should "work" in {
    test(new adder) { dut =>
      for (a <- 0 to 2) {
        for (b <- 0 to 3) {
          val result = a + b
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step(1)
          dut.io.c.expect(result.U)
        }
      }
    }
  }
}

```



##### 13.2.2 functions

所有这些peek和expect都很麻烦。作为第一步，我们将引入表示读请求和写请求的函数。

```scala
" CounterDevice " should "work with functions " in {
test(new CounterDevice()) { dut =>
def step(n: Int = 1) = {
dut.clock.step(n)
}
def read(addr: Int) = {
dut.io.addr.poke(addr.U)
dut.io.rd.poke(true.B)
step ()
dut.io.rd.poke(false.B)
while (! dut.io.ack.peekBoolean ()) {
step ()
}
dut.io.rdData.peekInt ()
}
def write(addr: Int , data: Int) = {
dut.io.addr.poke(addr.U)
dut.io.wrData.poke(data.U)
dut.io.wr.poke(true.B)
step ()
dut.io.wr.poke(false.B)
while (!dut.io.ack. peekBoolean ()) {
step ()
}
}
for (i <- 0 until 4) {
assert(read(i) < 10, s"Counter $i should have just
started")
}
step (100)
for (i <- 0 until 4) {
assert(read(i) > 100, s"Counter $i should advance")
}
write (2, 0)
write (3, 1000)
assert(read (2) < 5, "Counter should reset")
assert(read (3) > 1000 , "Counter should load")
}
}
```



如果您有一个大型的测试，可能只希望运行的一部分测试。实现这一点的最简单的方法是使用tag打标签，然后使用sbt运行你标记的测试。

```scala
object Unnecessary extends Tag("Unnecessary")
class TagTest extends AnyFlatSpec with Matches{
  "Integers" should "add" taggedAs(Unnecessary) in{
    17+25 should be (42)
  }
}
```

```shell
sbt "testOnly * -- -l Unnecessary"
```



### 13.3 Multithreaded Testing



### 13.4 Simulator Backends

