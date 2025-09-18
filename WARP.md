---
domain: proyecto
project: OmenShell
version: "1.0.0"
created: 2025-09-18T12:20:19Z
updated: 2025-09-18T12:20:19Z
author: AI Assistant (Claude)
type: optimization_rules
---

# WARP.md - OmenShell Project Optimization Rules

## Resumen del proyecto

**OmenShell** es una herramienta CLI para gestionar múltiples servidores Linux a través de SSH con una interfaz unificada. Permite ejecutar comandos de diagnóstico y monitoreo en varios servidores simultáneamente.

## Arquitectura actual

### Componentes principales
- `omen.sh` - Script principal con opciones de comando
- `omenshell.sh` - Ejecutor de comandos SSH masivos
- `install.sh` - Script de instalación
- `omen.host` - Lista de servidores objetivo
- `future.tlf` - Fuente tipográfica personalizada para figlet

### Stack tecnológico
- **Lenguaje**: Bash 5.1.16+
- **Plataforma**: Linux (Ubuntu 22.04.3 LTS)
- **Dependencias**: SSH, figlet, speedtest-cli (opcional)
- **Licencia**: GPLv3

## Optimizaciones críticas identificadas

### 1. Seguridad (CRÍTICO)

#### 1.1 SSH Key Management
**Problema**: Clave SSH hardcodeada (`~/.ssh/id_rsa`)
```bash
# ACTUAL (problemático)
ssh -o LogLevel=error $USER@$x -i ~/.ssh/id_rsa $1
```
**Solución**:
```bash
# OPTIMIZADO
SSH_KEY="${SSH_KEY:-$HOME/.ssh/id_rsa}"
ssh -o LogLevel=error "$USER@$x" -i "$SSH_KEY" "$1"
```

#### 1.2 Validación de entrada
**Problema**: No validación de argumentos
```bash
# AGREGAR validación
validate_host() {
    if [[ ! "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        echo "Error: IP address format invalid: $1" >&2
        return 1
    fi
}
```

#### 1.3 Manejo seguro de sudo
**Problema**: `sudo -S` sin validación
```bash
# OPTIMIZADO - verificar permisos primero
check_sudo_perms() {
    ssh -o LogLevel=error "$USER@$1" 'sudo -n true' 2>/dev/null
}
```

### 2. Rendimiento (ALTO)

#### 2.1 Ejecución paralela
**Problema**: Ejecución secuencial lenta
```bash
# ACTUAL (secuencial)
for x in `cat ~/bin/omen.host`; do
    ssh $USER@$x $command
done

# OPTIMIZADO (paralelo)
parallel_ssh() {
    local command="$1"
    while IFS= read -r host; do
        ssh_command "$host" "$command" &
    done < ~/bin/omen.host
    wait
}
```

#### 2.2 Timeouts SSH
```bash
# AGREGAR timeout
SSH_TIMEOUT="${SSH_TIMEOUT:-30}"
ssh -o ConnectTimeout="$SSH_TIMEOUT" -o LogLevel=error "$USER@$host" "$command"
```

#### 2.3 Connection reuse
```bash
# OPTIMIZAR conexiones SSH
ssh -o ControlMaster=auto -o ControlPath=/tmp/ssh-%r@%h:%p -o ControlPersist=300
```

### 3. Mantenibilidad (ALTO)

#### 3.1 Configuración centralizada
```bash
# config.sh - nuevo archivo
#!/bin/bash
OMEN_CONFIG_DIR="${OMEN_CONFIG_DIR:-$HOME/.config/omen}"
OMEN_HOST_FILE="${OMEN_HOST_FILE:-$OMEN_CONFIG_DIR/hosts}"
OMEN_SSH_KEY="${OMEN_SSH_KEY:-$HOME/.ssh/id_rsa}"
OMEN_LOG_FILE="${OMEN_LOG_FILE:-$OMEN_CONFIG_DIR/omen.log}"
```

#### 3.2 Logging system
```bash
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" >> "$OMEN_LOG_FILE"
    [[ "$level" == "ERROR" ]] && echo "$message" >&2
}
```

#### 3.3 Error handling
```bash
ssh_command() {
    local host="$1"
    local command="$2"
    
    if ! ssh -o ConnectTimeout=10 -o BatchMode=yes \
         -o LogLevel=error "$USER@$host" \
         -i "$SSH_KEY" "$command" 2>/dev/null; then
        log "ERROR" "Failed to execute command on $host: $command"
        return 1
    fi
}
```

### 4. Portabilidad (MEDIO)

#### 4.1 Detección de distribución
```bash
detect_distro() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "debian"
    elif command -v dnf >/dev/null 2>&1; then
        echo "fedora"
    elif command -v yum >/dev/null 2>&1; then
        echo "rhel"
    else
        echo "unknown"
    fi
}
```

#### 4.2 Package manager abstraction
```bash
install_package() {
    local package="$1"
    case $(detect_distro) in
        debian) sudo apt-get update && sudo apt-get install -y "$package" ;;
        fedora) sudo dnf install -y "$package" ;;
        rhel) sudo yum install -y "$package" ;;
        *) log "ERROR" "Unsupported distribution" && return 1 ;;
    esac
}
```

## Convenciones del proyecto

### Nomenclatura
- **Funciones**: `snake_case` (ej: `ssh_command`, `validate_host`)
- **Variables**: `UPPER_CASE` para configuración, `lower_case` para variables locales
- **Archivos**: Mantener nombres actuales por compatibilidad

### Estructura de directorios propuesta
```
OmenShell/
├── bin/
│   ├── omen                    # Script principal
│   └── omenshell              # Ejecutor SSH
├── lib/
│   ├── config.sh              # Configuración
│   ├── ssh.sh                 # Funciones SSH
│   ├── logging.sh             # Sistema de logging
│   └── utils.sh               # Utilidades
├── config/
│   ├── hosts                  # Lista de servidores
│   └── omen.conf              # Configuración principal
├── share/
│   └── figlet/
│       └── future.tlf         # Fuente tipográfica
├── docs/
│   ├── README.md
│   ├── CHANGELOG.md
│   └── CONTRIBUTING.md
└── tests/
    └── test_omen.sh
```

### Standards de código
1. **Shebang**: Usar `#!/usr/bin/env bash`
2. **Set options**: `set -euo pipefail` en todos los scripts
3. **Quoting**: Always quote variables: `"$variable"`
4. **Arrays**: Usar arrays para listas: `hosts=("host1" "host2")`

## Próximos pasos recomendados

### Fase 1: Seguridad (Inmediato)
1. [ ] Implementar validación de entrada
2. [ ] Configurar SSH key path variable
3. [ ] Agregar manejo de errores básico
4. [ ] Implementar logging básico

### Fase 2: Performance (1-2 semanas)  
1. [ ] Implementar ejecución paralela
2. [ ] Agregar timeouts SSH
3. [ ] Optimizar conexiones SSH con ControlMaster
4. [ ] Implementar progress indicators

### Fase 3: Mantenibilidad (2-4 semanas)
1. [ ] Refactorizar en módulos separados
2. [ ] Implementar sistema de configuración
3. [ ] Agregar tests unitarios
4. [ ] Mejorar documentación

### Fase 4: Features (1-2 meses)
1. [ ] Soporte multi-distro
2. [ ] Interfaz web opcional
3. [ ] Monitoreo continuo
4. [ ] Dashboard de estado

## Testing strategy

### Unit tests
```bash
#!/usr/bin/env bash
# tests/test_omen.sh

test_validate_host() {
    validate_host "192.168.1.1" || fail "Valid IP rejected"
    ! validate_host "invalid.ip" || fail "Invalid IP accepted"
}

test_ssh_command() {
    # Mock SSH for testing
    SSH_CMD="echo" ssh_command "localhost" "uptime"
}
```

### Integration tests
1. Test con servidores de prueba locales
2. Verificar compatibilidad multi-distro
3. Performance tests con múltiples hosts

## Metrics y monitoring

### KPIs sugeridos
- **Response time**: Tiempo promedio de ejecución por servidor
- **Success rate**: % de comandos ejecutados exitosamente
- **Connection reuse**: % de conexiones reutilizadas
- **Error rate**: Errores por comando/servidor

### Logging structure
```json
{
  "timestamp": "2025-09-18T12:20:19Z",
  "level": "INFO",
  "host": "192.168.1.100",
  "command": "uptime",
  "duration_ms": 1240,
  "status": "success"
}
```

## Security checklist

- [ ] No hardcoded credentials
- [ ] Input validation implemented
- [ ] SSH keys properly managed
- [ ] Audit logging enabled
- [ ] Network segmentation considered
- [ ] Privilege escalation controlled
- [ ] Error messages don't leak information

## Dependencies management

### Current dependencies
- `bash` >= 5.0
- `ssh` client
- `figlet` (installable)
- `speedtest-cli` (optional)

### Recommended additions
- `parallel` (GNU parallel para ejecución paralela)
- `jq` (para parsing JSON en logs)
- `nc`/`nmap` (para health checks)

---

## Reglas específicas para desarrollo

### Commits
- Usar conventional commits: `feat:`, `fix:`, `docs:`, etc.
- Commits en inglés (siguiendo regla global)
- Un commit por cambio lógico

### Pull requests
- Requieren tests pasando
- Revisión de código obligatoria para cambios críticos
- Documentación actualizada

### Releases
- Semantic versioning (major.minor.patch)
- Changelog actualizado
- Tests de regresión completos

---

**Nota**: Este documento debe actualizarse conforme evolucione el proyecto. Revisar mensualmente para mantener relevancia.