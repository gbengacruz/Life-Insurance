--------------------------------------------------------
--  DDL for Package HM_SEARCH_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HM_SEARCH_FW" as
    procedure build_search_collection(  p_search_term in varchar2,
                                        p_tables in varchar2 default null );
end HM_search_fw;

/
