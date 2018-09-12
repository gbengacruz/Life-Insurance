--------------------------------------------------------
--  DDL for Package PK_20_CUS_STP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_20_CUS_STP" AS 
-- Author       : Gbenga Cruz 
-- Description  : Customer Account Setup
-- Date         : January 18, 2017 

     --- Customer Type Creation AND Update
     PROCEDURE PC_20_CUS_TP (p_cus_tp IN v_20_cus_tp%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
       --- Validate customer type
     FUNCTION FN_20_CUS_TP (p_cus_tp IN v_20_cus_tp%ROWTYPE) RETURN BOOLEAN;
              			  
	 --- Customer Type deletion
     PROCEDURE PC_20_CUS_TP_DEL (p_cus_tp IN v_20_cus_tp%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
    
END PK_20_CUS_STP;

/
