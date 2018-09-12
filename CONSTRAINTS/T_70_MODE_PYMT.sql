--------------------------------------------------------
--  Constraints for Table T_70_MODE_PYMT
--------------------------------------------------------

  ALTER TABLE "T_70_MODE_PYMT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_MODE_PYMT" ADD CONSTRAINT "T_70_MODE_PYMT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
