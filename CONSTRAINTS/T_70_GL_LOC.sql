--------------------------------------------------------
--  Constraints for Table T_70_GL_LOC
--------------------------------------------------------

  ALTER TABLE "T_70_GL_LOC" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_LOC" ADD CONSTRAINT "T_70_GL_LOC_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
