--------------------------------------------------------
--  Constraints for Table T_70_PYMT_COMM_TRAN
--------------------------------------------------------

  ALTER TABLE "T_70_PYMT_COMM_TRAN" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_PYMT_COMM_TRAN" ADD CONSTRAINT "T_70_PYMT_COMM_TRAN_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
