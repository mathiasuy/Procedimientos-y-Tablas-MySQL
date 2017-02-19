
-- ---------------------------------
-- PROCEDIMIENTOS PARA EMPLEADOS --
-- ---------------------------------

DROP PROCEDURE IF EXISTS AltaEmpleado; 
DELIMITER //
CREATE PROCEDURE AltaEmpleado 
(IN innombre VARCHAR(30),
IN indocumento VARCHAR(15),
IN infecha_de_nacimiento DATE,
IN incomentarios VARCHAR(100),
IN intelefono VARCHAR(15),
IN inusuario VARCHAR(10),
IN incontrasena VARCHAR(10),
IN inhabilitado BOOL,
IN invencimiento_carnet_de_salud DATE, 
IN insueldo DOUBLE,
OUT exito INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		SET exito = -1; -- es el error si falla y se dejo sin cambios
		ROLLBACK;
	END;
    START TRANSACTION;
       IF EXISTS (SELECT * FROM Personas WHERE documento = indocumento) THEN
			SET exito = -4; -- ya existe el documento
			ROLLBACK;
		ELSE
			IF EXISTS (SELECT * FROM Personas WHERE usuario = inusuario) THEN
				SET exito = -5; -- ya existe el usuario
				ROLLBACK;
			ELSE
				INSERT INTO Personas
					(nombre,  documento, fecha_de_nacimiento, comentarios, telefono, usuario, contrasena, habilitado)
					VALUES (innombre,  indocumento, infecha_de_nacimiento,incomentarios, intelefono, inusuario, incontrasena, inhabilitado); 
				INSERT INTO Empleados 
					(empleadoID, vencimiento_carnet_de_salud,sueldo)
					VALUES (@@identity, invencimiento_carnet_de_salud,insueldo);
					SET exito = @@identity;
			END IF;
		END IF;
    COMMIT;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS BajaEmpleado; 
DELIMITER //
CREATE PROCEDURE BajaEmpleado (IN indocumento VARCHAR(15), OUT exito INT)
BEGIN
	DECLARE id VARCHAR(10) DEFAULT NULL;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		SET exito = -1; -- es el error si falla y se dejo sin cambios
		ROLLBACK;
	END;
    START TRANSACTION;
		IF EXISTS (SELECT empleadoID 
		FROM Personas INNER JOIN Empleados on Personas.personaID = Empleados.empleadoID
		WHERE documento = indocumento) THEN
			SELECT empleadoID INTO id
			FROM Personas INNER JOIN Empleados on Personas.personaID = Empleados.empleadoID
			WHERE documento = indocumento;
			DELETE FROM Personas WHERE personaID = id;
			DELETE FROM Empleados WHERE empleadoID = id;
            SET exito = 1;
		ELSE
			SET exito = -2;
			ROLLBACK;
		END IF;
    COMMIT;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS ModificarEmpleado; 
DELIMITER //
CREATE PROCEDURE ModificarEmpleado
(IN inpersonaID INT, 
IN innombre VARCHAR(30),
IN indocumento VARCHAR(15),
IN infecha_de_nacimiento DATE,
IN incomentarios VARCHAR(100),
IN intelefono VARCHAR(15),
IN inusuario VARCHAR(10),
IN incontrasena VARCHAR(10),
IN inhabilitado BOOL,
IN invencimiento_carnet_de_salud DATE,
IN insueldo DOUBLE,
OUT exito INT)
BEGIN
	DECLARE cu INT DEFAULT 0;
    DECLARE cd INT DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		SET exito = -1; -- es el error si falla y se dejo sin cambios
		ROLLBACK;
	END;
    
    START TRANSACTION;
		IF EXISTS (SELECT EmpleadoID 
			FROM Personas INNER JOIN Empleados on Personas.personaID = Empleados.EmpleadoID
			WHERE personaID = inpersonaID) THEN
			SELECT COUNT(*) INTO cu FROM Personas WHERE usuario=inusuario AND NOT personaID = inpersonaID;
			SELECT COUNT(*) INTO cd FROM Personas WHERE documento = indocumento AND NOT personaID = inpersonaID; 
			IF cu <> 0 THEN -- ya existe el usuario
				SET exito = -6;
				ROLLBACK;
			ELSE
				IF cd <> 0 THEN -- ya existe el documento
					SET exito = -7;
					ROLLBACK;
				ELSE
					UPDATE Empleados SET vencimiento_carnet_de_salud=invencimiento_carnet_de_salud, sueldo=insueldo 
					WHERE EmpleadoID = inpersonaID;
					UPDATE Personas SET 
					nombre=innombre, fecha_de_nacimiento=infecha_de_nacimiento,
					comentarios=incomentarios, telefono=intelefono, documento=indocumento, usuario=inusuario, contrasena=incontrasena, habilitado=inhabilitado
					WHERE personaID = inpersonaID;
                    SET exito = 1;
				END IF;
			END IF;
		ELSE
			SET exito = -4;
			ROLLBACK;
		END IF;
    COMMIT;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS ListarEmpleados;
DELIMITER //
CREATE PROCEDURE ListarEmpleados()
BEGIN
	SELECT Personas.*, Empleados.vencimiento_carnet_de_salud, Empleados.sueldo
    FROM Personas RIGHT JOIN Empleados on Personas.personaID = Empleados.empleadoID;
END//
DELIMITER ;
