CREATE OR REPLACE PROCEDURE paging_cursor
  (v_in_table IN VARCHAR2,
    v_in_sqlWhere IN VARCHAR2,
    v_in_pagesize IN OUT NUMBER,
    v_in_pagenow IN OUT NUMBER,
    v_out_result OUT pagingPackage.paging_cursor,
    v_out_rows OUT NUMBER,
    v_out_pagecount OUT NUMBER)
  IS
    v_sql VARCHAR2(1000):='';
    v_sql_select VARCHAR2(1000):='';
    v_start NUMBER;
    v_end NUMBER;
    BEGIN
      /*查询到的记录总数*/
      v_sql_select:= 'SELECT TO_NUMBER(COUNT(*)) FROM ' || v_in_table || ' WHERE 1=1';
      IF v_in_sqlWhere IS NOT NULL OR v_in_sqlWhere<>'' THEN
        v_sql_select:=v_sql_select||v_in_sqlWhere;
      END IF;
      dbms_output.put_line (v_sql_select);
      EXECUTE IMMEDIATE v_sql_select INTO v_out_rows;

      /*验证页面记录大小*/
      IF v_in_pagesize<0 THEN
        v_in_pagesize:=0;
      END IF;
      /*统计记录页数*/
      IF mod(v_out_rows,v_in_pagesize)=0 THEN
        v_out_pagecount:=v_out_rows/v_in_pagesize;
      ELSE
        v_out_pagecount:=v_out_rows/v_in_pagesize+1;
      END IF;
      /*验证页号*/
      IF v_in_pagenow<1 THEN
        v_in_pagenow:=1;
      END IF;
      IF v_in_pagenow>v_out_pagecount THEN
        v_in_pagenow:=v_out_pagecount;
      END IF;

      /*分页*/
      v_start:=v_in_pagesize*(v_in_pagenow-1)+1;
      v_end:=v_in_pagesize*v_in_pagenow;
      v_sql:= 'SELECT t2.* FROM (SELECT t1.*, ROWNUM rn FROM (SELECT * FROM '|| v_in_table || ' WHERE 1=1 ';
      IF v_in_sqlWhere IS NOT NULL OR v_in_sqlWhere<>'' THEN
        v_sql:= v_sql || v_in_sqlWhere;
      END IF;
      v_sql:= v_sql || ')t1 WHERE ROWNUM<= '|| v_end || ')t2 WHERE t2.rn>=' || v_start;

      OPEN v_out_result FOR v_sql;

    END;

/

