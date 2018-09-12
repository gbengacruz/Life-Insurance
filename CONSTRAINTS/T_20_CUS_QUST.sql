--------------------------------------------------------
--  Constraints for Table T_20_CUS_QUST
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_QUST" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_QUST" ADD CONSTRAINT "T_20_CUS_QUST_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
