--------------------------------------------------------
--  Constraints for Table T_20_PYMT_FEQ
--------------------------------------------------------

  ALTER TABLE "T_20_PYMT_FEQ" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_PYMT_FEQ" MODIFY ("CRT_BY" NOT NULL ENABLE);
  ALTER TABLE "T_20_PYMT_FEQ" MODIFY ("PYMT_ID" NOT NULL ENABLE);
  ALTER TABLE "T_20_PYMT_FEQ" ADD CONSTRAINT "T_20_PYMT_FEQ_PK" PRIMARY KEY ("R_K", "PYMT_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "T_20_PYMT_FEQ" MODIFY ("PRT_YN" NOT NULL ENABLE);
