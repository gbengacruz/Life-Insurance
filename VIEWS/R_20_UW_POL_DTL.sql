--------------------------------------------------------
--  DDL for View R_20_UW_POL_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "R_20_UW_POL_DTL" ("R_K", "POL_NO", "SI_AMT", "INSR_R_K", "PRM_AMT", "ST_DT", "EN_DT", "APR_BY", "APR_DT", "POL_STA", "APR_STA", "PRD_DESC", "TERM_DESC", "DOB", "PYMT_FEQ", "T_PRM_AMT", "CUS_NM", "ADDR", "PHONE") AS 
  SELECT
     pol.r_k,
     pol.pol_no,
     pol.si_amt,
     pol.insr_r_k,
     pol.prm_amt,
    pol.st_dt,
     pol.en_dt,
     pol.apr_by,
     pol.apr_dt,
     pol.pol_sta,
     pol.apr_sta,
     pol.prd_desc,
    pol.term_desc,
     pol.dob,
     pol.pymt_feq,
     pol.term_id * pol.pymt_id * pol.prm_amt as t_prm_amt,
    cus.fst_nm||' '||cus.mid_nm||' '|| cus.lst_nm as cus_nm,
    cus.addr,
    cus.phone
FROM
    v_20_uw_pol_dtl pol, v_20_cus_info cus
    WHERE pol.insr_r_k = cus.r_k(+)
         -- AND pol.apr_sta = 1
;
