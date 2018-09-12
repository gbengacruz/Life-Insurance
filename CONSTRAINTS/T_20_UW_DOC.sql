--------------------------------------------------------
--  Constraints for Table T_20_UW_DOC
--------------------------------------------------------

  ALTER TABLE "T_20_UW_DOC" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_DOC" ADD CONSTRAINT "T_20_UW_DOC_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
