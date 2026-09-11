USE bd_escolar_unidad2;

-- Ampliar la tabla de alumnos para añadir metadatos de auditoría de privacidad y borrado lógico
ALTER TABLE alumnos 
ADD COLUMN fecha_baja DATETIME DEFAULT NULL,
ADD COLUMN motivo_baja VARCHAR(255) DEFAULT NULL,
ADD COLUMN operador_baja VARCHAR(100) DEFAULT NULL;

-- Ampliar la tabla de docentes para auditoría de privacidad y borrado lógico
ALTER TABLE docentes 
ADD COLUMN fecha_baja DATETIME DEFAULT NULL,
ADD COLUMN motivo_baja VARCHAR(255) DEFAULT NULL,
ADD COLUMN operador_baja VARCHAR(100) DEFAULT NULL;