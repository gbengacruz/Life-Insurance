--------------------------------------------------------
--  Ref Constraints for Table HM_USER_PREFERENCES
--------------------------------------------------------

  ALTER TABLE "HM_USER_PREFERENCES" ADD CONSTRAINT "HM_USER_PREF_FK" FOREIGN KEY ("USER_ID")
	  REFERENCES "HM_USERS" ("ID") ON DELETE CASCADE ENABLE;
