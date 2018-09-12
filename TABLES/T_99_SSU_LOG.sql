--------------------------------------------------------
--  DDL for Table T_99_SSU_LOG
--------------------------------------------------------

  CREATE TABLE "T_99_SSU_LOG" 
   (	"R_K" NUMBER, 
	"R_T" TIMESTAMP (6), 
	"APP_ID" VARCHAR2(250), 
	"PAGE_ID" VARCHAR2(250), 
	"SCH_NM" VARCHAR2(250), 
	"ERR_CD" VARCHAR2(250), 
	"ERR_MSG" VARCHAR2(4000), 
	"USR_ID" VARCHAR2(250), 
	"PRC_NM" VARCHAR2(250), 
	"ERR_STK" CLOB
   ) ;
