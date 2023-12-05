
DROP TABLESPACE IA643F21_TBS including contents and datafiles;

CREATE TABLESPACE IA643F21_TBS 
DATAFILE 'IA643f21_dat' SIZE 500K REUSE
AUTOEXTEND ON NEXT 300K MAXSIZE 50M;
	
--Create user account JAdmin

DROP USER JAdmin;
CREATE USER JAdmin
IDENTIFIED BY JAdmin
DEFAULT TABLESPACE IA643F21_TBS
QUOTA 200K ON IA643F21_TBS
TEMPORARY TABLESPACE TEMP
ACCOUNT UNLOCK;

--Grant Connect and resource 
GRANT CONNECT, RESOURCE TO JAdmin;

--Create user account FAdmin
DROP USER FAdmin;
CREATE USER FAdmin
IDENTIFIED BY FAdmin
DEFAULT TABLESPACE IA643F21_TBS
QUOTA 200K ON IA643F21_TBS
TEMPORARY TABLESPACE TEMP
ACCOUNT UNLOCK;

--Grant Connect and resource 
GRANT CONNECT, RESOURCE TO FAdmin;


--Create Public Synonyms for each tables
DROP PUBLIC SYNONYM COMPANY;
CREATE PUBLIC SYNONYM COMPANY FOR DBA643.COMPANY;
GRANT SELECT, INSERT, UPDATE, DELETE ON COMPANY TO JAdmin,FAdmin;

DROP PUBLIC SYNONYM EMPLOYEE;
CREATE PUBLIC SYNONYM EMPLOYEE FOR DBA643.EMPLOYEE;
GRANT SELECT, INSERT, UPDATE, DELETE ON EMPLOYEE TO JAdmin,FAdmin;

DROP PUBLIC SYNONYM TIMESHEET;
CREATE PUBLIC SYNONYM TIMESHEET FOR DBA643.TIMESHEET;
GRANT SELECT, INSERT, UPDATE, DELETE ON TIMESHEET TO JAdmin,FAdmin;

DROP PUBLIC SYNONYM PAYROLL_PERIOD;
CREATE PUBLIC SYNONYM PAYROLL_PERIOD FOR DBA643.PAYROLL_PERIOD;
GRANT SELECT, INSERT, UPDATE, DELETE ON PAYROLL_PERIOD TO JAdmin,FAdmin;


DROP PUBLIC SYNONYM DAILY_WORK_HOURS;
CREATE PUBLIC SYNONYM DAILY_WORK_HOURS FOR DBA643.DAILY_WORK_HOURS;
GRANT SELECT, INSERT, UPDATE, DELETE ON DAILY_WORK_HOURS TO JAdmin,FAdmin;




--Create Triggers to automatically insert the user’s ID into CTL_SEC_USER columns 

CREATE OR REPLACE TRIGGER Trig_Insert_user_company
BEFORE INSERT OR UPDATE
ON COMPANY FOR EACH ROW
BEGIN
  :NEW.CTL_SEC_USER := USER;
  
END;
/


CREATE OR REPLACE TRIGGER Trig_Insert_user_employee
BEFORE INSERT OR UPDATE
ON EMPLOYEE FOR EACH ROW
BEGIN
  :NEW.CTL_SEC_USER := USER;
END;
/


CREATE OR REPLACE TRIGGER Trig_Insert_user_timesheet
BEFORE INSERT OR UPDATE
ON TIMESHEET FOR EACH ROW
BEGIN
  :NEW.CTL_SEC_USER := USER;
  
END;
/


CREATE OR REPLACE TRIGGER Trig_Insert_user_Payrollperiod
BEFORE INSERT OR UPDATE
ON PAYROLL_PERIOD FOR EACH ROW
BEGIN
  :NEW.CTL_SEC_USER := USER;
 
END;
/


CREATE OR REPLACE TRIGGER Trig_Insert_user_Dailyworkhours
BEFORE INSERT OR UPDATE
ON DAILY_WORK_HOURS FOR EACH ROW
BEGIN
  :NEW.CTL_SEC_USER := USER;
END;
/





-- VPD Policy Function to allow DBA user all access and the users only to the objects that they are related to 

create or replace function Sec_Payroll_V_P_D(p_scheme_name in varchar2, p_object_name in varchar2) return varchar2 is v_where varchar2(300);
begin
if user = 'DBA643' then
v_where := '';
        Else
            V_where := 'CTL_SEC_USER = USER';   
        END IF; 
      RETURN V_Where;
END;
/


exec DBMS_RLS.add_policy('DBA643', 'company', 'Row_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
exec DBMS_RLS.add_policy('DBA643', 'employee', 'Row_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
exec DBMS_RLS.add_policy('DBA643', 'timesheet', 'Row_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
exec DBMS_RLS.add_policy('DBA643', 'Payroll_period', 'Row_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
exec DBMS_RLS.add_policy('DBA643', 'Daily_work_hours', 'Row_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
exec DBMS_RLS.add_policy('DBA643', 'COMPANY_ADMINISTRATORS', 'Table_Access','dba643','Sec_Payroll_V_P_D','select,update,delete,insert',true);
