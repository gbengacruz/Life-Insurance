--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_NTR
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_NTR" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_NTR" ADD CONSTRAINT "T_70_GL_ACT_NTR_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
