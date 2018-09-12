--------------------------------------------------------
--  DDL for Package PK_99_SSU_PMV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_99_SSU_PMV" AS 

 -- Author       : Gbenga Cruz 
-- Description  : Parameter Setup
-- Date         : January 18, 2017 

    
      --- Get Money format 9,999.99
     FUNCTION FN_99_SS_PMV_CUR_CF   RETURN VARCHAR2;
     
     --- Get Money format 9999.99
     FUNCTION FN_99_SS_PMV_CUR_NF   RETURN NUMBER;
     
      --- Get Money decimal place 
     FUNCTION FN_99_SS_PMV_CUR_DP   RETURN NUMBER;
     
     --- Get Business date 
     FUNCTION FN_99_SS_PMV_BUS_DT  RETURN DATE ;
     
     --- Get Default Company
     FUNCTION FN_99_SS_PMV_COMP RETURN NUMBER;
     
     --- Get Default Currency
     FUNCTION FN_99_SS_PMV_CURR RETURN NUMBER;

     --- Audit Trail
     PROCEDURE PC_99_SSU_AUD (p_aud IN v_99_ssu_aud%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_99_SSU_PMV;

/
