#!/usr/bin/env bash
# ==============================================================================
# Installer for Developer Agent Skills (Antigravity, OpenCode, Claude Code, etc.)
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/REPLACE_WITH_YOUR_USER/skill.git"
INSTALL_DIR="${HOME}/Projects/skill"

# If run directly via curl/pipe, clone or update the repository first
if [ ! -d "${INSTALL_DIR}/.git" ]; then
    echo "📦 Clonando repositorio en ${INSTALL_DIR}..."
    mkdir -p "$(dirname "${INSTALL_DIR}")"
    # Si la carpeta existe pero no tiene .git (o si viene vía curl)
    if [ -d "${INSTALL_DIR}" ]; then
        cd "${INSTALL_DIR}"
    else
        git clone "${REPO_URL}" "${INSTALL_DIR}"
        cd "${INSTALL_DIR}"
    fi
else
    cd "${INSTALL_DIR}"
    echo "🔄 Actualizando repositorio de skills..."
    git pull --quiet || true
fi

SOURCE_SKILLS_DIR="${INSTALL_DIR}/skills"

if [ ! -d "${SOURCE_SKILLS_DIR}" ]; then
    echo "❌ No se encontró la carpeta de skills en ${SOURCE_SKILLS_DIR}"
    exit 1
fi

# Directorios de destino para agentes de IA
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

echo ""
echo "🎉 ¡Instalación completada exitosamente!"
echo "Tus skills ya están activas y disponibles para Antigravity, OpenCode y otros agentes."
