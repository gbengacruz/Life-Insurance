--------------------------------------------------------
--  DDL for View V_70_GL_VCHR
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_VCHR" ("R_K", "VCHR_TP", "VCHR_TLE", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "VCHR_NTR") AS 
  SELECT
    r_k,
    vchr_tp,
    vchr_tle,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    vchr_ntr
FROM
    t_70_gl_vchr
;
