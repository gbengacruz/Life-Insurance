--------------------------------------------------------
--  DDL for View V_70_GL_DEPT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_DEPT" ("R_K", "DEPT_NM", "COMM_R_K", "LOC_R_K", "DEPT_PHN", "DEPT_EML", "DEPT_CTY", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    dept_nm,
    comm_r_k,
    loc_r_k,
    dept_phn,
    dept_eml,
    dept_cty,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_gl_dept
;
