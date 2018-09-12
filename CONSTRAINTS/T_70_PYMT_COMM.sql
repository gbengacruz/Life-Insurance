--------------------------------------------------------
--  Constraints for Table T_70_PYMT_COMM
--------------------------------------------------------

  ALTER TABLE "T_70_PYMT_COMM" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_PYMT_COMM" ADD CONSTRAINT "T_70_PYMT_COMM_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
