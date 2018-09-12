--------------------------------------------------------
--  Constraints for Table T_70_GL_JV_TRAN
--------------------------------------------------------

  ALTER TABLE "T_70_GL_JV_TRAN" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_JV_TRAN" ADD CONSTRAINT "T_70_GL_JV_TRAN_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
