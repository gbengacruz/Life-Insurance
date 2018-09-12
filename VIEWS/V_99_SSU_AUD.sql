--------------------------------------------------------
--  DDL for View V_99_SSU_AUD
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_99_SSU_AUD" ("R_K", "AUD_CODE", "AUD_DESC", "CRT_BY", "CRT_DT", "TRAN_R_K", "APP_MDL") AS 
  SELECT
    r_k,
    aud_code,
    aud_desc,
    crt_by,
    crt_dt,
    tran_r_k,
    app_mdl
FROM
    t_99_ssu_aud
;
