      subroutine SINDA(param, insig, outsig)
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDA

CC      PROGRAM SINDA
      CHARACTER*6 H
      COMMON /TITLE/H(20)
      COMMON /TEMP/T(      9)
      COMMON /CAP/C(      6)
      COMMON /SOURCE/Q(      6)
      COMMON /COND/G(       9)
      COMMON /KONST/K(     10)
      COMMON /ARRAY/A(      38)
      COMMON /PC1/LSQ1(      84)
      COMMON /PC2/LSQ2(      15)
      COMMON /DIMENS/NND,NNC,NNT,NGL,NGT,NGE,NCC,NUC,NCT,NAT,LENA
     +,NSQ1,NSQ2,NPC,NPT,NSQ3,NVL,NPM,NTE,NSQ4,NCS,LCS
      COMMON /POINTN/LNODE,LCOND,LCONS,LARRY,IVB,LPRES,LTUBE,LCHAR
      COMMON /TAPE/NIN,NOUT,LDAT,LDIC,ASCI,FLUD,GNRL,CHAR
      COMMON /XSPACE/NDIM,NTH,X(   10000)
      COMMON /FIXCON/
     +TIMEN ,DTIMEU,TIMEND,CSGFAC,NLOOP ,DTMPCA,ITROUT,DTIMEH,
     +DAMPA ,DAMPD ,ATMPCA,BACKUP,TIMEO ,TIMEM ,DTMPCC,ATMPCC,
     +CSGMIN,OUTPUT,ARLXCA,LOOPCT,DTIMEL,DTIMEI,CSGMAX,CSGRAL,
     +CSGRCL,DRLXCA,DRLXCC,NLINE ,NPAGE ,ARLXCC,LSPCS ,ENGBAL,
     +BALENG,ATSLIM,NCSGMN,NDTMPC,NARLXC,NATMPC,ITEST ,JTEST ,
     +KTEST ,LTEST ,MTEST ,RTEST ,STEST ,TTEST ,UTEST ,VTEST ,
     +LAXFAC,SIGMA ,TMPZRO,NDRLXC,TDERV ,NTDERV,BENODE,EBNODE,
     +NODEEB,EXTLIM,NCOLUM,PRLXCA,PRLXCC,NEGSIV,GRVCON,PZERO ,
     +NCSGMX,NTEST ,ATEST ,BTEST ,CTEST ,DTEST ,ETEST ,FTEST ,
     +GTEST ,HTEST ,OTEST ,PTEST ,QTEST ,WTEST ,XTEST ,YTEST ,
     +ZTEST ,NTROSS,ISNUNC,NLINPP,LOTEMP,ERRMAX,ERRMIN,SENGIN,
     +DBLPRC,MPCNTL,IPCNT1,IPCNT2,ATSLM1,NLOOP1,JDIFQ ,KMAX  ,
     +FRACHG,EPS   ,PRSABS,PRSREL,FLOABS,FLOREL,FLOMAX,PRANGE,
     +ISOLVE,NPASS ,DEFLIM,ICHECK,GRAV  ,GC1   ,GC2   ,USRFLO,
     +PMPTOL,DEBUGF,NOFERR,GC3   ,SPARE1,SPARE2,SPARE3,SPARE4,
     +SPARE5,SPARE6,SPARE7,NNGSPM,NCONVG
      DIMENSION XK(     10),NX(   10000),IA(      38)
      EQUIVALENCE (K(1),XK(1)),(X(1),NX(1)),(A(1),IA(1))
      LOGICAL ASCI,FLUD,GNRL,CHAR
      COMMON /MODNAME/MODNAME
      CHARACTER *50 MODNAME
      COMMON /IMODNAME/MODNSTRT,MODNEND,IFILESYS
c*
c*
c*    INPUT(S):   insig(1)  = LOX skirt purge flow (lbm/min)
c*                insig(2)  = downcomer surface h coeff. (btu/hr-ft^2-F)
c*                insig(3)  = RP tank tunnel surface h coeff. (btu/hr-ft^2-F)
c*                insig(4)  = purge temp at inlet to downcomer tunnel (F)
c*    OUTPUT(S):  outsig(1) = bulk air outlet temp (F)
c*                outsig(2) = net energy loss by bulk air (btu/hr)
c*    PARAMETERS: param(1)  = (null)
c*
c*************** Dimensioning *****************************
      real*8 param(1), insig(4), outsig(2)
c afc
      MODNAME='sinda'                                                                               
      MODNSTRT=  1
      MODNEND=  5
      IFILESYS=  1
      NIN=5
      LDAT=2
      LDIC=4
      OPEN(LDAT,FILE='downcomer.TP2',STATUS='UNKNOWN',
     +FORM='UNFORMATTED')                               
      OPEN(LDIC,FILE='downcomer.TP4',STATUS='UNKNOWN',
     +FORM='UNFORMATTED')                               
      ASCI=.FALSE.
      CHAR=.FALSE.
      FLUD=.FALSE.
      GNRL=.FALSE.
      T(1)=0.
      C(1)=0.
      Q(1)=0.
      G(1)=0.
      LSQ1(1)=0
      LSQ2(1)=0
      K(1)=0
      A(1)=0.
      X(1)=0.
      NOUT=   6
      OPEN(NOUT ,FILE='downcomer.OUT',STATUS='UNKNOWN',
     +FORM='FORMATTED')                                
      CALL INPUT
c afc
      XK(1) = insig(1)
	XK(2) = insig(2)
	XK(3) = insig(3)
	XK(4) = insig(4)
c afc
      CALL EXECT
      CLOSE(LDAT)
      CLOSE(LDIC)
      CLOSE(NIN)
      CLOSE(NOUT)
      outsig(1) = T(6)
      outsig(2) = XK(6)
      END

      subroutine SINDAPI( param )
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDAPI
      real*8 param(1)
      param(1) = 0
      end

      integer*4 function SINDAPA( pCount )
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDAPA
      integer*2 pCount
      pCount = 1
      runavgPA = 8*1 	! room for 1 real*8's
      end

      integer*4 function SINDAPC( )
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDAPC
      SINDAPC = LOC( 'Data Count;Sum'c)
      end

C Place holders for Simulation Start and End events
      subroutine SINDASE( param, runCount )
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDASE
      real*8 param(1)
      integer*4 runCount
      param(1) = 0
      end

      subroutine SINDASS( param, runCount )
	!DEC$ ATTRIBUTES DLLEXPORT :: SINDASS
      real*8 param(1)
      integer*4 runCount    
      param(1) = 0
      end

      SUBROUTINE EXECT 
      CHARACTER*6 H
      COMMON /TITLE/H(20)
      COMMON /TEMP/T(      9)
      COMMON /CAP/C(      6)
      COMMON /SOURCE/Q(      6)
      COMMON /COND/G(       9)
      COMMON /KONST/K(     10)
      COMMON /ARRAY/A(      38)
      COMMON /PC1/LSQ1(      84)
      COMMON /PC2/LSQ2(      15)
      COMMON /DIMENS/NND,NNC,NNT,NGL,NGT,NGE,NCC,NUC,NCT,NAT,LENA
     +,NSQ1,NSQ2,NPC,NPT,NSQ3,NVL,NPM,NTE,NSQ4,NCS,LCS
      COMMON /POINTN/LNODE,LCOND,LCONS,LARRY,IVB,LPRES,LTUBE,LCHAR
      COMMON /TAPE/NIN,NOUT,LDAT,LDIC,ASCI,FLUD,GNRL,CHAR
      COMMON /XSPACE/NDIM,NTH,X(   10000)
      COMMON /FIXCON/
     +TIMEN ,DTIMEU,TIMEND,CSGFAC,NLOOP ,DTMPCA,ITROUT,DTIMEH,
     +DAMPA ,DAMPD ,ATMPCA,BACKUP,TIMEO ,TIMEM ,DTMPCC,ATMPCC,
     +CSGMIN,OUTPUT,ARLXCA,LOOPCT,DTIMEL,DTIMEI,CSGMAX,CSGRAL,
     +CSGRCL,DRLXCA,DRLXCC,NLINE ,NPAGE ,ARLXCC,LSPCS ,ENGBAL,
     +BALENG,ATSLIM,NCSGMN,NDTMPC,NARLXC,NATMPC,ITEST ,JTEST ,
     +KTEST ,LTEST ,MTEST ,RTEST ,STEST ,TTEST ,UTEST ,VTEST ,
     +LAXFAC,SIGMA ,TMPZRO,NDRLXC,TDERV ,NTDERV,BENODE,EBNODE,
     +NODEEB,EXTLIM,NCOLUM,PRLXCA,PRLXCC,NEGSIV,GRVCON,PZERO ,
     +NCSGMX,NTEST ,ATEST ,BTEST ,CTEST ,DTEST ,ETEST ,FTEST ,
     +GTEST ,HTEST ,OTEST ,PTEST ,QTEST ,WTEST ,XTEST ,YTEST ,
     +ZTEST ,NTROSS,ISNUNC,NLINPP,LOTEMP,ERRMAX,ERRMIN,SENGIN,
     +DBLPRC,MPCNTL,IPCNT1,IPCNT2,ATSLM1,NLOOP1,JDIFQ ,KMAX  ,
     +FRACHG,EPS   ,PRSABS,PRSREL,FLOABS,FLOREL,FLOMAX,PRANGE,
     +ISOLVE,NPASS ,DEFLIM,ICHECK,GRAV  ,GC1   ,GC2   ,USRFLO,
     +PMPTOL,DEBUGF,NOFERR,GC3   ,SPARE1,SPARE2,SPARE3,SPARE4,
     +SPARE5,SPARE6,SPARE7,NNGSPM,NCONVG
      DIMENSION XK(     10),NX(   10000),IA(      38)
      EQUIVALENCE (K(1),XK(1)),(X(1),NX(1)),(A(1),IA(1))
      LOGICAL ASCI,FLUD,GNRL,CHAR
       open(8,file='downcomer_insulated_c_08.out',access='sequential',          
     +  status='unknown')                                                       
        XK(5)= 0                                                        
      CALL SNDSNR                                                       
      RETURN
      END
      SUBROUTINE VARBL1
      CHARACTER*6 H
      COMMON /TITLE/H(20)
      COMMON /TEMP/T(      9)
      COMMON /CAP/C(      6)
      COMMON /SOURCE/Q(      6)
      COMMON /COND/G(       9)
      COMMON /KONST/K(     10)
      COMMON /ARRAY/A(      38)
      COMMON /PC1/LSQ1(      84)
      COMMON /PC2/LSQ2(      15)
      COMMON /DIMENS/NND,NNC,NNT,NGL,NGT,NGE,NCC,NUC,NCT,NAT,LENA
     +,NSQ1,NSQ2,NPC,NPT,NSQ3,NVL,NPM,NTE,NSQ4,NCS,LCS
      COMMON /POINTN/LNODE,LCOND,LCONS,LARRY,IVB,LPRES,LTUBE,LCHAR
      COMMON /TAPE/NIN,NOUT,LDAT,LDIC,ASCI,FLUD,GNRL,CHAR
      COMMON /XSPACE/NDIM,NTH,X(   10000)
      COMMON /FIXCON/
     +TIMEN ,DTIMEU,TIMEND,CSGFAC,NLOOP ,DTMPCA,ITROUT,DTIMEH,
     +DAMPA ,DAMPD ,ATMPCA,BACKUP,TIMEO ,TIMEM ,DTMPCC,ATMPCC,
     +CSGMIN,OUTPUT,ARLXCA,LOOPCT,DTIMEL,DTIMEI,CSGMAX,CSGRAL,
     +CSGRCL,DRLXCA,DRLXCC,NLINE ,NPAGE ,ARLXCC,LSPCS ,ENGBAL,
     +BALENG,ATSLIM,NCSGMN,NDTMPC,NARLXC,NATMPC,ITEST ,JTEST ,
     +KTEST ,LTEST ,MTEST ,RTEST ,STEST ,TTEST ,UTEST ,VTEST ,
     +LAXFAC,SIGMA ,TMPZRO,NDRLXC,TDERV ,NTDERV,BENODE,EBNODE,
     +NODEEB,EXTLIM,NCOLUM,PRLXCA,PRLXCC,NEGSIV,GRVCON,PZERO ,
     +NCSGMX,NTEST ,ATEST ,BTEST ,CTEST ,DTEST ,ETEST ,FTEST ,
     +GTEST ,HTEST ,OTEST ,PTEST ,QTEST ,WTEST ,XTEST ,YTEST ,
     +ZTEST ,NTROSS,ISNUNC,NLINPP,LOTEMP,ERRMAX,ERRMIN,SENGIN,
     +DBLPRC,MPCNTL,IPCNT1,IPCNT2,ATSLM1,NLOOP1,JDIFQ ,KMAX  ,
     +FRACHG,EPS   ,PRSABS,PRSREL,FLOABS,FLOREL,FLOMAX,PRANGE,
     +ISOLVE,NPASS ,DEFLIM,ICHECK,GRAV  ,GC1   ,GC2   ,USRFLO,
     +PMPTOL,DEBUGF,NOFERR,GC3   ,SPARE1,SPARE2,SPARE3,SPARE4,
     +SPARE5,SPARE6,SPARE7,NNGSPM,NCONVG
      DIMENSION XK(     10),NX(   10000),IA(      38)
      EQUIVALENCE (K(1),XK(1)),(X(1),NX(1)),(A(1),IA(1))
      LOGICAL ASCI,FLUD,GNRL,CHAR
       T(8)=XK(4)                                                       
       G(7)=XK(1)* 14.4                                                 
       G(8)=XK(1)* 14.4                                                 
       G(2)=XK(2)* 42.79                                                
       G(3)=XK(3)* 115.49                                               
      RETURN
      END
      SUBROUTINE VARBL2
      CHARACTER*6 H
      COMMON /TITLE/H(20)
      COMMON /TEMP/T(      9)
      COMMON /CAP/C(      6)
      COMMON /SOURCE/Q(      6)
      COMMON /COND/G(       9)
      COMMON /KONST/K(     10)
      COMMON /ARRAY/A(      38)
      COMMON /PC1/LSQ1(      84)
      COMMON /PC2/LSQ2(      15)
      COMMON /DIMENS/NND,NNC,NNT,NGL,NGT,NGE,NCC,NUC,NCT,NAT,LENA
     +,NSQ1,NSQ2,NPC,NPT,NSQ3,NVL,NPM,NTE,NSQ4,NCS,LCS
      COMMON /POINTN/LNODE,LCOND,LCONS,LARRY,IVB,LPRES,LTUBE,LCHAR
      COMMON /TAPE/NIN,NOUT,LDAT,LDIC,ASCI,FLUD,GNRL,CHAR
      COMMON /XSPACE/NDIM,NTH,X(   10000)
      COMMON /FIXCON/
     +TIMEN ,DTIMEU,TIMEND,CSGFAC,NLOOP ,DTMPCA,ITROUT,DTIMEH,
     +DAMPA ,DAMPD ,ATMPCA,BACKUP,TIMEO ,TIMEM ,DTMPCC,ATMPCC,
     +CSGMIN,OUTPUT,ARLXCA,LOOPCT,DTIMEL,DTIMEI,CSGMAX,CSGRAL,
     +CSGRCL,DRLXCA,DRLXCC,NLINE ,NPAGE ,ARLXCC,LSPCS ,ENGBAL,
     +BALENG,ATSLIM,NCSGMN,NDTMPC,NARLXC,NATMPC,ITEST ,JTEST ,
     +KTEST ,LTEST ,MTEST ,RTEST ,STEST ,TTEST ,UTEST ,VTEST ,
     +LAXFAC,SIGMA ,TMPZRO,NDRLXC,TDERV ,NTDERV,BENODE,EBNODE,
     +NODEEB,EXTLIM,NCOLUM,PRLXCA,PRLXCC,NEGSIV,GRVCON,PZERO ,
     +NCSGMX,NTEST ,ATEST ,BTEST ,CTEST ,DTEST ,ETEST ,FTEST ,
     +GTEST ,HTEST ,OTEST ,PTEST ,QTEST ,WTEST ,XTEST ,YTEST ,
     +ZTEST ,NTROSS,ISNUNC,NLINPP,LOTEMP,ERRMAX,ERRMIN,SENGIN,
     +DBLPRC,MPCNTL,IPCNT1,IPCNT2,ATSLM1,NLOOP1,JDIFQ ,KMAX  ,
     +FRACHG,EPS   ,PRSABS,PRSREL,FLOABS,FLOREL,FLOMAX,PRANGE,
     +ISOLVE,NPASS ,DEFLIM,ICHECK,GRAV  ,GC1   ,GC2   ,USRFLO,
     +PMPTOL,DEBUGF,NOFERR,GC3   ,SPARE1,SPARE2,SPARE3,SPARE4,
     +SPARE5,SPARE6,SPARE7,NNGSPM,NCONVG
      DIMENSION XK(     10),NX(   10000),IA(      38)
      EQUIVALENCE (K(1),XK(1)),(X(1),NX(1)),(A(1),IA(1))
      LOGICAL ASCI,FLUD,GNRL,CHAR
      RETURN
      END
      SUBROUTINE OUTCAL
      CHARACTER*6 H
      COMMON /TITLE/H(20)
      COMMON /TEMP/T(      9)
      COMMON /CAP/C(      6)
      COMMON /SOURCE/Q(      6)
      COMMON /COND/G(       9)
      COMMON /KONST/K(     10)
      COMMON /ARRAY/A(      38)
      COMMON /PC1/LSQ1(      84)
      COMMON /PC2/LSQ2(      15)
      COMMON /DIMENS/NND,NNC,NNT,NGL,NGT,NGE,NCC,NUC,NCT,NAT,LENA
     +,NSQ1,NSQ2,NPC,NPT,NSQ3,NVL,NPM,NTE,NSQ4,NCS,LCS
      COMMON /POINTN/LNODE,LCOND,LCONS,LARRY,IVB,LPRES,LTUBE,LCHAR
      COMMON /TAPE/NIN,NOUT,LDAT,LDIC,ASCI,FLUD,GNRL,CHAR
      COMMON /XSPACE/NDIM,NTH,X(   10000)
      COMMON /FIXCON/
     +TIMEN ,DTIMEU,TIMEND,CSGFAC,NLOOP ,DTMPCA,ITROUT,DTIMEH,
     +DAMPA ,DAMPD ,ATMPCA,BACKUP,TIMEO ,TIMEM ,DTMPCC,ATMPCC,
     +CSGMIN,OUTPUT,ARLXCA,LOOPCT,DTIMEL,DTIMEI,CSGMAX,CSGRAL,
     +CSGRCL,DRLXCA,DRLXCC,NLINE ,NPAGE ,ARLXCC,LSPCS ,ENGBAL,
     +BALENG,ATSLIM,NCSGMN,NDTMPC,NARLXC,NATMPC,ITEST ,JTEST ,
     +KTEST ,LTEST ,MTEST ,RTEST ,STEST ,TTEST ,UTEST ,VTEST ,
     +LAXFAC,SIGMA ,TMPZRO,NDRLXC,TDERV ,NTDERV,BENODE,EBNODE,
     +NODEEB,EXTLIM,NCOLUM,PRLXCA,PRLXCC,NEGSIV,GRVCON,PZERO ,
     +NCSGMX,NTEST ,ATEST ,BTEST ,CTEST ,DTEST ,ETEST ,FTEST ,
     +GTEST ,HTEST ,OTEST ,PTEST ,QTEST ,WTEST ,XTEST ,YTEST ,
     +ZTEST ,NTROSS,ISNUNC,NLINPP,LOTEMP,ERRMAX,ERRMIN,SENGIN,
     +DBLPRC,MPCNTL,IPCNT1,IPCNT2,ATSLM1,NLOOP1,JDIFQ ,KMAX  ,
     +FRACHG,EPS   ,PRSABS,PRSREL,FLOABS,FLOREL,FLOMAX,PRANGE,
     +ISOLVE,NPASS ,DEFLIM,ICHECK,GRAV  ,GC1   ,GC2   ,USRFLO,
     +PMPTOL,DEBUGF,NOFERR,GC3   ,SPARE1,SPARE2,SPARE3,SPARE4,
     +SPARE5,SPARE6,SPARE7,NNGSPM,NCONVG
      DIMENSION XK(     10),NX(   10000),IA(      38)
      EQUIVALENCE (K(1),XK(1)),(X(1),NX(1)),(A(1),IA(1))
      LOGICAL ASCI,FLUD,GNRL,CHAR
      CALL TPRINT                                                       
      CALL TPNTSN                                                       
      CALL TPNTST                                                       
      CALL QNPRNT                                                       
       XK(6)= G(7)* (T(2)- T(8)) - G(8)* (T(6)- T(2))                   
       XK(5)= XK(5)+ 1.0                                                
       if (XK(5).gt.2.0) then                                           
         write(8,991) T(6),XK(6)                                        
       endif                                                            
  991 format(1x,E14.7,1x,E14.7)                                                 
      RETURN
      END
      SUBROUTINE VARBLF
      RETURN
      END
