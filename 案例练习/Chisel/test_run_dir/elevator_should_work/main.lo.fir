FIRRTL version 1.1.0
circuit main :
  module elevator :
    input clock : Clock
    input reset : UInt<1>
    input io_stop_next : UInt<1>
    input io_continue : UInt<1>
    input io_random_push : UInt<4>
    input io_random : UInt<1>
    input io_r_stop : UInt<1>
    output io_inc : UInt<1>
    output io_dec : UInt<1>
    output io_location : UInt<2>
    output io_door : UInt<2>
    output io_movement : UInt<1>
    output io_open_next : UInt<1>
    output io_direction0 : UInt<1>

    reg inc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), inc) @[elevator.scala 27:20]
    reg dec : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dec) @[elevator.scala 29:20]
    reg buttons_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), buttons_0) @[elevator.scala 33:24]
    reg buttons_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), buttons_1) @[elevator.scala 33:24]
    reg buttons_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), buttons_2) @[elevator.scala 33:24]
    reg buttons_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), buttons_3) @[elevator.scala 33:24]
    reg location : UInt<2>, clock with :
      reset => (UInt<1>("h0"), location) @[elevator.scala 35:25]
    reg direction : UInt<1>, clock with :
      reset => (UInt<1>("h0"), direction) @[elevator.scala 37:26]
    reg door : UInt<2>, clock with :
      reset => (UInt<1>("h0"), door) @[elevator.scala 39:21]
    reg open_next : UInt<1>, clock with :
      reset => (UInt<1>("h0"), open_next) @[elevator.scala 41:26]
    reg movement : UInt<1>, clock with :
      reset => (UInt<1>("h0"), movement) @[elevator.scala 43:25]
    node _bottom_0_T = eq(buttons_0, UInt<1>("h0")) @[elevator.scala 48:26]
    node _bottom_1_T = eq(buttons_1, UInt<1>("h0")) @[elevator.scala 49:38]
    node bottom_0 = _bottom_0_T @[elevator.scala 47:20 48:13]
    node _bottom_1_T_1 = or(bottom_0, _bottom_1_T) @[elevator.scala 49:26]
    node _bottom_2_T = eq(buttons_2, UInt<1>("h0")) @[elevator.scala 50:38]
    node bottom_1 = _bottom_1_T_1 @[elevator.scala 47:20 49:13]
    node _bottom_2_T_1 = or(bottom_1, _bottom_2_T) @[elevator.scala 50:26]
    node _top_2_T = eq(buttons_3, UInt<1>("h0")) @[elevator.scala 54:23]
    node _top_1_T = eq(buttons_2, UInt<1>("h0")) @[elevator.scala 55:32]
    node top_2 = _top_2_T @[elevator.scala 53:17 54:10]
    node _top_1_T_1 = or(top_2, _top_1_T) @[elevator.scala 55:20]
    node _top_0_T = eq(buttons_1, UInt<1>("h0")) @[elevator.scala 56:32]
    node top_1 = _top_1_T_1 @[elevator.scala 53:17 55:10]
    node _top_0_T_1 = or(top_1, _top_0_T) @[elevator.scala 56:20]
    node _button_below_T = eq(location, UInt<2>("h3")) @[elevator.scala 59:29]
    node bottom_2 = _bottom_2_T_1 @[elevator.scala 47:20 50:13]
    node _button_below_T_1 = bits(bottom_2, 0, 0) @[elevator.scala 59:50]
    node _button_below_T_2 = and(_button_below_T, _button_below_T_1) @[elevator.scala 59:37]
    node _button_below_T_3 = eq(location, UInt<2>("h2")) @[elevator.scala 60:29]
    node _button_below_T_4 = bits(bottom_1, 0, 0) @[elevator.scala 60:50]
    node _button_below_T_5 = and(_button_below_T_3, _button_below_T_4) @[elevator.scala 60:37]
    node _button_below_T_6 = or(_button_below_T_2, _button_below_T_5) @[elevator.scala 59:58]
    node _button_below_T_7 = eq(location, UInt<1>("h1")) @[elevator.scala 61:29]
    node _button_below_T_8 = bits(bottom_0, 0, 0) @[elevator.scala 61:50]
    node _button_below_T_9 = and(_button_below_T_7, _button_below_T_8) @[elevator.scala 61:37]
    node _button_below_T_10 = or(_button_below_T_6, _button_below_T_9) @[elevator.scala 60:58]
    node _button_above_T = eq(location, UInt<1>("h0")) @[elevator.scala 62:29]
    node top_0 = _top_0_T_1 @[elevator.scala 53:17 56:10]
    node _button_above_T_1 = bits(top_0, 0, 0) @[elevator.scala 62:47]
    node _button_above_T_2 = and(_button_above_T, _button_above_T_1) @[elevator.scala 62:37]
    node _button_above_T_3 = eq(location, UInt<1>("h1")) @[elevator.scala 63:29]
    node _button_above_T_4 = bits(top_1, 0, 0) @[elevator.scala 63:47]
    node _button_above_T_5 = and(_button_above_T_3, _button_above_T_4) @[elevator.scala 63:37]
    node _button_above_T_6 = or(_button_above_T_2, _button_above_T_5) @[elevator.scala 62:55]
    node _button_above_T_7 = eq(location, UInt<2>("h2")) @[elevator.scala 64:29]
    node _button_above_T_8 = bits(top_2, 0, 0) @[elevator.scala 64:47]
    node _button_above_T_9 = and(_button_above_T_7, _button_above_T_8) @[elevator.scala 64:37]
    node _button_above_T_10 = or(_button_above_T_6, _button_above_T_9) @[elevator.scala 63:55]
    node _buttons_location = UInt<1>("h1") @[elevator.scala 66:{21,21}]
    node _GEN_0 = mux(eq(UInt<1>("h0"), location), _buttons_location, buttons_0) @[elevator.scala 66:{21,21} 33:24]
    node _GEN_1 = mux(eq(UInt<1>("h1"), location), _buttons_location, buttons_1) @[elevator.scala 66:{21,21} 33:24]
    node _GEN_2 = mux(eq(UInt<2>("h2"), location), _buttons_location, buttons_2) @[elevator.scala 66:{21,21} 33:24]
    node _GEN_3 = mux(eq(UInt<2>("h3"), location), _buttons_location, buttons_3) @[elevator.scala 66:{21,21} 33:24]
    node _T = bits(io_random_push, 0, 0) @[elevator.scala 67:22]
    node _T_1 = bits(_T, 0, 0) @[elevator.scala 67:26]
    node _GEN_4 = mux(_T_1, UInt<1>("h0"), _GEN_0) @[elevator.scala 67:{33,44}]
    node _T_2 = bits(io_random_push, 1, 1) @[elevator.scala 68:22]
    node _T_3 = bits(_T_2, 0, 0) @[elevator.scala 68:26]
    node _GEN_5 = mux(_T_3, UInt<1>("h0"), _GEN_1) @[elevator.scala 68:{33,44}]
    node _T_4 = bits(io_random_push, 2, 2) @[elevator.scala 69:22]
    node _T_5 = bits(_T_4, 0, 0) @[elevator.scala 69:26]
    node _GEN_6 = mux(_T_5, UInt<1>("h0"), _GEN_2) @[elevator.scala 69:{33,44}]
    node _T_6 = bits(io_random_push, 3, 3) @[elevator.scala 70:22]
    node _T_7 = bits(_T_6, 0, 0) @[elevator.scala 70:26]
    node _GEN_7 = mux(_T_7, UInt<1>("h0"), _GEN_3) @[elevator.scala 70:{33,44}]
    node _T_8 = eq(direction, UInt<1>("h0")) @[elevator.scala 74:19]
    node _T_9 = add(location, UInt<1>("h1")) @[elevator.scala 75:23]
    node _T_10 = tail(_T_9, 1) @[elevator.scala 75:23]
    node _buttons_T_10 = UInt<1>("h0") @[elevator.scala 75:{29,29}]
    node _GEN_8 = mux(eq(UInt<1>("h0"), _T_10), _buttons_T_10, _GEN_4) @[elevator.scala 75:{29,29}]
    node _GEN_9 = mux(eq(UInt<1>("h1"), _T_10), _buttons_T_10, _GEN_5) @[elevator.scala 75:{29,29}]
    node _GEN_10 = mux(eq(UInt<2>("h2"), _T_10), _buttons_T_10, _GEN_6) @[elevator.scala 75:{29,29}]
    node _GEN_11 = mux(eq(UInt<2>("h3"), _T_10), _buttons_T_10, _GEN_7) @[elevator.scala 75:{29,29}]
    node _T_11 = sub(location, UInt<1>("h1")) @[elevator.scala 77:23]
    node _T_12 = tail(_T_11, 1) @[elevator.scala 77:23]
    node _buttons_T_12 = UInt<1>("h0") @[elevator.scala 77:{29,29}]
    node _GEN_12 = mux(eq(UInt<1>("h0"), _T_12), _buttons_T_12, _GEN_4) @[elevator.scala 77:{29,29}]
    node _GEN_13 = mux(eq(UInt<1>("h1"), _T_12), _buttons_T_12, _GEN_5) @[elevator.scala 77:{29,29}]
    node _GEN_14 = mux(eq(UInt<2>("h2"), _T_12), _buttons_T_12, _GEN_6) @[elevator.scala 77:{29,29}]
    node _GEN_15 = mux(eq(UInt<2>("h3"), _T_12), _buttons_T_12, _GEN_7) @[elevator.scala 77:{29,29}]
    node _GEN_16 = mux(_T_8, _GEN_8, _GEN_12) @[elevator.scala 74:25]
    node _GEN_17 = mux(_T_8, _GEN_9, _GEN_13) @[elevator.scala 74:25]
    node _GEN_18 = mux(_T_8, _GEN_10, _GEN_14) @[elevator.scala 74:25]
    node _GEN_19 = mux(_T_8, _GEN_11, _GEN_15) @[elevator.scala 74:25]
    node _GEN_20 = mux(io_stop_next, _GEN_16, _GEN_4) @[elevator.scala 73:21]
    node _GEN_21 = mux(io_stop_next, _GEN_17, _GEN_5) @[elevator.scala 73:21]
    node _GEN_22 = mux(io_stop_next, _GEN_18, _GEN_6) @[elevator.scala 73:21]
    node _GEN_23 = mux(io_stop_next, _GEN_19, _GEN_7) @[elevator.scala 73:21]
    node _T_13 = neq(door, UInt<2>("h2")) @[elevator.scala 82:12]
    node _T_14 = eq(movement, UInt<1>("h1")) @[elevator.scala 84:23]
    node _T_15 = eq(direction, UInt<1>("h0")) @[elevator.scala 86:27]
    node _T_16 = add(location, UInt<1>("h1")) @[elevator.scala 86:52]
    node _T_17 = tail(_T_16, 1) @[elevator.scala 86:52]
    node _GEN_24 = validif(eq(UInt<1>("h0"), _T_17), buttons_0) @[elevator.scala 86:{57,57}]
    node _GEN_25 = mux(eq(UInt<1>("h1"), _T_17), buttons_1, _GEN_24) @[elevator.scala 86:{57,57}]
    node _GEN_26 = mux(eq(UInt<2>("h2"), _T_17), buttons_2, _GEN_25) @[elevator.scala 86:{57,57}]
    node _GEN_27 = mux(eq(UInt<2>("h3"), _T_17), buttons_3, _GEN_26) @[elevator.scala 86:{57,57}]
    node _buttons_T_17 = _GEN_27 @[elevator.scala 86:57]
    node _T_18 = eq(_buttons_T_17, UInt<1>("h0")) @[elevator.scala 86:57]
    node _T_19 = and(_T_15, _T_18) @[elevator.scala 86:33]
    node _T_20 = or(io_stop_next, _T_19) @[elevator.scala 85:29]
    node _T_21 = eq(direction, UInt<1>("h1")) @[elevator.scala 87:27]
    node _T_22 = sub(location, UInt<1>("h1")) @[elevator.scala 87:54]
    node _T_23 = tail(_T_22, 1) @[elevator.scala 87:54]
    node _GEN_28 = validif(eq(UInt<1>("h0"), _T_23), buttons_0) @[elevator.scala 87:{59,59}]
    node _GEN_29 = mux(eq(UInt<1>("h1"), _T_23), buttons_1, _GEN_28) @[elevator.scala 87:{59,59}]
    node _GEN_30 = mux(eq(UInt<2>("h2"), _T_23), buttons_2, _GEN_29) @[elevator.scala 87:{59,59}]
    node _GEN_31 = mux(eq(UInt<2>("h3"), _T_23), buttons_3, _GEN_30) @[elevator.scala 87:{59,59}]
    node _buttons_T_23 = _GEN_31 @[elevator.scala 87:59]
    node _T_24 = eq(_buttons_T_23, UInt<1>("h0")) @[elevator.scala 87:59]
    node _T_25 = and(_T_21, _T_24) @[elevator.scala 87:35]
    node _T_26 = or(_T_20, _T_25) @[elevator.scala 86:64]
    node _T_27 = and(_T_14, _T_26) @[elevator.scala 84:34]
    node _GEN_32 = mux(_T_27, UInt<1>("h1"), open_next) @[elevator.scala 87:67 88:15 41:26]
    node _GEN_33 = mux(_T_13, UInt<1>("h0"), _GEN_32) @[elevator.scala 82:22 83:15]
    node _T_28 = eq(UInt<2>("h2"), door) @[elevator.scala 92:15]
    node _T_29 = eq(movement, UInt<1>("h0")) @[elevator.scala 93:42]
    node _T_30 = and(open_next, _T_29) @[elevator.scala 93:31]
    node _GEN_34 = mux(_T_30, UInt<2>("h1"), door) @[elevator.scala 39:21 93:{53,58}]
    node _T_31 = eq(UInt<2>("h1"), door) @[elevator.scala 92:15]
    node _GEN_35 = mux(io_random, UInt<2>("h0"), door) @[elevator.scala 39:21 94:{32,37}]
    node _T_32 = eq(UInt<2>("h0"), door) @[elevator.scala 92:15]
    node _GEN_36 = mux(io_random, UInt<2>("h3"), door) @[elevator.scala 39:21 95:{29,34}]
    node _T_33 = eq(UInt<2>("h3"), door) @[elevator.scala 92:15]
    node _GEN_37 = mux(io_random, UInt<2>("h2"), door) @[elevator.scala 39:21 96:{32,37}]
    node _GEN_38 = mux(_T_33, _GEN_37, door) @[elevator.scala 92:15 39:21]
    node _GEN_39 = mux(_T_32, _GEN_36, _GEN_38) @[elevator.scala 92:15]
    node _GEN_40 = mux(_T_31, _GEN_35, _GEN_39) @[elevator.scala 92:15]
    node _GEN_41 = mux(_T_28, _GEN_34, _GEN_40) @[elevator.scala 92:15]
    node _start_moving_T = eq(direction, UInt<1>("h0")) @[elevator.scala 101:60]
    node button_above = _button_above_T_10 @[elevator.scala 58:40 62:16]
    node _start_moving_T_1 = and(button_above, _start_moving_T) @[elevator.scala 101:48]
    node _start_moving_T_2 = or(io_continue, _start_moving_T_1) @[elevator.scala 101:32]
    node _start_moving_T_3 = eq(direction, UInt<1>("h1")) @[elevator.scala 102:43]
    node button_below = _button_below_T_10 @[elevator.scala 58:40 59:16]
    node _start_moving_T_4 = and(button_below, _start_moving_T_3) @[elevator.scala 102:32]
    node _start_moving_T_5 = or(_start_moving_T_2, _start_moving_T_4) @[elevator.scala 101:67]
    node _stop_moving_T = eq(movement, UInt<1>("h1")) @[elevator.scala 103:38]
    node _stop_moving_T_1 = and(io_r_stop, _stop_moving_T) @[elevator.scala 103:27]
    node _inc_T = eq(direction, UInt<1>("h0")) @[elevator.scala 104:35]
    node stop_moving = _stop_moving_T_1 @[elevator.scala 100:38 103:15]
    node _inc_T_1 = and(stop_moving, _inc_T) @[elevator.scala 104:23]
    node _dec_T = eq(direction, UInt<1>("h1")) @[elevator.scala 105:35]
    node _dec_T_1 = and(stop_moving, _dec_T) @[elevator.scala 105:23]
    node _T_34 = eq(door, UInt<2>("h2")) @[elevator.scala 108:12]
    node _T_35 = eq(UInt<1>("h0"), movement) @[elevator.scala 109:21]
    node _T_36 = eq(door, UInt<2>("h2")) @[elevator.scala 110:28]
    node start_moving = _start_moving_T_5 @[elevator.scala 100:38 101:16]
    node _T_37 = and(_T_36, start_moving) @[elevator.scala 110:37]
    node _T_38 = eq(open_next, UInt<1>("h0")) @[elevator.scala 110:54]
    node _T_39 = and(_T_37, _T_38) @[elevator.scala 110:51]
    node _GEN_42 = mux(_T_39, UInt<1>("h1"), movement) @[elevator.scala 110:{65,74} 43:25]
    node _T_40 = eq(UInt<1>("h1"), movement) @[elevator.scala 109:21]
    node _GEN_43 = mux(stop_moving, UInt<1>("h0"), movement) @[elevator.scala 112:{26,35} 43:25]
    node _T_41 = eq(direction, UInt<1>("h0")) @[elevator.scala 113:24]
    node _location_T = add(location, UInt<1>("h1")) @[elevator.scala 113:54]
    node _location_T_1 = tail(_location_T, 1) @[elevator.scala 113:54]
    node _GEN_44 = mux(_T_41, _location_T_1, location) @[elevator.scala 113:{32,42} 35:25]
    node _T_42 = eq(direction, UInt<1>("h1")) @[elevator.scala 114:24]
    node _location_T_2 = sub(location, UInt<1>("h1")) @[elevator.scala 114:56]
    node _location_T_3 = tail(_location_T_2, 1) @[elevator.scala 114:56]
    node _GEN_45 = mux(_T_42, _location_T_3, _GEN_44) @[elevator.scala 114:{34,44}]
    node _GEN_46 = mux(_T_40, _GEN_43, movement) @[elevator.scala 109:21 43:25]
    node _GEN_47 = mux(_T_40, _GEN_45, location) @[elevator.scala 109:21 35:25]
    node _GEN_48 = mux(_T_35, _GEN_42, _GEN_46) @[elevator.scala 109:21]
    node _GEN_49 = mux(_T_35, location, _GEN_47) @[elevator.scala 109:21 35:25]
    node _GEN_50 = mux(_T_34, _GEN_48, movement) @[elevator.scala 108:22 43:25]
    node _GEN_51 = mux(_T_34, _GEN_49, location) @[elevator.scala 108:22 35:25]
    node _T_43 = eq(UInt<1>("h0"), direction) @[elevator.scala 120:20]
    node _T_44 = eq(button_above, UInt<1>("h0")) @[elevator.scala 121:18]
    node _T_45 = eq(io_continue, UInt<1>("h0")) @[elevator.scala 121:35]
    node _T_46 = and(_T_44, _T_45) @[elevator.scala 121:32]
    node _GEN_52 = mux(_T_46, UInt<1>("h1"), direction) @[elevator.scala 121:{48,58} 37:26]
    node _T_47 = eq(UInt<1>("h1"), direction) @[elevator.scala 120:20]
    node _T_48 = eq(button_below, UInt<1>("h0")) @[elevator.scala 122:20]
    node _T_49 = eq(io_continue, UInt<1>("h0")) @[elevator.scala 122:37]
    node _T_50 = and(_T_48, _T_49) @[elevator.scala 122:34]
    node _GEN_53 = mux(_T_50, UInt<1>("h0"), direction) @[elevator.scala 122:{50,60} 37:26]
    node _GEN_54 = mux(_T_47, _GEN_53, direction) @[elevator.scala 120:20 37:26]
    node _GEN_55 = mux(_T_43, _GEN_52, _GEN_54) @[elevator.scala 120:20]
    node _T_51 = eq(location, UInt<2>("h3")) @[elevator.scala 124:16]
    node _GEN_56 = mux(_T_51, UInt<1>("h1"), _GEN_55) @[elevator.scala 124:{23,33}]
    node _T_52 = eq(location, UInt<1>("h0")) @[elevator.scala 125:16]
    node _GEN_57 = mux(_T_52, UInt<1>("h0"), _GEN_56) @[elevator.scala 125:{23,33}]
    node _buttons_WIRE_0 = UInt<1>("h1") @[elevator.scala 33:{40,40}]
    node _buttons_WIRE_1 = UInt<1>("h1") @[elevator.scala 33:{40,40}]
    node _buttons_WIRE_2 = UInt<1>("h1") @[elevator.scala 33:{40,40}]
    node _buttons_WIRE_3 = UInt<1>("h1") @[elevator.scala 33:{40,40}]
    io_inc <= inc @[elevator.scala 28:10]
    io_dec <= dec @[elevator.scala 30:10]
    io_location <= location @[elevator.scala 36:15]
    io_door <= door @[elevator.scala 40:11]
    io_movement <= movement @[elevator.scala 44:15]
    io_open_next <= open_next @[elevator.scala 42:16]
    io_direction0 <= direction @[elevator.scala 38:17]
    inc <= mux(reset, UInt<1>("h1"), _inc_T_1) @[elevator.scala 27:{20,20} 104:7]
    dec <= mux(reset, UInt<1>("h0"), _dec_T_1) @[elevator.scala 29:{20,20} 105:7]
    buttons_0 <= mux(reset, _buttons_WIRE_0, _GEN_20) @[elevator.scala 33:{24,24}]
    buttons_1 <= mux(reset, _buttons_WIRE_1, _GEN_21) @[elevator.scala 33:{24,24}]
    buttons_2 <= mux(reset, _buttons_WIRE_2, _GEN_22) @[elevator.scala 33:{24,24}]
    buttons_3 <= mux(reset, _buttons_WIRE_3, _GEN_23) @[elevator.scala 33:{24,24}]
    location <= mux(reset, UInt<1>("h0"), _GEN_51) @[elevator.scala 35:{25,25}]
    direction <= mux(reset, UInt<1>("h0"), _GEN_57) @[elevator.scala 37:{26,26}]
    door <= mux(reset, UInt<2>("h0"), _GEN_41) @[elevator.scala 39:{21,21}]
    open_next <= mux(reset, UInt<1>("h0"), _GEN_33) @[elevator.scala 41:{26,26}]
    movement <= mux(reset, UInt<1>("h0"), _GEN_50) @[elevator.scala 43:{25,25}]

  module main_control :
    input clock : Clock
    input reset : UInt<1>
    input io_inc : UInt<1>
    input io_dec : UInt<1>
    input io_random_up : UInt<4>
    input io_random_down : UInt<4>
    output io_stop_next : UInt<1>
    output io_continue : UInt<1>

    reg stop_next : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stop_next) @[elevator.scala 142:26]
    reg continue : UInt<1>, clock with :
      reset => (UInt<1>("h0"), continue) @[elevator.scala 144:25]
    reg locations : UInt<2>, clock with :
      reset => (UInt<1>("h0"), locations) @[elevator.scala 147:26]
    reg direction : UInt<1>, clock with :
      reset => (UInt<1>("h0"), direction) @[elevator.scala 148:26]
    reg up_floor_buttons_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_0) @[elevator.scala 149:33]
    reg up_floor_buttons_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_1) @[elevator.scala 149:33]
    reg up_floor_buttons_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_2) @[elevator.scala 149:33]
    reg up_floor_buttons_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_3) @[elevator.scala 149:33]
    reg down_floor_buttons_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), down_floor_buttons_0) @[elevator.scala 150:35]
    reg down_floor_buttons_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), down_floor_buttons_1) @[elevator.scala 150:35]
    reg down_floor_buttons_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), down_floor_buttons_2) @[elevator.scala 150:35]
    reg down_floor_buttons_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), down_floor_buttons_3) @[elevator.scala 150:35]
    node _buttons_0_T = eq(up_floor_buttons_0, UInt<1>("h1")) @[elevator.scala 153:36]
    node _buttons_0_T_1 = eq(down_floor_buttons_0, UInt<1>("h1")) @[elevator.scala 153:66]
    node _buttons_0_T_2 = or(_buttons_0_T, _buttons_0_T_1) @[elevator.scala 153:42]
    node _buttons_1_T = eq(up_floor_buttons_1, UInt<1>("h1")) @[elevator.scala 154:36]
    node _buttons_1_T_1 = eq(down_floor_buttons_1, UInt<1>("h1")) @[elevator.scala 154:66]
    node _buttons_1_T_2 = or(_buttons_1_T, _buttons_1_T_1) @[elevator.scala 154:42]
    node _buttons_2_T = eq(up_floor_buttons_2, UInt<1>("h1")) @[elevator.scala 155:36]
    node _buttons_2_T_1 = eq(down_floor_buttons_2, UInt<1>("h1")) @[elevator.scala 155:66]
    node _buttons_2_T_2 = or(_buttons_2_T, _buttons_2_T_1) @[elevator.scala 155:42]
    node _buttons_3_T = eq(up_floor_buttons_3, UInt<1>("h1")) @[elevator.scala 156:36]
    node _buttons_3_T_1 = eq(down_floor_buttons_3, UInt<1>("h1")) @[elevator.scala 156:66]
    node _buttons_3_T_2 = or(_buttons_3_T, _buttons_3_T_1) @[elevator.scala 156:42]
    node buttons_0 = _buttons_0_T_2 @[elevator.scala 152:21 153:14]
    node bottom_0 = buttons_0 @[elevator.scala 158:25 159:13]
    node buttons_1 = _buttons_1_T_2 @[elevator.scala 152:21 154:14]
    node _bottom_1_T = or(bottom_0, buttons_1) @[elevator.scala 160:26]
    node bottom_1 = _bottom_1_T @[elevator.scala 158:25 160:13]
    node buttons_2 = _buttons_2_T_2 @[elevator.scala 152:21 155:14]
    node _bottom_2_T = or(bottom_1, buttons_2) @[elevator.scala 161:26]
    node buttons_3 = _buttons_3_T_2 @[elevator.scala 152:21 156:14]
    node top_2 = buttons_3 @[elevator.scala 158:25 162:10]
    node _top_1_T = or(top_2, buttons_2) @[elevator.scala 163:20]
    node top_1 = _top_1_T @[elevator.scala 158:25 163:10]
    node _top_0_T = or(top_1, buttons_1) @[elevator.scala 164:20]
    node _button_below_T = eq(locations, UInt<2>("h3")) @[elevator.scala 167:30]
    node bottom_2 = _bottom_2_T @[elevator.scala 158:25 161:13]
    node _button_below_T_1 = and(_button_below_T, bottom_2) @[elevator.scala 167:37]
    node _button_below_T_2 = eq(locations, UInt<2>("h2")) @[elevator.scala 168:30]
    node _button_below_T_3 = and(_button_below_T_2, bottom_1) @[elevator.scala 168:37]
    node _button_below_T_4 = or(_button_below_T_1, _button_below_T_3) @[elevator.scala 167:51]
    node _button_below_T_5 = eq(locations, UInt<1>("h1")) @[elevator.scala 169:30]
    node _button_below_T_6 = and(_button_below_T_5, bottom_0) @[elevator.scala 169:37]
    node _button_below_T_7 = or(_button_below_T_4, _button_below_T_6) @[elevator.scala 168:51]
    node _button_above_T = eq(locations, UInt<1>("h0")) @[elevator.scala 170:31]
    node top_0 = _top_0_T @[elevator.scala 158:25 164:10]
    node _button_above_T_1 = and(_button_above_T, top_0) @[elevator.scala 170:39]
    node _button_above_T_2 = eq(locations, UInt<1>("h1")) @[elevator.scala 171:31]
    node _button_above_T_3 = and(_button_above_T_2, top_1) @[elevator.scala 171:39]
    node _button_above_T_4 = or(_button_above_T_1, _button_above_T_3) @[elevator.scala 170:50]
    node _button_above_T_5 = eq(locations, UInt<2>("h2")) @[elevator.scala 172:31]
    node _button_above_T_6 = and(_button_above_T_5, top_2) @[elevator.scala 172:39]
    node _button_above_T_7 = or(_button_above_T_4, _button_above_T_6) @[elevator.scala 171:50]
    node _continue_T = eq(direction, UInt<1>("h0")) @[elevator.scala 174:42]
    node button_above = _button_above_T_7 @[elevator.scala 166:39 170:16]
    node _continue_T_1 = and(button_above, _continue_T) @[elevator.scala 174:29]
    node _continue_T_2 = eq(direction, UInt<1>("h1")) @[elevator.scala 175:45]
    node button_below = _button_below_T_7 @[elevator.scala 166:39 167:16]
    node _continue_T_3 = and(button_below, _continue_T_2) @[elevator.scala 175:32]
    node _continue_T_4 = or(_continue_T_1, _continue_T_3) @[elevator.scala 174:50]
    node _stop_next_T = neq(locations, UInt<2>("h3")) @[elevator.scala 176:31]
    node _stop_next_T_1 = eq(direction, UInt<1>("h0")) @[elevator.scala 176:52]
    node _stop_next_T_2 = and(_stop_next_T, _stop_next_T_1) @[elevator.scala 176:40]
    node _stop_next_T_3 = add(locations, UInt<1>("h1")) @[elevator.scala 177:55]
    node _stop_next_T_4 = tail(_stop_next_T_3, 1) @[elevator.scala 177:55]
    node _GEN_0 = validif(eq(UInt<1>("h0"), _stop_next_T_4), up_floor_buttons_0) @[elevator.scala 177:{60,60}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _stop_next_T_4), up_floor_buttons_1, _GEN_0) @[elevator.scala 177:{60,60}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _stop_next_T_4), up_floor_buttons_2, _GEN_1) @[elevator.scala 177:{60,60}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _stop_next_T_4), up_floor_buttons_3, _GEN_2) @[elevator.scala 177:{60,60}]
    node _up_floor_buttons_stop_next_T_4 = _GEN_3 @[elevator.scala 177:60]
    node _stop_next_T_5 = eq(_up_floor_buttons_stop_next_T_4, UInt<1>("h1")) @[elevator.scala 177:60]
    node _stop_next_T_6 = mux(_stop_next_T_5, UInt<1>("h1"), UInt<1>("h0")) @[elevator.scala 177:28]
    node _stop_next_T_7 = neq(locations, UInt<1>("h0")) @[elevator.scala 178:38]
    node _stop_next_T_8 = eq(direction, UInt<1>("h1")) @[elevator.scala 178:57]
    node _stop_next_T_9 = and(_stop_next_T_7, _stop_next_T_8) @[elevator.scala 178:45]
    node _stop_next_T_10 = sub(locations, UInt<1>("h1")) @[elevator.scala 179:61]
    node _stop_next_T_11 = tail(_stop_next_T_10, 1) @[elevator.scala 179:61]
    node _GEN_4 = validif(eq(UInt<1>("h0"), _stop_next_T_11), down_floor_buttons_0) @[elevator.scala 179:{66,66}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), _stop_next_T_11), down_floor_buttons_1, _GEN_4) @[elevator.scala 179:{66,66}]
    node _GEN_6 = mux(eq(UInt<2>("h2"), _stop_next_T_11), down_floor_buttons_2, _GEN_5) @[elevator.scala 179:{66,66}]
    node _GEN_7 = mux(eq(UInt<2>("h3"), _stop_next_T_11), down_floor_buttons_3, _GEN_6) @[elevator.scala 179:{66,66}]
    node _down_floor_buttons_stop_next_T_11 = _GEN_7 @[elevator.scala 179:66]
    node _stop_next_T_12 = eq(_down_floor_buttons_stop_next_T_11, UInt<1>("h1")) @[elevator.scala 179:66]
    node _stop_next_T_13 = mux(_stop_next_T_12, UInt<1>("h1"), UInt<1>("h0")) @[elevator.scala 179:32]
    node _stop_next_T_14 = mux(_stop_next_T_9, _stop_next_T_13, UInt<1>("h0")) @[elevator.scala 178:28]
    node _stop_next_T_15 = mux(_stop_next_T_2, _stop_next_T_6, _stop_next_T_14) @[elevator.scala 176:19]
    node _T = dshr(io_random_up, UInt<1>("h0")) @[elevator.scala 183:22]
    node _T_1 = bits(_T, 0, 0) @[elevator.scala 183:22]
    node _T_2 = bits(_T_1, 0, 0) @[elevator.scala 183:28]
    node _GEN_8 = mux(_T_2, UInt<1>("h1"), up_floor_buttons_0) @[elevator.scala 149:33 183:{35,57}]
    node _T_3 = dshr(io_random_down, UInt<1>("h0")) @[elevator.scala 184:24]
    node _T_4 = bits(_T_3, 0, 0) @[elevator.scala 184:24]
    node _T_5 = bits(_T_4, 0, 0) @[elevator.scala 184:30]
    node _GEN_9 = mux(_T_5, UInt<1>("h1"), down_floor_buttons_0) @[elevator.scala 150:35 184:{37,61}]
    node _T_6 = dshr(io_random_up, UInt<1>("h1")) @[elevator.scala 183:22]
    node _T_7 = bits(_T_6, 0, 0) @[elevator.scala 183:22]
    node _T_8 = bits(_T_7, 0, 0) @[elevator.scala 183:28]
    node _GEN_10 = mux(_T_8, UInt<1>("h1"), up_floor_buttons_1) @[elevator.scala 149:33 183:{35,57}]
    node _T_9 = dshr(io_random_down, UInt<1>("h1")) @[elevator.scala 184:24]
    node _T_10 = bits(_T_9, 0, 0) @[elevator.scala 184:24]
    node _T_11 = bits(_T_10, 0, 0) @[elevator.scala 184:30]
    node _GEN_11 = mux(_T_11, UInt<1>("h1"), down_floor_buttons_1) @[elevator.scala 150:35 184:{37,61}]
    node _T_12 = dshr(io_random_up, UInt<2>("h2")) @[elevator.scala 183:22]
    node _T_13 = bits(_T_12, 0, 0) @[elevator.scala 183:22]
    node _T_14 = bits(_T_13, 0, 0) @[elevator.scala 183:28]
    node _GEN_12 = mux(_T_14, UInt<1>("h1"), up_floor_buttons_2) @[elevator.scala 149:33 183:{35,57}]
    node _T_15 = dshr(io_random_down, UInt<2>("h2")) @[elevator.scala 184:24]
    node _T_16 = bits(_T_15, 0, 0) @[elevator.scala 184:24]
    node _T_17 = bits(_T_16, 0, 0) @[elevator.scala 184:30]
    node _GEN_13 = mux(_T_17, UInt<1>("h1"), down_floor_buttons_2) @[elevator.scala 150:35 184:{37,61}]
    node _T_18 = dshr(io_random_up, UInt<2>("h3")) @[elevator.scala 183:22]
    node _T_19 = bits(_T_18, 0, 0) @[elevator.scala 183:22]
    node _T_20 = bits(_T_19, 0, 0) @[elevator.scala 183:28]
    node _GEN_14 = mux(_T_20, UInt<1>("h1"), up_floor_buttons_3) @[elevator.scala 149:33 183:{35,57}]
    node _T_21 = dshr(io_random_down, UInt<2>("h3")) @[elevator.scala 184:24]
    node _T_22 = bits(_T_21, 0, 0) @[elevator.scala 184:24]
    node _T_23 = bits(_T_22, 0, 0) @[elevator.scala 184:30]
    node _GEN_15 = mux(_T_23, UInt<1>("h1"), down_floor_buttons_3) @[elevator.scala 150:35 184:{37,61}]
    node _T_24 = neq(locations, UInt<2>("h3")) @[elevator.scala 187:17]
    node _T_25 = eq(direction, UInt<1>("h0")) @[elevator.scala 187:36]
    node _T_26 = and(_T_24, _T_25) @[elevator.scala 187:24]
    node _T_27 = add(locations, UInt<1>("h1")) @[elevator.scala 188:36]
    node _T_28 = tail(_T_27, 1) @[elevator.scala 188:36]
    node _GEN_16 = validif(eq(UInt<1>("h0"), _T_28), up_floor_buttons_0) @[elevator.scala 188:{41,41}]
    node _GEN_17 = mux(eq(UInt<1>("h1"), _T_28), up_floor_buttons_1, _GEN_16) @[elevator.scala 188:{41,41}]
    node _GEN_18 = mux(eq(UInt<2>("h2"), _T_28), up_floor_buttons_2, _GEN_17) @[elevator.scala 188:{41,41}]
    node _GEN_19 = mux(eq(UInt<2>("h3"), _T_28), up_floor_buttons_3, _GEN_18) @[elevator.scala 188:{41,41}]
    node _up_floor_buttons_T_28 = _GEN_19 @[elevator.scala 188:41]
    node _T_29 = eq(_up_floor_buttons_T_28, UInt<1>("h1")) @[elevator.scala 188:41]
    node _T_30 = add(locations, UInt<1>("h1")) @[elevator.scala 189:33]
    node _T_31 = tail(_T_30, 1) @[elevator.scala 189:33]
    node _up_floor_buttons_T_31 = UInt<1>("h0") @[elevator.scala 189:{38,38}]
    node _GEN_20 = mux(eq(UInt<1>("h0"), _T_31), _up_floor_buttons_T_31, _GEN_8) @[elevator.scala 189:{38,38}]
    node _GEN_21 = mux(eq(UInt<1>("h1"), _T_31), _up_floor_buttons_T_31, _GEN_10) @[elevator.scala 189:{38,38}]
    node _GEN_22 = mux(eq(UInt<2>("h2"), _T_31), _up_floor_buttons_T_31, _GEN_12) @[elevator.scala 189:{38,38}]
    node _GEN_23 = mux(eq(UInt<2>("h3"), _T_31), _up_floor_buttons_T_31, _GEN_14) @[elevator.scala 189:{38,38}]
    node _GEN_24 = mux(_T_29, _GEN_20, _GEN_8) @[elevator.scala 188:47]
    node _GEN_25 = mux(_T_29, _GEN_21, _GEN_10) @[elevator.scala 188:47]
    node _GEN_26 = mux(_T_29, _GEN_22, _GEN_12) @[elevator.scala 188:47]
    node _GEN_27 = mux(_T_29, _GEN_23, _GEN_14) @[elevator.scala 188:47]
    node _GEN_28 = mux(_T_26, _GEN_24, _GEN_8) @[elevator.scala 187:42]
    node _GEN_29 = mux(_T_26, _GEN_25, _GEN_10) @[elevator.scala 187:42]
    node _GEN_30 = mux(_T_26, _GEN_26, _GEN_12) @[elevator.scala 187:42]
    node _GEN_31 = mux(_T_26, _GEN_27, _GEN_14) @[elevator.scala 187:42]
    node _T_32 = neq(locations, UInt<1>("h0")) @[elevator.scala 192:17]
    node _T_33 = eq(direction, UInt<1>("h1")) @[elevator.scala 192:34]
    node _T_34 = and(_T_32, _T_33) @[elevator.scala 192:23]
    node _T_35 = sub(locations, UInt<1>("h1")) @[elevator.scala 193:38]
    node _T_36 = tail(_T_35, 1) @[elevator.scala 193:38]
    node _GEN_32 = validif(eq(UInt<1>("h0"), _T_36), down_floor_buttons_0) @[elevator.scala 193:{43,43}]
    node _GEN_33 = mux(eq(UInt<1>("h1"), _T_36), down_floor_buttons_1, _GEN_32) @[elevator.scala 193:{43,43}]
    node _GEN_34 = mux(eq(UInt<2>("h2"), _T_36), down_floor_buttons_2, _GEN_33) @[elevator.scala 193:{43,43}]
    node _GEN_35 = mux(eq(UInt<2>("h3"), _T_36), down_floor_buttons_3, _GEN_34) @[elevator.scala 193:{43,43}]
    node _down_floor_buttons_T_36 = _GEN_35 @[elevator.scala 193:43]
    node _T_37 = eq(_down_floor_buttons_T_36, UInt<1>("h1")) @[elevator.scala 193:43]
    node _T_38 = sub(locations, UInt<1>("h1")) @[elevator.scala 194:35]
    node _T_39 = tail(_T_38, 1) @[elevator.scala 194:35]
    node _down_floor_buttons_T_39 = UInt<1>("h0") @[elevator.scala 194:{41,41}]
    node _GEN_36 = mux(eq(UInt<1>("h0"), _T_39), _down_floor_buttons_T_39, _GEN_9) @[elevator.scala 194:{41,41}]
    node _GEN_37 = mux(eq(UInt<1>("h1"), _T_39), _down_floor_buttons_T_39, _GEN_11) @[elevator.scala 194:{41,41}]
    node _GEN_38 = mux(eq(UInt<2>("h2"), _T_39), _down_floor_buttons_T_39, _GEN_13) @[elevator.scala 194:{41,41}]
    node _GEN_39 = mux(eq(UInt<2>("h3"), _T_39), _down_floor_buttons_T_39, _GEN_15) @[elevator.scala 194:{41,41}]
    node _GEN_40 = mux(_T_37, _GEN_36, _GEN_9) @[elevator.scala 193:49]
    node _GEN_41 = mux(_T_37, _GEN_37, _GEN_11) @[elevator.scala 193:49]
    node _GEN_42 = mux(_T_37, _GEN_38, _GEN_13) @[elevator.scala 193:49]
    node _GEN_43 = mux(_T_37, _GEN_39, _GEN_15) @[elevator.scala 193:49]
    node _GEN_44 = mux(_T_34, _GEN_40, _GEN_9) @[elevator.scala 192:42]
    node _GEN_45 = mux(_T_34, _GEN_41, _GEN_11) @[elevator.scala 192:42]
    node _GEN_46 = mux(_T_34, _GEN_42, _GEN_13) @[elevator.scala 192:42]
    node _GEN_47 = mux(_T_34, _GEN_43, _GEN_15) @[elevator.scala 192:42]
    node _T_40 = eq(locations, UInt<2>("h3")) @[elevator.scala 198:17]
    node _GEN_48 = mux(_T_40, UInt<1>("h1"), direction) @[elevator.scala 198:24 148:26 198:35]
    node _T_41 = eq(locations, UInt<1>("h0")) @[elevator.scala 199:17]
    node _GEN_49 = mux(_T_41, UInt<1>("h0"), _GEN_48) @[elevator.scala 199:{24,35}]
    node _locations_T = add(locations, UInt<1>("h1")) @[elevator.scala 201:27]
    node _locations_T_1 = tail(_locations_T, 1) @[elevator.scala 201:27]
    node _GEN_50 = mux(io_inc, _locations_T_1, locations) @[elevator.scala 200:15 201:15 147:26]
    node _GEN_51 = mux(io_inc, UInt<1>("h0"), _GEN_49) @[elevator.scala 200:15 202:15]
    node _locations_T_2 = sub(locations, UInt<1>("h1")) @[elevator.scala 205:27]
    node _locations_T_3 = tail(_locations_T_2, 1) @[elevator.scala 205:27]
    node _GEN_52 = mux(io_dec, _locations_T_3, _GEN_50) @[elevator.scala 204:15 205:15]
    node _GEN_53 = mux(io_dec, UInt<1>("h1"), _GEN_51) @[elevator.scala 204:15 206:15]
    node _up_floor_buttons_WIRE_0 = UInt<1>("h0") @[elevator.scala 149:{49,49}]
    node _up_floor_buttons_WIRE_1 = UInt<1>("h0") @[elevator.scala 149:{49,49}]
    node _up_floor_buttons_WIRE_2 = UInt<1>("h0") @[elevator.scala 149:{49,49}]
    node _up_floor_buttons_WIRE_3 = UInt<1>("h0") @[elevator.scala 149:{49,49}]
    node _down_floor_buttons_WIRE_0 = UInt<1>("h0") @[elevator.scala 150:{51,51}]
    node _down_floor_buttons_WIRE_1 = UInt<1>("h0") @[elevator.scala 150:{51,51}]
    node _down_floor_buttons_WIRE_2 = UInt<1>("h0") @[elevator.scala 150:{51,51}]
    node _down_floor_buttons_WIRE_3 = UInt<1>("h0") @[elevator.scala 150:{51,51}]
    io_stop_next <= stop_next @[elevator.scala 143:16]
    io_continue <= continue @[elevator.scala 145:15]
    stop_next <= mux(reset, UInt<1>("h0"), _stop_next_T_15) @[elevator.scala 142:{26,26} 176:13]
    continue <= mux(reset, UInt<1>("h0"), _continue_T_4) @[elevator.scala 144:{25,25} 174:12]
    locations <= mux(reset, UInt<1>("h1"), _GEN_52) @[elevator.scala 147:{26,26}]
    direction <= mux(reset, UInt<1>("h0"), _GEN_53) @[elevator.scala 148:{26,26}]
    up_floor_buttons_0 <= mux(reset, _up_floor_buttons_WIRE_0, _GEN_28) @[elevator.scala 149:{33,33}]
    up_floor_buttons_1 <= mux(reset, _up_floor_buttons_WIRE_1, _GEN_29) @[elevator.scala 149:{33,33}]
    up_floor_buttons_2 <= mux(reset, _up_floor_buttons_WIRE_2, _GEN_30) @[elevator.scala 149:{33,33}]
    up_floor_buttons_3 <= mux(reset, _up_floor_buttons_WIRE_3, _GEN_31) @[elevator.scala 149:{33,33}]
    down_floor_buttons_0 <= mux(reset, _down_floor_buttons_WIRE_0, _GEN_44) @[elevator.scala 150:{35,35}]
    down_floor_buttons_1 <= mux(reset, _down_floor_buttons_WIRE_1, _GEN_45) @[elevator.scala 150:{35,35}]
    down_floor_buttons_2 <= mux(reset, _down_floor_buttons_WIRE_2, _GEN_46) @[elevator.scala 150:{35,35}]
    down_floor_buttons_3 <= mux(reset, _down_floor_buttons_WIRE_3, _GEN_47) @[elevator.scala 150:{35,35}]

  module main :
    input clock : Clock
    input reset : UInt<1>
    input io_random_up : UInt<4>
    input io_random_down : UInt<4>
    input io_random : UInt<1>
    input io_r_stop : UInt<1>
    input io_random_push1 : UInt<4>
    output io_stop_next : UInt<1>
    output io_continue : UInt<1>
    output io_inc : UInt<1>
    output io_dec : UInt<1>
    output io_location : UInt<2>
    output io_door : UInt<2>
    output io_movement : UInt<1>
    output io_open_next : UInt<1>
    output io_direction0 : UInt<1>

    inst e1 of elevator @[elevator.scala 233:18]
    inst ec of main_control @[elevator.scala 234:18]
    io_stop_next <= ec.io_continue @[elevator.scala 246:16]
    io_continue <= ec.io_continue @[elevator.scala 247:15]
    io_inc <= e1.io_inc @[elevator.scala 248:10]
    io_dec <= e1.io_dec @[elevator.scala 249:10]
    io_location <= e1.io_location @[elevator.scala 250:15]
    io_door <= e1.io_door @[elevator.scala 251:11]
    io_movement <= e1.io_movement @[elevator.scala 252:15]
    io_open_next <= e1.io_open_next @[elevator.scala 253:16]
    io_direction0 <= e1.io_direction0 @[elevator.scala 254:17]
    e1.clock <= clock
    e1.reset <= reset
    e1.io_stop_next <= ec.io_stop_next @[elevator.scala 240:19]
    e1.io_continue <= ec.io_continue @[elevator.scala 241:18]
    e1.io_random_push <= io_random_push1 @[elevator.scala 242:21]
    e1.io_random <= io_random @[elevator.scala 244:16]
    e1.io_r_stop <= io_r_stop @[elevator.scala 243:16]
    ec.clock <= clock
    ec.reset <= reset
    ec.io_inc <= e1.io_inc @[elevator.scala 236:13]
    ec.io_dec <= e1.io_dec @[elevator.scala 235:13]
    ec.io_random_up <= io_random_up @[elevator.scala 237:19]
    ec.io_random_down <= io_random_down @[elevator.scala 238:21]
