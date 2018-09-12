--------------------------------------------------------
--  DDL for View V_99_SSU_PWD_PRF
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_99_SSU_PWD_PRF" ("ROW_ID", "R_K", "PRF_CD", "PRF_KEY", "PRF_DSC", "ROW_VSN", "CRT_DT", "CRT_BY", "UPD_DT", "UPD_BY", "ACC_CD", "IUS_YN", "V_CD") AS 
  SELECT ROWID ROW_ID, R_K,
  PRF_CD,
  PRF_KEY,
  PRF_DSC,
  ROW_VSN,
  CRT_DT,
  CRT_BY,
  UPD_DT,
  UPD_BY,
  ACC_CD,
  IUS_YN,
  V_CD
FROM T_99_SSU_PWD_PRF
;
