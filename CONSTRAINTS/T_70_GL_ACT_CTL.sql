--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_CTL
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_CTL" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_CTL" ADD CONSTRAINT "T_70_GL_ACT_CTL_UK1" UNIQUE ("ACT_NO")
  USING INDEX  ENABLE;
  ALTER TABLE "T_70_GL_ACT_CTL" ADD CONSTRAINT "T_70_GL_ACT_CTL_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
