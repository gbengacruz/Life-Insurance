--------------------------------------------------------
--  Constraints for Table T_70_BRK_PYMT_TRAN
--------------------------------------------------------

  ALTER TABLE "T_70_BRK_PYMT_TRAN" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_BRK_PYMT_TRAN" ADD CONSTRAINT "T_70_BRK_PYMT_TRAN_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
