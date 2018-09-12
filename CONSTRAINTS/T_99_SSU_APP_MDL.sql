--------------------------------------------------------
--  Constraints for Table T_99_SSU_APP_MDL
--------------------------------------------------------

  ALTER TABLE "T_99_SSU_APP_MDL" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_APP_MDL" ADD CONSTRAINT "T_99_APP_MDL_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
