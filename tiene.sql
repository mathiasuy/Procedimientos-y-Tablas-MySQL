-- use Pelqueria;

-- --------------------------------------
-- ----- VINCULAR SERVICIOS PRODUCTOS ---
-- --------------------------------------

DROP FUNCTION IF EXISTS agreagarProductoAServicio;
DELIMITER //
CREATE FUNCTION agreagarProductoAServicio(inservicioID INT, inproductoID INT) RETURNS INT
BEGIN
	IF EXISTS(SELECT * FROM Servicios WHERE servicioID = inservicioID) THEN
		IF EXISTS(SELECT * FROM Productos WHERE productoID = inproductoID) THEN
			IF EXISTS (SELECT * FROM ServiciosProductos WHERE servicioID = inservicioID AND productoID = inproductoID) THEN
				RETURN -1;
			ELSE
				INSERT INTO ServiciosProductos VALUES(inservicioID,inproductoID);
                RETURN 1;                
			END IF;
		ELSE
			RETURN -2;
        END IF;
	ELSE
		RETURN -3;
	END IF;
END//
DELIMITER ;


DROP FUNCTION IF EXISTS quitarProductoAServicio;
DELIMITER //
CREATE FUNCTION quitarProductoAServicio(inServicioID INT, inProductoID INT) RETURNS INT
BEGIN
	IF EXISTS (SELECT * FROM ServiciosProductos WHERE ProductoID = inProductoID AND ServicioID = inServicioID) THEN
		DELETE FROM ServiciosProductos WHERE ProductoID = inProductoID AND ServicioID = inServicioID;
		RETURN 1;
	ELSE
		RETURN -1;
	END IF;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS agregarDescuentoAServicio;
DELIMITER //
CREATE FUNCTION agregarDescuentoAServicio(inservicioID INT, indescuentoID INT) RETURNS INT
BEGIN
	IF EXISTS(SELECT * FROM Descuentos WHERE descuentoID = indescuentoID) THEN
		IF EXISTS(SELECT * FROM Servicios WHERE servicioID = inservicioID) THEN
			IF EXISTS (SELECT * FROM DescuentosServicios WHERE descuentoID = indescuentoID AND servicioID = inservicioID) THEN
				RETURN -1;
			ELSE
				INSERT INTO DescuentosServicios VALUES(indescuentoID,inservicioID);
                RETURN 1;                
			END IF;
		ELSE
			RETURN -2;
        END IF;
	ELSE
		RETURN -3;
	END IF;
END//
DELIMITER ;


DROP FUNCTION IF EXISTS quitarDescuentoAServicio;
DELIMITER //
CREATE FUNCTION quitarDescuentoAServicio(inservicioID INT, indescuentoID INT) RETURNS INT
BEGIN
	IF EXISTS (SELECT * FROM DescuentosServicios WHERE descuentoID = indescuentoID AND servicioID = inservicioID) THEN
		DELETE FROM DescuentosServicios WHERE descuentoID = indescuentoID AND servicioID = inservicioID;
		RETURN 1;
	ELSE
		RETURN -1;
	END IF;
END//
DELIMITER ;


DROP FUNCTION IF EXISTS agregarDescuentoAProducto;
DELIMITER //
CREATE FUNCTION agregarDescuentoAProducto(inproductoID INT, indescuentoID INT) RETURNS INT
BEGIN
	IF EXISTS(SELECT * FROM Descuentos WHERE descuentoID = indescuentoID AND habilitado = true) THEN
		IF EXISTS(SELECT * FROM Productos WHERE productoID = inproductoID) THEN
			IF EXISTS (SELECT * FROM DescuentosProductos WHERE descuentoID = indescuentoID AND productoID = inproductoID) THEN
				RETURN -1;
			ELSE
				INSERT INTO DescuentosProductos VALUES(indescuentoID,inproductoID);
                RETURN 1;                
			END IF;
		ELSE
			RETURN -2;
        END IF;
	ELSE
		RETURN -3;
	END IF;
END//
DELIMITER ;


DROP FUNCTION IF EXISTS quitarDescuentoAProducto;
DELIMITER //
CREATE FUNCTION quitarDescuentoAProducto(inproductoID INT, indescuentoID INT) RETURNS INT
BEGIN
	IF EXISTS (SELECT * FROM DescuentosProductos WHERE descuentoID = indescuentoID AND ProductoID = inProductoID) THEN
		DELETE FROM DescuentosProductos WHERE descuentoID = indescuentoID AND ProductoID = inProductoID;
		RETURN 1;
	ELSE
		RETURN -1;
	END IF;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS agregarServicioACita;
DELIMITER //
CREATE FUNCTION agregarServicioACita(incitaID  INT, inservicioID INT, indescuentoID INT) RETURNS INT
BEGIN
	DECLARE inprecio INT;
	IF EXISTS(SELECT * FROM Servicios WHERE servicioID = inservicioID) THEN
		IF EXISTS(SELECT * FROM Citas WHERE citaID = incitaID) THEN
			IF EXISTS (SELECT * FROM ServiciosCitas WHERE servicioID = inservicioID AND citaID = incitaID) THEN
				RETURN -1;
			ELSE
				SELECT precio INTO inprecio FROM Servicios WHERE servicioID = inservicioID;
				INSERT INTO ServiciosCitas VALUES(incitaID,indescuentoID,inprecio,inservicioID);
                RETURN 1;
			END IF;
		ELSE
			RETURN -2;
        END IF;
	ELSE
		RETURN -3;
	END IF;
END//
DELIMITER ;


DROP FUNCTION IF EXISTS agregarServicioACitaAutoDescuento; -- NO USAR
DELIMITER //
CREATE FUNCTION agregarServicioACitaAutoDescuento(incitaID  INT, inservicioID INT) RETURNS INT
BEGIN
	DECLARE inclienteID INT;
	DECLARE indescuentoID INT;
    DECLARE inprecio double;
    DECLARE induracion int;
	IF EXISTS(SELECT * FROM Servicios WHERE servicioID = inservicioID) THEN
		IF EXISTS(SELECT * FROM Citas WHERE citaID = incitaID) THEN
			IF EXISTS (SELECT * FROM ServiciosCitas WHERE servicioID = inservicioID AND citaID = incitaID) THEN
				RETURN -1;
			ELSE
				SELECT clienteID INTO inclienteID FROM Citas WHERE citaID = incitaID;
                SELECT precio INTO inprecio FROM Servicios WHERE servicioID = inservicioID;
                SELECT duracion INTO induracion FROM Servicios WHERE servicioID = inservicioID;
				IF tieneClienteConvenioEnServicio(inclienteID , inservicioID) THEN
					SELECT DescuentosServicios.descuentoID INTO indescuentoID
					 FROM Clientes inner join DescuentosServicios
					 on Clientes.descuentoID = DescuentosServicios.descuentoID
					 INNER JOIN Servicios on DescuentosServicios.servicioID = Servicios.servicioID 
                     INNER JOIN Descuentos on DescuentosServicios.descuentoID = Descuentos.descuentoID
					 WHERE Clientes.clienteID = inclienteID AND Servicios.servicioID = inservicioID
							AND Descuentos.es_por_convenio = 1 AND Descuentos.habilitado = 1;
				END IF;            
                IF EXISTS (SELECT * FROM Descuentos WHERE descuentoID = indescuentoID AND habilitado=true) THEN
					INSERT INTO ServiciosCitas VALUES(incitaID,indescuentoID, induracion,inprecio,inservicioID);
				ELSE
					INSERT INTO ServiciosCitas VALUES(incitaID,NULL,induracion,inprecio,inservicioID);
                END IF;
                RETURN 1;
			END IF;
		ELSE
			RETURN -2;
        END IF;
	ELSE
		RETURN -3;
	END IF;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS quitarServicioACita;
DELIMITER //
CREATE FUNCTION quitarServicioACita(incitaID INT, inservicioID INT) RETURNS INT
BEGIN
	IF EXISTS (SELECT * FROM ServiciosCitas WHERE servicioID = inservicioID AND citaID = incitaID) THEN
		DELETE FROM ServiciosCitas WHERE servicioID = inservicioID AND citaID = incitaID;
		RETURN 1;
	ELSE
		RETURN -1;
	END IF;
END//
DELIMITER ;


-- ------------------------------------------------
-- ------------------------------------------------
-- -------------------  filtro --------------------
-- ------------------------------------------------
-- ------------------------------------------------

DROP PROCEDURE IF EXISTS filtroMostrarDescuentosProductos;
DELIMITER //
CREATE PROCEDURE filtroMostrarDescuentosProductos(IN filtro VARCHAR(10))
BEGIN
		SELECT 
		 Descuentos.*,
		 Productos.productoID,
		 Proveedores.proveedorID,
	     Productos.nombre as NombreProducto,
	     Productos.marca,
	     Productos.precio as PrecioProducto,
	     Productos.descripcion as DescripcionProducto,
	     Proveedores.nombre as NombreProveedor,
	     Productos.stock
	     FROM (Productos inner join DescuentosProductos ON Productos.productoID = DescuentosProductos.productoID)
	     inner join Descuentos on DescuentosProductos.descuentoID = Descuentos.descuentoID inner join Proveedores
	     ON Productos.proveedorID = Proveedores.proveedorID where 
         Descuentos.nombre like filtro OR Productos.nombre like filtro OR Proveedores.nombre like filtro OR
         Descuentos.descripcion like filtro OR Productos.descripcion like filtro OR Proveedores.descripcion like filtro;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS filtroMostrarDescuentosServicios;
DELIMITER //
CREATE PROCEDURE filtroMostrarDescuentosServicios(IN filtro VARCHAR(10))
BEGIN
		SELECT 
		 Descuentos.*,
	     Servicios.*
	     FROM (Servicios inner join DescuentosServicios ON Servicios.ServicioID = DescuentosServicios.ServicioID)
	     inner join Descuentos on DescuentosServicios.descuentoID = Descuentos.descuentoID WHERE
         Descuentos.nombre like filtro OR Servicios.nombre like filtro OR
         Descuentos.descripcion like filtro OR Servicios.descripcion like filtro;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS filtroMostrarServiciosProductos;
DELIMITER //
CREATE PROCEDURE filtroMostrarServiciosProductos(IN filtro VARCHAR(10))
BEGIN
		SELECT 
         Servicios.servicioID,
         Productos.productoID,
		 Servicios.nombre as NombreServicio,
         Servicios.descripcion as DescripcionServicio,
         Servicios.precio as PrecioServicio,
         Servicios.duracion as DuracionServicio,
	     Productos.nombre as NombreProducto,
         Productos.descripcion as DescripcionProducto,
         Productos.precio as PrecioProducto,
		 Productos.proveedorID,
         Proveedores.nombre as NombreProveedor,
         Productos.stock
	     FROM (Servicios inner join ServiciosProductos ON Servicios.ServicioID = ServiciosProductos.ServicioID)
	     inner join Productos on ServiciosProductos.ProductoID = Productos.ProductoID 
         inner join Proveedores on Productos.proveedorID = Proveedores.proveedorID WHERE
         Productos.nombre like filtro OR Servicios.nombre like filtro OR
         Productos.descripcion like filtro OR Servicios.descripcion like filtro;
END//
DELIMITER ;


-- ------------------------------------------------
-- ------------------------------------------------
-- -------------  LISTAR  A X B  ------------------
-- ------------------------------------------------
-- ------------------------------------------------


DROP PROCEDURE IF EXISTS listarProductosXServicio;
DELIMITER //
CREATE PROCEDURE listarProductosXServicio(IN inservicioID INT)
BEGIN
		SELECT 
		 Servicios.servicioID,
		 Productos.*,
         Proveedores.nombre as NombreProveedor
	     FROM (Productos inner join ServiciosProductos ON Productos.productoID = ServiciosProductos.productoID)
	     inner join Servicios on ServiciosProductos.servicioID = Servicios.servicioID inner join Proveedores
	     ON Productos.proveedorID = Proveedores.proveedorID WHERE Servicios.servicioID=inservicioID;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS listarDescuentosXServicio;
DELIMITER //
CREATE PROCEDURE listarDescuentosXServicio(IN inservicioID INT, in inhabilitado BOOL, in ines_por_convenio BOOL)
BEGIN
		SELECT 
		 Servicios.servicioID,
		 Descuentos.*
	     FROM (Descuentos inner join DescuentosServicios ON Descuentos.descuentoID = DescuentosServicios.descuentoID)
	     inner join Servicios on DescuentosServicios.servicioID = Servicios.servicioID
         WHERE Servicios.servicioID = inservicioID AND Descuentos.habilitado = inhabilitado AND Descuentos.es_por_convenio = ines_por_convenio;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS listarDescuentosXProducto;
DELIMITER //
CREATE PROCEDURE listarDescuentosXProducto(IN inproductoID INT, in inhabilitado BOOL, in ines_por_convenio BOOL)
BEGIN
		SELECT 
		 Productos.productoID,
		 Descuentos.*
	     FROM (Descuentos inner join DescuentosProductos ON Descuentos.descuentoID = DescuentosProductos.descuentoID)
	     inner join Productos on DescuentosProductos.productoID = Productos.productoID
         WHERE Productos.productoID = inproductoID 
         AND Descuentos.habilitado = inhabilitado 
         AND Descuentos.es_por_convenio = ines_por_convenio;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS listarServiciosXCita;
DELIMITER //
CREATE PROCEDURE listarServiciosXCita(IN incitaID INT)
BEGIN
		SELECT 
		 Citas.citaID,
		 Servicios.nombre,
         Servicios.descripcion,
         Servicios.duracion,
         Servicios.precio
	     FROM (Servicios inner join ServiciosCitas ON Servicios.servicioID = ServiciosCitas.servicioID)
	     inner join Citas on ServiciosCitas.citaID = Citas.citaID
         WHERE Citas.citaID = incitaID;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS obtenerNombrePersona;
DELIMITER //
CREATE FUNCTION obtenerNombrePersona(inpersonaID INT) RETURNS VARCHAR(15)
BEGIN
	DECLARE innombre VARCHAR(15);
    SELECT nombre INTO innombre FROM Personas WHERE personaID = inpersonaID;
	RETURN innombre;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS listarCitasEntre;
DELIMITER //
CREATE PROCEDURE listarCitasEntre(IN fecha_inicio DATETIME, IN fecha_fin DATETIME)
BEGIN
SELECT fecha_inicio, fecha_fin;
	SELECT obtenerNombrePersona(Citas.clienteID) as Cliente, obtenerNombrePersona(Citas.empleadoID) as Empleado, 
	Citas.*
	FROM Citas inner join Clientes on Clientes.clienteID = Citas.clienteID
	INNER JOIN Empleados on Empleados.empleadoID = Citas.citaID
    WHERE fecha_de_cita BETWEEN fecha_inicio AND fecha_fin;
END//
DELIMITER ;

-- SELECT * FROM Citas;
DROP PROCEDURE IF EXISTS listarCitasDeldia;
DELIMITER //
CREATE PROCEDURE listarCitasDeldia(IN fecha DATE)
BEGIN
	call listarCitasEntre(Date(fecha),Date(DATE_ADD(fecha,INTERVAL 1 DAY)));
END//
DELIMITER ;

-- ----------------------------------------------
-- ----------------------------------------------
-- ----------------- Utilidades -----------------
-- ----------------------------------------------
-- ----------------------------------------------
-- ----------------------------------------------


DROP FUNCTION IF EXISTS tieneClienteConvenioEnProducto;
DELIMITER //
CREATE FUNCTION tieneClienteConvenioEnProducto(inclienteID INT, inproductoID INT) RETURNS BOOL
BEGIN
		return EXISTS(SELECT *
	     FROM Clientes inner join DescuentosProductos
         on Clientes.descuentoID = DescuentosProductos.descuentoID
         INNER JOIN Productos on DescuentosProductos.productoID = Productos.productoID 
         INNER JOIN Descuentos on Descuentos.descuentoID = DescuentosProductos.descuentoID
         WHERE Clientes.clienteID = inclienteID AND Productos.productoID = inproductoID
         AND Descuentos.habilitado = 1 AND Descuentos.es_por_convenio = 1);
END//
DELIMITER ;


DROP FUNCTION IF EXISTS tieneClienteConvenioEnServicio;
DELIMITER //
CREATE FUNCTION tieneClienteConvenioEnServicio(inclienteID INT, inservicioID INT) RETURNS BOOL
BEGIN
		return EXISTS(SELECT *
	     FROM Clientes inner join DescuentosServicios
         on Clientes.descuentoID = DescuentosServicios.descuentoID
         INNER JOIN Servicios on DescuentosServicios.servicioID = Servicios.servicioID 
         INNER JOIN Descuentos on Descuentos.descuentoID = DescuentosServicios.descuentoID
         WHERE Clientes.clienteID = inclienteID AND Servicios.servicioID = inservicioID
         AND Descuentos.habilitado = 1 AND Descuentos.es_por_convenio = 1);
END//
DELIMITER ;
