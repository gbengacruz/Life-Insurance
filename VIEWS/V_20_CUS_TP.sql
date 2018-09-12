--------------------------------------------------------
--  DDL for View V_20_CUS_TP
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_TP" ("R_K", "CUS_TP", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "SHT_NM", "APR_STA", "IUS_YN") AS 
  SELECT
    r_k,
    cus_tp,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    sht_nm,
    apr_sta,
    ius_yn
FROM
    t_20_cus_tp
;
