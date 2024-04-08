--SET SERVEROUTPUT ON

DECLARE
identificador INTEGER := 50;
nombre VARCHAR2(25) := 'Team developer';
apodo CHAR(20) := 'melwetanos';
sueldo NUMBER(5):= 50000; 
comision decimal(4,2) := 50.40;
fecha_actual DATE := (sysdate);
fecha date :=  to_date('2020/07/09', 'yyyy/mm/dd');
nombre VARCHAR2(25)default 'valor default';

BEGIN

dbms_output.put_line(apodo || sueldo);

END;
