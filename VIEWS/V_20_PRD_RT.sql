--------------------------------------------------------
--  DDL for View V_20_PRD_RT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PRD_RT" ("R_K", "PRD_R_K", "CUS_AGE", "PRD_RT", "IUS_YN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "PRD_TERM", "PYMT_R_K") AS 
  SELECT
    r_k,
    prd_r_k,
    cus_age,
    prd_rt,
    ius_yn,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    prd_term,
    PYMT_R_K
FROM
    t_20_prd_rt
;
