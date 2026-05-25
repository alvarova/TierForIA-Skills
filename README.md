# 🎨 Framework UI/UX con IA — Instalador Global

> Instala en un solo script todos los skills, plugins y herramientas para desarrollar interfaces UI/UX de calidad profesional con agentes de IA.

**Versión:** 4.0 · **Actualizado:** Mayo 2026  
**Agentes soportados:** Claude Code · Cursor · Windsurf · Codex CLI · **Gemini CLI** ← nuevo

---

## ⚡ Instalación rápida

```bash
curl -O https://raw.githubusercontent.com/alvarova/TierForIA-Skills/main/install-uiux-skills.sh
chmod +x install-uiux-skills.sh
./install-uiux-skills.sh
```

El script detecta tu OS, verifica todos los prerequisitos y te pregunta para qué agente(s) instalar antes de tocar nada. Si algo falta, muestra el comando exacto para instalarlo.

---

## 🏗️ Arquitectura en cuatro tiers

```
TIER A  →  Plugins nativos Claude Code     (/plugin install · mcp add)
TIER B  →  Skills universales SKILL.md     (Claude · Cursor · Windsurf · Codex · Gemini)
TIER C  →  Proyectos y herramientas        (clonar / instalar según necesidad)
TIER D  →  MCP Servers de diseño           (imagen, Stitch, find-skills, mcp-builder)
```

---

## 🔵 TIER A — Plugins exclusivos de Claude Code

Usan el sistema nativo `/plugin install`, `/install` o `claude mcp add`. No son SKILL.md — requieren Claude Code CLI activo.

| # | Plugin | Descripción | Instalación |
|---|--------|-------------|-------------|
| A1 | [obra/superpowers](https://github.com/obra/superpowers) | Framework TDD agentic: brainstorming → spec → subagent dev. 14 skills, auto-trigger. | `/plugin install superpowers@claude-plugins-official` |
| A2 | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | Memoria persistente entre sesiones. Captura, comprime e inyecta contexto. | `/install thedotmack/claude-mem` |
| A3 | [anthropics/security-guidance](https://github.com/anthropics) | Hook oficial: command injection, XSS, eval(), deserialización insegura. | `/install anthropics/security-guidance` |
| A4 | [garrytan/gstack](https://github.com/garrytan/gstack) | 6 skills, 24 comandos del CEO de YCombinator. `/review /qa /ship /plan-*`. 20K+ ★ | `git clone + ./setup` |
| A5 | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | Harness completo: 36 agentes, 142 skills, 68 comandos, hooks TDD, security scan. | `npx ecc-install --profile minimal` |
| A6 | [czlonkowski/n8n-MCP](https://github.com/czlonkowski/n8n-mcp) | MCP Server: 525 nodos n8n, 263 herramientas IA, 396 workflows. | `claude mcp add n8n-mcp -- npx n8n-mcp` |

### Comandos manuales (Tier A)

```bash
# En una sesión de Claude Code:
/plugin install superpowers@claude-plugins-official
/install thedotmack/claude-mem
/install anthropics/security-guidance

# En terminal:
git clone --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
cd ~/.claude/skills/gstack && ./setup

npx ecc-install --profile minimal --target claude

# n8n-MCP (básico):
claude mcp add n8n-mcp \
  -e MCP_MODE=stdio -e LOG_LEVEL=error -e DISABLE_CONSOLE_OUTPUT=true \
  -- npx n8n-mcp

# n8n-MCP (completo, conectado a tu instancia):
claude mcp add n8n-mcp \
  -e MCP_MODE=stdio -e LOG_LEVEL=error -e DISABLE_CONSOLE_OUTPUT=true \
  -e N8N_API_URL=https://tu-n8n.com -e N8N_API_KEY=tu-api-key \
  -- npx n8n-mcp
```

---

## 🟢 TIER B — Skills universales

Archivos SKILL.md compatibles con **Claude Code · Cursor · Windsurf · Codex CLI · Gemini CLI**.

| # | Skill | Descripción | Comando |
|---|-------|-------------|---------|
| B1 | [emilkowalski/skill](https://emilkowal.ski/skill) | Animaciones, motion design, componentes. Principios de Sonner y Vaul. | `npx skills add emilkowalski/skill` |
| B2 | [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Motor de design system: 67 estilos, 161 paletas, 57 pares tipográficos. | `uipro init --ai [agente] --global` |
| B3 | [taste-skill ×4](https://github.com/Leonxlnx/taste-skill) | `high-end-visual-design` · `design-taste-frontend` · `full-output-enforcement` · `industrial-brutalist-ui` | `npx skills add Leonxlnx/taste-skill` |
| B4 | [impeccable](https://github.com/pbakaus/impeccable) | 23 comandos: `/polish` `/audit` `/critique` `/typeset` `/motion` `/a11y` | `npx skills add pbakaus/impeccable` |
| B5 | [anthropics/frontend-design](https://github.com/anthropics/skills) | Skill oficial de Anthropic para interfaces production-grade. | `npx skills add anthropics/skills --skill frontend-design` |
| B6 | [antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | 1,465+ skills. Bundle `web-wizard` (frontend + design + lint). | `npx antigravity-awesome-skills --[agente]` |
| B7 | [vercel-labs/web-design-guidelines](https://github.com/vercel-labs/agent-skills) 🆕 | Auditor UI contra Web Interface Guidelines de Vercel. Detecta anti-patrones de accesibilidad y contraste. | `npx skills add vercel-labs/agent-skills --skill web-design-guidelines` |
| B8 | [huashu-design](https://github.com/iamhuashu/huashu-design) 🆕 | 7 capacidades · 20 filosofías de diseño · Brand Asset Protocol. Genera prototipos, slides, animaciones sin salir de la terminal. | `npx huashu install` |
| B9 | [nexu-io/open-design skills](https://github.com/nexu-io/open-design) 🆕 | 19 skills + 71 design systems (Stripe, Vercel, Linear, Apple…). Alternativa open-source a Claude Design. | `git clone nexu-io/open-design → copiar /skills` |

### Directorios de instalación

```
Claude Code  →  ~/.claude/skills/
Cursor       →  ~/.cursor/skills/
Windsurf     →  ~/.windsurf/skills/
Codex CLI    →  ~/.codex/skills/
Gemini CLI   →  ~/.gemini/skills/  (o ~/.config/gemini/skills/)
```

### Comandos manuales (Tier B)

```bash
# B7 — web-design-guidelines (Vercel)
npx skills add vercel-labs/agent-skills --skill web-design-guidelines

# B8 — huashu-design
npx huashu install
# O clonar manualmente:
git clone https://github.com/iamhuashu/huashu-design.git ~/.claude/skills/huashu-design

# B9 — open-design skills
git clone --depth 1 https://github.com/nexu-io/open-design.git /tmp/open-design
cp -r /tmp/open-design/skills ~/.claude/skills/open-design-skills

# Antigravity por agente
npx antigravity-awesome-skills --claude --bundle web-wizard
npx antigravity-awesome-skills --cursor --bundle web-wizard
npx antigravity-awesome-skills --gemini --bundle web-wizard
```

---

## 🟡 TIER C — Proyectos y herramientas

Proyectos completos que se instalan o clonan según necesidad. El script pregunta antes de instalar cada uno.

### C1 — LightRAG
**RAG con grafos de conocimiento** · 33K+ ★ · HKUDS / EMNLP 2025

```bash
uv tool install "lightrag-hku[api]"    # recomendado
# o: pip install "lightrag-hku[api]"
cp env.example .env && lightrag-server
```

Requiere LLM con contexto ≥ 32K tokens. **Repo:** [github.com/HKUDS/LightRAG](https://github.com/HKUDS/LightRAG)

---

### C2 — cult/ui 🆕
**Componentes premium para Design Engineers** · shadcn registry · MIT

Componentes accesibles y customizables sobre Tailwind + Framer Motion + shadcn. Dynamic Island, Shift Card, Family Button, Direction Aware Tabs, Texture Card, y más.

```bash
# Agregar registry en components.json:
# "registries": { "@cult-ui": "https://cult-ui.com/r/{name}.json" }

# Instalar componentes:
npx shadcn@beta add @cult-ui/texture-card
npx shadcn@beta add @cult-ui/direction-aware-tabs

# O clonar todo el repo:
git clone https://github.com/nolly-studio/cult-ui.git ~/projects/cult-ui
```

**Site:** [cult-ui.com](https://www.cult-ui.com) · **Repo:** [github.com/nolly-studio/cult-ui](https://github.com/nolly-studio/cult-ui)

---

### C3 — agent-browser 🆕
**Browser automation CLI para agentes** · vercel-labs · Rust nativo · 377K★ skills

CLI nativo en Rust para automatización de browser. Instala Chrome for Testing automáticamente. Requiere Node.js 24+ para build desde fuente.

```bash
# macOS (recomendado):
brew install agent-browser
agent-browser install    # descarga Chrome for Testing

# npm:
npm install -g agent-browser
agent-browser install
```

**Repo:** [github.com/vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser)

---

### C4 — nexu-io/open-design 🆕
**Alternativa open-source a Claude Design** · 47K★ · Apache 2.0

19 skills + 71 design systems. Corre sobre tu agente existente (Claude Code, Gemini, Codex, Cursor). Exporta HTML, PDF, PPTX, MP4.

```bash
git clone https://github.com/nexu-io/open-design.git
cd open-design
pnpm install
pnpm dev:all
```

**Repo:** [github.com/nexu-io/open-design](https://github.com/nexu-io/open-design)

---

### C5 — WhatsApp AgentKit
**Agente WhatsApp completo** · en español · < 30 min · sin código

```bash
git clone https://github.com/Hainrixz/whatsapp-agentkit.git
cd whatsapp-agentkit && claude → /build-agent
```

---

### C6 — Claude Web Builder
**Landing pages profesionales** · sin código · README en español

```bash
git clone [Claude Web Builder GitHub]
claude → seguir instrucciones del README.es.md
```

---

### C7 — Claude Code Ultimate Guide
**Guía de referencia** · v3.38.12 · Interactive + PDF · sin instalación

🔗 Buscar en GitHub: `Claude Code Ultimate Guide`

---

## 🟣 TIER D — MCP Servers de diseño 🆕

Servidores MCP que amplían capacidades específicas de imagen, prototipado y flujo de diseño.

### D1 — nano-banana-mcp
**Generación de imágenes con Gemini Flash** · Requiere `GEMINI_API_KEY`

Genera imágenes, iconos, diagramas, storyboards, thumbnails con Gemini 2.5 Flash. Compatible con Claude Code y Gemini CLI.

```bash
# Configurar en Claude Code:
claude mcp add nano-banana \
  -e GEMINI_API_KEY=TU_KEY \
  -- npx -y -p @lyalindotcom/nano-banana-mcp nano-banana-server

# Configurar en Gemini CLI (.config/gemini/settings.json):
{
  "mcpServers": {
    "nano-banana": {
      "command": "npx",
      "args": ["-y", "-p", "@lyalindotcom/nano-banana-mcp", "nano-banana-server"],
      "env": { "GEMINI_API_KEY": "TU_KEY" }
    }
  }
}
```

**Repo:** [github.com/LyalinDotCom/nano-banana-mcp](https://github.com/LyalinDotCom/nano-banana-mcp) · [npmjs @lyalindotcom/nano-banana-mcp](https://www.npmjs.com/package/@lyalindotcom/nano-banana-mcp)

---

### D2 — google-labs-code/stitch-skills
**Skills para Google Stitch** · Google Labs · Gemini CLI · Claude Code · Cursor

Skills del MCP Server de Stitch (herramienta de diseño de Google Labs):

| Skill | Función |
|-------|---------|
| `design-md` | Genera DESIGN.md desde proyectos Stitch |
| `enhance-prompt` | Mejora prompts con vocabulario UI/UX |
| `react-components` | Convierte diseños Stitch a componentes React |
| `shadcn-ui` | Construye UI con shadcn/ui desde diseños |
| `stitch-loop` | Bucle iterativo diseño → código |
| `remotion` | Genera videos walkthrough desde diseños |

```bash
# Clonar y copiar skills:
git clone --depth 1 https://github.com/google-labs-code/stitch-skills.git
cp -r stitch-skills/skills ~/.claude/skills/stitch-skills

# Para Codex (via plugin marketplace):
codex plugin marketplace add google-labs-code/stitch-skills --ref main
```

**Repo:** [github.com/google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills)

---

### D3 — find-skills + mcp-builder (antigravity)
**Descubrimiento de skills y construcción de MCP servers**

- **find-skills**: se activa automáticamente cuando le pedís "find a skill for X" al agente. Busca en el catálogo de antigravity.
- **mcp-builder**: guía para crear MCP servers de alta calidad en Python/FastMCP o Node.js/TypeScript.

```bash
npx antigravity-awesome-skills --claude --skill find-skills
npx antigravity-awesome-skills --claude --skill mcp-builder

# Para Gemini:
npx antigravity-awesome-skills --gemini --skill find-skills
```

---

## 🌐 Gemini CLI — Configuración como agente 🆕

### Instalación

```bash
# Instalar:
npm install -g @google/gemini-cli

# Autenticar (wizard interactivo):
gemini

# Verificar:
gemini --version
```

**Gratis con OAuth Google:** 60 req/min · 1,000 req/día · contexto 1M tokens · Gemini 3 Pro

### Directorio de skills

```bash
# Gemini CLI busca skills en:
~/.gemini/skills/           # preferido
~/.config/gemini/skills/    # alternativo

# Verificar qué agente usás:
gemini → @web-design-guidelines  review components/
gemini → Using huashu-design, create a landing page for my SaaS
```

### MCP con Gemini CLI

```bash
# Agregar MCP server a Gemini CLI:
# Editar ~/.config/gemini/settings.json:
{
  "mcpServers": {
    "nano-banana": { ... },
    "stitch": { ... }
  }
}

# O via extensiones:
gemini extensions install --auto-update [url-extension]
```

---

## 📋 Prerequisitos

El script verifica y guía la instalación de cada herramienta:

| Herramienta | Versión | Requerido | Uso |
|------------|---------|-----------|-----|
| Node.js | v18+ | ✅ | npm, npx, CLIs |
| npm | v8+ | ✅ | instalación global |
| npx | any | ✅ | skills add, ecc-install |
| Git | any | ✅ | clonar repos |
| Python 3 | 3.8+ | ✅ | ui-ux-pro-max, LightRAG |
| pip/uv | any | ⚠️ | LightRAG |
| curl | any | ⚠️ | descarga alternativa |
| pnpm | v11+ | ⚠️ | open-design, agent-browser |
| Claude Code CLI | any | ⚠️ Tier A | plugins nativos |
| Gemini CLI | any | ⚠️ Tier B/D | skills Gemini, nano-banana |
| Homebrew | any | ⚠️ macOS | instalaciones macOS |

```bash
# Instalar todo en macOS:
brew install node git python3 pnpm
npm install -g @anthropic-ai/claude-code @google/gemini-cli

# Ubuntu/Debian:
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs git python3 python3-pip
npm install -g @anthropic-ai/claude-code @google/gemini-cli

# Windows:
winget install OpenJS.NodeJS Git.Git Python.Python.3.12
npm install -g @anthropic-ai/claude-code @google/gemini-cli
```

---

## 🔄 Flujo de trabajo post-instalación

### 1 · Verificar

```bash
ls ~/.claude/skills/           # skills Claude Code
ls ~/.gemini/skills/           # skills Gemini CLI
claude /plugin list            # plugins activos
claude mcp list                # MCP servers activos
```

### 2 · Design System First (todos los agentes)

```
Before any code, generate a complete design system for:
Product: [ej: "B2B SaaS for HR teams"]
Stack: [ej: Next.js 15 + Tailwind + shadcn/ui]

Include: UI style, color palette, typography, spacing system,
component patterns, anti-patterns to AVOID.

Wait for approval before writing any code.
```

### 3 · Componente con referencia

```
Build a [componente] for [contexto].

Reference: [URL de cult-ui.com o 21st.dev]

Design system:
- Colors: primary #[hex], accent #[hex]
- Typography: [fuente]
- Style: [glassmorphism / brutalist / minimalist]

Stack: [stack]

Avoid: Inter font, purple gradients, centered layouts,
       boolean props, inline styles, AI slop aesthetics.

Deliver the COMPLETE component. No placeholders.
```

### 4 · Comandos disponibles

```bash
# impeccable:
/polish    /audit    /critique    /typeset    /motion    /a11y

# gstack:
/plan-ceo-review    /plan-design-review    /review    /qa    /ship

# nano-banana (Claude Code / Gemini):
"generate an icon for a coffee app"
"create a dashboard screenshot for my SaaS"
"design a logo variation set"

# stitch-skills:
"create design-md from this project"
"convert Stitch screens to React components"

# huashu-design:
"design a SaaS landing page, save as landing.html"
"create a product launch animation"

# find-skills:
"find a skill for writing documentation"
"is there a skill for React Native?"
```

---

## 📁 Estructura resultante

```
~/.claude/
├── skills/
│   ├── ui-ux-pro-max/           # motor design system
│   ├── emil-design-eng/         # animaciones motion
│   ├── high-end-visual-design/  # vocabulario premium
│   ├── design-taste-frontend/   # criterio en código
│   ├── full-output-enforcement/ # sin truncar
│   ├── industrial-brutalist-ui/ # estilo editorial
│   ├── impeccable/              # /polish /audit /critique
│   ├── frontend-design/         # oficial Anthropic
│   ├── antigravity/             # 1,465+ skills
│   ├── web-design-guidelines/   # auditor Vercel ← nuevo
│   ├── huashu-design/           # 花叔 terminal design ← nuevo
│   ├── open-design-skills/      # 19 skills nexu-io ← nuevo
│   ├── stitch-skills/           # Google Labs MCP ← nuevo
│   ├── find-skills/             # descubrir skills ← nuevo
│   ├── mcp-builder/             # construir MCPs ← nuevo
│   └── gstack/                  # /review /qa /ship
├── plugins/
│   └── marketplaces/
│       ├── obra/                # superpowers
│       ├── thedotmack/          # claude-mem
│       └── anthropics/          # security-guidance
└── settings.json                # n8n-mcp · nano-banana

~/.gemini/skills/                # mismos skills B7-B9 + antigravity
~/.cursor/skills/                # idem
~/.windsurf/skills/              # idem
~/.codex/skills/                 # idem
```

---

## ❓ Preguntas frecuentes

**¿Gemini CLI necesita pagar?**
No. Con tu cuenta Google personal obtenés 60 req/min y 1,000 req/día gratis con Gemini 3 (contexto 1M tokens).

**¿Los skills de Gemini funcionan igual que los de Claude Code?**
Sí. El formato SKILL.md es estándar. Gemini CLI los detecta automáticamente en `~/.gemini/skills/` o los podés mencionar por nombre en el prompt.

**¿nano-banana requiere pagar?**
Sí, requiere una Gemini API Key. El tier gratuito de Google AI Studio incluye cuota básica para generación de imágenes con Gemini Flash.

**¿Qué hace huashu-design diferente de los otros skills?**
Implementa el Brand Asset Protocol de Claude Design (sin clonarlo) y 20 vocabularios de diseño. Genera prototipos completos en HTML/PDF/PPTX dentro de la terminal, sin herramientas visuales.

**¿open-design es un skill o una app?**
Las dos cosas. Tier B instala sus 19 SKILL.md (para usar en cualquier agente). Tier C instala la app completa (interfaz web local con los 71 design systems y preview en tiempo real).

**¿cult/ui es compatible con shadcn?**
Sí. Funciona sobre el mismo registry CLI de shadcn. Agregás el registry en `components.json` y usás `npx shadcn@beta add @cult-ui/[component]`.

**¿agent-browser reemplaza a Playwright?**
No directamente. Es un CLI optimizado para que agentes IA controlen el browser. Puede invocar Playwright internamente.

**¿Los skills se actualizan solos?**
No. Volvé a ejecutar el script — detecta los existentes y hace `git pull` en los repos clonados.

---

## 🗺️ Hoja de ruta

- [ ] Soporte Gemini CLI extensions (`gemini extensions install`)
- [ ] Bundle mobile (React Native + Flutter skills)
- [ ] Script `--update` incremental
- [ ] Integración con Kiro y OpenCode como agentes adicionales
- [ ] Verificación de versiones con alertas de actualización

---

## 🙏 Créditos

| Recurso | Autor |
|---------|-------|
| ui-ux-pro-max | [nextlevelbuilder](https://github.com/nextlevelbuilder) |
| taste-skill | [LeonxlnX](https://github.com/Leonxlnx) |
| impeccable | [pbakaus](https://github.com/pbakaus) |
| emilkowalski/skill | [Emil Kowalski](https://emilkowal.ski) |
| frontend-design | [Anthropic](https://github.com/anthropics) |
| antigravity-awesome-skills | [sickn33](https://github.com/sickn33) |
| web-design-guidelines | [Vercel Labs](https://github.com/vercel-labs) |
| huashu-design | [花叔 (iamhuashu)](https://github.com/iamhuashu) |
| open-design | [nexu-io](https://github.com/nexu-io) |
| cult/ui | [Jordan Gilliam / nolly-studio](https://github.com/nolly-studio) |
| agent-browser | [Vercel Labs](https://github.com/vercel-labs) |
| nano-banana-mcp | [LyalinDotCom](https://github.com/LyalinDotCom) |
| stitch-skills | [Google Labs](https://github.com/google-labs-code) |
| obra/superpowers | [obra](https://github.com/obra) |
| thedotmack/claude-mem | [thedotmack](https://github.com/thedotmack) |
| garrytan/gstack | [Garry Tan](https://github.com/garrytan) |
| affaan-m/ECC | [affaan-m](https://github.com/affaan-m) |
| n8n-MCP | [czlonkowski](https://github.com/czlonkowski) |
| LightRAG | [HKUDS](https://github.com/HKUDS) |
| WhatsApp AgentKit | [Hainrixz](https://github.com/Hainrixz) |

---

## 📄 Licencia

MIT — usá, modificá y distribuí libremente.

---

*Framework UI/UX con IA — v4.0 — Mayo 2026*
