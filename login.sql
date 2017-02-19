
-- ---------------------------------
-- --------- LOGIN -----------------
-- ---------------------------------

DROP FUNCTION if exists tipoPersona;
DELIMITER //
CREATE FUNCTION tipoPersona (inusuario VARCHAR(10)) RETURNS INT
BEGIN
	IF EXISTS (SELECT * FROM Personas inner join Clientes on Personas.personaID = Clientes.clienteID WHERE usuario=LCASE(inusuario)) THEN
		RETURN 1;
	ELSE
		IF EXISTS (SELECT * FROM Personas inner join Empleados on Personas.personaID = Empleados.empleadoID WHERE usuario=LCASE(inusuario)) THEN
			RETURN 2;
		ELSE
			RETURN -1;
        END IF;
    END IF;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS Login;
DELIMITER //
CREATE PROCEDURE Login(IN inusuario VARCHAR(10), IN incontrasena VARCHAR(10), OUT  tipo INT)
BEGIN
	DECLARE inpersonaID INT DEFAULT NULL;
    SET tipo = tipoPersona(inusuario);
    
    SELECT personaID INTO inpersonaID FROM Personas WHERE usuario=inusuario;
	CASE
		WHEN tipo=1 THEN SELECT * FROM Personas inner join Clientes on Personas.personaID = Clientes.clienteID WHERE usuario=LCASE(inusuario) AND contrasena=incontrasena;
		WHEN tipo=2 THEN SELECT * FROM Personas inner join Empleados on Personas.personaID = Empleados.empleadoID WHERE usuario=LCASE(inusuario) AND contrasena=incontrasena;
	END CASE;
END//
DELIMITER ;
