--------------------------------------------------------
--  DDL for Package PK_70_CUS_ACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_70_CUS_ACT" AS 

-- Author       : Gbenga Cruz 
-- Description  : Customer Account Management
-- Date         : January 18, 2017 
 
    --- GET Customer Numner      
     FUNCTION FN_70_CUS_ACT_GET (p_cus IN NUMBER) RETURN NUMBER ;
     
     --- GET Customer Name
    FUNCTION FN_70_CUS_ACT_NM_GET (p_cus IN NUMBER) RETURN VARCHAR2 ;
    
     --- Customer Account Creation
     PROCEDURE PC_70_CUS_ACT (p_cus_act IN v_70_cus_act%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Approve Customer Account Creation
     PROCEDURE PC_70_CUS_ACT_APR (p_cus_act IN v_70_cus_act%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Customer Account Deposit
     PROCEDURE PC_70_CUS_ACT_TRAN (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Customer Deposit deletion
     PROCEDURE PC_70_CUS_ACT_TRAN_DEL (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Customer Deposit Update
     PROCEDURE PC_70_CUS_ACT_TRAN_UPD (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Customer Deposit Approval
     PROCEDURE PC_70_CUS_ACT_TRAN_APR (p_act_tran IN v_70_cus_act_tran%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_70_CUS_ACT;

/
