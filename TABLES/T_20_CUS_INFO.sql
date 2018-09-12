--------------------------------------------------------
--  DDL for Table T_20_CUS_INFO
--------------------------------------------------------

  CREATE TABLE "T_20_CUS_INFO" 
   (	"R_K" NUMBER, 
	"LST_NM" VARCHAR2(128), 
	"FST_NM" VARCHAR2(128), 
	"MID_NM" VARCHAR2(128), 
	"DOB" DATE, 
	"BTH_PC" VARCHAR2(128), 
	"NXT_AGE" NUMBER, 
	"OCCP" VARCHAR2(128), 
	"EMAIL" VARCHAR2(52), 
	"PHONE" VARCHAR2(52), 
	"FAX" NUMBER, 
	"ADDR" VARCHAR2(512), 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"CUS_TLE" VARCHAR2(20), 
	"CUS_TP" NUMBER, 
	"ASR_TP" VARCHAR2(1), 
	"CUS_NM" VARCHAR2(250), 
	"BNK_NO" VARCHAR2(52), 
	"APR_BY" VARCHAR2(52), 
	"APR_DT" DATE, 
	"APR_STA" NUMBER, 
	"SEC" VARCHAR2(128)
   ) ;
