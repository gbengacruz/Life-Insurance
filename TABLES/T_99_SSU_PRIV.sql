--------------------------------------------------------
--  DDL for Table T_99_SSU_PRIV
--------------------------------------------------------

  CREATE TABLE "T_99_SSU_PRIV" 
   (	"R_K" NUMBER, 
	"PG_ID" VARCHAR2(52), 
	"BT_ID" VARCHAR2(20) DEFAULT NULL, 
	"PG_DSC" VARCHAR2(512), 
	"BT_DSC" VARCHAR2(512), 
	"USR_RLE" VARCHAR2(52), 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"ROW_VSN" NUMBER, 
	"ACC_CD" VARCHAR2(32), 
	"APP_ID" VARCHAR2(52), 
	"IUS_YN" VARCHAR2(1), 
	"APR_STA" VARCHAR2(1), 
	"APP_MDL" NUMBER
   ) ;
