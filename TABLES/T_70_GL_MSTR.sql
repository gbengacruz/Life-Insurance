--------------------------------------------------------
--  DDL for Table T_70_GL_MSTR
--------------------------------------------------------

  CREATE TABLE "T_70_GL_MSTR" 
   (	"R_K" NUMBER, 
	"BUS_DT" DATE, 
	"SYS_DTT" DATE, 
	"APR_STA" NUMBER, 
	"COMP_R_K" NUMBER, 
	"LOC_R_K" NUMBER, 
	"DEPT_R_K" NUMBER, 
	"COMP_YR" NUMBER, 
	"COMP_MON" NUMBER, 
	"TRAN_BTCH_NO" NUMBER(38,0), 
	"TRAN_NO" NUMBER(38,0), 
	"LDGR_KEY" NUMBER(38,0), 
	"CURR_R_K" NUMBER, 
	"TRAN_DESC" VARCHAR2(250), 
	"TRAN_SRCE" NUMBER, 
	"CLS_STA" NUMBER, 
	"TRAN_AMT" NUMBER, 
	"EXCH_RT" NUMBER, 
	"SYS_TRAN_YN" NUMBER, 
	"UPD_FLAG_YN" VARCHAR2(1), 
	"EFF_DT" DATE, 
	"PROC_DT" DATE, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"VCHR_TP" NUMBER, 
	"PRD_R_K" NUMBER, 
	"DR_CR" VARCHAR2(1)
   ) ;
