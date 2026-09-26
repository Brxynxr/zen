#!/usr/bin/env bash
# ==============================================================================
# Installer for Developer Agent Skills & MCP Servers (Antigravity, OpenCode, etc.)
# Repository: https://github.com/Brxynxr/zen
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/Brxynxr/zen.git"

# Detect if executing inside a cloned repo or via curl pipe
if [ -d "./skills" ] && [ -f "./install.sh" ]; then
    INSTALL_DIR="$(pwd -P)"
elif [ -d "${HOME}/Projects/skill/.git" ]; then
    INSTALL_DIR="${HOME}/Projects/skill"
else
    INSTALL_DIR="${HOME}/.agents-zen"
fi

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

SOURCE_SKILLS_DIR="${INSTALL_DIR}/skills"

if [ ! -d "${SOURCE_SKILLS_DIR}" ]; then
    echo "❌ Error: No se encontró la carpeta de skills en ${SOURCE_SKILLS_DIR}"
    exit 1
fi

# 1. Enlace de Skills hacia plataformas soportadas
TARGET_DIRS=(
    "${HOME}/.agents/skills"
    "${HOME}/.gemini/config/skills"
)

echo "🔗 Vinculando skills a las plataformas soportadas..."

for target in "${TARGET_DIRS[@]}"; do
    mkdir -p "${target}"
    for skill_path in "${SOURCE_SKILLS_DIR}"/*; do
        if [ -d "${skill_path}" ]; then
            skill_name="$(basename "${skill_path}")"
            ln -sfn "${skill_path}" "${target}/${skill_name}"
            echo "   ✅ [${skill_name}] -> ${target}/${skill_name}"
        fi
    done
done

# 2. Enlace de configuración MCP (Servidores locales sin API keys)
MCP_SOURCE="${INSTALL_DIR}/mcp_config.json"
if [ -f "${MCP_SOURCE}" ]; then
    echo ""
    echo "🔌 Vinculando servidores MCP locales (Context7 + Playwright)..."
    
    # Antigravity global
    mkdir -p "${HOME}/.gemini/config"
    ln -sfn "${MCP_SOURCE}" "${HOME}/.gemini/config/mcp_config.json"
    echo "   ✅ [mcp_config.json] -> ${HOME}/.gemini/config/mcp_config.json"

    # OpenCode global
    mkdir -p "${HOME}/.config/opencode"
    ln -sfn "${MCP_SOURCE}" "${HOME}/.config/opencode/mcp_config.json"
    echo "   ✅ [mcp_config.json] -> ${HOME}/.config/opencode/mcp_config.json"
fi

echo ""
echo "🎉 ¡Instalación completada exitosamente!"
echo "Tus 24 skills y tus servidores MCP ya están activos en Antigravity y OpenCode."
echo "👉 Para iniciar en cualquier proyecto, solo escribe: hola (o zen)"
