--------------------------------------------------------
--  Constraints for Table T_20_UW_POL
--------------------------------------------------------

  ALTER TABLE "T_20_UW_POL" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_UW_POL" ADD CONSTRAINT "T_20_UW_POL_PK_1" PRIMARY KEY ("R_K")
  USING INDEX (CREATE UNIQUE INDEX "T_20_UW_POL_PK_2" ON "T_20_UW_POL" ("R_K") 
  )  ENABLE;
