--------------------------------------------------------
--  Constraints for Table T_20_UW_POL_STA
--------------------------------------------------------

  ALTER TABLE "T_20_UW_POL_STA" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_POL_STA" ADD CONSTRAINT "T_20_UW_POL_STA_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
