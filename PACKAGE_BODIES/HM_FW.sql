--------------------------------------------------------
--  DDL for Package Body HM_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HM_FW" as
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for an application preference.
    -- If the preference is not set, p_preference_exists is set to FALSE.
    --
    function get_preference_value (
        p_preference_name   in  varchar2,
        p_preference_exists out boolean )
        return varchar2
    is
    begin
        for c1 in ( select preference_value
                    from HM_preferences
                    where preference_name = p_preference_name ) loop
            p_preference_exists := true;
            return c1.preference_value;
        end loop;
        p_preference_exists := false;
        return null;
    end get_preference_value;
    --
    -- Function: get_preference_value
    -- Purpose: Returns the current value for an application preference.
    --
    function get_preference_value ( p_preference_name in varchar2 ) return varchar2 is
        l_dummy boolean;
    begin
        return get_preference_value( p_preference_name, l_dummy );
    end get_preference_value;
   --
   -- Function: get_preference_value
   -- Purpose: Returns the current value for a user preference.
   -- If the preference is not set, p_preference_exists is set to FALSE.
   --
   function get_preference_value (
       p_preference_name   in  varchar2,
       p_username          in  varchar2,
       p_preference_exists out boolean )
   return varchar2
   is
   begin
       for c1 in ( select p.preference_value
                   from HM_user_preferences p,
                       HM_users u
                   where p.preference_name = p_preference_name
                       and p.user_id = u.id
                       and upper(u.username) = upper(p_username) ) loop
           p_preference_exists := true;
           return c1.preference_value;
       end loop;
       p_preference_exists := false;
       return null;
   end get_preference_value;
   --
   -- Function: get_preference_value
   -- Purpose: Returns the current value for a user preference.
   --
   function get_preference_value (
       p_preference_name   in varchar2,
       p_username          in varchar2 )
   return varchar2
   is
       l_dummy boolean;
   begin
       return get_preference_value( p_preference_name, p_username, l_dummy );
   end get_preference_value;
    --
    -- Procedure: set_preference_value
    -- Purpose: Sets an application preference.
    --
    procedure set_preference_value (
        p_preference_name  in varchar2,
        p_preference_value in varchar2 ) is
    begin
        merge into HM_preferences dest
        using ( select upper(p_preference_name) preference_name,
                    p_preference_value preference_value
                from dual ) src
        on ( upper(dest.preference_name) = src.preference_name )
        when matched then
            update set dest.preference_value = src.preference_value
        when not matched then
            insert (dest.preference_name, dest.preference_value)
            values (src.preference_name, src.preference_value);
    end set_preference_value;
    --
    -- Procedure: set_preference_value
    -- Purpose: Sets a user preference.
    --
    procedure set_preference_value (
        p_preference_name  in varchar2,
        p_username         in varchar2,
        p_preference_value in varchar2 ) is
    begin
        merge into HM_user_preferences dest
        using ( select upper(p_preference_name) preference_name,
                    p_preference_value preference_value,
                    u.id user_id
                from HM_users u
                where upper(u.username) = upper(p_username) ) src
        on ( upper(dest.preference_name) = src.preference_name
            and dest.user_id = src.user_id )
        when matched then
            update set dest.preference_value = src.preference_value
        when not matched then
            insert (dest.preference_name, dest.user_id, dest.preference_value)
            values (src.preference_name, src.user_id, src.preference_value);
    end set_preference_value;
    --
    -- Function: preference_exists
    -- Purpose: Indicates whether or not a given preference exists.
    --
    function preference_exists (
        p_preference_name  in varchar2 ) return boolean is
    begin
        for c1 in ( select null
                    from HM_preferences
                    where preference_name = p_preference_name ) loop
            return true;
        end loop;
        return false;
    end preference_exists;
    --
    -- Function: preference_exists
    -- Purpose: Indicates whether or not a given preference exists.
    --
    function preference_exists (
        p_preference_name  in varchar2,
        p_username         in varchar2 ) return boolean is
    begin
        for c1 in ( select null
                    from HM_user_preferences p,
                        HM_users u
                    where p.preference_name = p_preference_name
                        and p.user_id = u.id
                        and upper(u.username) = upper(p_username) ) loop
            return true;
        end loop;
        return false;
    end preference_exists;
    --
    -- Function: apex_error_handling
    -- Purpose: Try to elegantly handle errors that occur while using the application.
    --
    function apex_error_handling ( p_error in apex_error.t_error )
            return apex_error.t_error_result is
        l_result          apex_error.t_error_result;
        l_constraint_name varchar2(255);
        procedure add_error_log ( p_error in apex_error.t_error ) is
            pragma autonomous_transaction;
        begin
            -- Remove old errors
            delete from HM_errors where err_time <= localtimestamp - 21;
            -- Log the error.
            insert into HM_errors (
                app_id,
                app_page_id,
                app_user,
                user_agent,
                ip_address,
                ip_address2,
                message,
                page_item_name,
                region_id,
                column_alias,
                row_num,
                apex_error_code,
                ora_sqlcode,
                ora_sqlerrm,
                error_backtrace )
            select v('APP_ID'),
                v('APP_PAGE_ID'),
                v('APP_USER'),
                owa_util.get_cgi_env('HTTP_USER_AGENT'),
                owa_util.get_cgi_env('REMOTE_ADDR'),
                sys_context('USERENV', 'IP_ADDRESS'),
                substr(p_error.message,0,4000),
                p_error.page_item_name,
                p_error.region_id,
                p_error.column_alias,
                p_error.row_num,
                p_error.apex_error_code,
                p_error.ora_sqlcode,
                substr(p_error.ora_sqlerrm,0,4000),
                substr(p_error.error_backtrace,0,4000)
            from dual;
            commit;
        end add_error_log;
    begin
        l_result := apex_error.init_error_result (
                        p_error => p_error );
        -- If it is an internal error raised by APEX, like an invalid statement or
        -- code which can not be executed, the error text might contain security sensitive
        -- information. To avoid this security problem we can rewrite the error to
        -- a generic error message and log the original error message for further
        -- investigation by the help desk.
        if p_error.is_internal_error then
            -- mask all errors that are not common runtime errors (Access Denied
            -- errors raised by application / page authorization and all errors
            -- regarding session and session state)
            if not p_error.is_common_runtime_error then
                add_error_log( p_error );
                -- Change the message to the generic error message which doesn't expose
                -- any sensitive information.
                l_result.message         := 'An unexpected internal application error has occurred.';
                l_result.additional_info := null;
            end if;
        else
            -- Always show the error as inline error
            -- Note: If you have created manual tabular forms (using the package
            --       apex_item/htmldb_item in the SQL statement) you should still
            --       use "On error page" on that pages to avoid loosing entered data
            l_result.display_location := case
                                           when l_result.display_location = apex_error.c_on_error_page then apex_error.c_inline_in_notification
                                           else l_result.display_location
                                         end;
            -- If it's a constraint violation like
            --
            --   -) ORA-00001: unique constraint violated
            --   -) ORA-02091: transaction rolled back (-> can hide a deferred constraint)
            --   -) ORA-02290: check constraint violated
            --   -) ORA-02291: integrity constraint violated - parent key not found
            --   -) ORA-02292: integrity constraint violated - child record found
            --
            -- we try to get a friendly error message from our constraint lookup configuration.
            -- If we don't find the constraint in our lookup table we fallback to
            -- the original ORA error message.
            if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then
                l_constraint_name := apex_error.extract_constraint_name (
                                         p_error => p_error );
                begin
                    select message
                      into l_result.message
                      from HM_error_lookup
                     where constraint_name = l_constraint_name;
                exception when no_data_found then null; -- not every constraint has to be in our lookup table
                end;
            end if;
            -- If an ORA error has been raised, for example a raise_application_error(-20xxx, '...')
            -- in a table trigger or in a PL/SQL package called by a process and we
            -- haven't found the error in our lookup table, then we just want to see
            -- the actual error text and not the full error stack with all the ORA error numbers.
            if p_error.ora_sqlcode is not null and l_result.message = p_error.message then
                l_result.message := apex_error.get_first_ora_error_text (
                                        p_error => p_error );
            end if;
            -- If no associated page item/tabular form column has been set, we can use
            -- apex_error.auto_set_associated_item to automatically guess the affected
            -- error field by examine the ORA error for constraint names or column names.
            if l_result.page_item_name is null and l_result.column_alias is null then
                apex_error.auto_set_associated_item (
                    p_error        => p_error,
                    p_error_result => l_result );
            end if;
        end if;
        return l_result;
    end apex_error_handling;
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
        p_arg10_val           in varchar2 default  null )
    is
    begin
        -- Remove old errors
        delete from HM_errors where err_time <= localtimestamp - 21;
        -- Log the error.
        insert into HM_errors (
            app_id,
            app_page_id,
            app_user,
            user_agent,
            --
            ip_address,
            ip_address2,
            message,
            page_item_name,
            --
            region_id,
            column_alias,
            row_num,
            apex_error_code,
            --
            ora_sqlcode,
            ora_sqlerrm,
            error_backtrace,
            arg1_name,
            arg1_val,
            arg2_name,
            arg2_val,
            arg3_name,
            arg3_val,
            arg4_name,
            arg4_val,
            arg5_name,
            arg5_val,
            arg6_name,
            arg6_val,
            arg7_name,
            arg7_val,
            arg8_name,
            arg8_val,
            arg9_name,
            arg9_val,
            arg10_name,
            arg10_val )
        select v('APP_ID'),
            v('APP_PAGE_ID'),
            v('APP_USER'),
            owa_util.get_cgi_env('HTTP_USER_AGENT'),
            --
            owa_util.get_cgi_env('REMOTE_ADDR'),
            sys_context('USERENV', 'IP_ADDRESS'),
            substr(p_error,0,4000),
            substr(p_page_item_name,0,4000),
            --
            p_region_id,
            p_column_alias,
            p_row_num,
            p_apex_error_code,
            --
            p_ora_sqlcode,
            substr(p_ora_sqlerrm,1,4000),
            substr(p_error_backtrace,1,4000),
            p_arg1_name,
            p_arg1_val,
            p_arg2_name,
            p_arg2_val,
            p_arg3_name,
            p_arg3_val,
            p_arg4_name,
            p_arg4_val,
            p_arg5_name,
            p_arg5_val,
            p_arg6_name,
            p_arg6_val,
            p_arg7_name,
            p_arg7_val,
            p_arg8_name,
            p_arg8_val,
            p_arg9_name,
            p_arg9_val,
            p_arg10_name,
            p_arg10_val
        from dual;
        commit;
    end add_error_log;
    --
    -- Function: get_name_from_email_address
    -- Purpose: Attempt to determine a user's name from their email address.
    -- If the email address exists in the users table, return that; otherwise,
    -- try to decipher it from their email address "name".
    --
    function get_name_from_email_address( p_email_address in varchar2 ) return varchar2 is
    begin
        for c1 in ( select trim(nvl(first_name,'')||' '||nvl(last_name,'')) name
                    from HM_users
                    where lower(email_address) = lower(p_email_address) ) loop
            return c1.name;
        end loop;
        if instr(p_email_address, '@') > 0 then
            return regexp_replace ( initcap( replace( substr ( p_email_address, 1, instr(p_email_address, '@') - 1 ), '.', ' ' ) ), '\s\w+\s', ' ' );
        else
            return lower(p_email_address);
        end if;
    end get_name_from_email_address;
end HM_fw;

/
