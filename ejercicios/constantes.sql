-- valores que no cambian
DECLARE
mensaje CONSTANT VARCHAR2(100) := 'Hola melwetanos3';
numero CONSTANT NUMBER(2) := 2;

BEGIN

    mensaje := 'estudien chuchesumangas';

    dbms_output.put_line(mensaje);
    dbms_output.put_line(numero);

END;