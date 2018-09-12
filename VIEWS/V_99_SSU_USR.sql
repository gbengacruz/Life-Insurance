--------------------------------------------------------
--  DDL for View V_99_SSU_USR
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_99_SSU_USR" ("R_K", "COMP_KEY", "USR_ID", "FST_NM", "LST_NM", "USR_EML", "USR_PHN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "LST_LOG", "IUS_YN", "TRN_APR", "TRN_EDT", "TRN_VEW", "USR_PWD", "COMP_SUB", "FLEX_01", "FLEX_02", "ROW_VSN", "LGN_CTN", "PWD_RST") AS 
  SELECT R_K, 
  COMP_KEY, 
  USR_ID, 
  FST_NM, 
  LST_NM, 
  USR_EML, 
  USR_PHN, 
  CRT_BY, 
  CRT_DT, 
  UPD_BY, 
  UPD_DT, 
  LST_LOG, 
  IUS_YN, 
  TRN_APR, 
  TRN_EDT, 
  TRN_VEW, 
  USR_PWD, 
  COMP_SUB, 
  FLEX_01, 
  FLEX_02, 
  ROW_VSN, 
  LGN_CTN ,
  PWD_RST
FROM T_99_SSU_USR
;
