--------------------------------------------------------
--  DDL for View V_70_GL_JV
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_JV" ("R_K", "TRAN_DESC", "APR_STA", "BUS_DT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "APR_DT", "SYS_DTT", "APR_BY", "VCHR_TP") AS 
  SELECT
    r_k,
    tran_desc,
    apr_sta,
    bus_dt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    apr_dt,
    sys_dtt,
    apr_by,
    vchr_tp
FROM
    t_70_gl_jv
;
