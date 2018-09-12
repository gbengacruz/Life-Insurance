--------------------------------------------------------
--  Constraints for Table T_20_CUS_INFO
--------------------------------------------------------

  ALTER TABLE "T_20_CUS_INFO" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_CUS_INFO" ADD CONSTRAINT "T_20_UW_POL_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
