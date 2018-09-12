--------------------------------------------------------
--  Constraints for Table T_20_PRD_TERM_TP
--------------------------------------------------------

  ALTER TABLE "T_20_PRD_TERM_TP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_PRD_TERM_TP" ADD CONSTRAINT "T_20_PRD_TERM_TP_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
