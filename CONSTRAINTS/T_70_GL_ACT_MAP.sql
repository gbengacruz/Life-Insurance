--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_MAP
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_MAP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_MAP" ADD CONSTRAINT "T_70_GL_ACT_MAP_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
