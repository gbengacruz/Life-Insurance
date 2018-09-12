--------------------------------------------------------
--  DDL for View V_20_CUS_INFO
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_INFO" ("R_K", "LST_NM", "FST_NM", "MID_NM", "DOB", "BTH_PC", "NXT_AGE", "OCCP", "EMAIL", "PHONE", "FAX", "ADDR", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "CUS_TLE", "CUS_TP", "ASR_TP", "CUS_NM", "BNK_NO", "APR_BY", "APR_DT", "APR_STA", "SEC") AS 
  SELECT
    r_k,
    lst_nm,
    fst_nm,
    mid_nm,
    dob,
    bth_pc,
    nxt_age,
    occp,
    email,
    phone,
    fax,
    addr,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    cus_tle,
    cus_tp,
    asr_tp,
    cus_nm,
    BNK_NO,
    APR_BY,
    APR_DT,
    APR_STA,
    SEC
    
FROM
    t_20_cus_info
;
