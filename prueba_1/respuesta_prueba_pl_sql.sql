-- ? para imprimir en consola
SET SERVEROUTPUT ON;
-- ? secuencia para genera rel id 
CREATE SEQUENCE seq_id_pago;
START WITH 1
INCREMENT BY 1;

DECLARE
    v_id_credito NUMBER;
    v_tipo_credito VARCHAR2(20);
    v_tipo_credito_pipo VARCHAR2(100);
    v_tipo_credito_number NUMBER; -- DEFINO EL VALOR YA QUE LA CADENA DE TEXTO NO FUNCIONA 
    v_monto_credito NUMBER;
    v_cantidad_cuotas NUMBER;
    v_fecha_inicio DATE;
    v_valor_uf NUMBER := 27500;
    v_interes_empresa NUMBER := 0.05; -- Se asigna el valor de la tasa de interés para empresas
    v_interes_diario NUMBER := 0.0005; -- Se asigna el valor del interés diario
    v_cobranza_diario NUMBER := 0.001; -- Se asigna el valor de la cobranza diaria
    v_valor_peso_empresa NUMBER := 10000; -- Se asigna el valor del peso para empresas
    v_monto_cuota NUMBER;
    v_fecha_vencimiento DATE;
    v_fecha_pago DATE; -- Variable para almacenar la fecha de pago
    v_id_cliente NUMBER;
    v_rut_cliente VARCHAR2(12);
    v_nombre_cliente VARCHAR2(200);
    v_tipo_cliente VARCHAR2(20);
    v_monto_creditos NUMBER;
    v_monto_pesos NUMBER;
    v_cobranza_dia NUMBER(10, 2); -- Variable para almacenar el valor de cobranza diario
    v_interes_diario_pago NUMBER(10, 2); -- Variable para almacenar el interés diario
    v_cobranza_diaria_pago NUMBER(10, 2); -- Variable para almacenar la cobranza diaria
BEGIN
    FOR credito_rec IN (SELECT * FROM CREDITO) LOOP
        -- Obtener detalles del crédito actual en el bucle
        v_id_credito := credito_rec.ID_CREDITO;
        v_monto_credito := credito_rec.MONTO;
        v_cantidad_cuotas := credito_rec.CANTIDAD_CUOTAS;
        v_fecha_inicio := credito_rec.FECHA_INICIO;

        -- Obtener tipo de cliente, nombre y rut etc
        SELECT CLIENTE.ID_CLIENTE, CLIENTE.RUT, CLIENTE.NOMBRE, TIPO_CLIENTE.TIPO_CLIENTE, TIPO_CREDITO.TIPO_CREDITO
        INTO v_id_cliente, v_rut_cliente, v_nombre_cliente, v_tipo_cliente, v_tipo_credito_pipo
        FROM CLIENTE
        JOIN CONTRATO ON CLIENTE.ID_CLIENTE = CONTRATO.ID_CLIENTE
        JOIN CREDITO  ON CONTRATO.ID_CONTRATO = CREDITO.ID_CONTRATO
        JOIN TIPO_CREDITO ON TIPO_CREDITO.COD_TIPO_CREDITO = CREDITO.COD_TIPO_CREDITO
        JOIN TIPO_CLIENTE ON CLIENTE.COD_TIPO_CLIENTE = TIPO_CLIENTE.COD_TIPO_CLIENTE
        WHERE CREDITO.ID_CREDITO = v_id_credito;
       
        -- Realizar cálculos de la cuota
        IF v_tipo_credito = 'HIPOTECARIO' THEN
            -- ? (1 + v_interes_empresa): Esto representa la suma de 1 
            -- ? (que es el monto original del crédito) más el interés de la empresa, 
            -- ? que se está expresando como un valor decimal (por ejemplo, 0.05 para un 5%).
            -- TODO : power
            v_monto_cuota := ROUND((v_monto_credito * (1 + v_interes_empresa) ** v_cantidad_cuotas) / v_cantidad_cuotas, 2);
        ELSE
            v_monto_cuota := ROUND((v_monto_credito / v_cantidad_cuotas) * (1 + v_interes_empresa), 2);
        END IF;
        
        -- Calcular la fecha de vencimiento de la primera cuota (un mes después de la fecha de inicio)
        v_fecha_vencimiento := ADD_MONTHS(v_fecha_inicio, 1);
        
        -- Insertar las cuotas en la tabla PAGO_CREDITO
        FOR i IN 1..v_cantidad_cuotas LOOP
            -- Calcular la fecha de pago (asumo que se registra en la misma fecha de vencimiento)
            v_fecha_pago := v_fecha_vencimiento; 

            -- Calcular el interés diario
            IF v_tipo_credito = 'HIPOTECARIO' THEN
                v_interes_diario_pago := ROUND((v_monto_credito * v_interes_diario / v_cantidad_cuotas), 2);
            ELSE
                v_interes_diario_pago := ROUND((v_monto_credito * v_interes_diario / v_cantidad_cuotas), 2);
            END IF;

            -- Calcular la cobranza diaria
            v_cobranza_diaria_pago := ROUND((v_monto_cuota * v_cobranza_diario), 2);
            
            -- Insertar la cuota en la tabla PAGO_CREDITO
            INSERT INTO PAGO_CREDITO (ID_PAGO, FECHA_VENCIMIENTO, NRO_CUOTA, FECHA_PAGO, MONTO, ID_CREDITO, RUT_CLIENTE, TIPO_CREDITO, COBRANZA_DIA, INTERES_DIA, NOMBRE_CLIENTE, TIPO_CLIENTE)
            VALUES (seq_id_pago.NEXTVAL, v_fecha_vencimiento, i, v_fecha_pago, v_monto_cuota, v_id_credito, v_rut_cliente, v_tipo_credito_pipo, v_cobranza_diaria_pago, v_interes_diario_pago, v_nombre_cliente, v_tipo_cliente);
            
            -- Incrementar la fecha de vencimiento para la siguiente cuota (un mes después)
            v_fecha_vencimiento := ADD_MONTHS(v_fecha_vencimiento, 1);
        END LOOP;
        
        -- Calcular monto de pesos acumulados por cliente
        IF v_tipo_cliente = 'EMPRESA' THEN
            -- v_monto_pesos := v_cantidad_cuotas * v_valor_peso_empresa;
            v_monto_total := v_monto_credito * POWER((1 + v_tasa_interes), v_cantidad_cuotas);
        ELSE
            v_monto_pesos := (v_monto_credito / 100000) * v_valor_peso_empresa;
        END IF;
                
        -- Insertar pesos acumulados en la tabla CLIENTE_PESOS
        INSERT INTO CLIENTE_PESOS (ID_CLIENTE, RUT_CLIENTE, NOMBRE, TIPO_CLIENTE, MONTO_CREDITOS, MONTO_PESOS)
        VALUES (v_id_cliente, v_rut_cliente, v_nombre_cliente, v_tipo_cliente, v_monto_credito, v_monto_pesos);
    END LOOP;
    
    COMMIT; -- Confirmar la transacción
END;
