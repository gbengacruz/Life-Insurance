--------------------------------------------------------
--  Constraints for Table T_20_UW_CUS_IMG
--------------------------------------------------------

  ALTER TABLE "T_20_UW_CUS_IMG" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_CUS_IMG" MODIFY ("IMG_CONT" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_CUS_IMG" ADD CONSTRAINT "T_20_UW_CUS_IMG_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
