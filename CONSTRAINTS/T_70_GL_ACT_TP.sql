--------------------------------------------------------
--  Constraints for Table T_70_GL_ACT_TP
--------------------------------------------------------

  ALTER TABLE "T_70_GL_ACT_TP" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_ACT_TP" ADD CONSTRAINT "T_70_GL_ACT_TYPE_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
