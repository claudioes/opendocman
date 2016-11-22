-- BASE DE DATOS ODM
ALTER TABLE `odm_data`
	ADD COLUMN `rb_id` INT NULL DEFAULT NULL AFTER `reviewer_comments`,
	ADD COLUMN `rb_operacion_id` INT NULL DEFAULT NULL AFTER `rb_id`;

CREATE TABLE `odm_export_rp` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`data_id` INT(11) NOT NULL,
	`destination` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

ALTER TABLE `odm_data`
	DROP INDEX `id`,
	DROP INDEX `id_2`,
	DROP INDEX `data_idx`;

ALTER TABLE `odm_user_perms`
	DROP INDEX `user_perms_idx`,
	DROP INDEX `fid`,
	DROP INDEX `uid`,
	DROP INDEX `rights`;


-- BASE DE DATOS MAZDEN
DROP TABLE rp_documentos;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `pr_generar_rp`(
	IN `P_RB_ID` INT,
	IN `P_OT_ID` INT,
	OUT `O_RP_ID` INT

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- Registro de produccion
	INSERT INTO rp
	(
		idrb
		,idot
		,codigo
		,detalle
		,mi_alto
		,mi_ancho
		,mi_largo
		,mu_alto
		,mu_ancho
		,mu_largo
		,me_alto
		,me_ancho
		,me_largo
		,puertas
		,puertas_tipo
		,puertas_sentido
		,puertas_accionamiento
		,tablero_ubicacion_comando
		,tablero_ubicacion_general
		,tension
		,frecuencia
		,calefaccion_tipo
		,calefaccion_potencia
		,calefaccion_resistencias
		,sensores
		,carros_internos
		,carros_internos_material
		,carros_internos_niveles
		,carros_internos_guias_fijas
		,carros_internos_guias_moviles
		,carros_externos
		,carros_externos_material
		,carros_externos_ruedas_fijas
		,carros_externos_ruedas_giratorias_cf
		,carros_externos_ruedas_giratorias_sf
		,bandejas
		,bandejas_tipo
		,bandejas_alto
		,bandejas_ancho
		,bandejas_largo
		,antiexplosivo
		,gabinete_hermetizacion
		,sistema_traslado
		,grafico_variables
		,generador_vapor
		,sistema_supervision
		,embalaje
		,version_plc
		,version_panel_principal
		,version_panel_auxiliar
		,calefaccion_tipo_resistencias
		,calefaccion_conectar_con
		,ensayos_recuento_particulas
		,ensayos_perfil_termico
		,ensayos_protocolo_fat
		,ensayos_medicion_velocidad_aire
		,ensayos_rayos_x
		,ensayos_rugosidad_camara
		,ensayos_rugosidad_puerta1
		,ensayos_rugosidad_puerta2
		,ensayos_rugosidad_generador_vapor
		,ensayos_rugosidad_fondo_camara
		,ensayos_rugosidad_tapa
		,ensayos_tintas_camara
		,ensayos_tintas_doble_camara
		,ensayos_tintas_generador_vapor
		,ensayos_tintas_serpentin
		,ciclos_programables
		,notas
		,advertencias
	)
	SELECT
		id
		,P_OT_ID
		,codigo
		,detalle
		,mi_alto
		,mi_ancho
		,mi_largo
		,mu_alto
		,mu_ancho
		,mu_largo
		,me_alto
		,me_ancho
		,me_largo
		,puertas
		,puertas_tipo
		,puertas_sentido
		,puertas_accionamiento
		,tablero_ubicacion_comando
		,tablero_ubicacion_general
		,tension
		,frecuencia
		,calefaccion_tipo
		,calefaccion_potencia
		,calefaccion_resistencias
		,sensores
		,carros_internos
		,carros_internos_material
		,carros_internos_niveles
		,carros_internos_guias_fijas
		,carros_internos_guias_moviles
		,carros_externos
		,carros_externos_material
		,carros_externos_ruedas_fijas
		,carros_externos_ruedas_giratorias_cf
		,carros_externos_ruedas_giratorias_sf
		,bandejas
		,bandejas_tipo
		,bandejas_alto
		,bandejas_ancho
		,bandejas_largo
		,antiexplosivo
		,gabinete_hermetizacion
		,sistema_traslado
		,grafico_variables
		,generador_vapor
		,sistema_supervision
		,embalaje
		,version_plc
		,version_panel_principal
		,version_panel_auxiliar
		,calefaccion_tipo_resistencias
		,calefaccion_conectar_con
		,ensayos_recuento_particulas
		,ensayos_perfil_termico
		,ensayos_protocolo_fat
		,ensayos_medicion_velocidad_aire
		,ensayos_rayos_x
		,ensayos_rugosidad_camara
		,ensayos_rugosidad_puerta1
		,ensayos_rugosidad_puerta2
		,ensayos_rugosidad_generador_vapor
		,ensayos_rugosidad_fondo_camara
		,ensayos_rugosidad_tapa
		,ensayos_tintas_camara
		,ensayos_tintas_doble_camara
		,ensayos_tintas_generador_vapor
		,ensayos_tintas_serpentin
		,ciclos_programables
		,notas
		,advertencias
	FROM rb
	WHERE id =  P_RB_ID;

	-- Obtengo el ID del registro de producción generado
	SET O_RP_ID = LAST_INSERT_ID();

	-- Cañerias
	INSERT INTO rp_canerias(
	    idrp
	    ,id
	    ,material
	    ,diametro
	    ,control
	    ,soldadura_orbital
	)
	SELECT
	    O_RP_ID
	    ,id
	    ,material
	    ,diametro
	    ,control
	    ,soldadura_orbital
	FROM rb_canerias
	WHERE idrb = P_RB_ID;

	-- Ensayos
	INSERT INTO rp_ensayos(
	    idrp
	    ,id
	    ,presion_trabajo
	    ,presion_prueba
	)
	SELECT
	    O_RP_ID
	    ,id
	    ,presion_trabajo
	    ,presion_prueba
	FROM rb_ensayos
	WHERE idrb = P_RB_ID;

	-- Limites
	INSERT INTO rp_limites(
	    idrp
	    ,id
	    ,minima
	    ,maxima
	    ,tolerancia
	)
	SELECT
	    O_RP_ID
	    ,id
	    ,minima
	    ,maxima
	    ,tolerancia
	FROM rb_limites
	WHERE idrb = P_RB_ID;
END$$
DELIMITER ;
