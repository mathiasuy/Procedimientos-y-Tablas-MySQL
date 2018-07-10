use master;
 
go
 
if exists (select * from SysDataBases where Name = 'eFacturaDGI')
begin
    drop database eFacturaDGI;
end
 
go
 
create database eFacturaDGI
 
go
 
use eFacturaDGI;
 
 go

create Table FormasDePagoType(
	id int  primary key,
	nombre varchar(20),
	habilitado bit
);

go

INSERT INTO FormasDePagoType
VALUES (1,'contado',1);
INSERT INTO FormasDePagoType
VALUES (2,'credito',1);

go

create table ViaTransp(
	id int  primary key,
	nombre varchar(50),
	habilitado bit
	)
	
go

insert into ViaTransp values(1,'Marítimo',1);
insert into ViaTransp values(2,'Aéreo',1);
insert into ViaTransp values(3,'Terrestre',1);
insert into ViaTransp values(9,'Otro',1);

go

create table TipoTraslado(
	id int  primary key,
	nombre varchar(50),
	habilitado bit
	)
	
go

insert into TipoTraslado values(1,'Venta',1);
insert into TipoTraslado values(2,'Traslados internos',1);


create table UnidadDeMedida(
	id int  primary key identity,
	nombre varchar(50),
	habilitado bit
	)
	
go
insert into UnidadDeMedida values('Unidad',1);
insert into UnidadDeMedida values('KG',1);
insert into UnidadDeMedida values('CM',1);
insert into UnidadDeMedida values('Km',1);
insert into UnidadDeMedida values('L',1);
insert into UnidadDeMedida values('Viajes',1);

create table IVAType(
	id int  primary key ,
	nombre varchar(50),
	valor money
	)
	
go


INSERT INTO IVAType
VALUES (10,'Mínimo',10);
INSERT INTO IVAType
VALUES (22,'Básico',22);


go

create Table IndicadorFacturaType(
	id int  primary key,
	nombre varchar(max),
	habilitado bit
);

go

INSERT INTO IndicadorFacturaType
VALUES (1,'Exento de IVA',1);
INSERT INTO IndicadorFacturaType
VALUES (2,'Gravado a Tasa Mínima ',1);
INSERT INTO IndicadorFacturaType
VALUES (3,'Gravado a Tasa Basica ',1);
INSERT INTO IndicadorFacturaType
VALUES (4,'Gravado a "Otra Tasa"',1);
INSERT INTO IndicadorFacturaType
VALUES (5,'Entrega Gratuita. Por ejemplo docenas de trece',1);
INSERT INTO IndicadorFacturaType
VALUES (6,'Producto o servicio no facturable ',1);
INSERT INTO IndicadorFacturaType
VALUES (7,'Producto o servicio no facturable negativo',1);
INSERT INTO IndicadorFacturaType
VALUES (8,'Sólo para remitos: Ítem a rebajar en remitos. En area de referencia se debe indicar el Nro de remito que ajusta ',1);
INSERT INTO IndicadorFacturaType
VALUES (9,'Sólo para resguardos: Ítem a ajustar en resguardos. En area de referencia se debe indicar el Nro de remito que ajusta',1);
INSERT INTO IndicadorFacturaType
VALUES (10,'Exportación y asimiladas ',1);
INSERT INTO IndicadorFacturaType
VALUES (11,'Impuesto percibido ',1);
INSERT INTO IndicadorFacturaType
VALUES (12,'IVA en suspenso',1);

go



 create table ModVentaType(
	id int  primary key,
	Nombre varchar(max),
	habilitado bit
	)

go

INSERT INTO ModVentaType
VALUES (1,'Régimen General',1);
INSERT INTO ModVentaType
VALUES (2,'Consignación',1);
INSERT INTO ModVentaType
VALUES (3,'Precio Revisable',1);
INSERT INTO ModVentaType
VALUES (4,'Bienes propios a exclaves aduaneros',1);
INSERT INTO ModVentaType
VALUES (90,'Otras transacciones',1);

go

create Table TipoMoneda(
	id varchar(4)  primary key not null, 
	nombre varchar(20),
	cambio money,
	simbolo varchar(4),
	nacional bit,
	habilitado bit
); 

go

INSERT INTO TipoMoneda
VALUES ('UY','Peso Uruguayo',1,'$U',1,1);
INSERT INTO TipoMoneda
VALUES ('AR','Peso Argentino',3,'$A',0,1);
INSERT INTO TipoMoneda
VALUES ('RE','Real',11,'$R',0,1);
INSERT INTO TipoMoneda
VALUES ('USD','Dolar EEUU',22,'U$D',0,1);

go

 create table ProductoServicio(
	id varchar(10)  primary key,
	Nombre varchar(20),
	Precio money,
	IdMoneda varchar(4) not null,
	Comentario varchar(50),
	Stock int,
	UnidadDeMedida int,
	foreign key (IdMoneda) references TipoMoneda (id),
	foreign key (UnidadDeMedida) references UnidadDeMedida (id)
	);
	
go

INSERT INTO ProductoServicio
VALUES ('1ZAP','Zapatos',1500,'UY','Zapatos Adidas',100,1);
INSERT INTO ProductoServicio
VALUES ('4AGU','Agua',6,'UY','Zapatos Adidas',100,5);
INSERT INTO ProductoServicio
VALUES ('2TEL','Teléfono',20,'RE','Teléfono fijo Panasonic',0,1);
INSERT INTO ProductoServicio
VALUES ('3VIA','Viaje',300,'USD','Florianópolis 2 dias 1 noche',-1,6);

go

create Table CodRetType(
	id varchar(20) primary key,
	tasa decimal
); 

go

INSERT INTO CodRetType
VALUES ('2183165',50);
INSERT INTO CodRetType
VALUES ('A2183114',22);
INSERT INTO CodRetType
VALUES ('2183161',5);
INSERT INTO CodRetType
VALUES ('1146171',10.5);

go

create table TipoCFEType(
	Id int primary key,
	Nombre varchar(max),
	IdNombre varchar(10)
	)

go

INSERT INTO TipoCFEType
VALUES (101,'e-Tckt','eTkt');
INSERT INTO TipoCFEType
VALUES (102,'e-Tckt Nota Crédito','eTkt');
INSERT INTO TipoCFEType
VALUES (103,'e-Tckt Nota Débito','eTkt');
INSERT INTO TipoCFEType
VALUES (201,'e-Tckt Cont','eTkt');
INSERT INTO TipoCFEType
VALUES (111,'e-Factura','eFact');
INSERT INTO TipoCFEType
VALUES (112,'e-Factura Nota Crédito','eFact');
INSERT INTO TipoCFEType
VALUES (113,'e-Nota Débito','eFact');
INSERT INTO TipoCFEType
VALUES (211,'e-Cont','eFact');
INSERT INTO TipoCFEType
VALUES (181,'e-Remito','eRem');
INSERT INTO TipoCFEType
VALUES (281,'e-Remito Cont','eRem');
INSERT INTO TipoCFEType
VALUES (121,'e-Factura de exportación','eFact_exp');
INSERT INTO TipoCFEType
VALUES (122,'e-Factura de exportación Nota Crédito','eFact_exp');
INSERT INTO TipoCFEType
VALUES (123,'e-Factura de exportación Nota Débito','eFact_exp');
INSERT INTO TipoCFEType
VALUES (223,'e-Factura de exportación Cont','eFact_exp');
INSERT INTO TipoCFEType
VALUES (124,'e-Remito de exportación','eRem_exp');
INSERT INTO TipoCFEType
VALUES (224,'e-Remito de exportación Cont','eRem_exp');
INSERT INTO TipoCFEType
VALUES (182,'e-Resguardo','eResg');
INSERT INTO TipoCFEType
VALUES (282,'e-Resguardo Cont','eResg');

go

create Table Emisor(
	Id int primary key identity,
    RUCEmisor varchar(50) ,
    RznSoc varchar(30)  not null,
    CdgDGISuc varchar(5)  not null,
    DomFiscal varchar(30)  not null,
	Ciudad varchar(20)  not null,
    Departamento varchar(20) not null,
	NomComercial varchar(30),
	GiroEmis varchar(30),
	Telefono varchar(30),
	CorreoEmisor varchar(30),
	EmiSucursal varchar(30)
)

go

INSERT INTO Emisor
VALUES ('2131234223423','Empresa','1','Av Uruguay 1212','Montevideo','Montevideo','','','','','');

go



create Table TipoDocumento(
	id int,
	constraint FK_TipoDocumento_id primary key (id),
	nombre varchar(20) not null
	);
	

go

INSERT INTO TipoDocumento
VALUES (2,'ruc');
INSERT INTO TipoDocumento
VALUES (3,'ci uruguaya');
INSERT INTO TipoDocumento
VALUES (4,'otro');
INSERT INTO TipoDocumento
VALUES (5,'pasaporte');
INSERT INTO TipoDocumento
VALUES (6,'dni');

go

 create table PaisType(
	id varchar(3),
	Nombre varchar(20) not null,
	primary key(id)
	)

go

INSERT INTO PaisType
VALUES ('UYU','Uruguay');
INSERT INTO PaisType
VALUES ('AR','Argentina');
INSERT INTO PaisType
VALUES ('BR','Brasil');

go

create Table Receptor (
	id int primary key IDENTITY,
    TipoDocRecep int,
	CodPaisRecep varchar(3),
	DocRecep varchar(50),
    RznSocRecep varchar(20),
    DirRecep varchar(50),
    CiudadRecep varchar(20),
	DeptoRecep varchar(20),
	/*PaisRecep varchar(20),*/
	CP varchar(10),
	InfoAdicional varchar(max),
	LugarDestEnt varchar(50),
	CompraID varchar(20),
	/*constraint FK_Receptor_PaisRecep foreign key (PaisRecep) references TipoDocumento (Nombre),*/
	constraint FK_Receptor_TipoDocRecep foreign key (TipoDocRecep) references TipoDocumento (id),
	constraint FK_Receptor_CodPaisRecep foreign key (CodPaisRecep) references PaisType (id),
)

go

INSERT INTO Receptor
VALUES (2,'UYU','214844360018','DGI','Fernández Crespo 1534','Montevideo','Montevideo','','','','');
INSERT INTO Receptor
VALUES (3,'BR','2341432','Juan Pérez','N/D1','N/D2','N/D3','N/D4','N/D5','N/D6','N/D7');
INSERT INTO Receptor
VALUES (4,'AR','12345','Juana','D1','D2','D3','D4','D5','D6','D7');
go

 create Table EnviosXML(
    id int primary key identity,
    archivoXML XML
    );

go
 create Table RespuestasXML(
    id int primary key,
    respuesta XML
    );    

go

 create Table EnviosFirmadosXML(
    id int primary key,
    archivoXML XML
    );    
        
go

create Table EnvioReporte (
	id int primary key,
	archivoXML XML
	);

go

create Table RespuestaReporte (
	id int primary key,
	archivoXML XML
	);

go


-----------------------------------------------------
-----------------AltaFormasDePago--------------------
-----------------------------------------------------
CREATE PROCEDURE AltaFormasDePago
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM FormasDePagoType
	where FormasDePagoType.id = @id) RETURN -1;

	IF EXISTS (SELECT *
	FROM FormasDePagoType
	where FormasDePagoType.nombre = @nombre) RETURN -3;

	BEGIN TRANSACTION
		INSERT INTO FormasDePagoType values (@id,@nombre,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    

/*exec AltaFormasDePago 3, 'Tercera', 0;*/

go

-----------------------------------------------------
-----------------BajaFormasDePago--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaFormasDePago
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM FormasDePagoType
	where FormasDePagoType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE FormasDePagoType WHERE FormasDePagoType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    

-----------------------------------------------------
-----------------ModificarFormasDePago------------
-----------------------------------------------------
CREATE PROCEDURE ModificarFormasDePago
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM FormasDePagoType
	where FormasDePagoType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE FormasDePagoType
		SET Nombre = @nombre, habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

/*GO    
exec ModificarFormasDePago 1, 'Modificado', 1*/
go

-----------------------------------------------------
-----------------BuscarFormasDePago------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarFormasDePago
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM FormasDePagoType
	where FormasDePagoType.id = @id) RETURN -3;

	SELECT * FROM FormasDePagoType WHERE FormasDePagoType.id=@id;
END

/*GO    
exec BuscarFormasDePago 3;
go

exec BuscarFormasDePago 1*/

go

-----------------------------------------------------
-----------------AltaIVAType--------------------
-----------------------------------------------------
CREATE PROCEDURE AltaIVAType
@id INT,
@nombre varchar(20),
@valor bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM IVAType
	where IVAType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO IVAType values (@id,@nombre,@valor)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    

/*exec AltaIVAType 4, 'IVA 4', 20;

go*/

-----------------------------------------------------
-----------------BajaIVAType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaIVAType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IVAType
	where IVAType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE IVAType WHERE IVAType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    
/*exec BajaIVAType 22
go*/
-----------------------------------------------------
-----------------ModificarIVAType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarIVAType
@id INT,
@nombre varchar(20),
@valor bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IVAType
	where IVAType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE IVAType
		SET Nombre = @nombre, valor = @valor
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

GO    
/*exec ModificarIVAType 10, 'IVA MOD', 20
go
*/
-----------------------------------------------------
-----------------BuscarIVAType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarIVAType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IVAType
	where IVAType.id = @id) RETURN -3;

	SELECT * FROM IVAType WHERE IVAType.id=@id;
END

GO    
/*exec BuscarIVAType 3;
go

select * from IVAType*/

-----------------------------------------------------
-----------------AltaIndicadorFacturaType------------
-----------------------------------------------------
CREATE PROCEDURE AltaIndicadorFacturaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM IndicadorFacturaType
	where IndicadorFacturaType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO IndicadorFacturaType values (@id,@nombre,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

/*GO    

exec AltaIndicadorFacturaType 22, 'ALTA INDICADR FACTURA', 0;
*/
go

-----------------------------------------------------
-----------------BajaIndicadorFacturaType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaIndicadorFacturaType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IndicadorFacturaType
	where IndicadorFacturaType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE IndicadorFacturaType WHERE IndicadorFacturaType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

/*GO    
exec BajaIndicadorFacturaType 1;*/
go
-----------------------------------------------------
-----------------ModificarIndicadorFacturaType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarIndicadorFacturaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IndicadorFacturaType
	where IndicadorFacturaType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE IndicadorFacturaType
		SET Nombre = @nombre,habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarIndicadorFacturaType 2, 'Gravado a Tasa Minima', 0*/
go

-----------------------------------------------------
-----------------BuscarIndicadorFacturaType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarIndicadorFacturaType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM IndicadorFacturaType
	where IndicadorFacturaType.id = @id) RETURN -3;

	SELECT * FROM IndicadorFacturaType WHERE IndicadorFacturaType.id=@id;
END
/*
GO    
exec BuscarIndicadorFacturaType 12;*/
go

/*select * from IndicadorFacturaType*/

go

-----------------------------------------------------
-----------------AltaModVentaType------------
-----------------------------------------------------
CREATE PROCEDURE AltaModVentaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM ModVentaType
	where ModVentaType.id = @id) RETURN -1;

	IF EXISTS (SELECT *
	FROM ModVentaType
	where ModVentaType.Nombre = @nombre) RETURN -3;
	
	BEGIN TRANSACTION
		INSERT INTO ModVentaType values (@id,@nombre,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

/*GO    

exec AltaModVentaType 22, 'ID 22 bit 0 ALTA INDICADR FACTURA', 0;*/

go

-----------------------------------------------------
-----------------BajaModVentaType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaModVentaType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ModVentaType
	where ModVentaType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE ModVentaType WHERE ModVentaType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

/*GO    
exec BajaModVentaType 1;*/
go
-----------------------------------------------------
-----------------ModificarModVentaType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarModVentaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ModVentaType
	where ModVentaType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE ModVentaType
		SET Nombre = @nombre,habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarModVentaType 2, 'id 2 Gravado a Tasa Minima', 0*/
go

-----------------------------------------------------
-----------------BuscarModVentaType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarModVentaType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ModVentaType
	where ModVentaType.id = @id) RETURN -3;

	SELECT * FROM ModVentaType WHERE ModVentaType.id=@id;
END

GO    
/*exec BuscarModVentaType 12;*/
go

/*select * from ModVentaType*/
go


-----------------------------------------------------
-----------------AltaTipoMoneda------------
-----------------------------------------------------
CREATE PROCEDURE AltaTipoMoneda
@id varchar(4),
@nombre varchar(20),
@cambio money,
@simbolo varchar(4),
@nacional bit,
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM TipoMoneda
	where TipoMoneda.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO TipoMoneda values (@id,@nombre,@cambio,@simbolo,@nacional,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    
/*
exec AltaTipoMoneda '22', 'ID 22 bit 0 ALTA INDICADR FACTURA',22,'$UY',1,0;

go
*/
-----------------------------------------------------
-----------------BajaTipoMoneda--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaTipoMoneda
@id varchar(4)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoMoneda
	where TipoMoneda.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE TipoMoneda WHERE TipoMoneda.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    
/*
exec BajaTipoMoneda 'AR';
go
*/
-----------------------------------------------------
-----------------ModificarTipoMoneda------------
-----------------------------------------------------
CREATE PROCEDURE ModificarTipoMoneda
@id varchar(4),
@nombre varchar(20),
@cambio money,
@simbolo varchar(4),
@nacional bit,
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoMoneda
	where TipoMoneda.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE TipoMoneda
		SET Nombre = @nombre,cambio = @cambio, simbolo = @simbolo, nacional= @nacional, habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarTipoMoneda 'UY', 'Moneda modificada',12,'$N',0,0;
*/
go

-----------------------------------------------------
-----------------BuscarTipoMoneda------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarTipoMoneda
@id varchar(4)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoMoneda
	where TipoMoneda.id = @id) RETURN -3;

	SELECT * FROM TipoMoneda WHERE TipoMoneda.id=@id;
END

GO    
/*
exec BuscarTipoMoneda 12;
go

select * from TipoMoneda
go
*/


-----------------------------------------------------
-----------------AltaProductoServicio------------
-----------------------------------------------------
CREATE PROCEDURE AltaProductoServicio
@id varchar(10),
@nombre varchar(20),
@Precio money,
@IdMoneda varchar(4),
@Comentario varchar(50),
@Stock int,
@UnidadDeMedida int
AS
BEGIN

	IF EXISTS (SELECT *
	FROM ProductoServicio
	where ProductoServicio.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO ProductoServicio values (@id,@nombre,@Precio,@IdMoneda,@Comentario,@stock,@UnidadDeMedida)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END
/*
GO    

exec AltaProductoServicio 50, 'ID 50 bit 0 ALTA INDICADR FACTURA',22,'UY','1',0;
*/
go

-----------------------------------------------------
-----------------BajaProductoServicio--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaProductoServicio
@id varchar(10)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ProductoServicio
	where ProductoServicio.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE ProductoServicio WHERE ProductoServicio.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaProductoServicio 1;
*/
go
-----------------------------------------------------
-----------------ModificarProductoServicio------------
-----------------------------------------------------
CREATE PROCEDURE ModificarProductoServicio
@id varchar(10),
@nombre varchar(20),
@Precio money,
@IdMoneda varchar(4),
@Comentario varchar(50),
@Stock int,
@UnidadDeMedida int
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ProductoServicio
	where ProductoServicio.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE ProductoServicio
		SET Nombre = @nombre,Precio = @Precio, IdMoneda = @IdMoneda, Comentario= @Comentario, Stock = @Stock, UnidadDeMedida = @UnidadDeMedida
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarProductoServicio 2, 'ID 2 bit 0 modificado INDICADR FACTURA',22,'UY','1',0;
*/
go

-----------------------------------------------------
-----------------BuscarTipoMoneda------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarProductoServicio
@id varchar(10)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ProductoServicio
	where ProductoServicio.id = @id) RETURN -3;

	SELECT * FROM ProductoServicio WHERE ProductoServicio.id=@id;
END

GO    
/*
exec BuscarProductoServicio 12;
go

select * from ProductoServicio
go
*/


-----------------------------------------------------
-----------------AltaCodRetType------------
-----------------------------------------------------
CREATE PROCEDURE AltaCodRetType
@id varchar(20),
@tasa decimal
AS
BEGIN

	IF EXISTS (SELECT *
	FROM CodRetType
	where CodRetType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO CodRetType values (@id,@tasa)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    
/*
exec AltaCodRetType 50,22;

go
*/
-----------------------------------------------------
-----------------BajaCodRetType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaCodRetType
@id varchar(20)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM CodRetType
	where CodRetType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE CodRetType WHERE CodRetType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaCodRetType 1146171;
*/
go
-----------------------------------------------------
-----------------ModificarCodRetType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarCodRetType
@id varchar(20),
@tasa decimal
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM CodRetType
	where CodRetType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE CodRetType
		SET tasa = @tasa
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarCodRetType 2183165, 10;
*/
go

-----------------------------------------------------
-----------------BuscarCodRetType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarCodRetType
@id varchar(20)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM CodRetType
	where CodRetType.id = @id) RETURN -3;

	SELECT * FROM CodRetType WHERE CodRetType.id=@id;
END
/*
GO    
exec BuscarCodRetType 3;
*/
go
/*
select * from CodRetType
go
*/


-----------------------------------------------------
-----------------AltaTipoCFEType------------
-----------------------------------------------------
CREATE PROCEDURE AltaTipoCFEType
@id int,
@Nombre varchar(max),
@IdNombre varchar(10)
AS
BEGIN

	IF EXISTS (SELECT *
	FROM TipoCFEType
	where TipoCFEType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO TipoCFEType values (@id,@Nombre,@IdNombre)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    
/*
exec AltaTipoCFEType 50,'Nuevo CFE 50','CFE50';

go
*/
-----------------------------------------------------
-----------------BajaTipoCFEType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaTipoCFEType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoCFEType
	where TipoCFEType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE TipoCFEType WHERE TipoCFEType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaTipoCFEType 111;
*/
go
-----------------------------------------------------
-----------------ModificarTipoCFEType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarTipoCFEType
@id int,
@Nombre varchar(max),
@IdNombre varchar(10)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoCFEType
	where TipoCFEType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE TipoCFEType
		SET Nombre = @Nombre, IdNombre = @IdNombre
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarTipoCFEType 112, 'CFE Modificado 112','CFE112';
*/
go

-----------------------------------------------------
-----------------BuscarTipoCFEType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarTipoCFEType
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoCFEType
	where TipoCFEType.id = @id) RETURN -3;

	SELECT * FROM TipoCFEType WHERE TipoCFEType.id=@id;
END
/*
GO    
exec BuscarTipoCFEType 101;*/
go
/*
select * from TipoCFEType
go
*/
-----------------------------------------------------
-----------------AltaEmisor------------
-----------------------------------------------------
CREATE PROCEDURE AltaEmisor
@id int output,
@RUCEmisor varchar(50),
@RznSoc varchar(30),
@CdgDGISucur varchar(5),
@DomFiscal varchar(30),
@Ciudad varchar(20),
@Departamento varchar(20),
@NomComercial varchar(30),
@GiroEmis varchar(30),
@Telefono varchar(30),
@CorreoEmisor varchar(30),
@EmiSucursal varchar(30)
AS
BEGIN

	IF EXISTS (SELECT *
	FROM Emisor
	where Emisor.RUCEmisor = @RUCEmisor) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO Emisor values (@RUCEmisor,@RznSoc,@CdgDGISucur,@DomFiscal,@Ciudad,@Departamento,
				@NomComercial,@GiroEmis,@Telefono,@CorreoEmisor,@EmiSucursal);
				
		set @Id = @@IDENTITY
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN -2;
			
		END

		COMMIT TRANSACTION
END

GO    

exec AltaEmisor 12345678,'Nuevo EMISOR 50 12345678',2,'EMI50','u','u','','','','','','';

exec AltaEmisor 12345679,'Nuevo EMISOR 51 12345679',2,'EMI51','u','u','','','','','','';

go

-----------------------------------------------------
-----------------BajaEmisor--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaEmisor
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Emisor
	where Emisor.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE Emisor WHERE Emisor.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaEmisor 1;
*/
go
-----------------------------------------------------
-----------------ModificarEmisor------------
-----------------------------------------------------
CREATE PROCEDURE ModificarEmisor
@id int,
@RUCEmisor varchar(50),
@RznSoc varchar(30),
@CdgDGISuc varchar(5),
@DomFiscal varchar(30),
@Ciudad varchar(20),
@Departamento varchar(20),
@NomComercial varchar(30),
@GiroEmis varchar(30),
@Telefono varchar(30),
@CorreoEmisor varchar(30),
@EmiSucursal varchar(30)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Emisor
	where Emisor.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE Emisor
		SET RUCEmisor = @RUCEmisor, RznSoc = @RznSoc, CdgDGISuc = @CdgDGISuc, DomFiscal = @DomFiscal,
			Ciudad = @Ciudad, Departamento = @Departamento, NomComercial = @NomComercial, GiroEmis = @GiroEmis,
			Telefono = @Telefono, CorreoEmisor = @CorreoEmisor, EmiSucursal = @EmiSucursal
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

GO    
exec ModificarEmisor '1','123456','Modificado EMISOR 51 12345678','2','EMI51 mod','','','um','um','','','';

go

-----------------------------------------------------
-----------------BuscarEmisor------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarEmisor
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Emisor
	where Emisor.id = @id) RETURN -3;

	SELECT * FROM Emisor WHERE Emisor.id=@id;
END
/*
GO    
exec BuscarEmisor 2;
go

select * from Emisor
*/
go


-----------------------------------------------------
-----------------AltaTipoDocumento------------
-----------------------------------------------------
CREATE PROCEDURE AltaTipoDocumento
@id int,
@Nombre varchar(20)
AS
BEGIN

	IF EXISTS (SELECT *
	FROM TipoDocumento
	where TipoDocumento.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO TipoDocumento values (@id,@Nombre)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    
/*
exec AltaTipoDocumento 50,'nombre';
exec AltaTipoDocumento 51,'nombre2';

go
*/
-----------------------------------------------------
-----------------BajaTipoDocumento--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaTipoDocumento
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoDocumento
	where TipoDocumento.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE TipoDocumento WHERE TipoDocumento.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaTipoDocumento 1;
*/
go
-----------------------------------------------------
-----------------ModificarTipoDocumento------------
-----------------------------------------------------
CREATE PROCEDURE ModificarTipoDocumento
@id int,
@Nombre varchar(20)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoDocumento
	where TipoDocumento.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE TipoDocumento
		SET Nombre = @Nombre
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarTipoDocumento 51,'Modificado EMISOR 51 12345678';
*/
go

-----------------------------------------------------
-----------------BuscarTipoDocumento------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarTipoDocumento
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoDocumento
	where TipoDocumento.id = @id) RETURN -3;

	SELECT * FROM TipoDocumento WHERE TipoDocumento.id=@id;
END
/*
GO    
exec BuscarTipoDocumento 2;
go
*/
/*
select * from TipoDocumento
*/
go


-----------------------------------------------------
-----------------AltaPaisType------------
-----------------------------------------------------
CREATE PROCEDURE AltaPaisType
@id VARCHAR(3),
@Nombre varchar(20)
AS
BEGIN

	IF EXISTS (SELECT *
	FROM PaisType
	where PaisType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		INSERT INTO PaisType values (@id,@Nombre)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    
/*
exec AltaTipoDocumento 50,'nombre';
exec AltaTipoDocumento 51,'nombre2';

go
*/
-----------------------------------------------------
-----------------BajaPaisType--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaPaisType
@id VARCHAR(3)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM PaisType
	where PaisType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE PaisType WHERE PaisType.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaPaisType 1;
*/
go
-----------------------------------------------------
-----------------ModificarPaisType------------
-----------------------------------------------------
CREATE PROCEDURE ModificarPaisType
@id VARCHAR(3),
@Nombre varchar(20)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM PaisType
	where PaisType.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE PaisType
		SET Nombre = @Nombre
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarPaisType 'AR','Modificado EMISOR 51 12345678';
*/
go

-----------------------------------------------------
-----------------BuscarPaisType------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarPaisType
@id varchar(3)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM PaisType
	where PaisType.id = @id) RETURN -3;

	SELECT * FROM PaisType WHERE PaisType.id=@id;
END

GO    
exec BuscarPaisType 2;
go
/*
select * from PaisType

go
*/


-----------------------------------------------------
-----------------AltaReceptor------------
-----------------------------------------------------

CREATE PROCEDURE AltaReceptor
	@id int output,
    @TipoDocRecep int,
	@CodPaisRecep varchar(3),
	@DocRecep varchar(50),
    @RznSocRecep varchar(20),
    @DirRecep varchar(50),
    @CiudadRecep varchar(20),
	@DeptoRecep varchar(20),
	@CP varchar(10),
	@InfoAdicional varchar(max),
	@LugarDestEnt varchar(50),
	@CompraID varchar(20)
AS
BEGIN
IF EXISTS (SELECT * FROM Receptor WHERE TipoDocRecep = @TipoDocRecep AND DocRecep = @DocRecep)
	RETURN -1;
	
	BEGIN TRANSACTION
		INSERT INTO Receptor values (@TipoDocRecep,@CodPaisRecep,@DocRecep,@RznSocRecep,@DirRecep,@CiudadRecep,
				@DeptoRecep,@CP,@InfoAdicional,@LugarDestEnt,@CompraID);
				set @id = @@IDENTITY
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN -2;
		END

		COMMIT TRANSACTION		
		
END

go

EXEC AltaReceptor 5,3,'UYU','151531153','Persona','julio herrerea y reissing 650','Montevideo','Montevideo','a','b','c','d';

go

exec AltaReceptor 6,5,'BR','B145678','Pr2','Alf 1347','Montevideo2','Montevideo2','a2','b2','c2','d2';


go

-----------------------------------------------------
-----------------BajaReceptor--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaReceptor
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Receptor
	where Receptor.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE Receptor WHERE Receptor.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END
/*
GO    
exec BajaReceptor 4;
*/
go
-----------------------------------------------------
-----------------ModificarReceptor------------
-----------------------------------------------------
CREATE PROCEDURE ModificarReceptor
	@id int,
    @TipoDocRecep int,
	@CodPaisRecep varchar(3),
	@DocRecep varchar(50),
    @RznSocRecep varchar(20),
    @DirRecep varchar(50),
    @CiudadRecep varchar(20),
	@DeptoRecep varchar(20),
	/*@PaisRecep varchar(20),*/
	@CP varchar(10),
	@InfoAdicional varchar(max),
	@LugarDestEnt varchar(50),
	@CompraID varchar(20)
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Receptor
	where Receptor.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE Receptor
		SET TipoDocRecep = @TipoDocRecep, CodPaisRecep = @CodPaisRecep, DocRecep = @DocRecep, RznSocRecep = @RznSocRecep,
			DirRecep = @DirRecep, CiudadRecep = @CiudadRecep, DeptoRecep = @DeptoRecep, CP = @CP,
			InfoAdicional = @InfoAdicional, LugarDestEnt = @LugarDestEnt, CompraID = @CompraID
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END
/*
GO    
exec ModificarReceptor 5,2,'UYU',8888888,'Persona Modificada','bv artigas 12312','Montevideo',null,null,null,null,null;
*/
go

-----------------------------------------------------
-----------------BuscarReceptor------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarReceptor
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM Receptor
	where Receptor.id = @id) RETURN -3;

	SELECT * FROM Receptor WHERE Receptor.id=@id;
END
/*
GO    
exec BuscarReceptor 2;
go

select * from Receptor
*/
go

CREATE PROCEDURE ListarPaises
AS
BEGIN 
	SELECT * FROM PaisType
END

GO 


CREATE PROCEDURE ListarCodRetType
AS
BEGIN 
	SELECT * FROM CodRetType
END

GO 


CREATE PROCEDURE ListarEmisores
AS
BEGIN 
	SELECT * FROM Emisor
END

GO 

CREATE PROCEDURE ListarReceptores
AS
BEGIN 
	SELECT * FROM Receptor
END

GO

CREATE PROCEDURE ListarFormasDePago
AS
BEGIN 
	SELECT * FROM FormasDePagoType
END

GO 

CREATE PROCEDURE ListarIndicadorFacturaType
AS
BEGIN 
	SELECT * FROM IndicadorFacturaType
END

GO 

CREATE PROCEDURE ListarIVAType
AS
BEGIN 
	SELECT * FROM IVAType
END

GO 

CREATE PROCEDURE ListarModVentaType
AS
BEGIN 
	SELECT * FROM ModVentaType
END

GO 

CREATE PROCEDURE ListarPaisType
AS
BEGIN 
	SELECT * FROM PaisType
END

GO 

CREATE PROCEDURE ListarProductoServicio
AS
BEGIN 
	SELECT * FROM ProductoServicio
END

GO 

CREATE PROCEDURE ListarTipoCFEType
AS
BEGIN 
	SELECT * FROM TipoCFEType
END

GO 

CREATE PROCEDURE ListarTipoDocumento
AS
BEGIN 
	SELECT * FROM TipoDocumento
END

GO 


CREATE PROCEDURE ListarTipoMoneda
AS
BEGIN 
	SELECT * FROM TipoMoneda
END

GO 


-----------------------------------------------------
-----------------AltaTipoTraslado--------------------
-----------------------------------------------------
CREATE PROCEDURE AltaTipoTraslado
@id INT,
@nombre varchar(50),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM TipoTraslado
	where TipoTraslado.id = @id) RETURN -1;

	IF EXISTS (SELECT *
	FROM TipoTraslado
	where TipoTraslado.nombre = @nombre) RETURN -3;

	BEGIN TRANSACTION
		INSERT INTO TipoTraslado values (@id,@nombre,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    

/*exec AltaTipoTraslado 3, 'Tercera', 0;*/

go

-----------------------------------------------------
-----------------BajaTipoTraslado--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaTipoTraslado
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoTraslado
	where TipoTraslado.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE TipoTraslado WHERE TipoTraslado.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    

-----------------------------------------------------
-----------------ModificarTipoTraslado------------
-----------------------------------------------------
CREATE PROCEDURE ModificarTipoTraslado
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoTraslado
	where TipoTraslado.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE TipoTraslado
		SET Nombre = @nombre, habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

/*GO    
exec ModificarTipoTraslado 1, 'Modificado', 1*/
go

-----------------------------------------------------
-----------------BuscarFormasDePago------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarTipoTraslado
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM TipoTraslado
	where TipoTraslado.id = @id) RETURN -3;

	SELECT * FROM TipoTraslado WHERE TipoTraslado.id=@id;
END

/*GO    
exec BuscarTipoTraslado 3;
go

exec BuscarTipoTraslado 1*/

go

-----------------------------------------------------
-----------------AltaUnidadDeMedida--------------------
-----------------------------------------------------
CREATE PROCEDURE AltaUnidadDeMedida
@id INT output,
@nombre varchar(50),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM UnidadDeMedida
	where UnidadDeMedida.id = @id) RETURN -1;

	IF EXISTS (SELECT *
	FROM UnidadDeMedida
	where UnidadDeMedida.nombre = @nombre) RETURN -3;

	BEGIN TRANSACTION
		INSERT INTO UnidadDeMedida values (@nombre,@habilitado)
		SET @id = @@IDENTITY
		IF @@ERROR <> 0
		BEGIN
			RETURN -2;
			ROLLBACK TRANSACTION;
		END

		COMMIT TRANSACTION
END

GO    

/*exec AltaUnidadDeMedida 3, 'Tercera', 0;*/

go

-----------------------------------------------------
-----------------BajaUnidadDeMedida--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaUnidadDeMedida
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM UnidadDeMedida
	where UnidadDeMedida.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE UnidadDeMedida WHERE UnidadDeMedida.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    

-----------------------------------------------------
-----------------ModificarUnidadDeMedida------------
-----------------------------------------------------
CREATE PROCEDURE ModificarUnidadDeMedida
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM UnidadDeMedida
	where UnidadDeMedida.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE UnidadDeMedida
		SET Nombre = @nombre, habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

/*GO    
exec ModificarUnidadDeMedida 1, 'Modificado', 1*/
go

-----------------------------------------------------
-----------------BuscarUnidadDeMedida------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarUnidadDeMedida
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM UnidadDeMedida
	where UnidadDeMedida.id = @id) RETURN -3;

	SELECT * FROM UnidadDeMedida WHERE UnidadDeMedida.id=@id;
END

/*GO    
exec BuscarUnidadDeMedida 3;
go

exec BuscarUnidadDeMedida 1*/

go


-----------------------------------------------------
-----------------AltaViaTransp--------------------
-----------------------------------------------------
CREATE PROCEDURE AltaViaTransp
@id INT,
@nombre varchar(50),
@habilitado bit
AS
BEGIN

	IF EXISTS (SELECT *
	FROM ViaTransp
	where ViaTransp.id = @id) RETURN -1;

	IF EXISTS (SELECT *
	FROM ViaTransp
	where ViaTransp.nombre = @nombre) RETURN -3;

	BEGIN TRANSACTION
		INSERT INTO ViaTransp values (@id,@nombre,@habilitado)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

		COMMIT TRANSACTION
END

GO    

/*exec AltaViaTransp 3, 'Tercera', 0;*/

go

-----------------------------------------------------
-----------------BajaViaTransp--------------------
-----------------------------------------------------
CREATE PROCEDURE BajaViaTransp
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ViaTransp
	where ViaTransp.id = @id) RETURN -1;

	BEGIN TRANSACTION
		DELETE ViaTransp WHERE ViaTransp.id=@id;

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN -2;
		END

	COMMIT TRANSACTION
END

GO    

-----------------------------------------------------
-----------------ModificarViaTransp------------
-----------------------------------------------------
CREATE PROCEDURE ModificarViaTransp
@id INT,
@nombre varchar(20),
@habilitado bit
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ViaTransp
	where ViaTransp.id = @id) RETURN -1;

	BEGIN TRANSACTION
		UPDATE ViaTransp
		SET Nombre = @nombre, habilitado = @habilitado
		WHERE Id = @id;	
		

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN -2;
		END;

	COMMIT TRANSACTION
END

/*GO    
exec ModificarViaTransp 1, 'Modificado', 1*/
go

-----------------------------------------------------
-----------------BuscarViaTransp------------------
-----------------------------------------------------
CREATE PROCEDURE BuscarViaTransp
@id INT
AS
BEGIN

	IF NOT EXISTS (SELECT *
	FROM ViaTransp
	where ViaTransp.id = @id) RETURN -3;

	SELECT * FROM ViaTransp WHERE ViaTransp.id=@id;
END

/*GO    
exec BuscarViaTransp 3;
go

exec BuscarViaTransp 1*/

go


CREATE PROCEDURE ListarTipoTraslado
AS
BEGIN 
	SELECT * FROM TipoTraslado
END

GO 

CREATE PROCEDURE ListarUnidadDeMedida
AS
BEGIN 
	SELECT * FROM UnidadDeMedida
END

GO 

CREATE PROCEDURE ListarViaTransp
AS
BEGIN 
	SELECT * FROM ViaTransp
END

GO 
