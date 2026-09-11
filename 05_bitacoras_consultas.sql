USE bd_escolar_unidad2;

-- 1. Tabla Centralizada de Bitácora de Cambios de Privacidad
CREATE TABLE IF NOT EXISTS bitacora_privacidad_escolar (
    bitacora_id INT AUTO_INCREMENT PRIMARY KEY,
    entidad_afectada VARCHAR(50) NOT NULL,
    llave_primaria_id INT NOT NULL,
    atributo_modificado VARCHAR(50) NOT NULL,
    valor_previo TEXT,
    valor_posterior TEXT,
    usuario_transaccion VARCHAR(100) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Trigger para Auditoría en la Tabla Alumnos
DELIMITER //
CREATE TRIGGER trg_auditar_alumnos_cambios
AFTER UPDATE ON alumnos
FOR EACH ROW
BEGIN
    -- Monitorear cambios en Teléfono
    IF (OLD.telefono <> NEW.telefono) OR (OLD.telefono IS NULL AND NEW.telefono IS NOT NULL) THEN
        INSERT INTO bitacora_privacidad_escolar (entidad_afectada, llave_primaria_id, atributo_modificado, valor_previo, valor_posterior, usuario_transaccion)
        VALUES ('alumnos', OLD.alumno_id, 'telefono', OLD.telefono, NEW.telefono, USER());
    END IF;

    -- Monitorear cambios en Domicilio
    IF (OLD.domicilio <> NEW.domicilio) OR (OLD.domicilio IS NULL AND NEW.domicilio IS NOT NULL) THEN
        INSERT INTO bitacora_privacidad_escolar (entidad_afectada, llave_primaria_id, atributo_modificado, valor_previo, valor_posterior, usuario_transaccion)
        VALUES ('alumnos', OLD.alumno_id, 'domicilio', OLD.domicilio, NEW.domicilio, USER());
    END IF;

    -- Monitorear transiciones de Borrado Lógico (Cancelación o Bloqueo)
    IF OLD.activo <> NEW.activo THEN
        INSERT INTO bitacora_privacidad_escolar (entidad_afectada, llave_primaria_id, atributo_modificado, valor_previo, valor_posterior, usuario_transaccion)
        VALUES ('alumnos', OLD.alumno_id, 'activo (borrado logico)', OLD.activo, NEW.activo, USER());
    END IF;
END //
DELIMITER ;