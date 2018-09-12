--------------------------------------------------------
--  DDL for Package PK_20_UW_POL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_20_UW_POL" AS 


-- Author       : Gbenga Cruz 
-- Description  : Policy Management
-- Date         : January 18, 2017 
 
     --- Policy Creation
     PROCEDURE PC_20_UW_POL (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
      -- Policy Approval
     PROCEDURE PC_20_UW_POL_APR (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
      --- Beneficiary Creation
     PROCEDURE PC_20_CUS_BENF (p_cus_benf IN v_20_cus_benf%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Add Group Policy Member
     PROCEDURE PC_20_UW_POL_MEM (p_pol_mem IN v_20_uw_pol_mem%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
     --- Group Policy Creation
     PROCEDURE PC_20_UW_POL_GRP (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Cancel Policy Approval
     PROCEDURE PC_20_UW_POL_APR_CNL (p_uw_pol IN v_20_uw_pol%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);

     --- Validate Policy update
     FUNCTION FN_20_POL_EDT_VAL (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN BOOLEAN;
     
      --- Validate Policy type
     FUNCTION FN_20_POL_TP_VAL (p_uw_pol IN v_20_uw_pol%ROWTYPE) RETURN NUMBER;
     
     --- Beneficiary Validation
     PROCEDURE PC_20_CUS_BENF_VAL (p_cus_benf IN v_20_cus_benf%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_20_UW_POL;

/
