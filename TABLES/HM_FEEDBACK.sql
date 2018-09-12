--------------------------------------------------------
--  DDL for Table HM_FEEDBACK
--------------------------------------------------------

  CREATE TABLE "HM_FEEDBACK" 
   (	"ID" NUMBER, 
	"APPLICATION_ID" NUMBER, 
	"PAGE_ID" NUMBER, 
	"USER_AGENT" VARCHAR2(4000), 
	"FEEDBACK" VARCHAR2(4000), 
	"RESPONSE" VARCHAR2(4000), 
	"STATUS" VARCHAR2(30), 
	"CREATED" TIMESTAMP (6) WITH LOCAL TIME ZONE, 
	"CREATED_BY" VARCHAR2(255), 
	"UPDATED" TIMESTAMP (6) WITH LOCAL TIME ZONE, 
	"UPDATED_BY" VARCHAR2(255)
   ) ;
