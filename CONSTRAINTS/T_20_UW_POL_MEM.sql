--------------------------------------------------------
--  Constraints for Table T_20_UW_POL_MEM
--------------------------------------------------------

  ALTER TABLE "T_20_UW_POL_MEM" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_POL_MEM" ADD CONSTRAINT "T_20_UW_POL_MEM_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
