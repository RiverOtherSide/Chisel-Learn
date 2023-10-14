#PASS: It is not possible to start from the surface, visit each small cube
# exaclty once, and stop at the center.
AG!(visited<*0*>=1 * visited<*1*>=1 * visited<*2*>=1 * visited<*3*>=1 * 
  visited<*4*>=1 * visited<*5*>=1 * visited<*6*>=1 * visited<*7*>=1 * 
  visited<*8*>=1 * visited<*9*>=1 * visited<*10*>=1 * visited<*11*>=1 * 
  visited<*12*>=1 * visited<*13*>=1 * visited<*14*>=1 * visited<*15*>=1 *
  visited<*16*>=1 * visited<*17*>=1 * visited<*18*>=1 * visited<*19*>=1 *
  visited<*20*>=1 * visited<*21*>=1 * visited<*22*>=1 * visited<*23*>=1 *
  visited<*24*>=1 * visited<*25*>=1 * visited<*26*>=1 * pos[4:0]=13);

#PASS: Forbidden positions are never reached.
AG!pos[4:0]={27,28,29,30,31};

#FAIL: On all paths with two transitions, it is not possible to go through
# cell 13 in the second state and end in cell 16.
AX(pos[4:0]=13 -> AX(!pos[4:0]=16));
