--------------------------------------------------------
--  DDL for Type T_01_AM_USR_ROW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_01_AM_USR_ROW" AS OBJECT (Title  VARCHAR2(300),
                                   FirstName                  VARCHAR2(150)  ,
                                   LastName                   VARCHAR2(300)  ,
                                   Gender                     VARCHAR2(18)   , 
                                   Marital                    VARCHAR2(21)   , 
                                   Address1                   VARCHAR2(1503) ,
                                   Address2                   CHAR(3)        ,      
                                   City                       VARCHAR2(150)  , 
                                   State                      VARCHAR2(300)  , 
                                   MainPhone                  VARCHAR2(150)  , 
                                   AltPhone                   VARCHAR2(150)  , 
                                   Picture                    CHAR(7)        ,
                                   Email                      VARCHAR2(300)  ,
                                   Website                    CHAR(3)        ,
                                   Subsidiary                 CHAR(5)        ,
                                   AgeofRelat                 VARCHAR2(45)   ,
                                   RelaMgrAgent               CHAR(3)        ,
                                   PolicyAcctype              VARCHAR2(300)  ,
                                   PolicyAccstatus            CHAR(6)        ,
                                   PolicyAccBenef             VARCHAR2(750)  ,
                                   Provider                   CHAR(3)        ,
                                   ClaimsStatus              CHAR(3)         ,
                                   cus_id                    VARCHAR2(90)   );

/
