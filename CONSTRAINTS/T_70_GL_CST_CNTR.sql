--------------------------------------------------------
--  Constraints for Table T_70_GL_CST_CNTR
--------------------------------------------------------

  ALTER TABLE "T_70_GL_CST_CNTR" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_CST_CNTR" ADD CONSTRAINT "T_70_GL_CST_CNTR_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
