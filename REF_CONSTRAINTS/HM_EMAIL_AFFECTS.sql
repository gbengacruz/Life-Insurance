--------------------------------------------------------
--  Ref Constraints for Table HM_EMAIL_AFFECTS
--------------------------------------------------------

  ALTER TABLE "HM_EMAIL_AFFECTS" ADD CONSTRAINT "HM_EMAIL_AFFECTS_FK1" FOREIGN KEY ("EMAIL_ID")
	  REFERENCES "HM_EMAILS" ("ID") ENABLE;
