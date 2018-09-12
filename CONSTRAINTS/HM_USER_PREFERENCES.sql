--------------------------------------------------------
--  Constraints for Table HM_USER_PREFERENCES
--------------------------------------------------------

  ALTER TABLE "HM_USER_PREFERENCES" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "HM_USER_PREFERENCES" ADD CONSTRAINT "HM_USER_PREFERENCES_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
