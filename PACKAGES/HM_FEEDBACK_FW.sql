--------------------------------------------------------
--  DDL for Package HM_FEEDBACK_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HM_FEEDBACK_FW" is
    procedure send_feedback_email (
        p_app_id        in number,
        p_page_id       in number,
        p_submitter     in varchar2,
        p_feedback      in varchar2
    );
end HM_feedback_fw;

/
