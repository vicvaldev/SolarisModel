-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-09-11 21:14:05 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BOLETA 
    ( 
     id_boleta      INTEGER  NOT NULL , 
     fecha_emision  TIMESTAMP  NOT NULL , 
     id_cliente     INTEGER  NOT NULL , 
--  corresponde a la suma de precio unitario de producto por la cantidad de
--  detalle_venta
     monto_total    INTEGER  NOT NULL , 
     sigla_sucursal CHAR (10)  NOT NULL 
    ) 
;

ALTER TABLE BOLETA 
    ADD CONSTRAINT BOLETA_PK PRIMARY KEY ( id_boleta ) ;

CREATE TABLE CATEGORIA 
    ( 
     id_categoria     INTEGER  NOT NULL , 
     nombre_categoria NVARCHAR2 (100)  NOT NULL , 
     perecible        NUMBER  NOT NULL 
    ) 
;

ALTER TABLE CATEGORIA 
    ADD CONSTRAINT CATEGORIA_PK PRIMARY KEY ( id_categoria ) ;

CREATE TABLE CLIENTE 
    ( 
     id_cliente      INTEGER  NOT NULL , 
     nombre_completo NVARCHAR2 (100)  NOT NULL , 
     telefono        NVARCHAR2 (15)  NOT NULL , 
     cod_comuna      CHAR (4)  NOT NULL 
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY ( id_cliente ) ;

CREATE TABLE COMUNA 
    ( 
     cod_comuna CHAR (4)  NOT NULL , 
     nombre     NVARCHAR2 (100)  NOT NULL , 
     cod_region CHAR (2)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( cod_comuna ) ;

CREATE TABLE DETALLE_VENTA 
    ( 
     id_producto INTEGER  NOT NULL , 
     id_boleta   INTEGER  NOT NULL , 
     cantidad    INTEGER  NOT NULL 
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_PK PRIMARY KEY ( id_producto, id_boleta ) ;

CREATE TABLE MARCA 
    ( 
     id_marca INTEGER  NOT NULL , 
     nombre   NVARCHAR2 (1)  NOT NULL 
    ) 
;

ALTER TABLE MARCA 
    ADD CONSTRAINT MARCA_PK PRIMARY KEY ( id_marca ) ;

CREATE TABLE MODELO 
    ( 
     id_modelo     INTEGER  NOT NULL , 
     id_marca      INTEGER  NOT NULL , 
     nombre_modelo NVARCHAR2 (100)  NOT NULL , 
     descripcion   NVARCHAR2 (300)  NOT NULL 
    ) 
;

ALTER TABLE MODELO 
    ADD CONSTRAINT MODELO_PK PRIMARY KEY ( id_modelo, id_marca ) ;

CREATE TABLE PRODUCTO 
    ( 
     id_producto       INTEGER  NOT NULL , 
     nombre_producto   NVARCHAR2 (100)  NOT NULL , 
     id_modelo         INTEGER  NOT NULL , 
     id_categoria      INTEGER  NOT NULL , 
     precio_unitario   INTEGER  NOT NULL , 
     rut_proveedor     INTEGER  NOT NULL , 
     fecha_vencimiento TIMESTAMP , 
     id_marca          INTEGER  NOT NULL 
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY ( id_producto ) ;

CREATE TABLE PROVEEDOR 
    ( 
     rut             INTEGER  NOT NULL , 
     dv              CHAR (1)  NOT NULL , 
     fono            CHAR (15)  NOT NULL , 
     calle_direccion NVARCHAR2 (100)  NOT NULL , 
     num_calle       CHAR (5)  NOT NULL , 
     email           NVARCHAR2 (100)  NOT NULL , 
     cod_postal      CHAR (7)  NOT NULL , 
--  E: Empresa y P: Persona
     tipo_proveedor  CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE PROVEEDOR 
    ADD CONSTRAINT PROVEEDOR_PK PRIMARY KEY ( rut ) ;

CREATE TABLE PROVEEDOR_EMPRESA 
    ( 
     rut             INTEGER  NOT NULL , 
     website         NVARCHAR2 (100) , 
     nombre_fantasia NVARCHAR2 (200)  NOT NULL , 
     razon_social    NVARCHAR2 (150)  NOT NULL 
    ) 
;

ALTER TABLE PROVEEDOR_EMPRESA 
    ADD CONSTRAINT PROVEEDOR_EMPRESA_PK PRIMARY KEY ( rut ) ;

CREATE TABLE PROVEEDOR_PERSONA_NATURAL 
    ( 
     rut       INTEGER  NOT NULL , 
     nombres   NVARCHAR2 (100)  NOT NULL , 
     apellidos NVARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE PROVEEDOR_PERSONA_NATURAL 
    ADD CONSTRAINT PRVEEDOR_PERSONA_NATURAL_PK PRIMARY KEY ( rut ) ;

CREATE TABLE REGION 
    ( 
     cod_region CHAR (2)  NOT NULL , 
     nombre     NVARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( cod_region ) ;

CREATE TABLE SUCURSAL 
    ( 
--  El id se compone del prefijo SUC + Cod Region + Cod Comuna + Correlativo
     sigla      CHAR (10)  NOT NULL , 
     nombre     NVARCHAR2 (100)  NOT NULL , 
     cod_comuna CHAR (4)  NOT NULL 
    ) 
;

ALTER TABLE SUCURSAL 
    ADD CONSTRAINT SUCURSAL_PK PRIMARY KEY ( sigla ) ;

CREATE TABLE SUCURSAL_PRODUCTO 
    ( 
     id_producto    INTEGER  NOT NULL , 
     sigla_sucursal CHAR (10)  NOT NULL , 
--  Corresponde al stock por sucursal
     stock          INTEGER  NOT NULL 
    ) 
;

ALTER TABLE SUCURSAL_PRODUCTO 
    ADD CONSTRAINT SUCURSAL_PRODUCTO_PK PRIMARY KEY ( id_producto, sigla_sucursal ) ;

ALTER TABLE BOLETA 
    ADD CONSTRAINT BOLETA_CLIENTE_FK FOREIGN KEY 
    ( 
     id_cliente
    ) 
    REFERENCES CLIENTE 
    ( 
     id_cliente
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_COMUNA_FK FOREIGN KEY 
    ( 
     cod_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     cod_comuna
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_REGION_FK FOREIGN KEY 
    ( 
     cod_region
    ) 
    REFERENCES REGION 
    ( 
     cod_region
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_BOLETA_FK FOREIGN KEY 
    ( 
     id_boleta
    ) 
    REFERENCES BOLETA 
    ( 
     id_boleta
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_PRODUCTO_FK FOREIGN KEY 
    ( 
     id_producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     id_producto
    ) 
;

ALTER TABLE MODELO 
    ADD CONSTRAINT MODELO_MARCA_FK FOREIGN KEY 
    ( 
     id_marca
    ) 
    REFERENCES MARCA 
    ( 
     id_marca
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_CATEGORIA_FK FOREIGN KEY 
    ( 
     id_categoria
    ) 
    REFERENCES CATEGORIA 
    ( 
     id_categoria
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_MODELO_FK FOREIGN KEY 
    ( 
     id_modelo,
     id_marca
    ) 
    REFERENCES MODELO 
    ( 
     id_modelo,
     id_marca
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_PROVEEDOR_FKv2 FOREIGN KEY 
    ( 
     rut_proveedor
    ) 
    REFERENCES PROVEEDOR 
    ( 
     rut
    ) 
;

ALTER TABLE PROVEEDOR_PERSONA_NATURAL 
    ADD CONSTRAINT PROV_PER_NATL_PROV_FK FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PROVEEDOR 
    ( 
     rut
    ) 
;

ALTER TABLE PROVEEDOR_EMPRESA 
    ADD CONSTRAINT PROVEEDOR_EMPRESA_PROVEEDOR_FK FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PROVEEDOR 
    ( 
     rut
    ) 
;

ALTER TABLE SUCURSAL 
    ADD CONSTRAINT SUCURSAL_COMUNA_FK FOREIGN KEY 
    ( 
     cod_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     cod_comuna
    ) 
;

ALTER TABLE SUCURSAL_PRODUCTO 
    ADD CONSTRAINT SUCURSAL_PRODUCTO_PRODUCTO_FK FOREIGN KEY 
    ( 
     id_producto
    ) 
    REFERENCES PRODUCTO 
    ( 
     id_producto
    ) 
;

ALTER TABLE SUCURSAL_PRODUCTO 
    ADD CONSTRAINT SUCURSAL_PRODUCTO_SUCURSAL_FK FOREIGN KEY 
    ( 
     sigla_sucursal
    ) 
    REFERENCES SUCURSAL 
    ( 
     sigla
    ) 
;

CREATE OR REPLACE TRIGGER ARC_FKArc_2_PROVEEDOR_EMPRESA 
BEFORE INSERT OR UPDATE OF rut 
ON PROVEEDOR_EMPRESA 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tipo_proveedor INTO d 
    FROM PROVEEDOR A 
    WHERE A.rut = :new.rut; 
    IF (d IS NULL OR d <> 'E') THEN 
        raise_application_error(-20223,'FK PROVEEDOR_EMPRESA_PROVEEDOR_FK in Table PROVEEDOR_EMPRESA violates Arc constraint on Table PROVEEDOR - discriminator column tipo_proveedor doesn''t have value ''E'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/

CREATE OR REPLACE TRIGGER ARC__PROVEEDOR_PERSONA_NATURAL 
BEFORE INSERT OR UPDATE OF rut 
ON PROVEEDOR_PERSONA_NATURAL 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tipo_proveedor INTO d 
    FROM PROVEEDOR A 
    WHERE A.rut = :new.rut; 
    IF (d IS NULL OR d <> 'P') THEN 
        raise_application_error(-20223,'FK PROV_PER_NATL_PROV_FK in Table PROVEEDOR_PERSONA_NATURAL violates Arc constraint on Table PROVEEDOR - discriminator column tipo_proveedor doesn''t have value ''P'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             28
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
