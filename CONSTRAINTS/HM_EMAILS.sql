--------------------------------------------------------
--  Constraints for Table HM_EMAILS
--------------------------------------------------------

  ALTER TABLE "HM_EMAILS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "HM_EMAILS" MODIFY ("SUBJECT" NOT NULL ENABLE);
  ALTER TABLE "HM_EMAILS" MODIFY ("CAN_OPT_OUT_YN" NOT NULL ENABLE);
  ALTER TABLE "HM_EMAILS" ADD CONSTRAINT "HM_EMAILS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
  ALTER TABLE "HM_EMAILS" ADD CONSTRAINT "HM_EMAILS_CC2" CHECK ((action_label is not null and action_link is not null) or
             (action_label is null and action_link is null)) ENABLE;
  ALTER TABLE "HM_EMAILS" ADD CONSTRAINT "HM_EMAILS_CC1" CHECK (can_opt_out_yn in ('Y','N')) ENABLE;
