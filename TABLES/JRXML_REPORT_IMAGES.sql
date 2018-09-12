--------------------------------------------------------
--  DDL for Table JRXML_REPORT_IMAGES
--------------------------------------------------------

  CREATE TABLE "JRXML_REPORT_IMAGES" 
   (	"JRI_ID" NUMBER, 
	"JRI_JRD_ID" NUMBER, 
	"JRI_NAME" VARCHAR2(255), 
	"JRI_DESCRIPTION" VARCHAR2(4000), 
	"JRI_IMAGE" BLOB, 
	"JRI_ADLER32" VARCHAR2(30), 
	"JRI_ADLER32_VALID" VARCHAR2(1) DEFAULT 'N'
   ) ;
