CREATE SCHEMA [mercado]
GO

CREATE TABLE [mercado].[categorias_producto] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [descripcion_categoria] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[productos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nombre_producto] nvarchar(255),
  [id_categoria_producto] int,
  [ind_precio_proveedor] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[proveedores] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nombre_proveedor] nvarchar(255),
  [direccion_proveedor] nvarchar(255),
  [correo_proveedor] nvarchar(255),
  [telefono_proveedor] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[detalle_orden_compra] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_orden_compra] int,
  [precio_compra] numeric,
  [precio_venta] numeric,
  [id_producto] int,
  [cantidad] int,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[inventarios] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_almacen] int,
  [id_detalle_orden_compra] int,
  [cantidad] int,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[almacenes] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nombre] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[ordenes_compra] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_proveedor] int,
  [ind_pagado] nvarchar(255),
  [ind_entregado] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[movimientos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [tipo_movimiento] nvarchar(255),
  [monto_total_movimiento] numeric,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[detalle_movimiento] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_movimiento] int,
  [id_inventario] int,
  [cantidad] int,
  [monto_detalle] int,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[clientes] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nombre_cliente] nvarchar(255),
  [ind_credito] nvarchar(255),
  [monto_aprobado_credito] numeric,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[creditos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente] int,
  [monto_credito] numeric,
  [fecha_creacion] date default GETDATE()
)
GO



CREATE TABLE [mercado].[ventas] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_cliente] int,
  [id_movimiento] int,
  [id_apertura_cierre_caja] int,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[apertura_cierre_caja] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [hora_apertura] datetime default CURRENT_TIMESTAMP,
  [hora_cierre] datetime default CURRENT_TIMESTAMP,
  [id_cajero] int,
  [fecha_creacion] date default GETDATE()
)
GO

CREATE TABLE [mercado].[cajeros] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [nombre_cajero] nvarchar(255),
  [cod_cajero] nvarchar(255),
  [contrasena] nvarchar(255),
  [fecha_creacion] date default GETDATE()
)
GO

ALTER TABLE [mercado].[productos] ADD FOREIGN KEY ([id_categoria_producto]) REFERENCES [mercado].[categorias_producto] ([id])
GO

ALTER TABLE [mercado].[detalle_orden_compra] ADD FOREIGN KEY ([id_orden_compra]) REFERENCES [mercado].[ordenes_compra] ([id])
GO

ALTER TABLE [mercado].[detalle_orden_compra] ADD FOREIGN KEY ([id_producto]) REFERENCES [mercado].[productos] ([id])
GO

ALTER TABLE [mercado].[inventarios] ADD FOREIGN KEY ([id_almacen]) REFERENCES [mercado].[almacenes] ([id])
GO

ALTER TABLE [mercado].[inventarios] ADD FOREIGN KEY ([id_detalle_orden_compra]) REFERENCES [mercado].[detalle_orden_compra] ([id])
GO

ALTER TABLE [mercado].[ordenes_compra] ADD FOREIGN KEY ([id_proveedor]) REFERENCES [mercado].[proveedores] ([id])
GO

ALTER TABLE [mercado].[detalle_movimiento] ADD FOREIGN KEY ([id_movimiento]) REFERENCES [mercado].[movimientos] ([id])
GO

ALTER TABLE [mercado].[detalle_movimiento] ADD FOREIGN KEY ([id_inventario]) REFERENCES [mercado].[inventarios] ([id])
GO

ALTER TABLE [mercado].[creditos] ADD FOREIGN KEY ([id_cliente]) REFERENCES [mercado].[clientes] ([id])
GO

ALTER TABLE [mercado].[ventas] ADD FOREIGN KEY ([id_cliente]) REFERENCES [mercado].[clientes] ([id])
GO

ALTER TABLE [mercado].[ventas] ADD FOREIGN KEY ([id_movimiento]) REFERENCES [mercado].[movimientos] ([id])
GO

ALTER TABLE [mercado].[ventas] ADD FOREIGN KEY ([id_apertura_cierre_caja]) REFERENCES [mercado].[apertura_cierre_caja] ([id])
GO

ALTER TABLE [mercado].[apertura_cierre_caja] ADD FOREIGN KEY ([id_cajero]) REFERENCES [mercado].[cajeros] ([id])
GO


CREATE TABLE [mercado].[pagos_creditos] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_credito] int,
  [monto_pagado] numeric,
  [fecha_creacion] date default GETDATE()
)
GO
ALTER TABLE [mercado].[pagos_creditos] ADD FOREIGN KEY ([id_credito]) REFERENCES [mercado].[creditos] ([id])
GO