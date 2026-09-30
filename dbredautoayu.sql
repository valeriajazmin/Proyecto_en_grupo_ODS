-- CREACIÓN Y USO DE LA BASE DE DATOS 2
CREATE DATABASE RADAL_RedAutoayuda_BD;
GO

USE RADAL_RedAutoayuda_BD;
GO

-- TABLA BASE DE USUARIOS PARA ESTE MÓDULO
CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    alias VARCHAR(50),
    rol VARCHAR(50)
);

-- TABLAS DE LA RED DE AUTOAYUDA
CREATE TABLE GRUPO_AUTOAYUDA (
    id_grupo INT IDENTITY(1,1) PRIMARY KEY,
    id_facilitadora INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tema VARCHAR(100),
    normas TEXT,
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    CONSTRAINT FK_Grupo_Facilitadora FOREIGN KEY (id_facilitadora) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE MEMBRESIA (
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_union DATE DEFAULT GETDATE(),
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    PRIMARY KEY (id_usuario, id_grupo),
    CONSTRAINT FK_Membresia_Usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT FK_Membresia_Grupo FOREIGN KEY (id_grupo) REFERENCES GRUPO_AUTOAYUDA(id_grupo)
);

CREATE TABLE PLAN_SEGURIDAD (
    id_plan INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    contactos_confianza TEXT,
    lugar_seguro VARCHAR(200),
    fecha_actualizacion DATE DEFAULT GETDATE(),
    CONSTRAINT FK_Plan_Usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE RECURSO_INFORMATIVO (
    id_recurso INT IDENTITY(1,1) PRIMARY KEY,
    id_autor INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    tema VARCHAR(100),
    contenido TEXT,
    fecha_publicacion DATE DEFAULT GETDATE(),
    CONSTRAINT FK_Recurso_Autor FOREIGN KEY (id_autor) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE PUBLICACION (
    id_publicacion INT IDENTITY(1,1) PRIMARY KEY,
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    CONSTRAINT FK_Publicacion_Grupo FOREIGN KEY (id_grupo) REFERENCES GRUPO_AUTOAYUDA(id_grupo),
    CONSTRAINT FK_Publicacion_Usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE COMENTARIO (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Comentario_Publicacion FOREIGN KEY (id_publicacion) REFERENCES PUBLICACION(id_publicacion),
    CONSTRAINT FK_Comentario_Usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE REPORTE_MODERACION (
    id_reporte INT IDENTITY(1,1) PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario_reporta INT NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    decision VARCHAR(100) NULL,
    estado VARCHAR(20) DEFAULT 'PENDIENTE',
    CONSTRAINT FK_Reporte_Publicacion FOREIGN KEY (id_publicacion) REFERENCES PUBLICACION(id_publicacion),
    CONSTRAINT FK_Reporte_UsuarioReporta FOREIGN KEY (id_usuario_reporta) REFERENCES USUARIO(id_usuario)
);
GO