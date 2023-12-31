; SMT-LIBv2 description generated by Yosys 0.35+24 (git sha1 7eea04779, aarch64-apple-darwin20.2-clang 10.0.0-4ubuntu1 -fPIC -Os)
; yosys-smt2-module ResetCounter
(declare-sort |ResetCounter_s| 0)
(declare-fun |ResetCounter_is| (|ResetCounter_s|) Bool)
; yosys-smt2-witness {"offset": 0, "path": ["\\count"], "smtname": 0, "smtoffset": 0, "type": "reg", "width": 32}
(declare-fun |ResetCounter#0| (|ResetCounter_s|) (_ BitVec 32)) ; \count
; yosys-smt2-output timeSinceReset 32
; yosys-smt2-wire timeSinceReset 32
(define-fun |ResetCounter_n timeSinceReset| ((state |ResetCounter_s|)) (_ BitVec 32) (|ResetCounter#0| state))
(declare-fun |ResetCounter#1| (|ResetCounter_s|) Bool) ; \reset
; yosys-smt2-input reset 1
; yosys-smt2-wire reset 1
; yosys-smt2-witness {"offset": 0, "path": ["\\reset"], "smtname": "reset", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |ResetCounter_n reset| ((state |ResetCounter_s|)) Bool (|ResetCounter#1| state))
; yosys-smt2-witness {"offset": 0, "path": ["\\flag"], "smtname": 2, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |ResetCounter#2| (|ResetCounter_s|) (_ BitVec 1)) ; \flag
; yosys-smt2-output notChaos 1
; yosys-smt2-wire notChaos 1
(define-fun |ResetCounter_n notChaos| ((state |ResetCounter_s|)) Bool (= ((_ extract 0 0) (|ResetCounter#2| state)) #b1))
; yosys-smt2-register flag 1
; yosys-smt2-wire flag 1
(define-fun |ResetCounter_n flag| ((state |ResetCounter_s|)) Bool (= ((_ extract 0 0) (|ResetCounter#2| state)) #b1))
; yosys-smt2-register count 32
; yosys-smt2-wire count 32
(define-fun |ResetCounter_n count| ((state |ResetCounter_s|)) (_ BitVec 32) (|ResetCounter#0| state))
(declare-fun |ResetCounter#3| (|ResetCounter_s|) Bool) ; \clk
; yosys-smt2-input clk 1
; yosys-smt2-wire clk 1
; yosys-smt2-clock clk posedge
; yosys-smt2-witness {"offset": 0, "path": ["\\clk"], "smtname": "clk", "smtoffset": 0, "type": "posedge", "width": 1}
; yosys-smt2-witness {"offset": 0, "path": ["\\clk"], "smtname": "clk", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |ResetCounter_n clk| ((state |ResetCounter_s|)) Bool (|ResetCounter#3| state))
(define-fun |ResetCounter#4| ((state |ResetCounter_s|)) (_ BitVec 1) (bvnot (ite (|ResetCounter#3| state) #b1 #b0))) ; $auto$rtlil.cc:2461:Not$161
; yosys-smt2-assume 0 $auto$formalff.cc:758:execute$162
(define-fun |ResetCounter_u 0| ((state |ResetCounter_s|)) Bool (or (= ((_ extract 0 0) (|ResetCounter#4| state)) #b1) (not true))) ; $auto$formalff.cc:758:execute$162
(define-fun |ResetCounter#5| ((state |ResetCounter_s|)) (_ BitVec 1) (ite (|ResetCounter#1| state) #b1 (|ResetCounter#2| state))) ; $0\flag[0:0]
(define-fun |ResetCounter#6| ((state |ResetCounter_s|)) (_ BitVec 32) (bvadd (|ResetCounter#0| state) #b00000000000000000000000000000001)) ; $add$ResetCounter.sv:24$78_Y
(define-fun |ResetCounter#7| ((state |ResetCounter_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ResetCounter#2| state)) #b1) (|ResetCounter#6| state) (|ResetCounter#0| state))) ; $procmux$83_Y
(define-fun |ResetCounter#8| ((state |ResetCounter_s|)) (_ BitVec 32) (ite (|ResetCounter#1| state) #b00000000000000000000000000000000 (|ResetCounter#7| state))) ; $0\count[31:0]
(define-fun |ResetCounter_a| ((state |ResetCounter_s|)) Bool true)
(define-fun |ResetCounter_u| ((state |ResetCounter_s|)) Bool 
  (|ResetCounter_u 0| state)
)
(define-fun |ResetCounter_i| ((state |ResetCounter_s|)) Bool (and
  (= (= ((_ extract 0 0) (|ResetCounter#2| state)) #b1) false) ; flag
  (= (|ResetCounter#0| state) #b00000000000000000000000000000000) ; count
))
(define-fun |ResetCounter_h| ((state |ResetCounter_s|)) Bool true)
(define-fun |ResetCounter_t| ((state |ResetCounter_s|) (next_state |ResetCounter_s|)) Bool (and
  (= (|ResetCounter#5| state) (|ResetCounter#2| next_state)) ; $procdff$123 \flag
  (= (|ResetCounter#8| state) (|ResetCounter#0| next_state)) ; $procdff$122 \count
)) ; end of module ResetCounter
; yosys-smt2-module counter
(declare-sort |counter_s| 0)
(declare-fun |counter_is| (|counter_s|) Bool)
; yosys-smt2-cell ResetCounter resetCounter
; yosys-smt2-witness {"path": ["\\resetCounter"], "smtname": "resetCounter", "type": "cell"}
(declare-fun |counter#0| (|counter_s|) (_ BitVec 32)) ; \resetCounter_timeSinceReset
(declare-fun |counter#1| (|counter_s|) Bool) ; \resetCounter_notChaos
(declare-fun |counter_h resetCounter| (|counter_s|) |ResetCounter_s|)
; yosys-smt2-wire resetCounter_timeSinceReset 32
(define-fun |counter_n resetCounter_timeSinceReset| ((state |counter_s|)) (_ BitVec 32) (|counter#0| state))
(declare-fun |counter#2| (|counter_s|) Bool) ; \reset
; yosys-smt2-wire resetCounter_reset 1
(define-fun |counter_n resetCounter_reset| ((state |counter_s|)) Bool (|counter#2| state))
; yosys-smt2-wire resetCounter_notChaos 1
(define-fun |counter_n resetCounter_notChaos| ((state |counter_s|)) Bool (|counter#1| state))
(declare-fun |counter#3| (|counter_s|) Bool) ; \clock
; yosys-smt2-wire resetCounter_clk 1
; yosys-smt2-clock resetCounter_clk posedge
(define-fun |counter_n resetCounter_clk| ((state |counter_s|)) Bool (|counter#3| state))
; yosys-smt2-input reset 1
; yosys-smt2-wire reset 1
; yosys-smt2-witness {"offset": 0, "path": ["\\reset"], "smtname": "reset", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |counter_n reset| ((state |counter_s|)) Bool (|counter#2| state))
; yosys-smt2-anyinit counter#4 8 counter.sv:27.3-112.6
; yosys-smt2-witness {"offset": 0, "path": ["\\count"], "smtname": 4, "smtoffset": 0, "type": "init", "width": 8}
(declare-fun |counter#4| (|counter_s|) (_ BitVec 8)) ; \count
; yosys-smt2-output io_count 8
; yosys-smt2-wire io_count 8
(define-fun |counter_n io_count| ((state |counter_s|)) (_ BitVec 8) (|counter#4| state))
; yosys-smt2-register count 8
; yosys-smt2-wire count 8
(define-fun |counter_n count| ((state |counter_s|)) (_ BitVec 8) (|counter#4| state))
; yosys-smt2-input clock 1
; yosys-smt2-wire clock 1
; yosys-smt2-clock clock posedge
; yosys-smt2-witness {"offset": 0, "path": ["\\clock"], "smtname": "clock", "smtoffset": 0, "type": "posedge", "width": 1}
; yosys-smt2-witness {"offset": 0, "path": ["\\clock"], "smtname": "clock", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |counter_n clock| ((state |counter_s|)) Bool (|counter#3| state))
; yosys-smt2-anyseq counter#5 1 $auto$setundef.cc:533:execute$155
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_155"], "smtname": 5, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#5| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_155
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_155 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_155| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#5| state)) #b1))
; yosys-smt2-anyseq counter#6 1 $auto$setundef.cc:533:execute$153
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_153"], "smtname": 6, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#6| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_153
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_153 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_153| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#6| state)) #b1))
; yosys-smt2-anyseq counter#7 1 $auto$setundef.cc:533:execute$151
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_151"], "smtname": 7, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#7| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_151
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_151 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_151| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#7| state)) #b1))
; yosys-smt2-anyseq counter#8 1 $auto$setundef.cc:533:execute$149
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_149"], "smtname": 8, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#8| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_149
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_149 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_149| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#8| state)) #b1))
; yosys-smt2-anyseq counter#9 1 $auto$setundef.cc:533:execute$147
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_147"], "smtname": 9, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#9| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_147
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_147 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_147| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#9| state)) #b1))
; yosys-smt2-anyseq counter#10 1 $auto$setundef.cc:533:execute$145
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_145"], "smtname": 10, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#10| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_145
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_145 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_145| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#10| state)) #b1))
; yosys-smt2-anyseq counter#11 1 $auto$setundef.cc:533:execute$143
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyseq_auto_setundef_cc_533_execute_143"], "smtname": 11, "smtoffset": 0, "type": "seq", "width": 1}
(declare-fun |counter#11| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyseq_auto_setundef_cc_533_execute_143
; yosys-smt2-wire _witness_.anyseq_auto_setundef_cc_533_execute_143 1
(define-fun |counter_n _witness_.anyseq_auto_setundef_cc_533_execute_143| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#11| state)) #b1))
; yosys-smt2-anyinit counter#12 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_136"], "smtname": 12, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#12| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_136
; yosys-smt2-register _witness_.anyinit_procdff_136 1
; yosys-smt2-wire _witness_.anyinit_procdff_136 1
(define-fun |counter_n _witness_.anyinit_procdff_136| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#12| state)) #b1))
; yosys-smt2-anyinit counter#13 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_134"], "smtname": 13, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#13| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_134
; yosys-smt2-register _witness_.anyinit_procdff_134 1
; yosys-smt2-wire _witness_.anyinit_procdff_134 1
(define-fun |counter_n _witness_.anyinit_procdff_134| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#13| state)) #b1))
; yosys-smt2-anyinit counter#14 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_132"], "smtname": 14, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#14| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_132
; yosys-smt2-register _witness_.anyinit_procdff_132 1
; yosys-smt2-wire _witness_.anyinit_procdff_132 1
(define-fun |counter_n _witness_.anyinit_procdff_132| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#14| state)) #b1))
; yosys-smt2-anyinit counter#15 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_130"], "smtname": 15, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#15| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_130
; yosys-smt2-register _witness_.anyinit_procdff_130 1
; yosys-smt2-wire _witness_.anyinit_procdff_130 1
(define-fun |counter_n _witness_.anyinit_procdff_130| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#15| state)) #b1))
; yosys-smt2-anyinit counter#16 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_128"], "smtname": 16, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#16| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_128
; yosys-smt2-register _witness_.anyinit_procdff_128 1
; yosys-smt2-wire _witness_.anyinit_procdff_128 1
(define-fun |counter_n _witness_.anyinit_procdff_128| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#16| state)) #b1))
; yosys-smt2-anyinit counter#17 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_126"], "smtname": 17, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#17| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_126
; yosys-smt2-register _witness_.anyinit_procdff_126 1
; yosys-smt2-wire _witness_.anyinit_procdff_126 1
(define-fun |counter_n _witness_.anyinit_procdff_126| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#17| state)) #b1))
; yosys-smt2-anyinit counter#18 1 counter.sv:158.3-187.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_124"], "smtname": 18, "smtoffset": 0, "type": "init", "width": 1}
(declare-fun |counter#18| (|counter_s|) (_ BitVec 1)) ; \_witness_.anyinit_procdff_124
; yosys-smt2-register _witness_.anyinit_procdff_124 1
; yosys-smt2-wire _witness_.anyinit_procdff_124 1
(define-fun |counter_n _witness_.anyinit_procdff_124| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#18| state)) #b1))
(define-fun |counter#19| ((state |counter_s|)) (_ BitVec 8) (bvadd (|counter#4| state) #b00000001)) ; \_count_T_1
; yosys-smt2-wire _count_T_1 8
(define-fun |counter_n _count_T_1| ((state |counter_s|)) (_ BitVec 8) (|counter#19| state))
(define-fun |counter#20| ((state |counter_s|)) Bool (not (or  (= ((_ extract 0 0) (|counter#4| state)) #b1) (= ((_ extract 1 1) (|counter#4| state)) #b1) (= ((_ extract 2 2) (|counter#4| state)) #b1) (= ((_ extract 3 3) (|counter#4| state)) #b1) (= ((_ extract 4 4) (|counter#4| state)) #b1) (= ((_ extract 5 5) (|counter#4| state)) #b1) (= ((_ extract 6 6) (|counter#4| state)) #b1) (= ((_ extract 7 7) (|counter#4| state)) #b1)))) ; \_T_5
; yosys-smt2-wire _T_5 1
(define-fun |counter_n _T_5| ((state |counter_s|)) Bool (|counter#20| state))
(define-fun |counter#21| ((state |counter_s|)) (_ BitVec 1) (bvnot (ite (|counter#2| state) #b1 #b0))) ; \_T_3
; yosys-smt2-wire _T_3 1
(define-fun |counter_n _T_3| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#21| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:184$7_EN"], "smtname": 22, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#22| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:184$7_EN
; yosys-smt2-register $formal$counter.sv:184$7_EN 1
(define-fun |counter_n $formal$counter.sv:184$7_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#22| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:180$6_EN"], "smtname": 23, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#23| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:180$6_EN
; yosys-smt2-register $formal$counter.sv:180$6_EN 1
(define-fun |counter_n $formal$counter.sv:180$6_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#23| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:176$5_EN"], "smtname": 24, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#24| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:176$5_EN
; yosys-smt2-register $formal$counter.sv:176$5_EN 1
(define-fun |counter_n $formal$counter.sv:176$5_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#24| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:172$4_EN"], "smtname": 25, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#25| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:172$4_EN
; yosys-smt2-register $formal$counter.sv:172$4_EN 1
(define-fun |counter_n $formal$counter.sv:172$4_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#25| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:168$3_EN"], "smtname": 26, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#26| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:168$3_EN
; yosys-smt2-register $formal$counter.sv:168$3_EN 1
(define-fun |counter_n $formal$counter.sv:168$3_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#26| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:164$2_EN"], "smtname": 27, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#27| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:164$2_EN
; yosys-smt2-register $formal$counter.sv:164$2_EN 1
(define-fun |counter_n $formal$counter.sv:164$2_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#27| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$formal$counter.sv:160$1_EN"], "smtname": 28, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |counter#28| (|counter_s|) (_ BitVec 1)) ; $formal$counter.sv:160$1_EN
; yosys-smt2-register $formal$counter.sv:160$1_EN 1
(define-fun |counter_n $formal$counter.sv:160$1_EN| ((state |counter_s|)) Bool (= ((_ extract 0 0) (|counter#28| state)) #b1))
(define-fun |counter#29| ((state |counter_s|)) (_ BitVec 1) (bvnot (ite (|counter#3| state) #b1 #b0))) ; $auto$rtlil.cc:2461:Not$158
; yosys-smt2-assume 0 $auto$formalff.cc:758:execute$159
(define-fun |counter_u 0| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#29| state)) #b1) (not true))) ; $auto$formalff.cc:758:execute$159
; yosys-smt2-assert 0 $assert$counter.sv:184$62 counter.sv:184.83-185.19
(define-fun |counter_a 0| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#12| state)) #b1) (not (= ((_ extract 0 0) (|counter#22| state)) #b1)))) ; $assert$counter.sv:184$62
; yosys-smt2-assert 1 $assert$counter.sv:180$61 counter.sv:180.83-181.28
(define-fun |counter_a 1| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#13| state)) #b1) (not (= ((_ extract 0 0) (|counter#23| state)) #b1)))) ; $assert$counter.sv:180$61
; yosys-smt2-assert 2 $assert$counter.sv:176$60 counter.sv:176.83-177.28
(define-fun |counter_a 2| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#14| state)) #b1) (not (= ((_ extract 0 0) (|counter#24| state)) #b1)))) ; $assert$counter.sv:176$60
; yosys-smt2-assert 3 $assert$counter.sv:172$59 counter.sv:172.83-173.28
(define-fun |counter_a 3| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#15| state)) #b1) (not (= ((_ extract 0 0) (|counter#25| state)) #b1)))) ; $assert$counter.sv:172$59
; yosys-smt2-assert 4 $assert$counter.sv:168$58 counter.sv:168.83-169.28
(define-fun |counter_a 4| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#16| state)) #b1) (not (= ((_ extract 0 0) (|counter#26| state)) #b1)))) ; $assert$counter.sv:168$58
; yosys-smt2-assert 5 $assert$counter.sv:164$57 counter.sv:164.83-165.28
(define-fun |counter_a 5| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#17| state)) #b1) (not (= ((_ extract 0 0) (|counter#27| state)) #b1)))) ; $assert$counter.sv:164$57
; yosys-smt2-assert 6 $assert$counter.sv:160$56 counter.sv:160.46-161.27
(define-fun |counter_a 6| ((state |counter_s|)) Bool (or (= ((_ extract 0 0) (|counter#18| state)) #b1) (not (= ((_ extract 0 0) (|counter#28| state)) #b1)))) ; $assert$counter.sv:160$56
(define-fun |counter#30| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (|counter#21| state))) ; $and$counter.sv:160$31_Y
(define-fun |counter#31| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#30| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:160$1_EN[0:0]$17
(define-fun |counter#32| ((state |counter_s|)) Bool (not (or  (= ((_ extract 0 0) (|counter#0| state)) #b1) (= ((_ extract 1 1) (|counter#0| state)) #b1) (= ((_ extract 2 2) (|counter#0| state)) #b1) (= ((_ extract 3 3) (|counter#0| state)) #b1) (= ((_ extract 4 4) (|counter#0| state)) #b1) (= ((_ extract 5 5) (|counter#0| state)) #b1) (= ((_ extract 6 6) (|counter#0| state)) #b1) (= ((_ extract 7 7) (|counter#0| state)) #b1) (= ((_ extract 8 8) (|counter#0| state)) #b1) (= ((_ extract 9 9) (|counter#0| state)) #b1) (= ((_ extract 10 10) (|counter#0| state)) #b1) (= ((_ extract 11 11) (|counter#0| state)) #b1) (= ((_ extract 12 12) (|counter#0| state)) #b1) (= ((_ extract 13 13) (|counter#0| state)) #b1) (= ((_ extract 14 14) (|counter#0| state)) #b1) (= ((_ extract 15 15) (|counter#0| state)) #b1) (= ((_ extract 16 16) (|counter#0| state)) #b1) (= ((_ extract 17 17) (|counter#0| state)) #b1) (= ((_ extract 18 18) (|counter#0| state)) #b1) (= ((_ extract 19 19) (|counter#0| state)) #b1) (= ((_ extract 20 20) (|counter#0| state)) #b1) (= ((_ extract 21 21) (|counter#0| state)) #b1) (= ((_ extract 22 22) (|counter#0| state)) #b1) (= ((_ extract 23 23) (|counter#0| state)) #b1) (= ((_ extract 24 24) (|counter#0| state)) #b1) (= ((_ extract 25 25) (|counter#0| state)) #b1) (= ((_ extract 26 26) (|counter#0| state)) #b1) (= ((_ extract 27 27) (|counter#0| state)) #b1) (= ((_ extract 28 28) (|counter#0| state)) #b1) (= ((_ extract 29 29) (|counter#0| state)) #b1) (= ((_ extract 30 30) (|counter#0| state)) #b1) (= ((_ extract 31 31) (|counter#0| state)) #b1)))) ; $eq$counter.sv:164$33_Y
(define-fun |counter#33| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#32| state) #b1 #b0))) ; $and$counter.sv:164$34_Y
(define-fun |counter#34| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#33| state) (|counter#21| state))) ; $and$counter.sv:164$35_Y
(define-fun |counter#35| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#34| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:164$2_EN[0:0]$19
(define-fun |counter#36| ((state |counter_s|)) Bool (= (|counter#0| state) #b00000000000000000000000000000001)) ; $eq$counter.sv:168$37_Y
(define-fun |counter#37| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#36| state) #b1 #b0))) ; $and$counter.sv:168$38_Y
(define-fun |counter#38| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#37| state) (|counter#21| state))) ; $and$counter.sv:168$39_Y
(define-fun |counter#39| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#38| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:168$3_EN[0:0]$21
(define-fun |counter#40| ((state |counter_s|)) Bool (= (|counter#0| state) #b00000000000000000000000000000010)) ; $eq$counter.sv:172$41_Y
(define-fun |counter#41| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#40| state) #b1 #b0))) ; $and$counter.sv:172$42_Y
(define-fun |counter#42| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#41| state) (|counter#21| state))) ; $and$counter.sv:172$43_Y
(define-fun |counter#43| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#42| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:172$4_EN[0:0]$23
(define-fun |counter#44| ((state |counter_s|)) Bool (= (|counter#0| state) #b00000000000000000000000000000011)) ; $eq$counter.sv:176$45_Y
(define-fun |counter#45| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#44| state) #b1 #b0))) ; $and$counter.sv:176$46_Y
(define-fun |counter#46| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#45| state) (|counter#21| state))) ; $and$counter.sv:176$47_Y
(define-fun |counter#47| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#46| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:176$5_EN[0:0]$25
(define-fun |counter#48| ((state |counter_s|)) Bool (= (|counter#0| state) #b00000000000000000000000000000100)) ; $eq$counter.sv:180$49_Y
(define-fun |counter#49| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#48| state) #b1 #b0))) ; $and$counter.sv:180$50_Y
(define-fun |counter#50| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#49| state) (|counter#21| state))) ; $and$counter.sv:180$51_Y
(define-fun |counter#51| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#50| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:180$6_EN[0:0]$27
(define-fun |counter#52| ((state |counter_s|)) Bool (= (|counter#0| state) #b00000000000000000000000000001011)) ; $eq$counter.sv:184$53_Y
(define-fun |counter#53| ((state |counter_s|)) (_ BitVec 1) (bvand (ite (|counter#1| state) #b1 #b0) (ite (|counter#52| state) #b1 #b0))) ; $and$counter.sv:184$54_Y
(define-fun |counter#54| ((state |counter_s|)) (_ BitVec 1) (bvand (|counter#53| state) (|counter#21| state))) ; $and$counter.sv:184$55_Y
(define-fun |counter#55| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#54| state)) #b1) #b1 #b0)) ; $0$formal$counter.sv:184$7_EN[0:0]$29
(define-fun |counter#56| ((state |counter_s|)) Bool (bvult (|counter#4| state) #b00001011)) ; $lt$counter.sv:161$32_Y
(define-fun |counter#57| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#30| state)) #b1) (ite (|counter#56| state) #b1 #b0) (|counter#7| state))) ; $0$formal$counter.sv:160$1_CHECK[0:0]$16
(define-fun |counter#58| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#34| state)) #b1) (ite (|counter#20| state) #b1 #b0) (|counter#6| state))) ; $0$formal$counter.sv:164$2_CHECK[0:0]$18
(define-fun |counter#59| ((state |counter_s|)) Bool (= (|counter#4| state) #b00000001)) ; $eq$counter.sv:169$40_Y
(define-fun |counter#60| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#38| state)) #b1) (ite (|counter#59| state) #b1 #b0) (|counter#5| state))) ; $0$formal$counter.sv:168$3_CHECK[0:0]$20
(define-fun |counter#61| ((state |counter_s|)) Bool (= (|counter#4| state) #b00000010)) ; $eq$counter.sv:173$44_Y
(define-fun |counter#62| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#42| state)) #b1) (ite (|counter#61| state) #b1 #b0) (|counter#11| state))) ; $0$formal$counter.sv:172$4_CHECK[0:0]$22
(define-fun |counter#63| ((state |counter_s|)) Bool (= (|counter#4| state) #b00000011)) ; $eq$counter.sv:177$48_Y
(define-fun |counter#64| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#46| state)) #b1) (ite (|counter#63| state) #b1 #b0) (|counter#10| state))) ; $0$formal$counter.sv:176$5_CHECK[0:0]$24
(define-fun |counter#65| ((state |counter_s|)) Bool (= (|counter#4| state) #b00000100)) ; $eq$counter.sv:181$52_Y
(define-fun |counter#66| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#50| state)) #b1) (ite (|counter#65| state) #b1 #b0) (|counter#9| state))) ; $0$formal$counter.sv:180$6_CHECK[0:0]$26
(define-fun |counter#67| ((state |counter_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|counter#54| state)) #b1) (ite (|counter#20| state) #b1 #b0) (|counter#8| state))) ; $0$formal$counter.sv:184$7_CHECK[0:0]$28
(define-fun |counter#68| ((state |counter_s|)) Bool (= (|counter#4| state) #b00001010)) ; $eq$counter.sv:30$14_Y
(define-fun |counter#69| ((state |counter_s|)) (_ BitVec 8) (ite (|counter#68| state) #b00000000 (|counter#19| state))) ; $procmux$117_Y
(define-fun |counter#70| ((state |counter_s|)) (_ BitVec 8) (ite (|counter#2| state) #b00000000 (|counter#69| state))) ; $0\count[7:0]
(define-fun |counter_a| ((state |counter_s|)) Bool (and
  (|counter_a 0| state)
  (|counter_a 1| state)
  (|counter_a 2| state)
  (|counter_a 3| state)
  (|counter_a 4| state)
  (|counter_a 5| state)
  (|counter_a 6| state)
  (|ResetCounter_a| (|counter_h resetCounter| state))
))
(define-fun |counter_u| ((state |counter_s|)) Bool (and
  (|counter_u 0| state)
  (|ResetCounter_u| (|counter_h resetCounter| state))
))
(define-fun |counter_i| ((state |counter_s|)) Bool (and
  (= (= ((_ extract 0 0) (|counter#22| state)) #b1) false) ; $formal$counter.sv:184$7_EN
  (= (= ((_ extract 0 0) (|counter#23| state)) #b1) false) ; $formal$counter.sv:180$6_EN
  (= (= ((_ extract 0 0) (|counter#24| state)) #b1) false) ; $formal$counter.sv:176$5_EN
  (= (= ((_ extract 0 0) (|counter#25| state)) #b1) false) ; $formal$counter.sv:172$4_EN
  (= (= ((_ extract 0 0) (|counter#26| state)) #b1) false) ; $formal$counter.sv:168$3_EN
  (= (= ((_ extract 0 0) (|counter#27| state)) #b1) false) ; $formal$counter.sv:164$2_EN
  (= (= ((_ extract 0 0) (|counter#28| state)) #b1) false) ; $formal$counter.sv:160$1_EN
  (|ResetCounter_i| (|counter_h resetCounter| state))
))
(define-fun |counter_h| ((state |counter_s|)) Bool (and
  (= (|counter_is| state) (|ResetCounter_is| (|counter_h resetCounter| state)))
  (= (|counter#0| state) (|ResetCounter_n timeSinceReset| (|counter_h resetCounter| state))) ; ResetCounter.timeSinceReset
  (= (|counter#2| state) (|ResetCounter_n reset| (|counter_h resetCounter| state))) ; ResetCounter.reset
  (= (|counter#1| state) (|ResetCounter_n notChaos| (|counter_h resetCounter| state))) ; ResetCounter.notChaos
  (= (|counter#3| state) (|ResetCounter_n clk| (|counter_h resetCounter| state))) ; ResetCounter.clk
  (|ResetCounter_h| (|counter_h resetCounter| state))
))
(define-fun |counter_t| ((state |counter_s|) (next_state |counter_s|)) Bool (and
  (= (|counter#31| state) (|counter#28| next_state)) ; $procdff$125 $formal$counter.sv:160$1_EN
  (= (|counter#35| state) (|counter#27| next_state)) ; $procdff$127 $formal$counter.sv:164$2_EN
  (= (|counter#39| state) (|counter#26| next_state)) ; $procdff$129 $formal$counter.sv:168$3_EN
  (= (|counter#43| state) (|counter#25| next_state)) ; $procdff$131 $formal$counter.sv:172$4_EN
  (= (|counter#47| state) (|counter#24| next_state)) ; $procdff$133 $formal$counter.sv:176$5_EN
  (= (|counter#51| state) (|counter#23| next_state)) ; $procdff$135 $formal$counter.sv:180$6_EN
  (= (|counter#55| state) (|counter#22| next_state)) ; $procdff$137 $formal$counter.sv:184$7_EN
  (= (|counter#57| state) (|counter#18| next_state)) ; $procdff$124 \_witness_.anyinit_procdff_124
  (= (|counter#58| state) (|counter#17| next_state)) ; $procdff$126 \_witness_.anyinit_procdff_126
  (= (|counter#60| state) (|counter#16| next_state)) ; $procdff$128 \_witness_.anyinit_procdff_128
  (= (|counter#62| state) (|counter#15| next_state)) ; $procdff$130 \_witness_.anyinit_procdff_130
  (= (|counter#64| state) (|counter#14| next_state)) ; $procdff$132 \_witness_.anyinit_procdff_132
  (= (|counter#66| state) (|counter#13| next_state)) ; $procdff$134 \_witness_.anyinit_procdff_134
  (= (|counter#67| state) (|counter#12| next_state)) ; $procdff$136 \_witness_.anyinit_procdff_136
  (= (|counter#70| state) (|counter#4| next_state)) ; $procdff$138 \count
  (|ResetCounter_t| (|counter_h resetCounter| state) (|counter_h resetCounter| next_state))
)) ; end of module counter
; yosys-smt2-topmod counter
; end of yosys output
