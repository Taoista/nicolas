-- 
-- resumen de la base de datos
-- 
-- 
Prompt ******  CREANDO TABLA CIUDAD ....

CREATE TABLE CIUDAD  
(
 CODCIUDAD 	NUMBER (2), 
 DESCRIPCION 	VARCHAR2(30)
);

ALTER TABLE CIUDAD 
    ADD CONSTRAINT COD_CIUDAD_PK PRIMARY KEY (CODCIUDAD);


Prompt ******  CREANDO TABLA COMUNA ....

CREATE TABLE COMUNA
(
 CODCOMUNA 	NUMBER (2), 
 DESCRIPCION 	VARCHAR2(30),
 CODCIUDAD 	NUMBER(2)
);

ALTER TABLE COMUNA 
    ADD CONSTRAINT COD_COMUNA_PK PRIMARY KEY (CODCOMUNA);

ALTER TABLE COMUNA 
    ADD CONSTRAINT COD_CIUDAD_FK FOREIGN KEY (CODCIUDAD) REFERENCES CIUDAD (CODCIUDAD);


Prompt ******  CREANDO TABLA CLIENTE ....

CREATE TABLE CLIENTE
(
  ID_CLIENTE  		NUMBER(2),	
  RUTCLIENTE  		VARCHAR2(10),
  NOMBRE      		VARCHAR2(30),
  DIRECCION   		VARCHAR2(30),
  CODCOMUNA   		NUMBER (2),
  TELEFONO    		NUMBER(10),
  ESTADO      		VARCHAR2(1),
  MAIL			VARCHAR2(50),
  CREDITO     		NUMBER (7),
  SALDO       		NUMBER (7)
);

ALTER TABLE CLIENTE
    ADD CONSTRAINT RUT_CLIENTE_PK
    PRIMARY KEY (RUTCLIENTE);

ALTER TABLE CLIENTE
    ADD CONSTRAINT ESTADO_CLIENTE_CK
    CHECK (ESTADO IN ('A', 'B') );

ALTER TABLE CLIENTE 
    ADD CONSTRAINT COD_COMUNA_FK 
    FOREIGN KEY (CODCOMUNA) REFERENCES COMUNA (CODCOMUNA);



Prompt ******  CREANDO TABLA VENDEDOR ....

CREATE TABLE VENDEDOR
(
  ID_VENDEDOR		NUMBER(2),	
  RUTVENDEDOR 		VARCHAR2(10),
  NOMBRE      		VARCHAR2(30),
  DIRECCION   		VARCHAR2(30),
  CODCOMUNA   		NUMBER (2),
  TELEFONO    		NUMBER(10),
  MAIL			VARCHAR2(50),
  SUELDO_BASE		NUMBER(8),
  COMISION		NUMBER(2,2)
);

ALTER TABLE VENDEDOR
    ADD CONSTRAINT RUT_VENDEDOR_PK
    PRIMARY KEY (RUTVENDEDOR);

ALTER TABLE VENDEDOR 
    ADD CONSTRAINT VENDEDOR_COD_COMUNA_FK 
    FOREIGN KEY (CODCOMUNA) REFERENCES COMUNA (CODCOMUNA);


Prompt ******  CREANDO TABLA UNIDAD_MEDIDA ....

CREATE TABLE  UNIDAD_MEDIDA 
   (
    CODUNIDAD 	VARCHAR2(2), 
    DESCRIPCION	VARCHAR2(30) 
   );

ALTER TABLE UNIDAD_MEDIDA 
      ADD CONSTRAINT COD_UNIDAD_PK 
      PRIMARY KEY (CODUNIDAD);


Prompt ******  CREANDO TABLA PAIS ....

CREATE TABLE  PAIS 
   (
    CODPAIS 	NUMBER(2), 
    NOMPAIS	VARCHAR2(30) 
   );

ALTER TABLE PAIS 
      ADD CONSTRAINT PAIS_PK 
      PRIMARY KEY (CODPAIS);

Prompt ******  CREANDO TABLA PRODUCTO ....

CREATE TABLE  PRODUCTO 
   (
    CODPRODUCTO  	NUMBER(3), 
    DESCRIPCION   	VARCHAR2(40), 
    CODUNIDAD     	VARCHAR2(2), 
    CODCATEGORIA    	VARCHAR2(1), 
    VUNITARIO    		NUMBER(8), 
    VALORCOMPRAPESO    	NUMBER(8), 
    VALORCOMPRADOLAR   NUMBER(8,2), 
    TOTALSTOCK   	NUMBER (5),
    STKSEGURIDAD  	NUMBER (5),    
    PROCEDENCIA   	VARCHAR2(1),
    CODPAIS		NUMBER(2),
    CODPRODUCTO_REL	NUMBER(3)
   );

ALTER TABLE PRODUCTO 
      ADD CONSTRAINT COD_PROD_PK 
      PRIMARY KEY (CODPRODUCTO);

ALTER TABLE PRODUCTO 
      ADD CONSTRAINT COD_UNIDAD_FK 
      FOREIGN KEY (CODUNIDAD) REFERENCES UNIDAD_MEDIDA (CODUNIDAD);

ALTER TABLE PRODUCTO 
      ADD CONSTRAINT COD_PAIS_FK 
      FOREIGN KEY (CODPAIS) REFERENCES PAIS (CODPAIS);

ALTER TABLE PRODUCTO 
      ADD CONSTRAINT CODPRODUCTO_REL_FK 
      FOREIGN KEY (CODPRODUCTO_REL) REFERENCES PRODUCTO (CODPRODUCTO);



Prompt ******  CREANDO TABLA PROMOCION ....

CREATE TABLE  PROMOCION 
   (
    CODPROMOCION  	NUMBER (4), 
    DESCRI_PROM   	VARCHAR2(60), 
    FECHA_DESDE		DATE,
    FECHA_HASTA		DATE,
    CODPRODUCTO	    NUMBER(3), 
    PORC_DSCTO_PROD	NUMBER(4,2),
    CODPRODUCTO_REL NUMBER(3)
   );

ALTER TABLE PROMOCION 
      ADD CONSTRAINT CODPROMOCION_PK 
      PRIMARY KEY (CODPROMOCION);

ALTER TABLE PROMOCION 
      ADD CONSTRAINT CODPRODUCTO_FK 
      FOREIGN KEY (CODPRODUCTO) REFERENCES PRODUCTO (CODPRODUCTO);


Prompt ******  CREANDO TABLA FORMA_PAGO ....

CREATE TABLE  FORMA_PAGO 
   (
    CODPAGO 	NUMBER(2), 
    DESCRIPCION	VARCHAR2(30) 
   );

ALTER TABLE FORMA_PAGO 
      ADD CONSTRAINT CODPAGO_PK 
      PRIMARY KEY (CODPAGO);


Prompt ******  CREANDO TABLA BANCO ....

CREATE TABLE  BANCO 
   (
    CODBANCO 	NUMBER(2), 
    DESCRIPCION	VARCHAR2(30) 
   );

ALTER TABLE BANCO 
      ADD CONSTRAINT CODBANCO_PK 
      PRIMARY KEY (CODBANCO);



Prompt ******  CREANDO TABLA FACTURA ....

CREATE TABLE FACTURA
(
  NUMFACTURA  		NUMBER(7),
  RUTCLIENTE  		VARCHAR2(10),
  RUTVENDEDOR     	VARCHAR2(10),
  FECHA       		DATE,
  F_VENCIMIENTO	DATE,
  NETO        		NUMBER (7),	
  IVA         		NUMBER (7),
  TOTAL       		NUMBER (7),
  CODBANCO		NUMBER(2),
  CODPAGO		NUMBER(2),
  NUM_DOCTO_PAGO	VARCHAR2(30),
  ESTADO      		VARCHAR2(2)
);

ALTER TABLE FACTURA 
      ADD CONSTRAINT NUMFACTURA_PK 
      PRIMARY KEY (NUMFACTURA);

ALTER TABLE FACTURA 
      ADD CONSTRAINT RUTCLIENTE_FK 
      FOREIGN KEY (RUTCLIENTE) REFERENCES CLIENTE (RUTCLIENTE);

ALTER TABLE FACTURA 
      ADD CONSTRAINT RUTVENDEDOR_FK 
      FOREIGN KEY (RUTVENDEDOR) REFERENCES VENDEDOR (RUTVENDEDOR);

ALTER TABLE FACTURA 
      ADD CONSTRAINT CODPAGO_FK 
      FOREIGN KEY (CODPAGO) REFERENCES FORMA_PAGO (CODPAGO);

ALTER TABLE FACTURA 
      ADD CONSTRAINT CODBANCO_FK 
      FOREIGN KEY (CODBANCO) REFERENCES BANCO (CODBANCO);

ALTER TABLE FACTURA
      ADD CONSTRAINT ESTADO_FACTURA_CK
      CHECK (ESTADO IN ('EM', 'PA','NC') );


Prompt ******  CREANDO TABLA DETALLE_FACTURA ....

CREATE TABLE DETALLE_FACTURA 
   (
    NUMFACTURA 	NUMBER (7), 
    CODPRODUCTO 	NUMBER (3), 
    VUNITARIO    		NUMBER(8),  
    CODPROMOCION	NUMBER (4),
    DESCRI_PROM   	VARCHAR2(60), 
    DESCUENTO		NUMBER(8),
    CANTIDAD 		NUMBER (5), 
    TOTALLINEA 		NUMBER(8)
   );

ALTER TABLE DETALLE_FACTURA 
      ADD CONSTRAINT DET_FACT_PK 
      PRIMARY KEY (NUMFACTURA, CODPRODUCTO);

ALTER TABLE DETALLE_FACTURA 
      ADD CONSTRAINT COD_PROD_FK 
      FOREIGN KEY (CODPRODUCTO) REFERENCES PRODUCTO (CODPRODUCTO);


ALTER TABLE DETALLE_FACTURA 
      ADD CONSTRAINT NUM_FACT_FK 
      FOREIGN KEY (NUMFACTURA) REFERENCES FACTURA (NUMFACTURA);

ALTER TABLE DETALLE_FACTURA 
      ADD CONSTRAINT CODPROMOCION_FK 
      FOREIGN KEY (CODPROMOCION) REFERENCES PROMOCION (CODPROMOCION);



Prompt ******  CREANDO TABLA BOLETA ....

CREATE TABLE BOLETA
(
  NUMBOLETA  		NUMBER(7),
  RUTCLIENTE  		VARCHAR2(10),
  RUTVENDEDOR     	VARCHAR2(10),
  FECHA       		DATE,
  TOTAL       		NUMBER (7),
  CODPAGO		NUMBER(2),
  CODBANCO		NUMBER(2),
  NUM_DOCTO_PAGO	VARCHAR2(30),
  ESTADO      		VARCHAR2(2)
);

ALTER TABLE BOLETA 
      ADD CONSTRAINT NUMBOLETA_PK 
      PRIMARY KEY (NUMBOLETA);

ALTER TABLE BOLETA 
      ADD CONSTRAINT BOL_RUTCLIENTE_FK 
      FOREIGN KEY (RUTCLIENTE) REFERENCES CLIENTE (RUTCLIENTE);

ALTER TABLE BOLETA 
      ADD CONSTRAINT BOL_RUTVENDEDOR_FK 
      FOREIGN KEY (RUTVENDEDOR) REFERENCES VENDEDOR (RUTVENDEDOR);

     
ALTER TABLE BOLETA 
      ADD CONSTRAINT BOL_CODPAGO_FK 
      FOREIGN KEY (CODPAGO) REFERENCES FORMA_PAGO (CODPAGO);

ALTER TABLE BOLETA 
      ADD CONSTRAINT BOL_CODBANCO_FK 
      FOREIGN KEY (CODBANCO) REFERENCES BANCO (CODBANCO);

ALTER TABLE BOLETA
      ADD CONSTRAINT BOL_ESTADO_BOLETA_CK
      CHECK (ESTADO IN ('EM', 'PA','NC') );


Prompt ******  CREANDO TABLA DETALLE_BOLETA ....

CREATE TABLE DETALLE_BOLETA 
   (
    NUMBOLETA	 	NUMBER (7), 
    CODPRODUCTO 	NUMBER (3), 
    VUNITARIO    		NUMBER(8),  
    CODPROMOCION	NUMBER (4),
    DESCRI_PROM   	VARCHAR2(60), 
    DESCUENTO		NUMBER(8),
    CANTIDAD 		NUMBER (5), 
    TOTALLINEA 		NUMBER(8)
   );

ALTER TABLE DETALLE_BOLETA 
      ADD CONSTRAINT DET_BOLETA_PK 
      PRIMARY KEY (NUMBOLETA, CODPRODUCTO);

ALTER TABLE DETALLE_BOLETA 
      ADD CONSTRAINT DET_BOL_CODPRODUCTO_FK 
      FOREIGN KEY (CODPRODUCTO) REFERENCES PRODUCTO (CODPRODUCTO);

ALTER TABLE DETALLE_BOLETA 
      ADD CONSTRAINT DET_BOL_NUM_BOLETA_FK 
      FOREIGN KEY (NUMBOLETA) REFERENCES BOLETA (NUMBOLETA);

ALTER TABLE DETALLE_BOLETA 
      ADD CONSTRAINT DET_BOL_CODPROMOCION_FK 
      FOREIGN KEY (CODPROMOCION) REFERENCES PROMOCION (CODPROMOCION);


Prompt ******  CREANDO SECUENCIA SEQ_AUDIT ....

create sequence SEQ_AUDIT
minvalue 1
maxvalue 9999999999
increment by 1;

Prompt ******  CREANDO SECUENCIA SEQ_ERROR ....

create sequence SEQ_ERROR
minvalue 1
maxvalue 9999999999
increment by 1;



Prompt ******  CREANDO AUDITORIA_PRODUCTO ....

CREATE TABLE AUDITORIA_PRODUCTO
(
     ID_AUDIT NUMBER(6),
     CODPRODUCTO NUMBER(3),
     DESCRIPCION VARCHAR2(40),
     PROCEDENCIA VARCHAR2(1),
     VALOR_UNITARIO_ANT NUMBER(8,2),
     VALOR_UNITARIO_NVO NUMBER(8,2),
     FECHA_AUDIT DATE
);

Prompt ******  CREANDO DETALLE_VENTA_MES ....

CREATE TABLE DETALLE_VENTA_MES 
(
 TIPO_DOCTO         	VARCHAR2(3),
 NUMDOCUMENTO   	NUMBER(7),
 FECHA         		DATE,
 NOMCLIENTE 		VARCHAR2(30),
 NETO        		NUMBER(8,2),
 IVA        		NUMBER(8,2),
 TOTAL        		NUMBER(8,2)
);


Prompt ******  CREANDO TABLA RESUMEN_VENTA_MES ....

CREATE TABLE RESUMEN_VENTA_MES 
(
 MES_ANNO     		VARCHAR2(10),
 TIPO_DOCTO        	VARCHAR2(3),
 CANT_TOTAL_DOCTO	NUMBER(8),
 MONTO_NETO_TOTAL   	NUMBER(8),
 MONTO_IVA_TOTAL   	NUMBER(8),
 MONTO_TOTAL	    	NUMBER(8)
);


Prompt ******  CREANDO TABLA PAGO_VENDEDOR ....

CREATE TABLE PAGO_VENDEDOR 
(
 MES_ANNO   		VARCHAR2(10),
 RUTVENDEDOR    	VARCHAR2(10),
 NOMVENDEDOR    	VARCHAR2(30),
 SUELDO_BASE    		NUMBER(8),
 COMISION_MES  		NUMBER(8),
 COLACION       		NUMBER(8),
 MOVILIZACION   	NUMBER(8),
 PREVISION      		NUMBER(8),
 SALUD          		NUMBER(8),
 TOTAL_PAGAR    	NUMBER(8) 
);


Prompt ******  CREANDO TABLA PORCENTAJE_COMISION ....

CREATE TABLE PORCENTAJE_COMISION
(
 NRO_TRAMO		NUMBER(1) NOT NULL,
 SUELDO_BASE_INF	NUMBER(8) NOT NULL,
 SUELDO_BASE_SUP   	NUMBER(8) NOT NULL,
 PORC_COMISION		NUMBER(4,2) NOT NULL
 );

ALTER TABLE PORCENTAJE_COMISION 
      ADD CONSTRAINT PK_PORCENTAJE_COMISION 
      PRIMARY KEY (NRO_TRAMO);


Prompt ******  CREANDO TABLA ERROR_CALC ....

CREATE TABLE ERROR_CALC
(
 CORREL_ERROR      	NUMBER(5) NOT NULL,
 RUTINA_ERROR		VARCHAR2(80) NOT NULL,
 DESCRIP_ERROR		VARCHAR2(200) NOT NULL
 ); 

ALTER TABLE ERROR_CALC 
      ADD CONSTRAINT PK_ERROR_CALC 
      PRIMARY KEY (CORREL_ERROR);


Prompt ******  CREANDO TABLA DETALLE_VENTA_MES_VENDEDOR ....

CREATE TABLE DETALLE_VENTA_MES_VENDEDOR 
(
 FECHA         		  	    DATE,
 TIPO_DOCTO         		VARCHAR2(3),
 NUM_DOCTO          		NUMBER(7),
 TOTAL_DOCTO   		        NUMBER(8,2),
 RUTVENDEDOR   		        VARCHAR2(10),
 COMISION_VENDEDOR  		NUMBER(2,2),
 TOTAL_COMISION     		NUMBER(8,2)
);

Prompt ******  CREANDO TABLA VENDEDOR_CURSO ....

CREATE TABLE VENDEDOR_CURSO 
(
  RUTVENDEDOR VARCHAR2(10), 
  CODCURSO NUMBER(1),
  CANT_HORAS NUMBER(2),
  FECHA_DESDE DATE NULL,
  FECHA_HASTA DATE NULL,
  ESTADO_APROB VARCHAR2(2) DEFAULT 'PR'
);

VARIABLE fecha_desde DATE;
VARIABLE fecha_hasta DATE;



-- declaración crea una secuencia
CREATE SEQUENCE SEQ_CLIENTE
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE CLIENTE_GESTION
(
  ID_CLIENTE        NUMBER(6),
  RUTCLIENTE        VARCHAR2(10),
  NOMBRE            VARCHAR2(30),
  DIRECCION         VARCHAR2(95),
  CREDITO           NUMBER(8),
  SALDO             NUMBER(8),
  COMPORTAMIENTO_CLTE VARCHAR2(50),
  CONSTRAINT PK_CLIENTE_GESTION PRIMARY KEY (ID_CLIENTE)
);

-- ? sin testiar
CREATE OR REPLACE TRIGGER TRG_CLIENTE_GESTION
BEFORE INSERT ON CLIENTE_GESTION
FOR EACH ROW
BEGIN
  SELECT SEQ_CLIENTE.NEXTVAL INTO :NEW.ID_CLIENTE FROM DUAL;
END;
/

-- ? crea un TRIGGER para insertar el dato
CREATE OR REPLACE TRIGGER trg_actualizar_clasificacion
BEFORE INSERT OR UPDATE ON CLIENTE_GESTION
FOR EACH ROW
DECLARE
    diferencia NUMBER(8);
BEGIN
    diferencia := :NEW.CREDITO - :NEW.SALDO;

    IF diferencia <= 500000 THEN
        :NEW.COMPORTAMIENTO_CLTE := 'Cliente realiza muchas compras';
    ELSIF diferencia > 500000 AND diferencia <= 1000000 THEN
        :NEW.COMPORTAMIENTO_CLTE := 'Cliente Medio, respecto a compras';
    ELSE
        :NEW.COMPORTAMIENTO_CLTE := 'Cliente no compra, candidato a campaña marketing';
    END IF;
END;
/


insert into CLIENTE_GESTION values (NULL,'6245678-1','JUAN LOPEZ','ALAMEDA 6152',1000000,696550,NULL);
insert into CLIENTE_GESTION values (NULL,'7812354-2','MARIA SANTANDER','APOQUINDO 9093',1000000,819120, NULL);
insert into CLIENTE_GESTION values (NULL,'14456789-4','OSCAR LARA','ALAMEDA 960',1500000,0, NULL);
insert into CLIENTE_GESTION values (NULL,'11245678-5','MARCO ITURRA','ALAMEDA 1056',2500000,2000000, NULL);
insert into CLIENTE_GESTION values (NULL,'6467708-6','MARIBEL SOTO','VICU�A MACKENNA 4555',3000000,2332410, NULL);
insert into CLIENTE_GESTION values (NULL,'10125945-7','SABINA VERGARA','AV. LA FLORIDA 15554 ',1800000,1200000, NULL);
insert into CLIENTE_GESTION values (NULL,'8125781-8','PATRICIA FUENTES','IRARRAZABAL 5452',500000,1500000, NULL);
insert into CLIENTE_GESTION values (NULL,'13746912-9','ABRAHAM IGLESIAS','ALAMEDA 454',450000,500000, NULL);
insert into CLIENTE_GESTION values (NULL,'5446780-0','CARLOS MENDOZA','PANAMERICANA 152',100000,90000, NULL);
insert into CLIENTE_GESTION values (NULL,'10812874-0','LIDIA FUENZALIDA','PROVIDENCIA 4587 ',1900000, 7900000,NULL);
