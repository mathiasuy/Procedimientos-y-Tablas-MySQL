CREATE PROCEDURE AltaFormasDePago
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BajaFormasDePago
@id INT
AS

CREATE PROCEDURE ModificarFormasDePago
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BuscarFormasDePago
@id INT
AS

CREATE PROCEDURE AltaIVAType
@id INT,
@nombre varchar(20),
@valor bit
AS

CREATE PROCEDURE BajaIVAType
@id INT
AS

CREATE PROCEDURE ModificarIVAType
@id INT,
@nombre varchar(20),
@valor bit
AS

CREATE PROCEDURE BuscarIVAType
@id INT
AS

CREATE PROCEDURE AltaIndicadorFacturaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BajaIndicadorFacturaType
@id INT
AS

CREATE PROCEDURE ModificarIndicadorFacturaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BuscarIndicadorFacturaType
@id INT
AS

CREATE PROCEDURE AltaModVentaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BajaModVentaType
@id INT
AS

CREATE PROCEDURE ModificarModVentaType
@id INT,
@nombre varchar(20),
@habilitado bit
AS

CREATE PROCEDURE BuscarModVentaType
@id INT
AS

CREATE PROCEDURE AltaTipoMoneda
@id varchar(4),
@nombre varchar(20),
@cambio money,
@simbolo varchar(4),
@nacional bit,
@habilitado bit
AS

CREATE PROCEDURE BajaTipoMoneda
@id varchar(4)
AS

CREATE PROCEDURE ModificarTipoMoneda
@id varchar(4),
@nombre varchar(20),
@cambio money,
@simbolo varchar(4),
@nacional bit,
@habilitado bit
AS

CREATE PROCEDURE BuscarTipoMoneda
@id varchar(4)
AS

CREATE PROCEDURE AltaProductoServicio
@id int,
@nombre varchar(20),
@Precio money,
@MonedaId varchar(4),
@Comentario varchar(50),
@Stock int
AS

CREATE PROCEDURE BajaProductoServicio
@id int
AS

CREATE PROCEDURE ModificarProductoServicio
@id int,
@nombre varchar(20),
@Precio money,
@MonedaId varchar(4),
@Comentario varchar(50),
@Stock int
AS

CREATE PROCEDURE BuscarProductoServicio
@id varchar(4)
AS

CREATE PROCEDURE AltaCodRetType
@id varchar(20),
@tasa float
AS

CREATE PROCEDURE BajaCodRetType
@id varchar(20)
AS

CREATE PROCEDURE ModificarCodRetType
@id varchar(20),
@tasa float
AS

CREATE PROCEDURE BuscarCodRetType
@id varchar(20)
AS

CREATE PROCEDURE AltaTipoCFEType
@id int,
@Nombre varchar(max),
@NombreId varchar(10)
AS

CREATE PROCEDURE BajaTipoCFEType
@id INT
AS

CREATE PROCEDURE ModificarTipoCFEType
@id int,
@Nombre varchar(max),
@NombreId varchar(10)
AS

CREATE PROCEDURE BuscarTipoCFEType
@id INT
AS

CREATE PROCEDURE AltaEmisor
@id int,
@RUCEmisor varchar(50),
@RznSoc varchar(30),
@CdgDGISucur int,
@DomFiscal varchar(30),
@Ciudad varchar(20),
@Departamento varchar(20),
@NomComercial varchar(30),
@GiroEmis varchar(30),
@Telefono varchar(30),
@CorreoEmisor varchar(30),
@EmiSucursal varchar(30)
AS

CREATE PROCEDURE BajaEmisor
@id INT
AS

CREATE PROCEDURE ModificarEmisor
@id int,
@RUCEmisor varchar(50),
@RznSoc varchar(30),
@CdgDGISucur int,
@DomFiscal varchar(30),
@Ciudad varchar(20),
@Departamento varchar(20),
@NomComercial varchar(30),
@GiroEmis varchar(30),
@Telefono varchar(30),
@CorreoEmisor varchar(30),
@EmiSucursal varchar(30)
AS

CREATE PROCEDURE BuscarEmisor
@id INT
AS

CREATE PROCEDURE AltaTipoDocumento
@id int,
@Nombre varchar(20)
AS

CREATE PROCEDURE BajaTipoDocumento
@id INT
AS

CREATE PROCEDURE ModificarTipoDocumento
@id int,
@Nombre varchar(20)
AS

CREATE PROCEDURE BuscarTipoDocumento
@id INT
AS

CREATE PROCEDURE AltaPaisType
@id VARCHAR(3),
@Nombre varchar(20)
AS

CREATE PROCEDURE BajaPaisType
@id VARCHAR(3)
AS

CREATE PROCEDURE ModificarPaisType
@id VARCHAR(3),
@Nombre varchar(20)
AS

CREATE PROCEDURE BuscarPaisType
@id varchar(3)
AS