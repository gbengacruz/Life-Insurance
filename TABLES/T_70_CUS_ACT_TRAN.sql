--------------------------------------------------------
--  DDL for Table T_70_CUS_ACT_TRAN
--------------------------------------------------------

  CREATE TABLE "T_70_CUS_ACT_TRAN" 
   (	"R_K" NUMBER, 
	"CUS_R_K" NUMBER, 
	"ACT_R_K" NUMBER, 
	"BUS_DT" DATE, 
	"SYS_DTT" DATE, 
	"APR_STA" NUMBER, 
	"APR_BY" VARCHAR2(52), 
	"TRAN_DESC" VARCHAR2(250), 
	"TRAN_AMT" NUMBER, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"REF_NO" VARCHAR2(250), 
	"MODE_PYMT" NUMBER, 
	"APR_DT" TIMESTAMP (6), 
	"TRAN_SRCE" NUMBER, 
	"PRC_DT" DATE, 
	"DR_CR" VARCHAR2(20), 
	"TRAN_R_K" NUMBER
   ) ;
