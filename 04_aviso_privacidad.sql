USE bd_escolar_unidad2;

-- Tabla maestra de control para el registro histórico de validación del aviso de privacidad
CREATE TABLE IF NOT EXISTS control_aviso_privacidad (
    registro_aviso_id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT NOT NULL,
    version_documento VARCHAR(20) NOT NULL, -- Ej: 'V2.1-JULIO2026'
    fecha_aceptacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    origen_consentimiento VARCHAR(100) NOT NULL, -- Ej: 'Formulario Web de Inscripción'
    FOREIGN KEY (alumno_id) REFERENCES alumnos(alumno_id) ON DELETE CASCADE
);