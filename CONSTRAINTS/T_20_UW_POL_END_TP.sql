--------------------------------------------------------
--  Constraints for Table T_20_UW_POL_END_TP
--------------------------------------------------------

  ALTER TABLE "T_20_UW_POL_END_TP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_POL_END_TP" ADD CONSTRAINT "T_20_UW_POL_END_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
