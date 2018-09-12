--------------------------------------------------------
--  Constraints for Table T_70_TRAN_SRCE
--------------------------------------------------------

  ALTER TABLE "T_70_TRAN_SRCE" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_TRAN_SRCE" ADD CONSTRAINT "T_70_TRAN_SRCE_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
