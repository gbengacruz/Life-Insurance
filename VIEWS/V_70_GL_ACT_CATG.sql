--------------------------------------------------------
--  DDL for View V_70_GL_ACT_CATG
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_CATG" ("R_K", "ACT_CATG", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    act_catg,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_gl_act_catg
;
