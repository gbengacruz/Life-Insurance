--------------------------------------------------------
--  DDL for Package PK_20_PRM_CAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_20_PRM_CAL" AS 

-- Author       : Gbenga Cruz 
-- Description  : Premium Calculation
-- Date         : January 18, 2017 
    --Premium Calculation
    FUNCTION FN_20_PRM_CAL(p_prd_R_K NUMBER, p_si NUMBER,  p_pymnt_r_k NUMBER, p_prd_term NUMBER,p_cus_age NUMBER) RETURN NUMBER;
    --Premium Calculation for group life
    FUNCTION FN_20_PRM_CAL_GRP(p_prd_R_K NUMBER, p_si NUMBER,  p_pymnt_r_k NUMBER, p_prd_term NUMBER,p_cus_age NUMBER, p_term_tp NUMBER, p_prt_by NUMBER, p_prt_v NUMBER, p_prt_rt NUMBER) RETURN NUMBER;
    ---Age @ Next Birthady
    FUNCTION FN_20_CUS_AGE (p_cus IN v_20_cus_info%ROWTYPE) RETURN NUMBER ;
    --- Policy Enddate
    FUNCTION FN_20_POL_END_DT (p_term_r_k IN NUMBER, p_prd_r_k IN NUMBER,p_start_dt IN DATE) RETURN DATE;
    --- Validate sum insured
    FUNCTION FN_20_POL_SI (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN;
    --- Validate insured age
    FUNCTION FN_20_INS_AGE (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN;
    --- Product Type
    FUNCTION FN_20_PRD_TP (p_prd_r_k IN NUMBER) RETURN NUMBER;
    --- Policy Enddate for prorate premium
    FUNCTION FN_20_POL_END_DT_PRT (p_prt_by IN NUMBER,p_prt_v IN NUMBER, p_start_dt IN DATE) RETURN DATE ;
    
END PK_20_PRM_CAL;

/
