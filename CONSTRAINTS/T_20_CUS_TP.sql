--------------------------------------------------------
--  Constraints for Table T_20_CUS_TP
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_TP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_TP" ADD CONSTRAINT "T_20_CUS_TP_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
