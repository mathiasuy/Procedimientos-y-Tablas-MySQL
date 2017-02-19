DROP DATABASE IF EXISTS Peluqueria;
create database Peluqueria;

use Peluqueria;

CREATE TABLE Proveedores(
	proveedorID 	INT PRIMARY KEY AUTO_INCREMENT,
	nombre 			VARCHAR(30),
	descripcion 	VARCHAR(100),
	direccion 		VARCHAR(30),
    habilitado		BOOL
);

CREATE TABLE TelefonosProveedores (
	id 				INT PRIMARY KEY AUTO_INCREMENT,
	proveedorID 	INT,
	nombre 			VARCHAR(30),
	telefono 		VARCHAR(15) UNIQUE,
	FOREIGN KEY (proveedorID) REFERENCES Proveedores(proveedorID)  on delete no action on update no action 
);	

CREATE TABLE Descuentos(
	descuentoID 	INT PRIMARY KEY AUTO_INCREMENT,
	nombre 			VARCHAR(30) UNIQUE,
	es_por_convenio BOOL,
	descripcion 	VARCHAR(100),
	porcentaje 		DOUBLE,
	dias 			VARCHAR(7),
	fecha_de_expiracion DATE,
    habilitado		BOOL
);

CREATE TABLE Servicios(
	servicioID 		INT PRIMARY KEY AUTO_INCREMENT,
	nombre 			VARCHAR(30) UNIQUE,
	duracion 		INT,
	descripcion 	VARCHAR(100),
    precio 			DOUBLE,
    habilitado		BOOL
	);

CREATE TABLE Productos(
	productoID 		INT PRIMARY KEY AUTO_INCREMENT,
	nombre 			VARCHAR(30),
	marca 			VARCHAR(30),
	precio 			DOUBLE,
	descripcion 	VARCHAR(100),
	proveedorID 	INT,
	stock 			INT,
    habilitado		BOOL,
	FOREIGN KEY (proveedorID) 	REFERENCES Proveedores(proveedorID)
);

CREATE TABLE ServiciosProductos(
	servicioID INT,
    productoID INT,
	FOREIGN KEY (productoID ) 	REFERENCES Productos(productoID),
	FOREIGN KEY (servicioID ) 	REFERENCES Servicios(servicioID)
);

CREATE TABLE DescuentosServicios(
	servicioID 		INT,
	descuentoID 	INT,
	FOREIGN KEY (descuentoID ) 	REFERENCES Descuentos(descuentoID),
	FOREIGN KEY (servicioID ) 	REFERENCES Servicios(servicioID)
);

CREATE TABLE DescuentosProductos(
	productoID 		INT,
	descuentoID 	INT,
	FOREIGN KEY (descuentoID ) 	REFERENCES Descuentos(descuentoID),
	FOREIGN KEY (productoID ) 	REFERENCES Productos(productoID)
);

CREATE TABLE Personas(
	personaID 		INT PRIMARY KEY AUTO_INCREMENT,
	nombre 			VARCHAR(30),
	documento 		VARCHAR (15) unique,
	fecha_de_nacimiento DATE,
	fecha_registrado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    comentarios 	VARCHAR(100),
    telefono		VARCHAR(15),
    usuario			VARCHAR(10) unique,
    contrasena		VARCHAR(10),
	habilitado		BOOL    
);

CREATE TABLE Empleados (
	empleadoID 		INT PRIMARY KEY,
    vencimiento_carnet_de_salud DATE,
    sueldo 			DOUBLE,
	FOREIGN KEY (empleadoID) 	REFERENCES Personas(personaID) on delete cascade on update cascade
);

CREATE TABLE Clientes(
	clienteID 		INT PRIMARY KEY,
    descuentoID 	INT,
	FOREIGN KEY (clienteID) 	REFERENCES Personas(personaID)  on delete cascade on update cascade,
	FOREIGN KEY (descuentoID) 	REFERENCES Descuentos(descuentoID) on delete NO ACTION on update NO ACTION
);

CREATE TABLE Cuponeras(
	cuponeraID 		INT PRIMARY KEY AUTO_INCREMENT,
	clienteID 		INT,
	descuento 		DOUBLE,
	fecha_de_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_de_vencimiento DATE,
	FOREIGN KEY (clienteID) 	REFERENCES Clientes(clienteID)
);

CREATE TABLE Cupon(
    cuponID INT PRIMARY KEY AUTO_INCREMENT,
	cuponeraID 		INT, 
	servicioID 		INT,
	fecha_concretado DATE,
	FOREIGN KEY (cuponeraID) 	REFERENCES Cuponeras(cuponeraID),	
	FOREIGN KEY (servicioID) 	REFERENCES Servicios(servicioID)
);

CREATE TABLE Citas(
	citaID 		INT PRIMARY KEY AUTO_INCREMENT,
	clienteID 	INT,
	empleadoID 	INT,
	descripcion VARCHAR(100),
	fecha_registrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_de_cita DATETIME,
	concretada 	BOOL,
	FOREIGN KEY (clienteID) 	REFERENCES Clientes(clienteID),
	FOREIGN KEY (empleadoID) 	REFERENCES Empleados(empleadoID)
);

CREATE TABLE ServiciosCitas(
    itemID INT PRIMARY KEY AUTO_INCREMENT,
	citaID INT,
	descuentoID INT,    
    duracion	INT,
	precio 		DOUBLE,    
    servicioID INT,
	FOREIGN KEY (descuentoID) 	REFERENCES Descuentos(descuentoID),
	FOREIGN KEY (citaID) 		REFERENCES Citas(citaID),
	FOREIGN KEY (servicioID) 	REFERENCES Servicios(servicioID)    
);