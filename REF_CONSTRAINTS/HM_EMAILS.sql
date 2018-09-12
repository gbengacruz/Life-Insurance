--------------------------------------------------------
--  Ref Constraints for Table HM_EMAILS
--------------------------------------------------------

  ALTER TABLE "HM_EMAILS" ADD CONSTRAINT "HM_EMAILS_FK1" FOREIGN KEY ("TEMPLATE_ID")
	  REFERENCES "HM_EMAIL_TEMPLATES" ("ID") ON DELETE SET NULL ENABLE;
