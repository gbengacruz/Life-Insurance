--------------------------------------------------------
--  DDL for View V_20_QUST_INFO
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_QUST_INFO" ("R_K", "QUST_DESC", "IUS_YN", "CRT_BY", "CRT_DT", "UPD_BY", "UPD_DT", "QUST_RESP") AS 
  SELECT
    r_k,
    qust_desc,
    ius_yn,
    crt_by,
    crt_dt,
    upd_by,
    upd_dt,
    QUST_RESP
FROM
    t_20_qust_info
;
