--------------------------------------------------------
--  Ref Constraints for Table JRXML_RESOURCE_ENTRIES
--------------------------------------------------------

  ALTER TABLE "JRXML_RESOURCE_ENTRIES" ADD CONSTRAINT "JRS_JRR_FK" FOREIGN KEY ("JRS_JRR_ID")
	  REFERENCES "JRXML_RESOURCE_FILES" ("JRR_ID") ENABLE;
