--------------------------------------------------------
--  Constraints for Table T_70_GL_COMP
--------------------------------------------------------

  ALTER TABLE "T_70_GL_COMP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_COMP" ADD CONSTRAINT "T_70_GL_COMP_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
