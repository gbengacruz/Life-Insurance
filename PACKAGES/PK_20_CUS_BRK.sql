--------------------------------------------------------
--  DDL for Package PK_20_CUS_BRK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_20_CUS_BRK" AS 

-- Author       : Gbenga Cruz 
-- Description  : Customer  Management
-- Date         : January 18, 2017

    --- Customer Creation
    PROCEDURE PC_20_CUS_BRK (p_cus_brk IN v_20_cus_brk%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
    
      --- Customer Approval
    PROCEDURE PC_20_CUS_BRK_APR (p_cus_brk IN v_20_cus_brk%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
    
END PK_20_CUS_BRK;

/
