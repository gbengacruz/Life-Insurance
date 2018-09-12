--------------------------------------------------------
--  Constraints for Table T_70_GL_FSCL_YR
--------------------------------------------------------

  ALTER TABLE "T_70_GL_FSCL_YR" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_FSCL_YR" ADD CONSTRAINT "T_70_GL_FSCL_YR_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
