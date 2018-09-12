--------------------------------------------------------
--  DDL for View V_20_PRD_TERM_LOV
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "V_20_PRD_TERM_LOV" ("R_K", "TERM_DESC", "PRD_DESC") AS 
  select 
       term.r_k ,term.term_desc, prd.PRD_DESC
  from v_20_prd_term term,   v_20_prd_info prd
  where term.prd_r_k = prd.r_k
;
