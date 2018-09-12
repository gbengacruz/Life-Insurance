--------------------------------------------------------
--  DDL for View V_20_PYMT_FEQ
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PYMT_FEQ" ("R_K", "PRD_R_K", "PYMT_FEQ", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "PYMT_RT", "IUS_YN", "PYMT_ID", "SNGL_ID", "PRT_YN") AS 
  SELECT
    r_k,
    prd_r_k,
    pymt_feq,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    pymt_rt,
    ius_yn,
    pymt_id,
    sngl_id,
    prt_yn
FROM
    t_20_pymt_feq
;
