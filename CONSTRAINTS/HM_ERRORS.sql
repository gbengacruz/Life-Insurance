--------------------------------------------------------
--  Constraints for Table HM_ERRORS
--------------------------------------------------------

  ALTER TABLE "HM_ERRORS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "HM_ERRORS" MODIFY ("ERR_TIME" NOT NULL ENABLE);
  ALTER TABLE "HM_ERRORS" ADD CONSTRAINT "HM_ERRORS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
