#!/usr/bin/env bash
# ==============================================================================
# Installer for Developer Agent Skills & MCP Servers (Antigravity, OpenCode, etc.)
# ==============================================================================
set -euo pipefail

INSTALL_DIR="${HOME}/Projects/skill"

# If run directly via curl/pipe, clone or update the repository first
if [ ! -d "${INSTALL_DIR}/.git" ]; then
    echo "Clonando repositorio en ${INSTALL_DIR}..."
    mkdir -p "$(dirname "${INSTALL_DIR}")"
    if [ -d "${INSTALL_DIR}" ]; then
        cd "${INSTALL_DIR}"
    else
        REPO_URL="${1:-https://github.com/REPLACE_WITH_YOUR_USER/skill.git}"
        git clone "${REPO_URL}" "${INSTALL_DIR}"
        cd "${INSTALL_DIR}"
    fi
else
    cd "${INSTALL_DIR}"
    echo "Actualizando repositorio de skills..."
    git pull --quiet 2>/dev/null || true
fi

SOURCE_SKILLS_DIR="${INSTALL_DIR}/skills"

if [ ! -d "${SOURCE_SKILLS_DIR}" ]; then
    echo "No se encontró la carpeta de skills en ${SOURCE_SKILLS_DIR}"
    exit 1
fi

# 1. Enlace de Skills hacia plataformas soportadas
TARGET_DIRS=(
    "${HOME}/.agents/skills"
    "${HOME}/.gemini/config/skills"
)

echo "Vinculando skills a las plataformas soportadas..."

for target in "${TARGET_DIRS[@]}"; do
    mkdir -p "${target}"
    for skill_path in "${SOURCE_SKILLS_DIR}"/*; do
        if [ -d "${skill_path}" ]; then
            skill_name="$(basename "${skill_path}")"
            ln -sfn "${skill_path}" "${target}/${skill_name}"
            echo "   [${skill_name}] -> ${target}/${skill_name}"
        fi
    done
done

# 2. Enlace de configuración MCP (Servidores locales sin API keys)
MCP_SOURCE="${INSTALL_DIR}/mcp_config.json"
if [ -f "${MCP_SOURCE}" ]; then
    echo ""
    echo "Vinculando configuración de servidores MCP..."
    
    # Antigravity global
    mkdir -p "${HOME}/.gemini/config"
    ln -sfn "${MCP_SOURCE}" "${HOME}/.gemini/config/mcp_config.json"
    echo "   [mcp_config.json] -> ${HOME}/.gemini/config/mcp_config.json"

    # OpenCode global
    mkdir -p "${HOME}/.config/opencode"
    ln -sfn "${MCP_SOURCE}" "${HOME}/.config/opencode/mcp_config.json"
    echo "   [mcp_config.json] -> ${HOME}/.config/opencode/mcp_config.json"
fi

echo ""
echo "Instalación completada exitosamente."
echo "Tus 23 skills y tus servidores MCP locales ya están activos."
