--------------------------------------------------------
--  DDL for Table T_99_SSU_USR
--------------------------------------------------------

  CREATE TABLE "T_99_SSU_USR" 
   (	"R_K" NUMBER(*,0), 
	"COMP_KEY" VARCHAR2(52), 
	"USR_ID" VARCHAR2(52), 
	"FST_NM" VARCHAR2(52), 
	"LST_NM" VARCHAR2(52), 
	"USR_EML" VARCHAR2(52), 
	"USR_PHN" VARCHAR2(52), 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"LST_LOG" TIMESTAMP (6), 
	"IUS_YN" NUMBER, 
	"TRN_APR" NUMBER, 
	"TRN_EDT" NUMBER, 
	"TRN_VEW" NUMBER, 
	"USR_PWD" VARCHAR2(2000), 
	"COMP_SUB" VARCHAR2(52), 
	"FLEX_01" VARCHAR2(52), 
	"FLEX_02" VARCHAR2(52), 
	"ROW_VSN" NUMBER, 
	"LGN_CTN" NUMBER, 
	"APR_STA" VARCHAR2(1), 
	"PWD_RST" NUMBER
   ) ;
