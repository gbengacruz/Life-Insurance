--------------------------------------------------------
--  DDL for Package Body HM_EMAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HM_EMAIL" as
g_ws_name        varchar2(255) := 'ASPIREHCM';  -- OWNING WORKSPACE
g_owning_app_id  number := 118733;      -- OWNING APPLICATION
procedure create_email (
   p_template_id    in   number,
   p_subject        in   varchar2  default null,
   p_body1_text     in   varchar2  default null,
   p_table_content  in   varchar2  default null,
   p_body2_text     in   varchar2  default null,
   p_action_label   in   varchar2  default null,
   p_action_link    in   varchar2  default null,
   p_can_opt_out_yn in   varchar2  default 'N',
   p_email_id       out  number,
   p_status         out  varchar2 )
is
begin
   p_status := 'SUCCESS';
   insert into HM_emails
      (template_id, subject, body1_text, table_content,
       body2_text, action_label, action_link, can_opt_out_yn)
   values
      (p_template_id, p_subject, p_body1_text, p_table_content,
       p_body2_text, p_action_label, p_action_link, p_can_opt_out_yn)
   returning id into p_email_id;
   commit;
exception
   when others then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (p_procedure_name  => 'HM_email.create_email', p_error => sqlerrm,
                                p_arg1_name => 'p_template_id', p_arg1_val => p_template_id,
                                p_arg2_name => 'p_subject', p_arg2_val => p_subject );
end create_email;
procedure add_user (
   p_email_id      in   number,
   p_username      in   varchar2,
   p_status        out  varchar2 )
is
   l_found              varchar2(1) := 'N';
   l_error_msg          varchar2(4000);
   custom_error         exception;
begin
   p_status := 'SUCCESS';
   -- EMAIL EXISTS
   for c1 in (
      select id
        from HM_emails
       where id = p_email_id
   ) loop
      l_found := 'Y';
   end loop;
   if l_found = 'N' then
      l_error_msg := 'Specified email_id not found';
      raise custom_error;
   end if;
   -- ADDING USER
   insert into HM_email_affects
      (email_id, username,
       user_tz_pref, user_lang_code, user_opted_out_yn)
   values
      (p_email_id, p_username,
       nvl(HM_fw.get_preference_value(p_username => p_username, p_preference_name => 'TIMEZONE'),'US/Pacific'),
       nvl(HM_fw.get_preference_value(p_username => p_username, p_preference_name => 'LANGUAGE'),'en'),
       decode(HM_fw.get_preference_value(p_username => p_username, p_preference_name => 'RECEIVE_EMAILS_YN'),
                    'N','Y','N')  );
   commit;
exception
   when custom_error then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (p_procedure_name  => 'HM_email.add_user', p_error => l_error_msg,
                                p_arg1_name => 'p_email_id', p_arg1_val => p_email_id,
                                p_arg2_name => 'p_username', p_arg2_val => p_username );
   when others then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (p_procedure_name  => 'HM_email.add_user', p_error => sqlerrm,
                                p_arg1_name => 'p_email_id', p_arg1_val => p_email_id,
                                p_arg2_name => 'p_username', p_arg2_val => p_username );
end add_user;
procedure send_email (
   p_email_id        in   number,
   p_status          out  varchar2 )
is
   l_found            varchar2(1) := 'N';
   l_send_email_yn    varchar2(1);
   l_email_from       varchar2(255);
   l_email_cnt        number      := 0;
   l_error_msg        varchar2(4000);
   custom_error       exception;
   l_vc_arr2          APEX_APPLICATION_GLOBAL.VC_ARR2;
   l_email_body       varchar2(32000);
   l_email_body_text  varchar2(32000);
   l_table            varchar2(4000);
   l_table_text       varchar2(4000);
   l_app_name         varchar2(4000);
begin
   for c1 in (
      select e.subject,
             e.body1_text,
             e.table_content,
             e.body2_text,
             e.action_label,
             e.action_link,
             e.can_opt_out_yn,
             t.full_template_html,
             t.text_template,
             t.table_open_html,
             t.tr_html,
             t.table_close_html,
             t.action_button_html
        from HM_emails e,
             HM_email_templates t
       where e.id = p_email_id
         and e.template_id = t.id
   ) loop
      l_found := 'Y';
      l_send_email_yn := HM_fw.get_preference_value('SEND_EMAIL_YN');
      l_email_from := HM_fw.get_preference_value('EMAILS_FROM');
      if l_send_email_yn = 'Y' and l_email_from is null then
         l_error_msg := 'Preference EMAILS_FROM must be set to send emails';
         raise custom_error;
      end if;
      -- #BODY1#, #TABLE#, #BODY2#, #ACTION#
      l_email_body_text := c1.text_template;
      l_email_body      := c1.full_template_html;
      apex_util.set_workspace (p_workspace => g_ws_name);
      if nvl(NV('APP_ID'),0) != g_owning_app_id then
         apex_application.g_flow_id := g_owning_app_id;
      end if;
      for c1 in (
         select substitution_value
           from apex_application_substitutions
          where workspace = g_ws_name
            and application_id = g_owning_app_id
            and substitution_string = 'APP_NAME'
      ) loop
         l_app_name := c1.substitution_value;
      end loop;
      l_email_body_text := replace(l_email_body_text,'#APP_NAME#',l_app_name);
      l_email_body      := replace(l_email_body,     '#APP_NAME#',l_app_name);
      l_email_body_text := replace(l_email_body_text,'#BODY1#',c1.body1_text);
      l_email_body      := replace(l_email_body,     '#BODY1#',c1.body1_text);
      if c1.table_content is not null then
         l_table      := c1.table_open_html;
         l_table_text := null;
         -- loop through each and replace into l_tr2
         l_vc_arr2 := APEX_UTIL.STRING_TO_TABLE(c1.table_content,',');
         for z IN 1..l_vc_arr2.count loop
            l_table := l_table ||
                       replace(replace(c1.tr_html, '#LABEL#', substr(l_vc_arr2(z),2,instr(l_vc_arr2(z),'"',1,2)-2)),
                                                   '#VALUE#', rtrim(substr(l_vc_arr2(z),instr(l_vc_arr2(z),'"',1,3)+1),'"'));
            if l_table_text is not null then
               l_table_text := l_table_text || '
   ' || substr(l_vc_arr2(z),2,instr(l_vc_arr2(z),'"',1,2)-2) ||' : '||rtrim(substr(l_vc_arr2(z),instr(l_vc_arr2(z),'"',1,3)));
            else
               l_table_text := '   ' || substr(l_vc_arr2(z),2,instr(l_vc_arr2(z),'"',1,2)-2) ||' : '||rtrim(substr(l_vc_arr2(z),instr(l_vc_arr2(z),'"',1,3)+1),'"');
            end if;
         end loop;
         l_table := l_table||c1.table_close_html;
         l_email_body_text := replace(l_email_body_text,'#TABLE#',l_table_text);
         l_email_body      := replace(l_email_body,     '#TABLE#',l_table);
      else
         l_email_body_text := replace(l_email_body_text,'#TABLE#',null);
         l_email_body      := replace(l_email_body,     '#TABLE#',null);
      end if;
      l_email_body_text := replace(l_email_body_text,'#BODY2#',c1.body2_text);
      l_email_body      := replace(l_email_body,     '#BODY2#',c1.body2_text);
      if c1.action_label is not null and c1.action_link is not null then
         l_email_body_text := replace(l_email_body_text,'#ACTION#',c1.action_label||', '||c1.action_link);
         l_email_body      := replace(l_email_body,     '#ACTION#',replace(replace(c1.action_button_html,'#ACTION_LINK#', c1.action_link),
                                                                                      '#ACTION_TEXT#', c1.action_label));
      else
         l_email_body_text := replace(l_email_body_text,'#ACTION#',null);
         l_email_body      := replace(l_email_body,     '#ACTION#',null);
      end if;
      update HM_emails
         set email_body = l_email_body
       where id = p_email_id;
      commit;
      for c2 in (
         select a.id,
                a.username,
                case when l_send_email_yn = 'N'
                     then 'N'
                     when c1.can_opt_out_yn = 'N'
                     then 'Y'
                     else decode(user_opted_out_yn,'Y','N','Y')
                     end distribute
           from HM_email_affects a
          where a.email_id = p_email_id
          order by username
      ) loop
         if c2.distribute = 'Y' then
            apex_mail.send (
               p_to        => c2.username,
               p_from      => l_email_from,
               p_subj      => c1.subject,
               p_body      => l_email_body_text,
               p_body_html => l_email_body );
            --   APEX_MAIL.PUSH_QUEUE('smtp.royalexchangeplc.com', 25);
            update HM_email_affects
               set email_sent_on = localtimestamp
             where c2.id = id;
            commit;
            l_email_cnt := l_email_cnt + 1;
         end if;
      end loop;
      if l_email_cnt > 0 then
        apex_mail.push_queue;
      --    APEX_MAIL.PUSH_QUEUE('smtp.royalexchangeplc.com', 25);
      end if;
      update HM_emails
         set nbr_emails_sent = l_email_cnt
       where id = p_email_id;
      commit;
   end loop;
   if l_found = 'N' then
      l_error_msg := 'Specified email_id not found';
      raise custom_error;
   end if;
exception
   when custom_error then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (
          p_procedure_name => 'HM_email.send_email', p_error => l_error_msg,
          p_arg1_name => 'p_email_id', p_arg1_val => p_email_id );
   when others then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (
          p_procedure_name => 'HM_email.send_email', p_error => sqlerrm,
          p_arg1_name => 'p_email_id', p_arg1_val => p_email_id );
end send_email;
procedure send (
   p_email_addresses in   varchar2,
   p_template_id     in   number,
   p_subject         in   varchar2,
   p_body1_text      in   varchar2  default null,
   p_table_content   in   varchar2  default null,
   p_body2_text      in   varchar2  default null,
   p_action_label    in   varchar2  default null,
   p_action_link     in   varchar2  default null,
   p_can_opt_out_yn  in   varchar2  default 'N',
   p_status          out  varchar2 )
is
   l_found              varchar2(1) := 'N';
   l_emails             wwv_flow_global.vc_arr2;
   l_email              varchar2(4000);
   l_at                 number;
   l_dot                number;
   l_domain             varchar2(4000);
   l_email_id           number;
   l_error_msg          varchar2(4000);
   custom_error         exception;
   deep_error           exception;
begin
   for c1 in (
      select 1
        from HM_email_templates
       where id = p_template_id
   ) loop
      l_found := 'Y';
      create_email (
         p_template_id    => p_template_id,
         p_subject        => p_subject,
         p_body1_text     => p_body1_text,
         p_table_content  => p_table_content,
         p_body2_text     => p_body2_text,
         p_action_label   => p_action_label,
         p_action_link    => p_action_link,
         p_can_opt_out_yn => p_can_opt_out_yn,
         p_email_id       => l_email_id,
         p_status         => p_status );
      -- CREATE_EMAIL FAILED
      if p_status != 'SUCCESS' then
         raise deep_error;
      end if;
      -- GET EMAIL ADDRESSES, ONLY VALID AND NON-REPEATED ONES
      l_emails := wwv_flow_utilities.string_to_table(p_email_addresses,',');
      for j in 1..l_emails.count loop
          l_email := trim(l_emails(j));
          if l_email is not null then
             l_at     := instr(nvl(l_email,'x'),'@');
             l_domain := substr(l_email,l_at+1);
             l_dot    := instr(l_domain,'.');
             if l_at >= 2 and
                l_dot > 0
             then
                l_email := trim(l_email);
                l_email := trim(both '.' from l_email);
                l_email := replace(l_email,' ',null);
                l_email := replace(l_email,chr(10),null);
                l_email := replace(l_email,chr(9),null);
                l_email := replace(l_email,chr(13),null);
                l_email := replace(l_email,chr(49824),null);
                if length(l_email) <= 255 then
                   for c1 in (
                      select 1 from dual
                       where not exists
                             (select 1
                                from HM_email_affects
                               where email_id = l_email_id
                                 and username = lower(l_email))
                   ) loop
                      add_user (
                         p_email_id     => l_email_id,
                         p_username     => lower(l_email),
                         p_status       => p_status );
                      -- ADD_USER FAILED
                      if p_status != 'SUCCESS' then
                         raise deep_error;
                      end if;
                   end loop;
                end if;
             end if;
          end if;
          l_email := null;
      end loop;
      send_email (
         p_email_id     => l_email_id,
         p_status       => p_status  );
   end loop;
   -- TEMPLATE_ID NOT FOUND
   if l_found = 'N' then
      l_error_msg := 'Specified template_id not found';
      raise custom_error;
   end if;
exception
   when custom_error then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (p_procedure_name  => 'HM_email.send', p_error => l_error_msg,
                                p_arg1_name => 'p_email_addresses', p_arg1_val => substr(p_email_addresses,1,4000),
                                p_arg2_name => 'p_template_id', p_arg2_val => p_template_id,
                                p_arg3_name => 'p_subject', p_arg3_val => p_subject );
   when deep_error then
      rollback;
   when others then
      rollback;
      p_status := 'FAILURE';
      HM_fw.add_error_log (p_procedure_name  => 'HM_email.send', p_error => sqlerrm,
                                p_arg1_name => 'p_email_addresses', p_arg1_val => substr(p_email_addresses,1,4000),
                                p_arg2_name => 'p_template_id', p_arg2_val => p_template_id,
                                p_arg3_name => 'p_subject', p_arg3_val => p_subject );
end send;
end HM_email;

/
