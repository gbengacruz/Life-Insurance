--------------------------------------------------------
--  Constraints for Table HM_FEEDBACK
--------------------------------------------------------

  ALTER TABLE "HM_FEEDBACK" MODIFY ("APPLICATION_ID" NOT NULL ENABLE);
  ALTER TABLE "HM_FEEDBACK" ADD CONSTRAINT "HM_FEEDBACK_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
