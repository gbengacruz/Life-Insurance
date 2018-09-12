--------------------------------------------------------
--  DDL for View V_70_GL_LOC
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_70_GL_LOC" ("R_K", "LOC_NM", "COMM_R_K", "LOC_PHN", "LOC_EML", "LOC_CTY", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    loc_nm,
    comm_r_k,
    loc_phn,
    loc_eml,
    loc_cty,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_70_gl_loc
;
