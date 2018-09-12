--------------------------------------------------------
--  DDL for View V_20_CUS_QUST
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_CUS_QUST" ("R_K", "CUS_R_K", "QUST_R_K", "QUST_RESP", "RESP_DESC", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT") AS 
  SELECT
    r_k,
    cus_r_k,
    qust_r_k,
    qust_resp,
    resp_desc,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt
FROM
    t_20_cus_qust
;
