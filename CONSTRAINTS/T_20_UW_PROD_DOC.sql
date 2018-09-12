--------------------------------------------------------
--  Constraints for Table T_20_UW_PROD_DOC
--------------------------------------------------------

  ALTER TABLE "T_20_UW_PROD_DOC" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_PROD_DOC" ADD CONSTRAINT "T_20_UW_PROD_DOC_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
