#!/usr/bin/env bash
# ==============================================================================
# Installer / Uninstaller for Developer Agent Skills & MCP Servers
# Platforms: Antigravity, OpenCode, Claude Code, Cursor, universal .agents/skills
# Repository: https://github.com/Brxynxr/zen
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/Brxynxr/zen.git"

# Detect if executing inside a cloned repo or via curl pipe
if [ -d "./skills" ] && [ -f "./install.sh" ]; then
    INSTALL_DIR="$(pwd -P)"
elif [ -d "${HOME}/Projects/zen/.git" ]; then
    INSTALL_DIR="${HOME}/Projects/zen"
elif [ -d "${HOME}/Projects/skill/.git" ]; then
    INSTALL_DIR="${HOME}/Projects/skill"
else
    INSTALL_DIR="${HOME}/.agents-zen"
fi

SOURCE_SKILLS_DIR="${INSTALL_DIR}/skills"
TARGET_DIRS=(
    "${HOME}/.agents/skills"
    "${HOME}/.gemini/config/skills"
    "${HOME}/.claude/skills"
)

# ------------------------------------------------------------------------------
# Mode: Uninstall
# ------------------------------------------------------------------------------
if [ "${1:-}" = "--uninstall" ] || [ "${1:-}" = "-u" ]; then
    echo "🧹 Desinstalando skills de Zen..."
    for target in "${TARGET_DIRS[@]}"; do
        if [ -d "${target}" ]; then
            for skill_path in "${SOURCE_SKILLS_DIR}"/*; do
                skill_name="$(basename "${skill_path}")"
                link_file="${target}/${skill_name}"
                if [ -L "${link_file}" ]; then
                    rm -f "${link_file}"
                    echo "   🗑️  Eliminado enlace: ${link_file}"
                fi
            done
        fi
    done
    echo "✅ Desinstalación de enlaces completada."
    exit 0
fi

# ------------------------------------------------------------------------------
# Dependency Verification
# ------------------------------------------------------------------------------
echo "🔍 Verificando dependencias del sistema..."
for cmd in git node npx; do
    if ! command -v "${cmd}" >/dev/null 2>&1; then
        echo "   ⚠️  Advertencia: '${cmd}' no se encuentra en el PATH. Algunas skills o servidores MCP pueden no operar."
    fi
done

# If repository is not yet cloned in INSTALL_DIR, clone or update it
if [ ! -d "${INSTALL_DIR}/.git" ]; then
    echo "📦 Clonando repositorio Zen en ${INSTALL_DIR}..."
    mkdir -p "$(dirname "${INSTALL_DIR}")"
    git clone --depth 1 "${REPO_URL}" "${INSTALL_DIR}"
    cd "${INSTALL_DIR}"
else
    cd "${INSTALL_DIR}"
    echo "🔄 Actualizando repositorio de skills (${INSTALL_DIR})..."
    git pull --quiet 2>/dev/null || true
fi

if [ ! -d "${SOURCE_SKILLS_DIR}" ]; then
    echo "❌ Error: No se encontró la carpeta de skills en ${SOURCE_SKILLS_DIR}"
    exit 1
fi

# ------------------------------------------------------------------------------
# 1. Enlace de Skills hacia plataformas soportadas
# ------------------------------------------------------------------------------
echo ""
echo "🔗 Vinculando skills a plataformas soportadas (Antigravity, OpenCode, Claude Code)..."

SKILL_COUNT=0
for skill_path in "${SOURCE_SKILLS_DIR}"/*; do
    if [ -d "${skill_path}" ]; then
        SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
done

for target in "${TARGET_DIRS[@]}"; do
    mkdir -p "${target}"
    for skill_path in "${SOURCE_SKILLS_DIR}"/*; do
        if [ -d "${skill_path}" ]; then
            skill_name="$(basename "${skill_path}")"
            ln -sfn "${skill_path}" "${target}/${skill_name}"
        fi
    done
    echo "   ✅ [${SKILL_COUNT} skills] vinculadas en -> ${target}"
done

# ------------------------------------------------------------------------------
# 2. Configuración MCP No Destructiva (Merge JSON con servidores locales)
# ------------------------------------------------------------------------------
MCP_SOURCE="${INSTALL_DIR}/mcp_config.json"
if [ -f "${MCP_SOURCE}" ] && command -v python3 >/dev/null 2>&1; then
    echo ""
    echo "🔌 Sincronizando servidores MCP (merge seguro sin borrar servidores existentes)..."

    MCP_TARGETS=(
        "${HOME}/.gemini/config/mcp_config.json"
        "${HOME}/.config/opencode/mcp_config.json"
    )

    # Si existe directorio de Cursor, también añadir su configuración
    if [ -d "${HOME}/.cursor" ]; then
        MCP_TARGETS+=("${HOME}/.cursor/mcp.json")
    fi

    for target_mcp in "${MCP_TARGETS[@]}"; do
        mkdir -p "$(dirname "${target_mcp}")"
        python3 - <<EOF
import json, os

target_path = os.path.expanduser("${target_mcp}")
source_path = os.path.expanduser("${MCP_SOURCE}")

try:
    with open(source_path, 'r', encoding='utf-8') as sf:
        source_data = json.load(sf)
except Exception as e:
    print(f"   ❌ Error al leer fuente MCP: {e}")
    exit(0)

existing_data = {"mcpServers": {}}
if os.path.exists(target_path) and not os.path.islink(target_path):
    try:
        with open(target_path, 'r', encoding='utf-8') as tf:
            existing_data = json.load(tf)
    except Exception:
        existing_data = {"mcpServers": {}}

if "mcpServers" not in existing_data or not isinstance(existing_data["mcpServers"], dict):
    existing_data["mcpServers"] = {}

# Merge conservando servidores pre-existentes del usuario
for k, v in source_data.get("mcpServers", {}).items():
    existing_data["mcpServers"][k] = v

with open(target_path, 'w', encoding='utf-8') as out:
    json.dump(existing_data, out, indent=2, ensure_ascii=False)
    out.write("\n")

print(f"   ✅ [mcp_config sincronizado] -> {target_path}")
EOF
    done
fi

echo ""
echo "🎉 ¡Instalación completada exitosamente!"
echo "Tus ${SKILL_COUNT} skills y tus servidores MCP (context7, playwright, memory, sequential-thinking, docker) están listos."
echo "👉 Para iniciar en cualquier proyecto, solo escribe: hola (o zen)"
echo "💡 Para desinstalar los enlaces en el futuro, ejecuta: ./install.sh --uninstall"
