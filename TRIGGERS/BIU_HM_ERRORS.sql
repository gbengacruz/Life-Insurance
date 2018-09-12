--------------------------------------------------------
--  DDL for Trigger BIU_HM_ERRORS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BIU_HM_ERRORS" 
    before insert or update on HM_errors
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;




/
ALTER TRIGGER "BIU_HM_ERRORS" ENABLE;
