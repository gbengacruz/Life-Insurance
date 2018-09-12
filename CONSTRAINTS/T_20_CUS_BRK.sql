--------------------------------------------------------
--  Constraints for Table T_20_CUS_BRK
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_BRK" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_BRK" ADD CONSTRAINT "T_20_CUS_BRK_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
