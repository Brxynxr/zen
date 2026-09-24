# 🛠️ Developer Agent Skills Repository

Repositorio centralizado de **Skills** de desarrollo de software para potenciar flujos de trabajo en **Antigravity (AGY)**, **OpenCode**, **Claude Code** y cualquier agente de IA compatible con el estándar abierto `.agents/skills`.

---

## ⚡ Instalación Rápida (Cualquier máquina)

Una vez subas este repositorio a GitHub, podrás instalar todas tus skills en cualquier ordenador nuevo con un solo comando:

```bash
curl -fsSL https://raw.githubusercontent.com/TU_USUARIO/skill/main/install.sh | bash
```

O si ya clonaste el repositorio localmente:

```bash
cd ~/Projects/skill
./install.sh
```

El script crea automáticamente enlaces simbólicos hacia:
- `~/.agents/skills/` (estándar abierto para OpenCode, Claude Code, Antigravity, etc.)
- `~/.gemini/config/skills/` (configuración global de Antigravity)

---

## 📚 Catálogo de Skills

| Skill | Descripción | Triggers principales |
| :--- | :--- | :--- |
| **[`systematic-debugging`](./skills/systematic-debugging/SKILL.md)** | Metodología rigurosa de 4 fases para resolver bugs encontrando la causa raíz antes de proponer código o parches cosméticos. Regla de oro: *No fixes without root cause investigation first*. | `bug`, `test failure`, `unexpected behavior`, `crashes`, `performance issue` |

---

## 📁 Estructura del Repositorio

```text
skill/
├── README.md                   # Catálogo y documentación
├── install.sh                  # Instalador multiplataforma
└── skills/
    └── systematic-debugging/
        ├── SKILL.md            # Definición principal de la skill
        ├── root-cause-tracing.md
        ├── defense-in-depth.md
        ├── condition-based-waiting.md
        ├── condition-based-waiting-example.ts
        └── find-polluter.sh
```
