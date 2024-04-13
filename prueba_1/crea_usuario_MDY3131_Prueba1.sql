﻿alter session set "_ORACLE_SCRIPT"=true;
/* Creación de usuario si está trabajando con BD Oracle XE */
CREATE USER MDY3131_P1 IDENTIFIED BY "MDY3131.prueba_1"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER MDY3131_P1 QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION TO MDY3131_P1;
GRANT "RESOURCE" TO MDY3131_P1;
ALTER USER MDY3131_P1 DEFAULT ROLE "RESOURCE";