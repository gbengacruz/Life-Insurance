--------------------------------------------------------
--  Constraints for Table JRXML_REPORT_DEFINITIONS
--------------------------------------------------------

  ALTER TABLE "JRXML_REPORT_DEFINITIONS" MODIFY ("JRD_ID" NOT NULL ENABLE);
  ALTER TABLE "JRXML_REPORT_DEFINITIONS" MODIFY ("JRD_NAME" NOT NULL ENABLE);
  ALTER TABLE "JRXML_REPORT_DEFINITIONS" ADD CONSTRAINT "JRD_PK" PRIMARY KEY ("JRD_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "JRXML_REPORT_DEFINITIONS" ADD CONSTRAINT "JRD_UK" UNIQUE ("JRD_NAME")
  USING INDEX  ENABLE;