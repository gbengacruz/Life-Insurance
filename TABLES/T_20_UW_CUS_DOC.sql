--------------------------------------------------------
--  DDL for Table T_20_UW_CUS_DOC
--------------------------------------------------------

  CREATE TABLE "T_20_UW_CUS_DOC" 
   (	"R_K" NUMBER, 
	"CUS_R_K" NUMBER, 
	"DOC_TP" NUMBER, 
	"DOC_BLOB" BLOB, 
	"DOC_MIMETYPE" VARCHAR2(512), 
	"DOC_CHARSET" VARCHAR2(512), 
	"CRT_BY" VARCHAR2(52), 
	"CRT_DT" TIMESTAMP (6), 
	"UPD_BY" VARCHAR2(52), 
	"UPD_DT" TIMESTAMP (6), 
	"DOC_NAME" VARCHAR2(512)
   ) ;
