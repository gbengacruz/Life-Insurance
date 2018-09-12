--------------------------------------------------------
--  Constraints for Table T_70_GL_DEPT
--------------------------------------------------------

  ALTER TABLE "T_70_GL_DEPT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_DEPT" ADD CONSTRAINT "T_70_GL_DEPT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
