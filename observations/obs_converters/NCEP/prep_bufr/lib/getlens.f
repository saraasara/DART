	SUBROUTINE GETLENS(MBAY,LL,LEN0,LEN1,LEN2,LEN3,LEN4,LEN5)

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    GETLENS
C   PRGMMR: ATOR             ORG: NP12       DATE: 2005-11-29
C
C ABSTRACT: THIS SUBROUTINE UNPACKS AND RETURNS ALL OF THE INDIVIDUAL
C   SECTION LENGTHS OF THE BUFR MESSAGE STORED IN ARRAY MBAY, UP TO A
C   SPECIFIED POINT.  IT WILL WORK ON ANY MESSAGE ENCODED USING BUFR
C   EDITION 2, 3 OR 4.  THE START OF THE BUFR MESSAGE (I.E. THE STRING
C   "BUFR") MUST BE ALIGNED ON THE FIRST FOUR BYTES OF MBAY.
C
C PROGRAM HISTORY LOG:
C 2005-11-29  J. ATOR    -- ORIGINAL AUTHOR
C DART $Id$
C
C USAGE:    CALL GETLENS (MBAY, LL, LEN0, LEN1, LEN2, LEN3, LEN4, LEN5)
C   INPUT ARGUMENT LIST:
C     MBAY     - INTEGER: *-WORD PACKED BINARY ARRAY CONTAINING
C                BUFR MESSAGE
C     LL       - INTEGER: NUMBER OF LAST SECTION FOR WHICH THE LENGTH
C                IS TO BE UNPACKED.  IN OTHER WORDS, SETTING LL = N
C                MEANS TO UNPACK THE LENGTHS OF SECTIONS 0 THROUGH N
C                (I.E. LEN0, LEN1,...,LEN(N)).  ANY SECTION LENGTHS
C                THAT ARE NOT UNPACKED ARE RETURNED WITH A DEFAULT
C                VALUE OF -1.
C
C   OUTPUT ARGUMENT LIST:
C     LEN0     - LENGTH OF SECTION 0 (= -1 IF NOT UNPACKED)
C     LEN1     - LENGTH OF SECTION 1 (= -1 IF NOT UNPACKED)
C     LEN2     - LENGTH OF SECTION 2 (= -1 IF NOT UNPACKED)
C     LEN3     - LENGTH OF SECTION 3 (= -1 IF NOT UNPACKED)
C     LEN4     - LENGTH OF SECTION 4 (= -1 IF NOT UNPACKED)
C     LEN5     - LENGTH OF SECTION 5 (= -1 IF NOT UNPACKED)
C
C REMARKS:
C    THIS ROUTINE CALLS:        IUPB     IUPBS01
C    THIS ROUTINE IS CALLED BY: CKTABA   CNVED4   DUMPBF   MESGBC
C                               MSGWRT   RDBFDX   UPDS3    WRITLC
C                               Normally not called by application
C                               programs but it could be.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

	DIMENSION   MBAY(*)

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

	LEN0 = -1
	LEN1 = -1
	LEN2 = -1
	LEN3 = -1
	LEN4 = -1
	LEN5 = -1

	IF(LL.LT.0) RETURN
	LEN0 = IUPBS01(MBAY,'LEN0') 

	IF(LL.LT.1) RETURN
	LEN1 = IUPBS01(MBAY,'LEN1') 

	IF(LL.LT.2) RETURN
	IAD2 = LEN0 + LEN1
	LEN2 = IUPB(MBAY,IAD2+1,24) * IUPBS01(MBAY,'ISC2')

	IF(LL.LT.3) RETURN
	IAD3 = IAD2 + LEN2
	LEN3 = IUPB(MBAY,IAD3+1,24)

	IF(LL.LT.4) RETURN
	IAD4 = IAD3 + LEN3
	LEN4 = IUPB(MBAY,IAD4+1,24)

	IF(LL.LT.5) RETURN
	LEN5 = 4

	RETURN
	END