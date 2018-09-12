--------------------------------------------------------
--  DDL for Package PK_20_CUS_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_20_CUS_INFO" AS 
-- Author       : Gbenga Cruz 
-- Description  : Customer Management
-- Date         : January 18, 2017 
 
      --- Customer Management
     PROCEDURE PC_20_CUS_INFO (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;

     --- Customer Questions 
     PROCEDURE PC_20_CUS_QUST (p_cus_qust IN v_20_cus_qust%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
     --- Customer endorsement      
     PROCEDURE PC_20_CUS_INFO_EDT (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
      
     --- Customer document 
     PROCEDURE PC_20_UW_CUS_DOC (p_cus_doc IN v_20_uw_cus_doc%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
          
     --- Customer approval      
     PROCEDURE PC_20_CUS_INFO_APR (p_cus IN v_20_cus_info%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
    
     --- Delete Customer document 
     PROCEDURE PC_20_UW_CUS_DOC_DEL (p_cus_doc IN v_20_uw_cus_doc%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
END PK_20_CUS_INFO;

/
