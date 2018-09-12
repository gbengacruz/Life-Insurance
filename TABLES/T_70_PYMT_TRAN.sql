--------------------------------------------------------
--  DDL for Table T_70_PYMT_TRAN
--------------------------------------------------------

  CREATE TABLE "T_70_PYMT_TRAN" 
   (	"R_K" NUMBER, 
	"CUS_ACC_R_K" NUMBER, 
	"CUS_R_K" NUMBER, 
	"DRCR" VARCHAR2(25), 
	"TRAN_TP" NUMBER, 
	"APR_STA" NUMBER, 
	"BUS_DT" DATE, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"DUE_DT" DATE, 
	"POL_R_K" NUMBER, 
	"PYMT_AMT" NUMBER, 
	"TRAN_DESC" VARCHAR2(512), 
	"APR_DT" TIMESTAMP (6), 
	"SYS_DTT" DATE, 
	"APR_BY" VARCHAR2(52)
   ) ;
