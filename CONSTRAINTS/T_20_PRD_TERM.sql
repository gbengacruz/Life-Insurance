--------------------------------------------------------
--  Constraints for Table T_20_PRD_TERM
--------------------------------------------------------

  ALTER TABLE "T_20_PRD_TERM" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_PRD_TERM" ADD CONSTRAINT "T_20_PRD_TERM_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
  ALTER TABLE "T_20_PRD_TERM" MODIFY ("PRT_YN" NOT NULL ENABLE);
