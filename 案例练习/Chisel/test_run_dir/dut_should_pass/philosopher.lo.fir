FIRRTL version 1.1.0
circuit philosopher :
  module philosopher :
    input clock : Clock
    input reset : UInt<1>
    input io_go : UInt<1>
    input io_left : UInt<2>
    input io_right : UInt<2>
    output io_out : UInt<2>

    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[philo.scala 15:22]
    node _T = eq(UInt<2>("h3"), state) @[philo.scala 20:18]
    node _T_1 = neq(io_left, UInt<2>("h2")) @[philo.scala 21:28]
    node _T_2 = neq(io_left, UInt<2>("h0")) @[philo.scala 21:51]
    node _T_3 = and(_T_1, _T_2) @[philo.scala 21:41]
    node _GEN_0 = mux(_T_3, UInt<2>("h1"), state) @[philo.scala 15:22 21:{59,66}]
    node _T_4 = eq(UInt<2>("h1"), state) @[philo.scala 20:18]
    node _T_5 = neq(io_right, UInt<2>("h1")) @[philo.scala 22:33]
    node _T_6 = neq(io_right, UInt<2>("h0")) @[philo.scala 22:56]
    node _T_7 = and(_T_5, _T_6) @[philo.scala 22:45]
    node _GEN_1 = mux(_T_7, UInt<2>("h2"), state) @[philo.scala 15:22 22:{64,71}]
    node _T_8 = eq(UInt<2>("h2"), state) @[philo.scala 20:18]
    node _T_9 = eq(UInt<2>("h0"), state) @[philo.scala 20:18]
    node _GEN_2 = mux(_T_9, UInt<2>("h3"), state) @[philo.scala 20:18 15:22 24:22]
    node _GEN_3 = mux(_T_8, UInt<2>("h0"), _GEN_2) @[philo.scala 20:18 23:27]
    node _GEN_4 = mux(_T_4, _GEN_1, _GEN_3) @[philo.scala 20:18]
    node _GEN_5 = mux(_T, _GEN_0, _GEN_4) @[philo.scala 20:18]
    node _GEN_6 = mux(io_go, _GEN_5, state) @[philo.scala 19:14 15:22]
    io_out <= state @[philo.scala 17:10]
    state <= mux(reset, UInt<2>("h3"), _GEN_6) @[philo.scala 15:{22,22}]
