--------------------------------------------------------
--  Ref Constraints for Table JRXML_REPORT_IMAGES
--------------------------------------------------------

  ALTER TABLE "JRXML_REPORT_IMAGES" ADD CONSTRAINT "JRI_JRD_FK" FOREIGN KEY ("JRI_JRD_ID")
	  REFERENCES "JRXML_REPORT_DEFINITIONS" ("JRD_ID") ENABLE;
