--------------------------------------------------------
--  Constraints for Table T_99_SSU_AUD
--------------------------------------------------------

  ALTER TABLE "T_99_SSU_AUD" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_AUD" ADD CONSTRAINT "T_99_AUD_TRL_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
