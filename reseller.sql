column MKT_REF NEW_VALUE MKTREF

set echo off
set head off
set lines 1000
set pages 1000
set feedback off
set trims on
set verify off


@/tables/home/Login_Scripts/SelectMKTTLGREF.sql

--PROMPT

SET PAGESIZE 50000
SET MARKUP HTML ON TABLE 'id="market"' ENTMAP OFF
COLUMN MKT HEADING "Market" FORMAT A40

set verify off
SET MARKUP HTML ON TABLE 'id="query"' ENTMAP OFF
SPOOL report_refwait.html APPEND

set lines 1000;
set echo on;
----------
set colsep '|';
set heading off
select 'DEALERs with Differences' from dual;
set head on
set feedback on
select distinct a.DEALER,a.DLR_NAME,b.DLR_NAME,a.START_DATE,b.START_DATE,a.END_DATE,b.END_DATE,a.NL_CD,b.NL_CD,a.DPRT_DEPARTMENT_CODE,b.DPRT_DEPARTMENT_CODE,a.SUB_MARKET,b.SUB_MARKET,a.AGENT,b.AGENT,a.AGENT_LOCATION,b.AGENT_LOCATION,a.AGENT_LEVEL,b.AGENT_LEVEL
from jd8296.tmp_dealerprofRESELLERS a, &&MKTREF..dealer_profile b
where a.DEALER=b.DEALER
and (nvl(trim(upper(a.DLR_NAME)),'X')!=nvl(trim(upper(b.DLR_NAME)),'X')
or nvl(trim(a.START_DATE),'X') !=nvl(trim(b.START_DATE),'X')
or nvl(trim(a.END_DATE),'X') !=nvl(trim(b.END_DATE),'X')
or nvl(trim(a.NL_CD),'X') !=nvl(trim(b.NL_CD),'X')
or nvl(trim(a.DPRT_DEPARTMENT_CODE),'X') !=nvl(trim(b.DPRT_DEPARTMENT_CODE),'X')
or nvl(trim(a.SUB_MARKET),'X') !=nvl(trim(b.SUB_MARKET),'X')
or nvl(trim(a.AGENT),'X') !=nvl(trim(b.AGENT),'X')
or nvl(trim(a.AGENT_LOCATION),'X') !=nvl(trim(b.AGENT_LOCATION),'X')
or nvl(trim(a.AGENT_LEVEL),'X') !=nvl(trim(b.AGENT_LEVEL),'X')
)
and b.DEALER not like 'FCCNT';
set feedback on
set verify on
exit;
