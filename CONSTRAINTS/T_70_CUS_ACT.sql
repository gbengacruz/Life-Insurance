--------------------------------------------------------
--  Constraints for Table T_70_CUS_ACT
--------------------------------------------------------

  ALTER TABLE "T_70_CUS_ACT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_CUS_ACT" MODIFY ("TRAN_BAL" NOT NULL ENABLE);
  ALTER TABLE "T_70_CUS_ACT" ADD CONSTRAINT "T_70_CUS_ACT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
  ALTER TABLE "T_70_CUS_ACT" ADD CONSTRAINT "T_70_CUS_ACT_UK1" UNIQUE ("CUS_R_K")
  USING INDEX  ENABLE;
