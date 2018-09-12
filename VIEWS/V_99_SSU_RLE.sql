--------------------------------------------------------
--  DDL for View V_99_SSU_RLE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_99_SSU_RLE" ("R_K", "ROLE_CD", "ROLE_NM", "CRT_DT", "CRT_BY", "UPD_DT", "UPD_BY", "ACC_CD") AS 
  SELECT R_K, ROLE_CD, ROLE_NM,CRT_DT, CRT_BY, UPD_DT, UPD_BY, ACC_CD FROM T_99_SSU_RLE
;
