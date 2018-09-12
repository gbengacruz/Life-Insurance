--------------------------------------------------------
--  Constraints for Table T_20_QUST_INFO
--------------------------------------------------------

  ALTER TABLE "T_20_QUST_INFO" MODIFY ("R_K" NOT NULL ENABLE);
  ALTER TABLE "T_20_QUST_INFO" ADD CONSTRAINT "T_20_QUST_INFO_PK" PRIMARY KEY ("R_K")
  USING INDEX  ENABLE;
