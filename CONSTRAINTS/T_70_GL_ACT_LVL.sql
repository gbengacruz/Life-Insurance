--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_LVL
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_LVL" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_LVL" ADD CONSTRAINT "T_70_GL_ACT_LVL_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
