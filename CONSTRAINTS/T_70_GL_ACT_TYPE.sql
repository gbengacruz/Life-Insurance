--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_TYPE
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_TYPE" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_TYPE" ADD CONSTRAINT "T_70_GL_ACT_TYPE2_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
