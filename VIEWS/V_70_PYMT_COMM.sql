--------------------------------------------------------
--  DDL for View V_70_PYMT_COMM
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_PYMT_COMM" ("R_K", "PRD_R_K", "TERM_R_K", "PRM_YR", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "IUS_YN", "COMM_RT") AS 
  SELECT
    r_k,
    prd_r_k,
    term_r_k,
    prm_yr,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    ius_yn,
    comm_rt
FROM
    t_70_pymt_comm
;
