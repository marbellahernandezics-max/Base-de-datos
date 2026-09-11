USE bd_escolar_unidad2;

-- 1. LIMPIEZA DE USUARIOS PREVIOS (Evita errores de duplicidad al ejecutar varias veces)
DROP USER IF EXISTS 'admin_escolar'@'localhost';
DROP USER IF EXISTS 'capturista_escolar'@'localhost';
DROP USER IF EXISTS 'usuario_reportes'@'localhost';
DROP USER IF EXISTS 'auditor_escolar'@'localhost';

-- =============================================================================
-- 2. CREACIÓN DE USUARIOS
-- =============================================================================

CREATE USER 'admin_escolar'@'localhost' IDENTIFIED BY 'AdminEscolar2026*';
CREATE USER 'capturista_escolar'@'localhost' IDENTIFIED BY 'CapturaEscolar2026*';
CREATE USER 'usuario_reportes'@'localhost' IDENTIFIED BY 'ReportesEscolar2026*';
CREATE USER 'auditor_escolar'@'localhost' IDENTIFIED BY 'AuditorEscolar2026*';

-- =============================================================================
-- 3. CREACIÓN DE VISTA PARA REPORTE (Requisito para el perfil de reportes)
-- =============================================================================

CREATE OR REPLACE VIEW vw_reporte_alumnos AS
SELECT 
    a.matricula,
    CONCAT(a.nombre, ' ', a.primer_apellido, ' ', IFNULL(a.segundo_apellido, '')) AS nombre_completo,
    c.nombre_carrera,
    g.nombre_grupo,
    g.cuatrimestre,
    a.correo_institucional
FROM alumnos a
JOIN carreras c ON a.carrera_id = c.carrera_id
JOIN grupos g ON a.grupo_id = g.grupo_id
WHERE a.activo = 1;

-- =============================================================================
-- 4. ASIGNACIÓN DE PRIVILEGIOS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- PERFIL 1: Administrador del Sistema
-- Acceso total sobre la base de datos escolar
-- -----------------------------------------------------------------------------
GRANT ALL PRIVILEGES ON bd_escolar_unidad2.* TO 'admin_escolar'@'localhost' WITH GRANT OPTION;


-- -----------------------------------------------------------------------------
-- PERFIL 2: Capturista Escolar
-- Puede consultar, agregar y modificar alumnos, docentes, inscripciones y calificaciones
-- -----------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE ON bd_escolar_unidad2.alumnos TO 'capturista_escolar'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bd_escolar_unidad2.docentes TO 'capturista_escolar'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bd_escolar_unidad2.inscripciones TO 'capturista_escolar'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bd_escolar_unidad2.calificaciones TO 'capturista_escolar'@'localhost';

-- Lectura sobre catálogos para poder hacer capturas válidas
GRANT SELECT ON bd_escolar_unidad2.carreras TO 'capturista_escolar'@'localhost';
GRANT SELECT ON bd_escolar_unidad2.grupos TO 'capturista_escolar'@'localhost';
GRANT SELECT ON bd_escolar_unidad2.materias TO 'capturista_escolar'@'localhost';
GRANT SELECT ON bd_escolar_unidad2.periodos TO 'capturista_escolar'@'localhost';

-- Restricción explícita de borrado (Seguridad de datos)
REVOKE DELETE ON bd_escolar_unidad2.alumnos FROM 'capturista_escolar'@'localhost';
REVOKE DELETE ON bd_escolar_unidad2.calificaciones FROM 'capturista_escolar'@'localhost';


-- -----------------------------------------------------------------------------
-- PERFIL 3: Usuario de Reportes
-- Acceso restringido únicamente a Vistas para no exponer datos personales sensibles
-- -----------------------------------------------------------------------------
GRANT SELECT ON bd_escolar_unidad2.vw_reporte_alumnos TO 'usuario_reportes'@'localhost';


-- -----------------------------------------------------------------------------
-- PERFIL 4: Auditor Escolar
-- Permiso exclusivo de solo lectura sobre todas las tablas del sistema
-- -----------------------------------------------------------------------------
GRANT SELECT ON bd_escolar_unidad2.* TO 'auditor_escolar'@'localhost';


-- =============================================================================
-- 5. REFRESCAR PRIVILEGIOS Y VERIFICAR
-- =============================================================================
FLUSH PRIVILEGES;

-- Comprobación visual de asignaciones
SHOW GRANTS FOR 'admin_escolar'@'localhost';
SHOW GRANTS FOR 'capturista_escolar'@'localhost';
SHOW GRANTS FOR 'usuario_reportes'@'localhost';
SHOW GRANTS FOR 'auditor_escolar'@'localhost';