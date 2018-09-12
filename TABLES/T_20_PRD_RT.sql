--------------------------------------------------------
--  DDL for Table T_20_PRD_RT
--------------------------------------------------------

  CREATE TABLE "T_20_PRD_RT" 
   (	"R_K" NUMBER, 
	"PRD_R_K" NUMBER, 
	"CUS_AGE" NUMBER, 
	"PRD_RT" NUMBER, 
	"IUS_YN" NUMBER DEFAULT 1, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"PRD_TERM" NUMBER, 
	"PYMT_R_K" NUMBER
   ) ;
