USE bd_escolar_unidad2;

-- Vista 1: Reporte General Escolar de Alumnos (Sin datos sensibles expuestos)
CREATE OR REPLACE VIEW vw_alumnos_minimizada AS
SELECT 
    alumno_id,
    matricula,
    CONCAT(nombre, ' ', primer_apellido, ' ', COALESCE(segundo_apellido, '')) AS estudiante,
    correo_institucional,
    carrera_id,
    grupo_id
FROM alumnos
WHERE activo = 1; -- El borrado lógico descarta automáticamente a los alumnos suspendidos o bloqueados

-- Vista 2: Reporte de Docentes con Datos Minimizados
CREATE OR REPLACE VIEW vw_docentes_minimizada AS
SELECT 
    docente_id,
    numero_empleado,
    CONCAT(nombre, ' ', primer_apellido, ' ', COALESCE(segundo_apellido, '')) AS docente,
    correo_institucional
FROM docentes
WHERE activo = 1;

-- Asignación exclusiva de permisos de lectura sobre las vistas sanitizadas al usuario operativo
GRANT SELECT ON bd_escolar_unidad2.vw_alumnos_minimizada TO 'usr_reportes_escolares'@'localhost';
GRANT SELECT ON bd_escolar_unidad2.vw_docentes_minimizada TO 'usr_reportes_escolares'@'localhost';
FLUSH PRIVILEGES;