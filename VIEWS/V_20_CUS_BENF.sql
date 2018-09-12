--------------------------------------------------------
--  DDL for View V_20_CUS_BENF
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_BENF" ("R_K", "BENF_NM", "BENF_PERC", "BENF_REL", "BENF_ADR", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "POL_R_K", "CUS_R_K") AS 
  SELECT
    r_k,
    benf_nm,
    benf_perc,
    benf_rel,
    benf_adr,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    pol_r_k,
    cus_r_k
FROM
    t_20_cus_benf
;
