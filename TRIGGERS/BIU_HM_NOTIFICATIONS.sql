--------------------------------------------------------
--  DDL for Trigger BIU_HM_NOTIFICATIONS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_NOTIFICATIONS" 
before insert or update on HM_notifications
    for each row
begin
    if inserting and :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
    if inserting then
        :new.created_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
        :new.created := localtimestamp;
        :new.row_version_number := 1;
    else
        :new.row_version_number := nvl(:old.row_version_number,1) + 1;
    end if;
    :new.updated_by := lower(nvl(sys_context('APEX$SESSION','APP_USER'),user));
    :new.updated := localtimestamp;
    if :new.notification_type is null then
        :new.notification_type := 'MANUAL';
    end if;
end biu_HM_notifications;




/
ALTER TRIGGER "BIU_HM_NOTIFICATIONS" ENABLE;
