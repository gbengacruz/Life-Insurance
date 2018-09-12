--------------------------------------------------------
--  DDL for View R_70_GL_RCPT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "R_70_GL_RCPT" ("R_K", "CUS_R_K", "BUS_DT", "APR_BY", "APR_STA", "TRAN_DESC", "TRAN_AMT", "REF_NO", "APR_DT", "CUS_NM", "PYMT_TP") AS 
  SELECT
    r_k,
    cus_r_k,
    bus_dt,
    apr_by,
    apr_sta,
    tran_desc,
    tran_amt,
    ref_no,
    apr_dt,
    case when act_tp = 1 then act_desc when act_tp = 2 then cus_nm end cus_nm,
    pymt_tp
FROM
    v_70_gl_rcpt_dtl where apr_sta = 1
;
