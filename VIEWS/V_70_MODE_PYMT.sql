--------------------------------------------------------
--  DDL for View V_70_MODE_PYMT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_MODE_PYMT" ("R_K", "PYMT_TP", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    pymt_tp,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_mode_pymt
;
