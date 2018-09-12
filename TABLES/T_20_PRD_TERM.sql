--------------------------------------------------------
--  DDL for Table T_20_PRD_TERM
--------------------------------------------------------

  CREATE TABLE "T_20_PRD_TERM" 
   (	"R_K" NUMBER, 
	"TERM_ID" NUMBER, 
	"TERM_DESC" VARCHAR2(128), 
	"PRD_R_K" NUMBER, 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"IUS_YN" NUMBER, 
	"PRT_YN" NUMBER DEFAULT 0
   ) ;
