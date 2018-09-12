--------------------------------------------------------
--  Constraints for Table T_70_GL_JV
--------------------------------------------------------

  ALTER TABLE "T_70_GL_JV" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_JV" ADD CONSTRAINT "T_70_GL_JV_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
