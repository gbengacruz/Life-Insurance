--------------------------------------------------------
--  DDL for Package HM_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HM_FW" as
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for an application preference.
    -- If the preference is not set, p_preference_exists is set to FALSE.
    --
    function get_preference_value (
        p_preference_name in varchar2,
        p_preference_exists out boolean )
        return varchar2;
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for an application preference.
    --
    function get_preference_value (
        p_preference_name in varchar2 )
        return varchar2;
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for a user preference.
    -- If the preference is not set, p_preference_exists is set to FALSE.
    --
    function get_preference_value (
        p_preference_name   in varchar2,
        p_username          in varchar2,
        p_preference_exists out boolean )
        return varchar2;
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for a user preference.
    --
    function get_preference_value (
        p_preference_name   in varchar2,
        p_username          in varchar2 )
        return varchar2;
    --
    -- Procedure: set_preference_value
    -- Purpose: Sets an application preference.
    --
    procedure set_preference_value (
        p_preference_name  in varchar2,
        p_preference_value in varchar2 );
    --
    -- Procedure: set_preference_value
    -- Purpose: Sets a user preference.
    --
    procedure set_preference_value (
        p_preference_name  in varchar2,
        p_username         in varchar2,
        p_preference_value in varchar2 );
    --
    -- Function: preference_exists
    -- Purpose: Indicates whether or not a given preference exists.
    --
    function preference_exists (
        p_preference_name  in varchar2 ) return boolean;
    --
    -- Function: preference_exists
    -- Purpose: Indicates whether or not a given user preference exists.
    --
    function preference_exists (
        p_preference_name  in varchar2,
        p_username         in varchar2 ) return boolean;
    --
    -- Function: apex_error_handling
    -- Purpose: Try to elegantly handle errors that occur while using the application.
    --
    function apex_error_handling (
        p_error in apex_error.t_error )
        return apex_error.t_error_result;
    --
    -- Procedure: add_error_log
    -- Purpose: logs application errors
    --
    procedure add_error_log (
        p_error               in varchar2 default  null,
        p_procedure_name      in varchar2 default  null,
        p_page_item_name      in varchar2 default  null,
        p_region_id           in varchar2 default  null,
        p_column_alias        in varchar2 default  null,
        p_row_num             in varchar2 default  null,
        p_apex_error_code     in varchar2 default  null,
        p_ora_sqlcode         in varchar2 default  null,
        p_ora_sqlerrm         in varchar2 default  null,
        p_error_backtrace     in varchar2 default  null,
        p_arg1_name           in varchar2 default  null,
        p_arg1_val            in varchar2 default  null,
        p_arg2_name           in varchar2 default  null,
        p_arg2_val            in varchar2 default  null,
        p_arg3_name           in varchar2 default  null,
        p_arg3_val            in varchar2 default  null,
        p_arg4_name           in varchar2 default  null,
        p_arg4_val            in varchar2 default  null,
        p_arg5_name           in varchar2 default  null,
        p_arg5_val            in varchar2 default  null,
        p_arg6_name           in varchar2 default  null,
        p_arg6_val            in varchar2 default  null,
        p_arg7_name           in varchar2 default  null,
        p_arg7_val            in varchar2 default  null,
        p_arg8_name           in varchar2 default  null,
        p_arg8_val            in varchar2 default  null,
        p_arg9_name           in varchar2 default  null,
        p_arg9_val            in varchar2 default  null,
        p_arg10_name          in varchar2 default  null,
        p_arg10_val           in varchar2 default  null
        );
    --
    -- Function: get_name_from_email_address
    -- Purpose: Attempt to determine a user's name from their email address.
    -- If the email address exists in the users table, return that; otherwise,
    -- try to decipher it from their email address "name".
    --
    function get_name_from_email_address(
        p_email_address in varchar2
    ) return varchar2;
end HM_fw;

/
