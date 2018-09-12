--------------------------------------------------------
--  Constraints for Table T_20_UW_APR_STA
--------------------------------------------------------

  ALTER TABLE "T_20_UW_APR_STA" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_APR_STA" ADD CONSTRAINT "T_20_UW_APR_STA_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
