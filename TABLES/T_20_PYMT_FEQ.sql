--------------------------------------------------------
--  DDL for Table T_20_PYMT_FEQ
--------------------------------------------------------

  CREATE TABLE "T_20_PYMT_FEQ" 
   (	"R_K" NUMBER, 
	"PRD_R_K" NUMBER, 
	"PYMT_FEQ" VARCHAR2(128), 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"PYMT_RT" NUMBER DEFAULT 1, 
	"IUS_YN" NUMBER, 
	"PYMT_ID" NUMBER DEFAULT 0, 
	"SNGL_ID" NUMBER DEFAULT 0, 
	"PRT_YN" NUMBER DEFAULT 0
   ) ;
