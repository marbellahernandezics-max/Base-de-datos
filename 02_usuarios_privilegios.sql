-- 1. Usuario Oficial de Auditoría y Control de Privacidad (Acceso Completo Interno)
CREATE USER IF NOT EXISTS 'sec_admin_escolar'@'localhost' IDENTIFIED BY 'CryptoSchoolAdmin2026$';
GRANT ALL PRIVILEGES ON bd_escolar_unidad2.* TO 'sec_admin_escolar'@'localhost';

-- 2. Usuario Operativo de Ventanilla y Reportes (Acceso ultra restringido a vistas sanitizadas)
CREATE USER IF NOT EXISTS 'usr_reportes_escolares'@'localhost' IDENTIFIED BY 'SafeReportUsr_2026!';

-- Se limpian privilegios para asegurar la correcta carga del diccionario de accesos
FLUSH PRIVILEGES;