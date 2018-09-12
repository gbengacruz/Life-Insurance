--------------------------------------------------------
--  DDL for Table JRXML_FONTS
--------------------------------------------------------

  CREATE TABLE "JRXML_FONTS" 
   (	"JRF_ID" NUMBER, 
	"JRF_NAME" VARCHAR2(80), 
	"JRF_TYPE" VARCHAR2(3), 
	"JRF_COMPRESS" VARCHAR2(1) DEFAULT 'Y', 
	"JRF_ENCODING" VARCHAR2(30), 
	"JRF_FONT" BLOB
   ) ;
