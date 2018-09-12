--------------------------------------------------------
--  DDL for Trigger TRG_JRR_BRUI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_JRR_BRUI" 
BEFORE INSERT OR UPDATE ON JRXML_RESOURCE_FILES
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.JRR_VALID:='N';
  ELSE
    IF     :OLD.JRR_VALID='Y'
       AND :NEW.JRR_VALID='Y' THEN
      :NEW.JRR_VALID:='N';
    END IF;
  END IF;
END;




/
ALTER TRIGGER "TRG_JRR_BRUI" ENABLE;
