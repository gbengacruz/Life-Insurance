--------------------------------------------------------
--  DDL for View V_20_PRD_TERM
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PRD_TERM" ("R_K", "TERM_ID", "TERM_DESC", "PRD_R_K", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "IUS_YN", "PRT_YN") AS 
  SELECT
    r_k,
    term_id,
    term_desc,
    prd_r_k,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    IUS_YN,
    PRT_YN
FROM
    t_20_prd_term
;
