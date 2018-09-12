--------------------------------------------------------
--  DDL for View V_99_SSU_LOG
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_99_SSU_LOG" ("ROW_ID", "R_K", "R_T", "APP_ID", "PAGE_ID", "SCH_NM", "ERR_CD", "ERR_MSG", "USR_ID", "PRC_NM", "ERR_STK") AS 
  SELECT ROWID ROW_ID,"R_K","R_T","APP_ID","PAGE_ID","SCH_NM","ERR_CD","ERR_MSG","USR_ID","PRC_NM","ERR_STK" FROM T_99_SSU_LOG
;
