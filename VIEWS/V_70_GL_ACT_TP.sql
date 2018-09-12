--------------------------------------------------------
--  DDL for View V_70_GL_ACT_TP
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_TP" ("R_K", "ACT_TP", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "IUS_YN") AS 
  SELECT
    r_k,
    act_tp,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    ius_yn
FROM
    t_70_gl_act_tp
;
