--------------------------------------------------------
--  Constraints for Table T_99_SSU_USR_RLE
--------------------------------------------------------

  ALTER TABLE "T_99_SSU_USR_RLE" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_USR_RLE" MODIFY ("ROLE_CD" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_USR_RLE" MODIFY ("USR_CD" NOT NULL ENABLE);
  ALTER TABLE "T_99_SSU_USR_RLE" ADD CONSTRAINT "T_99_SSU_USR_RLE_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
