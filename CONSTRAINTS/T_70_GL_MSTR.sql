--------------------------------------------------------
--  Constraints for Table T_70_GL_MSTR
--------------------------------------------------------

  ALTER TABLE "T_70_GL_MSTR" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_MSTR" ADD CONSTRAINT "T_70_GL_MSTR_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
