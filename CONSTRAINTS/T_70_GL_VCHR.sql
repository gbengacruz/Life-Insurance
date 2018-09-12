--------------------------------------------------------
--  Constraints for Table T_70_GL_VCHR
--------------------------------------------------------

  ALTER TABLE "T_70_GL_VCHR" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_VCHR" MODIFY ("VCHR_TLE" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_VCHR" ADD CONSTRAINT "T_70_GL_VCHR_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
