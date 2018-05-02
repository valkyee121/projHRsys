CREATE OR REPLACE PROCEDURE pastTrainn (v_out_resut OUT TRAINNPACKAGE.tr_cursor)
  IS
  v_sql VARCHAR2(1000):='';
  BEGIN
    v_sql:='SELECT * FROM T_HRSYS_TRAINN WHERE TR_END_TIME<sysdate';
    OPEN v_out_resut FOR v_sql;
  END;
/

