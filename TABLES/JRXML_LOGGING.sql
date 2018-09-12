--------------------------------------------------------
--  DDL for Table JRXML_LOGGING
--------------------------------------------------------

  CREATE TABLE "JRXML_LOGGING" 
   (	"JRL_ID" NUMBER, 
	"JRL_RUN_ID" NUMBER, 
	"JRL_TIME" TIMESTAMP (6), 
	"JRL_TIME_SINCE_LAST_LOG" NUMBER, 
	"JRL_TEXT" VARCHAR2(4000)
   ) ;
