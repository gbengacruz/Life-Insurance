--------------------------------------------------------
--  DDL for Table JRXML_APEX2JRXML_TEMPLATES
--------------------------------------------------------

  CREATE TABLE "JRXML_APEX2JRXML_TEMPLATES" 
   (	"JAT_ID" NUMBER, 
	"JAT_NAME" VARCHAR2(255), 
	"JAT_TYPE" VARCHAR2(2) DEFAULT 'RE', 
	"JAT_TEMPLATE_START" CLOB, 
	"JAT_TEMPLATE_END" CLOB, 
	"JAT_HEIGHT_OFFSET" NUMBER, 
	"JAT_CONTENT_WIDTH" NUMBER, 
	"JAT_STANDARD" VARCHAR2(1) DEFAULT 'N'
   ) ;
