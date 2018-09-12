--------------------------------------------------------
--  DDL for View V_20_UW_POL_MEM
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_UW_POL_MEM" ("R_K", "BENF_NM", "SEX", "DOB", "SAL", "SI", "PRM", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "POL_R_K", "CUS_R_K") AS 
  SELECT
    r_k,
    benf_nm,
    sex,
    dob,
    sal,
    si,
    prm,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    pol_r_k,
    cus_r_k
FROM
    t_20_uw_pol_mem
;
