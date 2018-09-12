--------------------------------------------------------
--  DDL for View V_70_GL_COMP
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_COMP" ("R_K", "COMP_NM", "COMP_ADR", "COMP_PHN", "COMP_EML", "COMP_CTY", "COMP_CUR", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    comp_nm,
    comp_adr,
    comp_phn,
    comp_eml,
    comp_cty,
    comp_cur,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_gl_comp
;
