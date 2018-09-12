--------------------------------------------------------
--  DDL for Package Body HM_SEARCH_FW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HM_SEARCH_FW" as
    procedure build_search_collection(  p_search_term in varchar2,
                                        p_tables in varchar2 default null ) is
        table_search_sql varchar2(32767) := null;
    begin
        apex_collection.create_or_truncate_collection( p_collection_name => 'SEARCH_RESULTS' );
        for c1 in ( select le.entry_text label,
                        le.entry_target,
                        sys.dbms_assert.qualified_sql_name(
                            trim(regexp_replace(le.entry_attribute_01,'\s*--.*',''))
                        ) table_name,
                        dbms_assert.simple_sql_name(
                            trim(regexp_replace(le.entry_attribute_02,'\s*--.*',''))
                        ) primary_key,
                        upper(regexp_replace(
                            regexp_replace(le.entry_attribute_03,'\s*--.*',''),
                            '[,;: ]+',':')) search_columns
                    from apex_application_lists l,
                        apex_application_list_entries le
                    where l.application_id = v('APP_ID')
                        and le.application_id = l.application_id
                        and l.list_name = 'Searched Tables'
                        and le.list_id = l.list_id
                        and ( p_tables is null
                            or ':'||p_tables||':' like '%:'||regexp_replace(le.entry_attribute_01,'\s*--.*','')||':%' )
                        ) loop
            for c2 in ( select 'select '||c1.primary_key||' p, '||replace(column_name,'''','''''')||' x'||chr(10)||
                                'from '||replace(table_name,'''','''''')||chr(10)||
                                'where instr(upper('||replace(column_name,'''','''''')||'),upper(:B1)) > 0'||chr(10)||
                                'and '||replace(column_name,'''','''''')||' is not null' the_sql,
                                table_name,
                                column_name,
                                data_type
                        from user_tab_columns
                        where table_name = c1.table_name
                            and ( c1.search_columns is null or ':'||c1.search_columns||':' like '%:'||column_name||':%' )
                            and data_type in ('VARCHAR2','CLOB') ) loop
                table_search_sql := 'begin'||chr(10)||'for csr in ('||c2.the_sql||') loop'||chr(10)||
                    'APEX_COLLECTION.ADD_MEMBER (p_collection_name => ''SEARCH_RESULTS'','||chr(10)||
                    'p_c001=>:B2,'||chr(10)||
                    'p_c002=>:B3,'||chr(10)||
                    'p_c003=>:B4,'||chr(10)||
                    'p_c004=>replace(:B5,''=PK='',csr.p),'||chr(10)||
                    'p_c005=>csr.p,'||chr(10)||
                    'p_c006=>csr.x,'||chr(10)||
                    'p_c007=>:B6'||chr(10)||
                    ');'||chr(10)||
                    'end loop;'||chr(10)||
                    'end;';
                execute immediate table_search_sql
                    using p_search_term, -- B1
                        c2.table_name, -- B2
                        c2.column_name, -- B3
                        c1.primary_key, -- B4
                        apex_application.do_substitutions(c1.entry_target), -- B5
                        c1.label -- B6
                        ;
                commit;
            end loop; -- c2
        end loop; -- c1
    end build_search_collection;
end HM_search_fw;

/
