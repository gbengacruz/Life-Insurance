--------------------------------------------------------
--  DDL for View V_20_PRD_INFO
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PRD_INFO" ("R_K", "PRD_CODE", "PRD_DESC", "MIN_SI", "MAX_SI", "PRD_RT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "IUS_YN", "MIN_AGE", "MAX_AGE", "PRM_PYMT", "MED_EXM", "FEE_AMT", "SI_DIV", "PRD_FML", "PRM_FML", "PRD_TP", "PRM_WAH", "PRM_TAB", "MIN_PRM", "MAX_PRM", "DTH_BNF", "PRM_PART", "GRP_YN", "MIN_RT", "MAX_RT") AS 
  SELECT
    r_k,
    prd_code,
    prd_desc,
    min_si,
    max_si,
    prd_rt,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    ius_yn,
    min_age,
    max_age,
    prm_pymt,
    med_exm,
    fee_amt,
    si_div,
    prd_fml,
    prm_fml,
    prd_tp,
    prm_wah,
    prm_tab,
    min_prm,
    max_prm,
    dth_bnf,
    prm_part,
    grp_yn,
    min_rt,
    max_rt
FROM
    t_20_prd_info
;
