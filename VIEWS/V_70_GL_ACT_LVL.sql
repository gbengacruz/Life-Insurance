--------------------------------------------------------
--  DDL for View V_70_GL_ACT_LVL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_ACT_LVL" ("R_K", "LVL_DESC", "IUS_YN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    lvl_desc,
    ius_yn,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_gl_act_lvl
;
