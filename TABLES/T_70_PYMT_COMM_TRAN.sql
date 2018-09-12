--------------------------------------------------------
--  DDL for Table T_70_PYMT_COMM_TRAN
--------------------------------------------------------

  CREATE TABLE "T_70_PYMT_COMM_TRAN" 
   (	"R_K" NUMBER, 
	"CUS_ACC_R_K" NUMBER, 
	"CUS_R_K" NUMBER, 
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
	"SYS_DTT" VARCHAR2(20), 
	"APR_BY" VARCHAR2(52), 
	"PYMT_R_K" NUMBER
   ) ;
