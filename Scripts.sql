/*TABLA DEPARTAMENTO*/
CREATE TABLE departamento (
    id_depto     NUMBER(9),
    departamento VARCHAR2(150),
    CONSTRAINT pk_departamento PRIMARY KEY ( id_depto )
);

/*TABLA CABECERA*/
CREATE TABLE cabecera (
    id_cabecera NUMBER(9),
    cabecera    VARCHAR2(150),
    id_depto    NUMBER(9),
    CONSTRAINT pk_cabecera PRIMARY KEY ( id_cabecera ),
    CONSTRAINT fk_depto_id FOREIGN KEY ( id_depto ) REFERENCES departamento ( id_depto )
);


/*TABLA TIPO_VIAJE*/
CREATE TABLE tipo_viaje (
    id_tipo_viaje NUMBER(9),
    tipo          VARCHAR2(150),
    CONSTRAINT pk_tipo PRIMARY KEY ( id_tipo_viaje )
);


/*TABLA CATEGORIA*/
CREATE TABLE categoria (
    id_categoria NUMBER(9),
    categoria    VARCHAR2(150),
    CONSTRAINT pk_categoria PRIMARY KEY ( id_categoria )
);


/*TABLA TIPO_PLACA*/
CREATE TABLE tipo_placa (
    id_tipo_placa NUMBER(9),
    tipo_placa    VARCHAR2(150),
    CONSTRAINT pk_tipo_placa PRIMARY KEY ( id_tipo_placa )
);


/*TABLA MARCA*/
CREATE TABLE marca (
    id_marca NUMBER(9),
    marca    VARCHAR2(150),
    CONSTRAINT pk_marca PRIMARY KEY ( id_marca )
);

/*TABLA LINEA*/
CREATE TABLE linea (
    id_linea NUMBER(9),
    linea    VARCHAR2(150),
    id_marca NUMBER(9),
    CONSTRAINT pk_linea PRIMARY KEY ( id_linea ),
    CONSTRAINT fk_marca FOREIGN KEY ( id_marca ) REFERENCES marca ( id_marca )
);


/*TABLA COLOR*/
CREATE TABLE color (
    id_color NUMBER(9),
    color    VARCHAR2(150),
    CONSTRAINT pk_color PRIMARY KEY ( id_color )
);


/*TABLA TIPO_BUS*/
CREATE TABLE tipo_bus (
    id_tipo_bus NUMBER(9),
    tipo_bus    VARCHAR2(150),
    CONSTRAINT pk_tipo_bus PRIMARY KEY ( id_tipo_bus )
);


/*TABLA BUS*/
CREATE TABLE bus (
    id_bus        NUMBER(9),
    placa         VARCHAR2(8),
    anio          VARCHAR2(4),
    no_pasajeros  NUMBER(3),
    estado_bus    VARCHAR2(1),
    id_tipo_bus   NUMBER(9),
    id_tipo_placa NUMBER(9),
    id_color      NUMBER(9),
    id_linea      NUMBER(9),
    CONSTRAINT pk_bus PRIMARY KEY ( id_bus ),
    CONSTRAINT fk_bus_tipo FOREIGN KEY ( id_tipo_bus )REFERENCES tipo_bus ( id_tipo_bus ),
    CONSTRAINT fk_placa_tipo FOREIGN KEY ( id_tipo_placa ) REFERENCES tipo_placa ( id_tipo_placa ),
    CONSTRAINT fk_color FOREIGN KEY ( id_color ) REFERENCES color ( id_color ),
    CONSTRAINT fk_linea FOREIGN KEY ( id_linea ) REFERENCES linea ( id_linea )
);



/*TABLA TIPO_LICENCIA*/
CREATE TABLE tipo_licencia (
    id_tipo_licencia NUMBER(9),
    tipo_licencia    VARCHAR2(1),
    estado_licencia  VARCHAR2(1),
    CONSTRAINT pk_tipo_licencia PRIMARY KEY ( id_tipo_licencia )
);


/*TABLA PILOTO*/
CREATE TABLE piloto (
    id_piloto        NUMBER(9),
    nombre           VARCHAR2(1),
    apellido         VARCHAR2(1),
    estado_piloto    VARCHAR2(1),
    no_licencia      NUMBER(13),
    id_tipo_licencia NUMBER(9),
    CONSTRAINT pk_piloto PRIMARY KEY ( id_piloto ),
    CONSTRAINT fk_licencia_tipo FOREIGN KEY ( id_tipo_licencia ) REFERENCES tipo_licencia ( id_tipo_licencia )
);


/*TABLA VIAJE*/
CREATE TABLE viaje (
    id_viaje            NUMBER(9),
    id_cabecera_incio   NUMBER(9),
    id_cabecera_destino NUMBER(9),
    id_tipo_viaje       NUMBER(9),
    id_piloto           NUMBER(9),
    id_bus              NUMBER(9),
    id_categoria        NUMBER(9),
    escala              VARCHAR2(1),
    fecha_hora_salida   TIMESTAMP,
    fecha_hora_llegada  TIMESTAMP,
    CONSTRAINT pk_viaje PRIMARY KEY ( id_viaje ),
    CONSTRAINT fk_cabcera_inicio FOREIGN KEY ( id_cabecera_incio ) REFERENCES cabecera ( id_cabecera ),
    CONSTRAINT fk_cabcera_destino FOREIGN KEY ( id_cabecera_destino ) REFERENCES cabecera ( id_cabecera ),
    CONSTRAINT fk_viaje_tipo FOREIGN KEY ( id_tipo_viaje )REFERENCES tipo_viaje ( id_tipo_viaje ),
    CONSTRAINT fk_piloto FOREIGN KEY ( id_piloto ) REFERENCES piloto ( id_piloto ),
    CONSTRAINT fk_bus FOREIGN KEY ( id_bus ) REFERENCES bus ( id_bus ),
    CONSTRAINT fk_categoria FOREIGN KEY ( id_categoria ) REFERENCES categoria ( id_categoria )
);


/*TABLA ESCALA_VIAJE*/
CREATE TABLE escala_viaje (
    id_escala_viaje NUMBER(9),
    id_viaje        NUMBER(9),
    id_cabecera_escala NUMBER(9),
    CONSTRAINT pk_escala PRIMARY KEY ( id_escala_viaje ),
    CONSTRAINT fk_viaje FOREIGN KEY ( id_viaje ) REFERENCES viaje ( id_viaje ),
    CONSTRAINT fk_cabecera FOREIGN KEY ( id_cabecera_escala ) REFERENCES cabecera ( id_cabecera )
);



/*TABLA ENCOMIENDA*/
CREATE TABLE encomienda (
    id_encomienda       NUMBER(9),
    id_viaje            NUMBER(9),
    peso                NUMBER(13, 2),
    precio              NUMBER(13, 2),
    descripcion         VARCHAR2(150),
    nombre_remitente    VARCHAR2(150),
    nombre_destinatario VARCHAR2(150),
    telefono            NUMBER(8),
    CONSTRAINT pk_encomienda PRIMARY KEY ( id_encomienda ),
    CONSTRAINT fk_encomienda_viaje FOREIGN KEY ( id_viaje ) REFERENCES viaje ( id_viaje )
);


/*TABLA TIPO_PAGO*/
CREATE TABLE tipo_pago (
    id_tipo_pago NUMBER(9),
    tipo_pago    VARCHAR2(150),
    banco        VARCHAR2(150),
    CONSTRAINT pk_tipo_pago PRIMARY KEY ( id_tipo_pago )
);


/*TABLA ESTADO_RESERVACION*/
CREATE TABLE estado_reservacion (
    id_estado_reserva NUMBER(9),
    estado            VARCHAR2(150),
    CONSTRAINT pk_estado_reserva PRIMARY KEY ( id_estado_reserva )
);


/*TABLA RESERVACION*/
CREATE TABLE reservacion (
    id_reservacion    NUMBER(9),
    id_estado_reserva NUMBER(9),
    id_viaje          NUMBER(9),
    id_tipo_pago      NUMBER(9),
    nombre            VARCHAR2(150),
    apellido          VARCHAR2(150),
    imagen            BFILE,
    asiento           NUMBER(3),
    CONSTRAINT pk_reservacion PRIMARY KEY ( id_reservacion ),
    CONSTRAINT fk_id_estado_reser FOREIGN KEY ( id_estado_reserva )REFERENCES estado_reservacion ( id_estado_reserva ),
    CONSTRAINT fk_viaje_reser FOREIGN KEY ( id_viaje )REFERENCES viaje ( id_viaje ),
    CONSTRAINT fk_tipo_pago_reser FOREIGN KEY ( id_tipo_pago )  REFERENCES tipo_pago ( id_tipo_pago )
);


/*TABLA AUTORIZA_RESERVA*/
CREATE TABLE autoriza_reserva (
    correlativo       NUMBER(9),
    id_tipo_pago      NUMBER(9),
    id_estado_reserva NUMBER(9),
    autorizado_por    VARCHAR2(150),
    fecha             DATE,
    CONSTRAINT pk_autoriza_reserva PRIMARY KEY ( correlativo ),
    CONSTRAINT fk_pago_tipo FOREIGN KEY ( id_tipo_pago ) REFERENCES tipo_pago ( id_tipo_pago ),
    CONSTRAINT fk_estado_reser FOREIGN KEY ( id_estado_reserva ) REFERENCES estado_reservacion ( id_estado_reserva )
);



/*TABLA DETALLE_RESERVACION*/
CREATE TABLE detalle_reservacion (
    id_detalle_reserva NUMBER(9),
    id_reservacion     NUMBER(9),
    id_encomienda      NUMBER(9),
    pasajero           NUMBER(3),
    total              NUMBER(13, 2),
    CONSTRAINT pk_detalle_reserva PRIMARY KEY ( id_detalle_reserva ),
    CONSTRAINT fk_reserva_deta FOREIGN KEY ( id_reservacion ) REFERENCES reservacion ( id_reservacion ),
    CONSTRAINT fk_encomienda_deta FOREIGN KEY ( id_encomienda )REFERENCES encomienda ( id_encomienda )
);



/*TABLA DETALLE_PAGO*/
CREATE TABLE detalle_pago (
    id_detalle_pago NUMBER(9),
    id_reservacion  NUMBER(9),
    cantidad        NUMBER(10),
    precio          NUMBER(10, 2),
    serie           VARCHAR2(30),
    CONSTRAINT pk_detalle_pago PRIMARY KEY ( id_detalle_pago ),
    CONSTRAINT fk_reserva FOREIGN KEY ( id_reservacion ) REFERENCES reservacion ( id_reservacion )
);



ALTER TABLE AUTORIZA_RESERVA  DROP CONSTRAINT fk_estado_reser;   
ALTER TABLE AUTORIZA_RESERVA  DROP COLUMN id_estado_reserva;   
ALTER TABLE AUTORIZA_RESERVA  ADD id_reservacion NUMBER(9);   
ALTER TABLE AUTORIZA_RESERVA  ADD FOREIGN KEY (ID_RESERVACION) REFERENCES RESERVACION(ID_RESERVACION);   


ALTER TABLE ENCOMIENDA  DROP CONSTRAINT fk_encomienda_viaje;   
ALTER TABLE ENCOMIENDA  DROP COLUMN id_viaje;   

