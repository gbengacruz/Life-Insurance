--------------------------------------------------------
--  Constraints for Table T_20_CUS_BENF
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_BENF" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_BENF" ADD CONSTRAINT "TABLE1_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
