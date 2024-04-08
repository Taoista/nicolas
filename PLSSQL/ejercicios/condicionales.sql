DECLARE
    a  number(2) := 20;
    b  number(2) := 30;

BEGIN
    if a > b THEN
        dbms_output.put_line(a || ' es amyor');
    else
        dbms_output.put_line(b || ' es amyor');
    END IF;

END;
