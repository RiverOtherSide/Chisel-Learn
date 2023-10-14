# Define common subformulae.
\define GAclean		GA.condition[1:0]=b00
\define GAdirty		GA.condition[1:0]=b01
\define GAshowering	GA.condition[1:0]=b10
\define GAhasSoap	GA.predecessor[2:0]=b100
\define GBclean		GB.condition[1:0]=b00
\define GBdirty		GB.condition[1:0]=b01
\define GBshowering	GB.condition[1:0]=b10
\define GBhasSoap	GB.predecessor[2:0]=b100
\define GCclean		GC.condition[1:0]=b00
\define GCdirty		GC.condition[1:0]=b01
\define GCshowering	GC.condition[1:0]=b10
\define GChasSoap	GC.predecessor[2:0]=b100
\define GDclean		GD.condition[1:0]=b00
\define GDdirty		GD.condition[1:0]=b01
\define GDshowering	GD.condition[1:0]=b10
\define GDhasSoap	GD.predecessor[2:0]=b100
\define GEclean		GE.condition[1:0]=b00
\define GEdirty		GE.condition[1:0]=b01
\define GEshowering	GE.condition[1:0]=b10
\define GEhasSoap	GE.predecessor[2:0]=b100
\define GFclean		GF.condition[1:0]=b00
\define GFdirty		GF.condition[1:0]=b01
\define GFshowering	GF.condition[1:0]=b10
\define GFhasSoap	GF.predecessor[2:0]=b100
\define GGclean		GG.condition[1:0]=b00
\define GGdirty		GG.condition[1:0]=b01
\define GGshowering	GG.condition[1:0]=b10
\define GGhasSoap	GG.predecessor[2:0]=b100
\define GHclean		GH.condition[1:0]=b00
\define GHdirty		GH.condition[1:0]=b01
\define GHshowering	GH.condition[1:0]=b10
\define GHhasSoap	GH.predecessor[2:0]=b100
\define GIclean		GI.condition[1:0]=b00
\define GIdirty		GI.condition[1:0]=b01
\define GIshowering	GI.condition[1:0]=b10
\define GIhasSoap	GI.predecessor[2:0]=b100
\define GJclean		GJ.condition[1:0]=b00
\define GJdirty		GJ.condition[1:0]=b01
\define GJshowering	GJ.condition[1:0]=b10
\define GJhasSoap	GJ.predecessor[2:0]=b100

#PASS: Only a guest with the soap may shower.

AG(\GAshowering -> \GAhasSoap);
AG(\GBshowering -> \GBhasSoap);
AG(\GCshowering -> \GChasSoap);
AG(\GDshowering -> \GDhasSoap);
AG(\GEshowering -> \GEhasSoap);
AG(\GFshowering -> \GFhasSoap);
AG(\GGshowering -> \GGhasSoap);
AG(\GHshowering -> \GHhasSoap);
AG(\GIshowering -> \GIhasSoap);
AG(\GJshowering -> \GJhasSoap);

#PASS: The soap is never requested from a non-existing neighbor.

AG(reqOutA[3]=0 * reqOutA[1:0]=b00 * reqOutC[2:0]=b000 * reqOutD[1]=0 *
   reqOutD[3]=0 * reqOutE[2]=0 * reqOutF[2:1]=b00 * reqOutG[3:2]=b00 *
   reqOutH[3]=0 * reqOutH[1:0]=b00 * reqOutI[3:2]=b00 * reqOutI[0]=0 *
   reqOutJ[3]=0 * reqOutJ[1:0]=b00);

#PASS: The soap is never passed to a non-existing neighbor.

AG(grantA[3]=0 * grantA[1:0]=b00 * grantC[2:0]=b000 * grantD[1]=0 *
   grantD[3]=0 * grantE[2]=0 * grantF[2:1]=b00 * grantG[3:2]=b00 *
   grantH[3]=0 * grantH[1:0]=b00 * grantI[3:2]=b00 * grantI[0]=0 *
   grantJ[3]=0 * grantJ[1:0]=b00);

#PASS: Showering only takes one clock cycle.
AG(\GAshowering -> AX(\GAclean));
AG(\GBshowering -> AX(\GBclean));
AG(\GCshowering -> AX(\GCclean));
AG(\GDshowering -> AX(\GDclean));
AG(\GEshowering -> AX(\GEclean));
AG(\GFshowering -> AX(\GFclean));
AG(\GGshowering -> AX(\GGclean));
AG(\GHshowering -> AX(\GHclean));
AG(\GIshowering -> AX(\GIclean));
AG(\GJshowering -> AX(\GJclean));

#PASS: no showering unless dirty.
!EF((!\GAdirty) * EX(\GAshowering));
!EF((!\GBdirty) * EX(\GBshowering));
!EF((!\GCdirty) * EX(\GCshowering));
!EF((!\GDdirty) * EX(\GDshowering));
!EF((!\GEdirty) * EX(\GEshowering));
!EF((!\GFdirty) * EX(\GFshowering));
!EF((!\GGdirty) * EX(\GGshowering));
!EF((!\GHdirty) * EX(\GHshowering));
!EF((!\GIdirty) * EX(\GIshowering));
!EF((!\GJdirty) * EX(\GJshowering));

#PASS: It is always possible for a guest to get dirty.

AG(EF(\GAdirty));
AG(EF(\GBdirty));
AG(EF(\GCdirty));
AG(EF(\GDdirty));
AG(EF(\GEdirty));
AG(EF(\GFdirty));
AG(EF(\GGdirty));
AG(EF(\GHdirty));
AG(EF(\GIdirty));
AG(EF(\GJdirty));

#PASS: At most one guest is showering at one time.

AG((showering[0]=1 -> (showering[9:1]=b000000000)) *
   (showering[1]=1 -> (showering[9:2]=b00000000 * showering[0]=0)) *
   (showering[2]=1 -> (showering[9:3]=b0000000 * showering[1:0]=b00)) *
   (showering[3]=1 -> (showering[9:4]=b000000 * showering[2:0]=b000)) *
   (showering[4]=1 -> (showering[9:5]=b00000 * showering[3:0]=b0000)) *
   (showering[5]=1 -> (showering[9:6]=b0000 * showering[4:0]=b00000)) *
   (showering[6]=1 -> (showering[9:7]=b000 * showering[5:0]=b000000)) *
   (showering[7]=1 -> (showering[9:8]=b00 * showering[6:0]=b0000000)) *
   (showering[8]=1 -> (showering[9]  = 0 * showering[7:0]=b00000000)) *
   (showering[9]=1 -> (                   showering[8:0]=b000000000)));

#PASS: If a guest ever gets dirty, eventually he/she will return clean.
AG(\GAdirty -> AF(\GAclean));
AG(\GBdirty -> AF(\GBclean));
AG(\GCdirty -> AF(\GCclean));
AG(\GDdirty -> AF(\GDclean));
AG(\GEdirty -> AF(\GEclean));
AG(\GFdirty -> AF(\GFclean));
AG(\GGdirty -> AF(\GGclean));
AG(\GHdirty -> AF(\GHclean));
AG(\GIdirty -> AF(\GIclean));
AG(\GJdirty -> AF(\GJclean));
