circuit gcd :
  module gcd :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<8>, flip b : UInt<8>, flip start : UInt<1>, o : UInt<8>}

    reg lsb : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[main.scala 15:20]
    reg x : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[main.scala 16:18]
    reg y : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[main.scala 17:18]
    reg busy : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[main.scala 18:21]
    wire done : UInt<1> @[main.scala 20:18]
    wire load : UInt<1> @[main.scala 21:18]
    wire x_lsb : UInt<1> @[main.scala 23:19]
    wire y_lsb : UInt<1> @[main.scala 24:19]
    wire diff : UInt<8> @[main.scala 25:18]
    node _io_o_T = gt(io.a, io.b) @[main.scala 31:18]
    node _io_o_T_1 = mux(_io_o_T, io.b, io.a) @[main.scala 31:13]
    io.o <= _io_o_T_1 @[main.scala 31:7]
    node _x_lsb_T = dshr(x, lsb) @[main.scala 33:13]
    node _x_lsb_T_1 = bits(_x_lsb_T, 0, 0) @[main.scala 33:13]
    x_lsb <= _x_lsb_T_1 @[main.scala 33:9]
    node _y_lsb_T = dshr(y, lsb) @[main.scala 34:13]
    node _y_lsb_T_1 = bits(_y_lsb_T, 0, 0) @[main.scala 34:13]
    y_lsb <= _y_lsb_T_1 @[main.scala 34:9]
    node _diff_T = lt(x, y) @[main.scala 35:16]
    node _diff_T_1 = sub(y, x) @[main.scala 35:20]
    node _diff_T_2 = tail(_diff_T_1, 1) @[main.scala 35:20]
    node _diff_T_3 = sub(x, y) @[main.scala 35:24]
    node _diff_T_4 = tail(_diff_T_3, 1) @[main.scala 35:24]
    node _diff_T_5 = mux(_diff_T, _diff_T_2, _diff_T_4) @[main.scala 35:14]
    diff <= _diff_T_5 @[main.scala 35:8]
    node _done_T = eq(x, y) @[main.scala 37:14]
    node _done_T_1 = eq(x, UInt<1>("h0")) @[main.scala 37:23]
    node _done_T_2 = or(_done_T, _done_T_1) @[main.scala 37:19]
    node _done_T_3 = eq(y, UInt<1>("h0")) @[main.scala 37:34]
    node _done_T_4 = or(_done_T_2, _done_T_3) @[main.scala 37:30]
    node _done_T_5 = and(_done_T_4, busy) @[main.scala 37:42]
    done <= _done_T_5 @[main.scala 37:8]
    when load : @[main.scala 39:13]
      x <= io.a @[main.scala 40:7]
      y <= io.b @[main.scala 41:7]
      lsb <= UInt<1>("h0") @[main.scala 42:9]
    else :
      node _T = not(done) @[main.scala 43:21]
      node _T_1 = and(busy, _T) @[main.scala 43:19]
      when _T_1 : @[main.scala 43:27]
        node _T_2 = cat(x_lsb, y_lsb) @[main.scala 44:18]
        node _T_3 = eq(UInt<1>("h0"), _T_2) @[main.scala 44:27]
        when _T_3 : @[main.scala 44:27]
          node _lsb_T = add(lsb, UInt<1>("h1")) @[main.scala 45:29]
          node _lsb_T_1 = tail(_lsb_T, 1) @[main.scala 45:29]
          lsb <= _lsb_T_1 @[main.scala 45:23]
        else :
          node _T_4 = eq(UInt<1>("h1"), _T_2) @[main.scala 44:27]
          when _T_4 : @[main.scala 44:27]
            node _x_T = dshr(x, UInt<1>("h1")) @[main.scala 46:23]
            x <= _x_T @[main.scala 46:20]
          else :
            node _T_5 = eq(UInt<2>("h2"), _T_2) @[main.scala 44:27]
            when _T_5 : @[main.scala 44:27]
              node _y_T = dshr(y, UInt<1>("h1")) @[main.scala 47:23]
              y <= _y_T @[main.scala 47:20]
            else :
              node _T_6 = eq(UInt<2>("h3"), _T_2) @[main.scala 44:27]
              when _T_6 : @[main.scala 44:27]
                node _T_7 = lt(x, y) @[main.scala 49:15]
                when _T_7 : @[main.scala 49:18]
                  node _y_T_1 = dshr(diff, UInt<1>("h1")) @[main.scala 50:18]
                  y <= _y_T_1 @[main.scala 50:12]
                else :
                  node _x_T_1 = dshr(diff, UInt<1>("h1")) @[main.scala 52:18]
                  x <= _x_T_1 @[main.scala 52:12]
      else :
        when done : @[main.scala 55:20]
          node _io_o_T_2 = lt(x, y) @[main.scala 56:18]
          node _io_o_T_3 = mux(_io_o_T_2, x, y) @[main.scala 56:16]
          io.o <= _io_o_T_3 @[main.scala 56:10]
    node _load_T = eq(busy, UInt<1>("h0")) @[main.scala 59:24]
    node _load_T_1 = and(io.start, _load_T) @[main.scala 59:20]
    load <= _load_T_1 @[main.scala 59:8]
    node _T_8 = eq(busy, UInt<1>("h0")) @[main.scala 61:8]
    when _T_8 : @[main.scala 61:14]
      when io.start : @[main.scala 62:19]
        busy <= UInt<1>("h1") @[main.scala 62:24]
    else :
      when done : @[main.scala 64:15]
        busy <= UInt<1>("h0") @[main.scala 64:20]


