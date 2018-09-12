--------------------------------------------------------
--  DDL for View V_20_UW_POL_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_UW_POL_DTL" ("R_K", "POL_NO", "PRD_R_K", "PRD_TERM", "SI_AMT", "MNS_PYMT", "INSR_R_K", "PYMT_R_K", "CUS_R_K", "PRM_AMT", "ST_DT", "EN_DT", "ANL_INC", "INC_PR", "ACTL_DBFT", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "APR_BY", "APR_DT", "BUS_DT", "POL_STA", "APR_STA", "SYS_DTT", "PRD_DESC", "TERM_ID", "TERM_DESC", "PRT_YN", "LST_NM", "FST_NM", "DOB", "CUS_NM", "PYMT_FEQ", "PYMT_ID", "CUS_DESC", "SNGL_ID", "PRM_PART", "PRM_WAH", "PRM_TAB", "LOC_R_K", "GRP_YN", "PRT_BY", "PRT_V", "PRT_RT", "END_CNT") AS 
  SELECT
    pol.r_k,
    pol.pol_no,
    pol.prd_r_k,
    pol.prd_term,
    pol.si_amt,
    pol.mns_pymt,
    pol.insr_r_k,
    pol.pymt_feq pymt_r_k,
    pol.cus_r_k,
    pol.prm_amt,
    pol.st_dt,
    pol.en_dt,
    pol.anl_inc,
    pol.inc_pr,
    pol.actl_dbft,
    pol.crt_by,
    pol.crt_dt,
    pol.upd_by,
    pol.upd_dt,
    pol.apr_by,
    pol.apr_dt,
    pol.bus_dt,
    pol.pol_sta,
    pol.apr_sta,
    pol.sys_dtt,
    prd.prd_desc,
    term.term_id,
    term.term_desc,
    term.PRT_YN,
    insr.lst_nm,
    insr.fst_nm,
    insr.dob,
    insr.cus_nm,
    pymt.pymt_feq,
    pymt.pymt_id,
    brk.cus_desc,
    pymt.sngl_id,
    pol.PRM_PART,
    pol.PRM_WAH,
    pol.PRM_TAB,
    POL.LOC_R_K,
    POL.GRP_YN,
    POL.PRT_BY,
    POL.PRT_V,
    POL.PRT_RT,
    POL.END_CNT
FROM
    v_20_uw_pol pol, v_20_prd_info prd, v_20_prd_term term, v_20_cus_info insr, v_20_pymt_feq pymt, v_20_cus_brk brk
    WHERE pol.prd_r_k = prd.r_k(+)
          AND pol.prd_term = term.r_k(+)
          AND pol.insr_r_k = insr.r_k(+)
          AND pol.pymt_feq = pymt.r_k(+)
          AND pol.cus_r_k = brk.r_k(+)
;
