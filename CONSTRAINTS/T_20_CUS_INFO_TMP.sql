--------------------------------------------------------
--  Constraints for Table T_20_CUS_INFO_TMP
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_INFO_TMP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_INFO_TMP" ADD CONSTRAINT "T_20_CUS_INFO_TMP_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
