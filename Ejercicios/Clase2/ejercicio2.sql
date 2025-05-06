USE jardineria;

DROP PROCEDURE IF EXISTS aumentar_credito_clientes;

DELIMITER //

CREATE PROCEDURE aumentar_credito_clientes()
    BEGIN
        DECLARE v_fin BOOLEAN DEFAULT FALSE;
        DECLARE v_codigo_cliente INT;
        DECLARE v_pais VARCHAR(50);
        DECLARE v_limite_credito DECIMAL(15,2);

        DECLARE c_clientes CURSOR FOR 
            SELECT codigo_cliente, pais, limite_credito FROM cliente;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;

        OPEN c_clientes;

        bucle: LOOP
            FETCH c_clientes INTO v_codigo_cliente, v_pais, v_limite_credito;
            IF v_fin THEN 
                LEAVE bucle;
            END IF;

            IF v_pais = 'España' THEN
                SET v_limite_credito = v_limite_credito * 1.08;
            ELSEIF v_pais = 'USA' THEN
                SET v_limite_credito = v_limite_credito * 1.08;
            ELSE
                SET v_limite_credito = v_limite_credito * 1.05;
            END IF;

            UPDATE cliente 
            SET limite_credito = v_limite_credito
            WHERE codigo_cliente = v_codigo_cliente;
        END LOOP;

        CLOSE c_clientes;
    END;
    //