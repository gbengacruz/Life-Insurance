--------------------------------------------------------
--  Constraints for Table T_99_SSU_PMV
--------------------------------------------------------

  ALTER TABLE "T_99_SSU_PMV" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_PMV" ADD CONSTRAINT "T_99_SSU_PMV_UK1" UNIQUE ("V_CD")
  USING INDEX  ENABLE;
  ALTER TABLE "T_99_SSU_PMV" ADD CONSTRAINT "T_99_SSU_PMV_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
