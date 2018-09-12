--------------------------------------------------------
--  Constraints for Table T_20_UW_PYMT
--------------------------------------------------------

  ALTER TABLE "T_20_UW_PYMT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_PYMT" ADD CONSTRAINT "T_20_UW_PYMT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
