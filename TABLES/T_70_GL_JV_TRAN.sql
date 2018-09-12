--------------------------------------------------------
--  DDL for Table T_70_GL_JV_TRAN
--------------------------------------------------------

  CREATE TABLE "T_70_GL_JV_TRAN" 
   (	"R_K" NUMBER, 
	"LDGR_KEY" NUMBER, 
	"TRAN_SRCE" NUMBER, 
	"APR_STA" NUMBER, 
	"BUS_DT" DATE, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"DUE_DT" DATE, 
	"POL_R_K" NUMBER, 
	"CLM_R_K" NUMBER, 
	"TRAN_AMT" NUMBER, 
	"TRAN_DESC" VARCHAR2(512), 
	"APR_DT" TIMESTAMP (6), 
	"SYS_DTT" DATE, 
	"APR_BY" VARCHAR2(52), 
	"TRAN_REF" VARCHAR2(128), 
	"MODE_PYMT" NUMBER, 
	"VCHR_TP" NUMBER, 
	"DR_CR" VARCHAR2(20), 
	"BATCH_NO" NUMBER
   ) ;
