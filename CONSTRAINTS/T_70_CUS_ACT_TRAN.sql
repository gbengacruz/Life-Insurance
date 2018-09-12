--------------------------------------------------------
--  Constraints for Table T_70_CUS_ACT_TRAN
--------------------------------------------------------

  ALTER TABLE "T_70_CUS_ACT_TRAN" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_CUS_ACT_TRAN" MODIFY ("REF_NO" NOT NULL ENABLE);
  ALTER TABLE "T_70_CUS_ACT_TRAN" ADD CONSTRAINT "T_70_CUS_ACT_TRAN_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
