--------------------------------------------------------
--  DDL for Package HM_EMAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HM_EMAIL" as
    --EXAMPLE
    --declare
    --   l_status        varchar2(30);
    --begin
    --
    --HM_email.send (
    --   p_email_addresses => 'someone@theemail.com',
    --   p_template_id     => 1,
    --   p_subject         => 'Testing',
    --   p_body1_text      => 'This is where the body1 text goes',
    --   p_table_content   => '"label 1":"value 1","label 2":"value 2"',
    --   p_body2_text      => 'This is where the body2 text goes',
    --   p_action_label    => 'Click to do Something',
    --   p_action_link     => 'www.oracle.com',
    --   p_can_opt_out_yn  => 'N',
    --   p_status          => l_status );
    --
    --end;
    --
procedure send (
   p_email_addresses in   varchar2,  -- comma separated list
   p_template_id     in   number,
   p_subject         in   varchar2,
   p_body1_text      in   varchar2  default null,
   p_table_content   in   varchar2  default null, -- format is '"Label 1":"Value 1","Label 2":"Value 2"'
   p_body2_text      in   varchar2  default null,
   p_action_label    in   varchar2  default null, -- not too long, used on a button
   p_action_link     in   varchar2  default null, -- url for action button
   p_can_opt_out_yn  in   varchar2  default 'N',  -- Y or N, if Y then checks for users RECEIVE_EMAILS preference
   p_status          out  varchar2 );
end HM_email;

/
