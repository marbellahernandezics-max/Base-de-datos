USE bd_escolar_unidad2;

-- PRUEBA 1: Registro formal de aceptación del aviso de privacidad de un estudiante
INSERT INTO control_aviso_privacidad (alumno_id, version_documento, origen_consentimiento)
VALUES (1, 'V1.0_2026', 'Portal Web Institucional');

-- PRUEBA 2: Modificación de datos protegidos de contacto (Debe disparar el Trigger de auditoría)
UPDATE alumnos 
SET telefono = '6189991122', domicilio = 'Paseo de las Camelias #404, Durango' 
WHERE alumno_id = 1;

-- PRUEBA 3: Solicitud de Derecho ARCO - Ejecución de Borrado Lógico (Cancelación técnica)
UPDATE alumnos 
SET activo = 0, fecha_baja = NOW(), motivo_baja = 'Ejercicio de Derecho de Cancelación (LFPDPPP)', operador_baja = USER()
WHERE alumno_id = 2;

-- CONSULTAS DE VERIFICACIÓN DE EVIDENCIAS:
SELECT * FROM control_aviso_privacidad;
SELECT * FROM bitacora_privacidad_escolar;
SELECT * FROM vw_alumnos_minimizada; -- El alumno_id 2 ya no debe mostrarse por estar inactivo