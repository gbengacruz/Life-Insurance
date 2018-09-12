--------------------------------------------------------
--  Constraints for Table T_20_PRD_RT
--------------------------------------------------------

  ALTER TABLE "T_20_PRD_RT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_PRD_RT" ADD CONSTRAINT "T_20_PRD_RT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
