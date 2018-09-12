--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_CATG
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_CATG" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_CATG" ADD CONSTRAINT "T_70_GL_ACT_CATG_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
