--------------------------------------------------------
--  Constraints for Table T_70_GL_RCPT
--------------------------------------------------------

  ALTER TABLE "T_70_GL_RCPT" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_RCPT" MODIFY ("REF_NO" NOT NULL ENABLE);
  ALTER TABLE "T_70_GL_RCPT" ADD CONSTRAINT "T_70_CUS_RCPT_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
  ALTER TABLE "T_70_GL_RCPT" ADD CONSTRAINT "T_70_GL_RCPT_UK1" UNIQUE ("REF_NO")
  USING INDEX  ENABLE;
