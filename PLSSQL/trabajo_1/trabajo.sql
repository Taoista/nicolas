DECLARE
    v_valor_uf NUMBER; 
    v_monto_total NUMBER;
    v_cantidad_cuotas NUMBER;
    v_fecha_inicio DATE;
    v_tasa_interes NUMBER;
    v_monto_cuota NUMBER;
    v_fecha_vencimiento DATE;
BEGIN
    v_valor_uf := 45000;
    -- Cursor para recorrer todos los registros de la tabla CREDITO
    FOR credito_rec IN (SELECT * FROM CREDITO) LOOP
        -- Recuperar los detalles del crédito actual desde el cursor
        v_monto_total := credito_rec.MONTO;
        v_cantidad_cuotas := credito_rec.CANTIDAD_CUOTAS;
        v_fecha_inicio := credito_rec.FECHA_INICIO;
        v_tasa_interes := credito_rec.TASA_INTERES;

        -- Calcular el monto de cada cuota
        v_monto_cuota := ROUND((v_monto_total * v_tasa_interes) / v_cantidad_cuotas);

        -- Calcular la fecha de vencimiento de cada cuota mensualmente a 
        -- partir de la fecha de inicio del crédito
        FOR i IN 1..v_cantidad_cuotas LOOP
            v_fecha_vencimiento := ADD_MONTHS(v_fecha_inicio, i);
            -- Insertar los valores calculados en la tabla PAGO_CREDITO
            INSERT INTO PAGO_CREDITO (ID_CREDITO, MONTO_PAGO, FECHA_VENCIMIENTO)
            VALUES (credito_rec.ID_CREDITO, v_monto_cuota, v_fecha_vencimiento);
        END LOOP;
    END LOOP;

    -- Confirmar la transacción
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejar cualquier error que pueda ocurrir
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Revertir la transacción en caso de error
END;