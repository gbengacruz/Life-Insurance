--------------------------------------------------------
--  Constraints for Table T_20_PRD_INFO
--------------------------------------------------------

  ALTER TABLE "T_20_PRD_INFO" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_PRD_INFO" ADD CONSTRAINT "T_20_PRD_INFO_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
