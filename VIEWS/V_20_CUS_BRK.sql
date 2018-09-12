--------------------------------------------------------
--  DDL for View V_20_CUS_BRK
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_BRK" ("R_K", "CUS_DESC", "CUS_TP", "IUS_YN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "PHN_NO", "CUS_EML", "NAIC_ID", "APR_STA", "APR_BY", "APR_DT") AS 
  SELECT
    r_k,
    cus_desc,
    cus_tp,
    ius_yn,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    phn_no,
    cus_eml,
    naic_id,
    apr_sta,
    apr_by,
    apr_dt
FROM
    t_20_cus_brk
;
