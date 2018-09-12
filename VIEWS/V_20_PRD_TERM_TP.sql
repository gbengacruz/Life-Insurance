--------------------------------------------------------
--  DDL for View V_20_PRD_TERM_TP
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PRD_TERM_TP" ("R_K", "PRD_R_K", "TERM_TP", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "IUS_YN") AS 
  SELECT
    r_k,
    prd_r_k,
    term_tp,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    ius_yn
FROM
    t_20_prd_term_tp
;
