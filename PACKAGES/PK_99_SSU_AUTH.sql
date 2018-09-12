--------------------------------------------------------
--  DDL for Package PK_99_SSU_AUTH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_99_SSU_AUTH" AS  
 
  ---Cloud Admin and App User Authentication 
      
     FUNCTION FN_99_SSU_AUTH (p_username IN varchar2, p_password IN varchar2) RETURN BOOLEAN; 

  -- Cloud user Authorization for pages 

    FUNCTION FN_99_SSU_PRIV RETURN BOOLEAN; 
    --Menu
    FUNCTION FN_99_SSU_PRIV_MNU(P_APP_PAGE_ID IN VARCHAR2) RETURN BOOLEAN ;

END PK_99_SSU_AUTH;

/
