CREATE TRIGGER TRIG_JOB_TRAINN_INSERT_FORBID
  BEFORE INSERT
  ON T_HRSYS_TRAINN
  FOR EACH ROW
  DECLARE
    v_total NUMBER;
  BEGIN
    v_total:= :NEW.TR_END_TIME - :NEW.TR_BEGIN_TIME;
    IF v_total<= 0 OR :NEW.TR_BEGIN_TIME<sysdate THEN
      raise_application_error(-20008,'��ѵʱ�����������');
    END IF;
  END TRIG_JOB_TRAINN_INSERT_FORBID;
/

