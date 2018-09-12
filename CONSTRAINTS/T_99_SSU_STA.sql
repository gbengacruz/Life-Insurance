--------------------------------------------------------
--  Constraints for Table T_99_SSU_STA
--------------------------------------------------------

  ALTER TABLE "T_99_SSU_STA" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_STA" ADD CONSTRAINT "T_99_SSU_STA_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
