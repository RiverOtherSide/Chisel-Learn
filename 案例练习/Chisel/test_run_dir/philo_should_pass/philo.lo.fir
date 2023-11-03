FIRRTL version 1.1.0
circuit philo :
  module philosopher :
    input clock : Clock
    input reset : UInt<1>
    input io_left : UInt<2>
    input io_right : UInt<2>
    output io_out : UInt<2>

    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[philo.scala 15:22]
    node _T = eq(UInt<2>("h3"), state) @[philo.scala 19:18]
    node _T_1 = neq(io_left, UInt<2>("h2")) @[philo.scala 20:28]
    node _T_2 = neq(io_left, UInt<2>("h0")) @[philo.scala 20:51]
    node _T_3 = and(_T_1, _T_2) @[philo.scala 20:41]
    node _GEN_0 = mux(_T_3, UInt<2>("h1"), state) @[philo.scala 15:22 20:{59,66}]
    node _T_4 = eq(UInt<2>("h1"), state) @[philo.scala 19:18]
    node _T_5 = neq(io_right, UInt<2>("h1")) @[philo.scala 21:33]
    node _T_6 = neq(io_right, UInt<2>("h0")) @[philo.scala 21:56]
    node _T_7 = and(_T_5, _T_6) @[philo.scala 21:45]
    node _GEN_1 = mux(_T_7, UInt<2>("h2"), state) @[philo.scala 15:22 21:{64,71}]
    node _T_8 = eq(UInt<2>("h2"), state) @[philo.scala 19:18]
    node _T_9 = eq(UInt<2>("h0"), state) @[philo.scala 19:18]
    node _GEN_2 = mux(_T_9, UInt<2>("h3"), state) @[philo.scala 19:18 15:22 23:22]
    node _GEN_3 = mux(_T_8, UInt<2>("h0"), _GEN_2) @[philo.scala 19:18 22:27]
    node _GEN_4 = mux(_T_4, _GEN_1, _GEN_3) @[philo.scala 19:18]
    node _GEN_5 = mux(_T, _GEN_0, _GEN_4) @[philo.scala 19:18]
    io_out <= state @[philo.scala 17:10]
    state <= mux(reset, UInt<2>("h0"), _GEN_5) @[philo.scala 15:{22,22}]

  module philosopher_1 :
    input clock : Clock
    input reset : UInt<1>
    input io_left : UInt<2>
    input io_right : UInt<2>
    output io_out : UInt<2>

    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[philo.scala 15:22]
    node _T = eq(UInt<2>("h3"), state) @[philo.scala 19:18]
    node _T_1 = neq(io_left, UInt<2>("h2")) @[philo.scala 20:28]
    node _T_2 = neq(io_left, UInt<2>("h0")) @[philo.scala 20:51]
    node _T_3 = and(_T_1, _T_2) @[philo.scala 20:41]
    node _GEN_0 = mux(_T_3, UInt<2>("h1"), state) @[philo.scala 15:22 20:{59,66}]
    node _T_4 = eq(UInt<2>("h1"), state) @[philo.scala 19:18]
    node _T_5 = neq(io_right, UInt<2>("h1")) @[philo.scala 21:33]
    node _T_6 = neq(io_right, UInt<2>("h0")) @[philo.scala 21:56]
    node _T_7 = and(_T_5, _T_6) @[philo.scala 21:45]
    node _GEN_1 = mux(_T_7, UInt<2>("h2"), state) @[philo.scala 15:22 21:{64,71}]
    node _T_8 = eq(UInt<2>("h2"), state) @[philo.scala 19:18]
    node _T_9 = eq(UInt<2>("h0"), state) @[philo.scala 19:18]
    node _GEN_2 = mux(_T_9, UInt<2>("h3"), state) @[philo.scala 19:18 15:22 23:22]
    node _GEN_3 = mux(_T_8, UInt<2>("h0"), _GEN_2) @[philo.scala 19:18 22:27]
    node _GEN_4 = mux(_T_4, _GEN_1, _GEN_3) @[philo.scala 19:18]
    node _GEN_5 = mux(_T, _GEN_0, _GEN_4) @[philo.scala 19:18]
    io_out <= state @[philo.scala 17:10]
    state <= mux(reset, UInt<2>("h3"), _GEN_5) @[philo.scala 15:{22,22}]

  module philosopher_2 :
    input clock : Clock
    input reset : UInt<1>
    input io_left : UInt<2>
    input io_right : UInt<2>
    output io_out : UInt<2>

    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[philo.scala 15:22]
    node _T = eq(UInt<2>("h3"), state) @[philo.scala 19:18]
    node _T_1 = neq(io_left, UInt<2>("h2")) @[philo.scala 20:28]
    node _T_2 = neq(io_left, UInt<2>("h0")) @[philo.scala 20:51]
    node _T_3 = and(_T_1, _T_2) @[philo.scala 20:41]
    node _GEN_0 = mux(_T_3, UInt<2>("h1"), state) @[philo.scala 15:22 20:{59,66}]
    node _T_4 = eq(UInt<2>("h1"), state) @[philo.scala 19:18]
    node _T_5 = neq(io_right, UInt<2>("h1")) @[philo.scala 21:33]
    node _T_6 = neq(io_right, UInt<2>("h0")) @[philo.scala 21:56]
    node _T_7 = and(_T_5, _T_6) @[philo.scala 21:45]
    node _GEN_1 = mux(_T_7, UInt<2>("h2"), state) @[philo.scala 15:22 21:{64,71}]
    node _T_8 = eq(UInt<2>("h2"), state) @[philo.scala 19:18]
    node _T_9 = eq(UInt<2>("h0"), state) @[philo.scala 19:18]
    node _GEN_2 = mux(_T_9, UInt<2>("h3"), state) @[philo.scala 19:18 15:22 23:22]
    node _GEN_3 = mux(_T_8, UInt<2>("h0"), _GEN_2) @[philo.scala 19:18 22:27]
    node _GEN_4 = mux(_T_4, _GEN_1, _GEN_3) @[philo.scala 19:18]
    node _GEN_5 = mux(_T, _GEN_0, _GEN_4) @[philo.scala 19:18]
    io_out <= state @[philo.scala 17:10]
    state <= mux(reset, UInt<2>("h1"), _GEN_5) @[philo.scala 15:{22,22}]

  module philo :
    input clock : Clock
    input reset : UInt<1>
    input io_ph1_init : UInt<2>
    input io_ph2_init : UInt<2>
    input io_ph3_init : UInt<2>
    input io_ph4_init : UInt<2>
    output io_ph1_out : UInt<2>
    output io_ph2_out : UInt<2>
    output io_ph3_out : UInt<2>
    output io_ph4_out : UInt<2>

    inst ph1 of philosopher @[philo.scala 46:19]
    inst ph2 of philosopher_1 @[philo.scala 47:19]
    inst ph3 of philosopher_2 @[philo.scala 48:19]
    inst ph4 of philosopher_1 @[philo.scala 49:19]
    io_ph1_out <= ph1.io_out @[philo.scala 61:14]
    io_ph2_out <= ph2.io_out @[philo.scala 62:14]
    io_ph3_out <= ph3.io_out @[philo.scala 63:14]
    io_ph4_out <= ph4.io_out @[philo.scala 64:14]
    ph1.clock <= clock
    ph1.reset <= reset
    ph1.io_left <= ph2.io_out @[philo.scala 53:15]
    ph1.io_right <= ph4.io_out @[philo.scala 52:16]
    ph2.clock <= clock
    ph2.reset <= reset
    ph2.io_left <= ph3.io_out @[philo.scala 55:15]
    ph2.io_right <= ph1.io_out @[philo.scala 54:16]
    ph3.clock <= clock
    ph3.reset <= reset
    ph3.io_left <= ph4.io_out @[philo.scala 57:15]
    ph3.io_right <= ph2.io_out @[philo.scala 56:16]
    ph4.clock <= clock
    ph4.reset <= reset
    ph4.io_left <= ph1.io_out @[philo.scala 59:15]
    ph4.io_right <= ph3.io_out @[philo.scala 58:16]
