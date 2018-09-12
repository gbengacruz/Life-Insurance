--------------------------------------------------------
--  DDL for Package Body HM_FEEDBACK_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HM_FEEDBACK_FW" as
    c_fb_subject     constant varchar2(500) := HM_fw.get_preference_value('APPLICATION_TITLE') || ': Feedback Submission';
    c_base_url       constant varchar2(500) := HM_fw.get_preference_value('HOST_URL');
    c_tdtop_tmpl     constant clob := '<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<title>#APP_NAME#</title>
<style>
    body { background-color: #ffffff; color: #707070; margin: 0; padding: 0; min-width: 100%; -webkit-text-size-adjust: none; -ms-text-size-adjust: none; text-size-adjust: none;
    font-family: Helvetica, Arial, sans-serif; mso-line-height-rule: exactly; -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; }
    table { border: 0; border-spacing: 0; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
    table td { padding: 0; vertical-align: top; border-collapse: collapse; }
    p { margin: 0 0 16px 0; font-size: 12px; }
    table.container { margin-right: auto; margin-left: auto; width: 580px; }
    a { color: #2C7ABF; }
    body, th, td { line-height: 1.5; }
    .complete { color : #009900 !important; }
    .late { color : #dd0000 !important;  }
    .done { color : #000000 !important; }
    #mmTable td, #aiTable td, #msTable td, #issTable td { font-size: 12px; }
    @media only screen and (max-width: 580px) {
      .mobile-hide { display: none !important; }
      .stack { display: block !important; width: 100% !important; }
      table.container { width: 100% !important; }
      .header { height: auto !important; }
      .category-content td,
      .sub-category-title,
      .category-title { padding-left: 10px !important; padding-right: 10px !important; }
    }
</style>
</head>
<body bgcolor="#ffffff" style="font-family: Helvetica, Arial, sans-serif; background-color: #ffffff; color: #707070; margin: 0; padding: 0;">
<table class="body" border="0" width="100%" style="font-family: Helvetica, Arial, sans-serif">
<tr>
<td align="center" valign="top" style="background-color: #ffffff; color: #707070;">
#HEADER_TEXT#
<center>
<!-- Header Wrapper -->
<table width="100%" border="0" bgcolor="#fd2a1b" style="background-color: #fd2a1b; color: #ffffff;">
<tr>
<td>
<table align="center" border="0" class="container" width="600">
<tr>
<td class="header" style="font-size: 14px; line-height: 1.3; text-align: left; padding: 10px; height: 140px; vertical-align: middle; color: #ffffff;" valign="middle" align="left">
<font style="font-size: 28px;">#SUBJECT#</font>#RECIPIENT_EMAIL#
</td>
</tr>
</table>
</td>
</tr>
</table>
<!-- // Header Wrapper -->
<br>
<!-- Content Wrapper -->
<table align="center" border="0" class="container" width="600">
<tr>
<td class="container-inner" style="text-align: left; padding-left: 10px; padding-right: 10px;" align="left">
'; -- To Do Email Top
    c_pspitf_tmpl    constant clob := '
</td>
</tr>
</table>
<!-- // Content Wrapper -->
<br>
'; -- Project Details Project Item Type Footer
    procedure set_apex_session( p_app_id in number ) is
    begin
        for c1 in ( select workspace_id
                    from apex_applications
                    where application_id = p_app_id ) loop
            apex_util.set_security_group_id(
                p_security_group_id => c1.workspace_id);
        end loop;
    end set_apex_session;
    function get_header_text (p_email_type in varchar2 default null) return varchar2 is
        l_header_text varchar2(4000) := null;
    begin
        l_header_text := HM_fw.get_preference_value( p_preference_name => 'EMAIL_MSG_HEADER' );
        if l_header_text = 'Preference does not exist' or l_header_text is null then
            l_header_text := null;
        end if;
        return l_header_text;
    end get_header_text;
    function get_feedback_email_body (  p_app_id        in number,
                                        p_page_id       in number,
                                        p_submitter     in varchar2,
                                        p_feedback      in varchar2 ) return clob is
        l_clob clob;
        l_body clob;
        m      clob;
    begin
        l_clob := m;
        m := m || replace( replace( replace( replace(c_tdtop_tmpl, '#APP_NAME#',
                        HM_fw.get_preference_value('APPLICATION_TITLE')), '#SUBJECT#', c_fb_subject),
                        '#RECIPIENT_EMAIL#', null), '#HEADER_TEXT#', get_header_text() );
        l_clob := l_clob || m;
        m := null;
        -- Construct html body
        l_body := '<p>' || p_submitter || ' has submitted the following <strong><a href="' || apex_util.prepare_url(c_base_url ||
                  'f?p=' || p_app_id || ':203:0:::203,RIR:IREQ_PAGE_ID,IREQ_CREATED_BY:' || p_page_id || ',' ||
                  upper(p_submitter)) || '">feedback</a></strong> from page ' || p_page_id || ':</p>' ||
                  '<p>' || p_feedback || '</p>';
        -- Add body to current clob
        l_clob := l_clob || l_body;
        m := m || c_pspitf_tmpl || c_pspitf_tmpl;
        l_clob := l_clob || m;
        return l_clob;
    end get_feedback_email_body;
    procedure log_sent_email (  p_email_to   in varchar2,
                                p_email_from in varchar2,
                                p_body_size  in number,
                                p_type       in varchar2,
                                p_project_id in number    default null ) is
    begin
        null;
    end log_sent_email;
    procedure send_feedback_email ( p_app_id        in number,
                                    p_page_id       in number,
                                    p_submitter     in varchar2,
                                    p_feedback      in varchar2 ) is
        l_recipients    varchar2(4000);
        l_exists        boolean;
        l_subject       varchar2(500) := c_fb_subject;
        l_body          clob := ' ';
        l_body_html     clob;
        l_email_type    varchar2(30) := 'FEEDBACK_SUBMISSION';
        l_from          varchar2(255);
    begin
        l_recipients := HM_fw.get_preference_value ( p_preference_name   => 'FEEDBACK_RECIPIENTS',
                                                          p_preference_exists => l_exists );
        if not l_exists or nvl(l_recipients,'XX') = 'XX' then
            return; -- No Feedback Recipients defined so exit
        end if;
        set_apex_session( p_app_id );
        -- Determine Sender
        if instr(p_submitter,'@') > 0 then
            l_from := lower(p_submitter);
        else
            for c1 in ( select email_address
                        from HM_users
                        where upper(username) = upper(p_submitter)
                            and email_address is not null
                            and instr(email_address,'@') > 0 ) loop
                l_from := lower(c1.email_address);
            end loop;
        end if;
        if l_from is null then
            if instr(l_recipients,',') > 0 then
                l_from := lower( substr( l_recipients, 1, instr(l_recipients,',') - 1) );
            else
                l_from := lower( l_recipients );
            end if;
        end if;
        -- Assign local variables
        l_body_html := get_feedback_email_body (
                            p_app_id        => p_app_id,
                            p_page_id       => p_page_id,
                            p_submitter     => p_submitter,
                            p_feedback      => p_feedback
                        );
        -- Send email
        apex_mail.send(
            p_to        => l_recipients,
            p_from      => l_from,
            p_body      => l_body,
            p_body_html => '<html><body>' || l_body_html || '</body></html>',
            p_subj      => l_subject,
            p_cc        => null,
            p_bcc       => null,
            p_replyto   => null);
        -- Log sent email
        log_sent_email(
            p_email_to => l_recipients,
            p_email_from => l_from,
            p_body_size => 26 + length(l_body_html),
            p_type => l_email_type);
        apex_mail.push_queue;
    end send_feedback_email;
end HM_feedback_fw;

/
