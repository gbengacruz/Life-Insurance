--------------------------------------------------------
--  Constraints for Table HM_USERS
--------------------------------------------------------

  ALTER TABLE "HM_USERS" MODIFY ("USERNAME" NOT NULL ENABLE);
  ALTER TABLE "HM_USERS" ADD CONSTRAINT "HM_USERS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
  ALTER TABLE "HM_USERS" ADD CONSTRAINT "HM_USERS_USERNAME_UK" UNIQUE ("USERNAME")
  USING INDEX  ENABLE;
