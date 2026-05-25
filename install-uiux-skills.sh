#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║        FRAMEWORK UI/UX CON IA — INSTALADOR GLOBAL               ║
# ║        Claude Code · Cursor · Windsurf · Codex · Gemini CLI     ║
# ║        v4.0 — Mayo 2026                                          ║
# ╚══════════════════════════════════════════════════════════════════╝
#
#  TIER A — Exclusivos Claude Code  (/plugin install · mcp add)
#  ├── obra/superpowers
#  ├── thedotmack/claude-mem
#  ├── anthropics/security-guidance
#  ├── garrytan/gstack
#  ├── affaan-m/everything-claude-code
#  └── czlonkowski/n8n-MCP
#
#  TIER B — Skills universales SKILL.md  (Claude · Cursor · Windsurf · Codex · Gemini)
#  ├── emilkowalski/skill
#  ├── ui-ux-pro-max  (nextlevelbuilder)
#  ├── taste-skill curado  (LeonxlnX)
#  ├── impeccable  (pbakaus)
#  ├── anthropics/frontend-design
#  ├── antigravity-awesome-skills  (bundle web-wizard)
#  ├── vercel-labs/web-design-guidelines          ← NUEVO
#  ├── huashu-design  (花叔)                       ← NUEVO
#  └── nexu-io/open-design skills                 ← NUEVO
#
#  TIER C — Proyectos / herramientas
#  ├── LightRAG
#  ├── WhatsApp AgentKit
#  ├── Claude Web Builder
#  ├── Claude Code Ultimate Guide  (referencia)
#  ├── cult/ui registry  (shadcn)                 ← NUEVO
#  ├── agent-browser  (vercel-labs · Rust)        ← NUEVO
#  └── nexu-io/open-design  (app completa)        ← NUEVO
#
#  TIER D — MCP Servers específicos de diseño     ← NUEVO TIER
#  ├── nano-banana-mcp  (Gemini image gen)
#  ├── stitch-skills  (Google Labs)
#  └── find-skills + mcp-builder  (antigravity)
#
# ══════════════════════════════════════════════════════════════════
set -euo pipefail

RESET="\033[0m"; BOLD="\033[1m"; DIM="\033[2m"
CYAN="\033[36m"; GREEN="\033[32m"; YELLOW="\033[33m"
RED="\033[31m";  BLUE="\033[34m"; MAGENTA="\033[35m"

step()    { echo -e "\n${CYAN}${BOLD}▶  $1${RESET}"; }
ok()      { echo -e "  ${GREEN}✓  $1${RESET}"; }
skip()    { echo -e "  ${DIM}–  $1 (ya instalado)${RESET}"; }
warn()    { echo -e "  ${YELLOW}⚠  $1${RESET}"; }
err()     { echo -e "\n  ${RED}${BOLD}✗  ERROR: $1${RESET}"; }
info()    { echo -e "  ${DIM}   $1${RESET}"; }
note()    { echo -e "  ${MAGENTA}★  $1${RESET}"; }
hr()      { echo -e "  ${DIM}────────────────────────────────────────────────────────────────${RESET}"; }
section() { echo -e "\n  ${BLUE}${BOLD}══  $1  ══${RESET}"; }

clear; echo ""
echo -e "${CYAN}${BOLD}"
echo "  ██╗   ██╗██╗    ██╗   ██╗██╗  ██╗    ███████╗██╗  ██╗██╗██╗     ██╗     ███████╗"
echo "  ██║   ██║██║    ██║   ██║╚██╗██╔╝    ██╔════╝██║ ██╔╝██║██║     ██║     ██╔════╝"
echo "  ██║   ██║██║    ██║   ██║ ╚███╔╝     ███████╗█████╔╝ ██║██║     ██║     ███████╗"
echo "  ██║   ██║██║    ██║   ██║ ██╔██╗     ╚════██║██╔═██╗ ██║██║     ██║     ╚════██║"
echo "  ╚██████╔╝██║    ╚██████╔╝██╔╝ ██╗    ███████║██║  ██╗██║███████╗███████╗███████║"
echo "   ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝    ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝"
echo -e "${RESET}"
echo -e "${DIM}  Framework profesional UI/UX con IA — Instalación Global  v4.0${RESET}"
hr; echo ""

# ════════════════════════════════════════════════════════════════════
# FASE 0: DIAGNÓSTICO
# ════════════════════════════════════════════════════════════════════
step "Diagnóstico del sistema"
echo ""

PREREQ_ERRORS=0; PREREQ_WARNINGS=0

OS="unknown"; PKG_MGR="desconocido"
if   [[ "$OSTYPE" == "darwin"* ]];    then OS="macos";   PKG_MGR="brew"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
  command -v apt    &>/dev/null && PKG_MGR="apt"
  command -v dnf    &>/dev/null && PKG_MGR="dnf"
  command -v pacman &>/dev/null && PKG_MGR="pacman"
elif [[ "$OSTYPE" =~ (msys|cygwin|win32) ]]; then OS="windows"; PKG_MGR="winget"; fi

echo -e "  ${BLUE}Sistema operativo:${RESET} ${BOLD}$OS${RESET}  ${DIM}($PKG_MGR)${RESET}"; echo ""

hint_node()   { case "$OS" in macos) echo "brew install node";; linux) echo "curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -";; windows) echo "winget install OpenJS.NodeJS";; *) echo "https://nodejs.org";; esac; }
hint_git()    { case "$OS" in macos) echo "brew install git";; linux) echo "sudo $PKG_MGR install git";; windows) echo "winget install Git.Git";; *) echo "https://git-scm.com";; esac; }
hint_python() { case "$OS" in macos) echo "brew install python3";; linux) echo "sudo $PKG_MGR install python3";; windows) echo "winget install Python.Python.3.12";; *) echo "https://python.org";; esac; }

echo -e "  ${BOLD}Herramientas requeridas:${RESET}"; echo ""

# Node.js ≥ 18
NODE_OK=false
if command -v node &>/dev/null; then
  NODE_RAW=$(node --version 2>&1 | head -1)
  NODE_MAJOR=$(echo "$NODE_RAW" | sed 's/v//' | cut -d'.' -f1)
  if [ "${NODE_MAJOR:-0}" -ge 18 ] 2>/dev/null; then
    ok "Node.js  ${DIM}$NODE_RAW${RESET}"; NODE_OK=true
  else err "Node.js $NODE_RAW — mínimo v18"; info "→ $(hint_node)"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi
else err "Node.js no encontrado"; info "→ $(hint_node)"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# npm
if command -v npm &>/dev/null; then
  NPM_VER=$(npm --version 2>&1 | head -1); NPM_MAJOR=$(echo "$NPM_VER" | cut -d'.' -f1)
  if [ "${NPM_MAJOR:-0}" -ge 8 ] 2>/dev/null; then ok "npm  ${DIM}v$NPM_VER${RESET}"
  else warn "npm v$NPM_VER antigua — actualizando..."; npm install -g npm@latest &>/dev/null && ok "npm actualizado" || true; fi
else err "npm no encontrado"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# npx
if command -v npx &>/dev/null; then ok "npx  ${DIM}v$(npx --version 2>&1 | head -1)${RESET}"
else err "npx no encontrado"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# Git
if command -v git &>/dev/null; then ok "Git  ${DIM}v$(git --version 2>&1 | awk '{print $3}')${RESET}"
else err "Git no encontrado"; info "→ $(hint_git)"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# Python 3
PYTHON_OK=false
if command -v python3 &>/dev/null; then
  PY_RAW=$(python3 --version 2>&1 | head -1)
  PY_MINOR=$(echo "$PY_RAW" | sed 's/Python //' | cut -d'.' -f2)
  if [ "${PY_MINOR:-0}" -ge 8 ] 2>/dev/null; then ok "Python  ${DIM}$PY_RAW${RESET}"; PYTHON_OK=true
  else warn "Python $PY_RAW — recomendado ≥ 3.8"; PYTHON_OK=true; fi
elif command -v python &>/dev/null && python --version 2>&1 | grep -q "^Python 3"; then
  ok "Python  ${DIM}$(python --version 2>&1 | head -1)${RESET}"; PYTHON_OK=true
else err "Python 3 no encontrado"; info "→ $(hint_python)"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# pip
PIP_OK=false
if command -v pip3 &>/dev/null || command -v pip &>/dev/null; then
  PIP_CMD=$(command -v pip3 2>/dev/null || command -v pip); ok "pip  ${DIM}disponible${RESET}"; PIP_OK=true
else warn "pip no encontrado  ${DIM}(opcional, para LightRAG)${RESET}"; PREREQ_WARNINGS=$((PREREQ_WARNINGS+1)); fi

echo ""; echo -e "  ${BOLD}Herramientas opcionales:${RESET}"; echo ""

# curl
command -v curl &>/dev/null \
  && ok "curl  ${DIM}v$(curl --version 2>&1 | head -1 | awk '{print $2}')${RESET}" \
  || { warn "curl no encontrado"; PREREQ_WARNINGS=$((PREREQ_WARNINGS+1)); }

# uv
command -v uv &>/dev/null \
  && ok "uv  ${DIM}(recomendado para LightRAG)${RESET}" \
  || { warn "uv no encontrado  ${DIM}(pip install uv)${RESET}"; PREREQ_WARNINGS=$((PREREQ_WARNINGS+1)); }

# pnpm (para open-design y agent-browser)
command -v pnpm &>/dev/null \
  && ok "pnpm  ${DIM}$(pnpm --version 2>&1 | head -1)  (requerido para open-design/agent-browser)${RESET}" \
  || { warn "pnpm no encontrado  ${DIM}(npm install -g pnpm)${RESET}"; PREREQ_WARNINGS=$((PREREQ_WARNINGS+1)); }

# Homebrew
[ "$OS" = "macos" ] && {
  command -v brew &>/dev/null \
    && ok "Homebrew  ${DIM}disponible${RESET}" \
    || { warn "Homebrew no encontrado  ${DIM}(brew.sh)${RESET}"; PREREQ_WARNINGS=$((PREREQ_WARNINGS+1)); }
}

# Claude Code CLI
CLAUDE_CLI=false
if command -v claude &>/dev/null; then
  ok "Claude Code CLI  ${DIM}v$(claude --version 2>&1 | head -1 | awk '{print $NF}')${RESET}"; CLAUDE_CLI=true
  note "Claude Code detectado → Tier A disponible"
else
  warn "Claude Code CLI no encontrado  ${DIM}(npm install -g @anthropic-ai/claude-code)${RESET}"
  PREREQ_WARNINGS=$((PREREQ_WARNINGS+1))
fi

# Gemini CLI
GEMINI_CLI=false
if command -v gemini &>/dev/null; then
  ok "Gemini CLI  ${DIM}v$(gemini --version 2>&1 | head -1 | awk '{print $NF}')${RESET}"; GEMINI_CLI=true
  note "Gemini CLI detectado → skills Gemini disponibles"
else
  warn "Gemini CLI no encontrado  ${DIM}(npm install -g @google/gemini-cli)${RESET}"
  info "Gratis con OAuth Google: 60 req/min · 1K req/día · contexto 1M tokens"
  PREREQ_WARNINGS=$((PREREQ_WARNINGS+1))
fi

# Conectividad
echo ""; info "Verificando conectividad..."
if curl -s --max-time 5 https://registry.npmjs.org/ &>/dev/null 2>/dev/null \
   || wget -q --timeout=5 --spider https://registry.npmjs.org/ &>/dev/null 2>/dev/null; then
  ok "Internet  ${DIM}(npmjs.org ✓)${RESET}"
else err "Sin conexión"; PREREQ_ERRORS=$((PREREQ_ERRORS+1)); fi

# Permisos npm
info "Permisos npm global..."
NPM_PREFIX=$(npm config get prefix 2>/dev/null || echo "")
if [ -n "$NPM_PREFIX" ] && [ -w "$NPM_PREFIX" ]; then ok "Permisos npm  ${DIM}($NPM_PREFIX)${RESET}"
else
  warn "Sin escritura en $NPM_PREFIX"
  info "→ mkdir -p ~/.npm-global && npm config set prefix ~/.npm-global"
  PREREQ_WARNINGS=$((PREREQ_WARNINGS+1))
fi

echo ""; hr; echo ""
if [ "$PREREQ_ERRORS" -gt 0 ]; then
  echo -e "  ${RED}${BOLD}$PREREQ_ERRORS error(es) crítico(s). Resolvelos y volvé a ejecutar.${RESET}"
  echo ""; exit 1
elif [ "$PREREQ_WARNINGS" -gt 0 ]; then
  echo -e "  ${YELLOW}${BOLD}OK con $PREREQ_WARNINGS advertencia(s).${RESET}"
  read -rp "  ¿Continuar? [S/n]: " cont; cont="${cont:-S}"
  [[ "$cont" =~ ^[Nn] ]] && exit 0
else echo -e "  ${GREEN}${BOLD}Diagnóstico OK ✓${RESET}"; fi
echo ""

# ════════════════════════════════════════════════════════════════════
# FASE 1: SELECCIÓN DE AGENTES
# ════════════════════════════════════════════════════════════════════
hr; echo ""
echo -e "  ${BOLD}¿Para qué agente(s) instalás los skills universales (Tier B)?${RESET}"; echo ""
echo -e "  ${CYAN}1)${RESET} Claude Code    ${DIM}(~/.claude/skills/)${RESET}"
echo -e "  ${CYAN}2)${RESET} Cursor         ${DIM}(~/.cursor/skills/)${RESET}"
echo -e "  ${CYAN}3)${RESET} Windsurf       ${DIM}(~/.windsurf/skills/)${RESET}"
echo -e "  ${CYAN}4)${RESET} Codex CLI      ${DIM}(~/.codex/skills/)${RESET}"
echo -e "  ${CYAN}5)${RESET} Gemini CLI     ${DIM}(~/.gemini/skills/ | ~/.config/gemini/skills/)${RESET}"
echo -e "  ${CYAN}6)${RESET} Todos          ${DIM}(Claude + Cursor + Windsurf + Codex + Gemini)${RESET}"
echo ""
read -rp "  Opción [1-6, default: 1]: " agent_choice; agent_choice="${agent_choice:-1}"
case "$agent_choice" in
  1) AGENTS=("claude") ;;
  2) AGENTS=("cursor") ;;
  3) AGENTS=("windsurf") ;;
  4) AGENTS=("codex") ;;
  5) AGENTS=("gemini") ;;
  6) AGENTS=("claude" "cursor" "windsurf" "codex" "gemini") ;;
  *) warn "Inválido, usando Claude Code."; AGENTS=("claude") ;;
esac
echo -e "\n  ${GREEN}Agentes: ${BOLD}${AGENTS[*]}${RESET}"

agent_skills_dir() {
  case "$1" in
    claude)   echo "$HOME/.claude/skills" ;;
    cursor)   echo "$HOME/.cursor/skills" ;;
    windsurf) echo "$HOME/.windsurf/skills" ;;
    codex)    echo "$HOME/.codex/skills" ;;
    gemini)
      # Gemini CLI busca en ~/.gemini/skills/ o ~/.config/gemini/skills/
      if [ -d "$HOME/.gemini" ]; then echo "$HOME/.gemini/skills"
      else echo "$HOME/.config/gemini/skills"; fi ;;
    *)        echo "$HOME/.claude/skills" ;;
  esac
}

skill_installed() { [ -d "$(agent_skills_dir "$2")/$1" ]; }

for agent in "${AGENTS[@]}"; do mkdir -p "$(agent_skills_dir "$agent")"; done
PRIMARY_DIR=$(agent_skills_dir "${AGENTS[0]}")

# ════════════════════════════════════════════════════════════════════
# TIER A — EXCLUSIVOS CLAUDE CODE
# ════════════════════════════════════════════════════════════════════
section "TIER A — Plugins exclusivos de Claude Code"
echo ""
echo -e "  ${DIM}/plugin install · /install · claude mcp add — Solo Claude Code${RESET}"; echo ""

if [ "$CLAUDE_CLI" = true ]; then

  # A1: superpowers
  step "A1 · obra/superpowers  ${DIM}(TDD agentic — 14 skills)${RESET}"
  if [ -d "$HOME/.claude/plugins/marketplaces/obra" ]; then skip "superpowers"
  else
    claude /plugin install superpowers@claude-plugins-official 2>/dev/null \
      && ok "superpowers instalado" \
      || { warn "Requiere sesión interactiva:"; note "/plugin install superpowers@claude-plugins-official"; }
  fi

  # A2: claude-mem
  step "A2 · thedotmack/claude-mem  ${DIM}(memoria entre sesiones)${RESET}"
  if [ -d "$HOME/.claude/plugins/marketplaces/thedotmack" ]; then skip "claude-mem"
  else
    claude /install thedotmack/claude-mem 2>/dev/null \
      && ok "claude-mem instalado" \
      || { warn "Requiere sesión interactiva:"; note "/install thedotmack/claude-mem"; }
  fi

  # A3: security-guidance
  step "A3 · anthropics/security-guidance  ${DIM}(Oficial)${RESET}"
  if [ -d "$HOME/.claude/plugins/marketplaces/anthropics/security-guidance" ]; then skip "security-guidance"
  else
    claude /install anthropics/security-guidance 2>/dev/null \
      && ok "security-guidance instalado" \
      || { warn "Requiere sesión interactiva:"; note "/install anthropics/security-guidance"; }
  fi

  # A4: gstack
  step "A4 · garrytan/gstack  ${DIM}(24 comandos — YCombinator CEO)${RESET}"
  GSTACK_DIR="$HOME/.claude/skills/gstack"
  if [ -d "$GSTACK_DIR/.git" ]; then
    git -C "$GSTACK_DIR" pull --quiet && ok "gstack actualizado"
  else
    git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$GSTACK_DIR" --quiet 2>/dev/null \
      && ok "gstack clonado" || warn "No se pudo clonar gstack"
    [ -f "$GSTACK_DIR/setup" ] && {
      cd "$GSTACK_DIR" && bash ./setup 2>/dev/null && ok "gstack configurado" \
        || { warn "setup requiere input:"; note "cd ~/.claude/skills/gstack && ./setup"; }
      cd - &>/dev/null
    }
  fi

  # A5: everything-claude-code
  step "A5 · affaan-m/everything-claude-code  ${DIM}(ECC — 142 skills, 36 agentes, hooks)${RESET}"
  if [ -d "$HOME/.claude/plugins/marketplaces/affaan-m" ] || [ -d "$HOME/.claude/skills/ecc" ]; then
    skip "everything-claude-code"
  else
    npx --yes ecc-install --profile minimal --target claude 2>/dev/null \
      && ok "ECC instalado (minimal)" \
      || { warn "Instalá manualmente:"; note "npm install -g @affaan-m/ecc && npx ecc-install --profile minimal --target claude"; }
  fi

  # A6: n8n-MCP
  step "A6 · czlonkowski/n8n-MCP  ${DIM}(MCP — 525 nodos n8n)${RESET}"
  if [ "$CLAUDE_CLI" = true ] && claude mcp list 2>/dev/null | grep -q "n8n-mcp"; then
    skip "n8n-MCP ya configurado"
  else
    claude mcp add n8n-mcp \
      -e MCP_MODE=stdio -e LOG_LEVEL=error -e DISABLE_CONSOLE_OUTPUT=true \
      -- npx n8n-mcp 2>/dev/null \
      && ok "n8n-MCP configurado" \
      || { warn "Ejecutá manualmente:"; note "claude mcp add n8n-mcp -e MCP_MODE=stdio -e LOG_LEVEL=error -- npx n8n-mcp"; }
  fi

else
  echo ""; warn "Claude Code CLI no detectado — Tier A omitido."; echo ""
  echo -e "  ${DIM}Instalá Claude Code: npm install -g @anthropic-ai/claude-code${RESET}"; echo ""
  echo -e "  ${YELLOW}Luego ejecutá en Claude Code:${RESET}"
  printf "  ${CYAN}%s${RESET}\n" \
    "/plugin install superpowers@claude-plugins-official" \
    "/install thedotmack/claude-mem" \
    "/install anthropics/security-guidance"
  echo ""; echo -e "  ${YELLOW}En terminal:${RESET}"
  echo -e "  ${DIM}git clone --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack${RESET}"
  echo -e "  ${DIM}npx ecc-install --profile minimal --target claude${RESET}"
  echo -e "  ${DIM}claude mcp add n8n-mcp -e MCP_MODE=stdio -e LOG_LEVEL=error -- npx n8n-mcp${RESET}"
fi

# ════════════════════════════════════════════════════════════════════
# TIER B — SKILLS UNIVERSALES
# ════════════════════════════════════════════════════════════════════
section "TIER B — Skills universales  ${DIM}(${AGENTS[*]})${RESET}"
echo ""
echo -e "  ${DIM}SKILL.md — Claude Code · Cursor · Windsurf · Codex CLI · Gemini CLI${RESET}"; echo ""

# ── Helper: instalar un skill desde git + copiar a todos los agentes
install_skill_from_git() {
  local name="$1" repo_url="$2" subdirectory="${3:-}"
  local repo_dir="$PRIMARY_DIR/_repo-$(echo "$name" | tr '/' '-')"
  local SKIP_ALL=true
  for agent in "${AGENTS[@]}"; do skill_installed "$name" "$agent" || { SKIP_ALL=false; break; }; done
  [ "$SKIP_ALL" = true ] && { skip "$name (todos los agentes)"; return; }

  if [ -d "$repo_dir/.git" ]; then git -C "$repo_dir" pull --quiet
  else git clone --quiet "$repo_url" "$repo_dir" 2>/dev/null || { warn "No se pudo clonar $repo_url"; return; }; fi

  local SRC="$repo_dir"; [ -n "$subdirectory" ] && SRC="$repo_dir/$subdirectory"
  [ -d "$SRC" ] || { warn "$name: directorio '$subdirectory' no encontrado en repo"; return; }

  for agent in "${AGENTS[@]}"; do
    skill_installed "$name" "$agent" && { ok "$name → $agent (ya existe)"; continue; }
    DEST="$(agent_skills_dir "$agent")/$name"
    rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "$name → $agent"
  done
}

# B1: emilkowalski/skill
step "B1 · emilkowalski/skill  ${DIM}(animaciones, motion, Sonner/Vaul)${RESET}"
SKIP_ALL=true
for agent in "${AGENTS[@]}"; do skill_installed "emil-design-eng" "$agent" || { SKIP_ALL=false; break; }; done
if [ "$SKIP_ALL" = false ]; then
  EMIL_REPO="$PRIMARY_DIR/_emilkowalski-skill-repo"
  [ -d "$EMIL_REPO/.git" ] \
    && git -C "$EMIL_REPO" pull --quiet \
    || npx --yes skills add emilkowalski/skill 2>/dev/null \
    || git clone --quiet https://github.com/emilkowalski/skill.git "$EMIL_REPO" 2>/dev/null || true
  for agent in "${AGENTS[@]}"; do
    skill_installed "emil-design-eng" "$agent" && { ok "emilkowalski/skill → $agent (ya existe)"; continue; }
    SRC="$(agent_skills_dir "claude")/emil-design-eng"; [ -d "$SRC" ] || SRC="$EMIL_REPO"
    [ -d "$SRC" ] && { rm -rf "$(agent_skills_dir "$agent")/emil-design-eng"; cp -r "$SRC" "$(agent_skills_dir "$agent")/emil-design-eng" && ok "emilkowalski/skill → $agent"; }
  done
else skip "emilkowalski/skill"; fi

# B2: ui-ux-pro-max
step "B2 · ui-ux-pro-max  ${DIM}(nextlevelbuilder — design system automático)${RESET}"
npm install -g uipro-cli 2>&1 | grep -v "^npm warn" | grep -v "^added" | grep -v "^$" | head -2 || true
for agent in "${AGENTS[@]}"; do
  skill_installed "ui-ux-pro-max" "$agent" && { ok "ui-ux-pro-max → $agent (ya existe)"; continue; }
  uipro init --ai "$agent" --global 2>/dev/null \
    && ok "ui-ux-pro-max → $agent" \
    || warn "uipro init falló para $agent"
done

# B3: taste-skill curado
step "B3 · taste-skill  ${DIM}(LeonxlnX — high-end-visual + design-taste + enforcement + brutalist)${RESET}"
TASTE_REPO="$PRIMARY_DIR/_taste-skill-repo"
if [ -d "$TASTE_REPO/.git" ]; then git -C "$TASTE_REPO" pull --quiet
else git clone --quiet https://github.com/Leonxlnx/taste-skill.git "$TASTE_REPO" && ok "taste-skill clonado"; fi
for skill in "high-end-visual-design" "design-taste-frontend" "full-output-enforcement" "industrial-brutalist-ui"; do
  SRC="$TASTE_REPO/$skill"; [ -d "$SRC" ] || { warn "$skill no encontrado"; continue; }
  for agent in "${AGENTS[@]}"; do
    skill_installed "$skill" "$agent" && { ok "$skill → $agent (ya existe)"; continue; }
    DEST="$(agent_skills_dir "$agent")/$skill"; rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "$skill → $agent"
  done
done

# B4: impeccable
step "B4 · impeccable  ${DIM}(pbakaus — /polish /audit /critique /typeset)${RESET}"
IMPEC_SKIP=true
for agent in "${AGENTS[@]}"; do skill_installed "impeccable" "$agent" || { IMPEC_SKIP=false; break; }; done
if [ "$IMPEC_SKIP" = false ]; then
  IMPEC_REPO="$PRIMARY_DIR/_impeccable-repo"
  npx --yes skills add pbakaus/impeccable 2>/dev/null && ok "impeccable via npx" || \
    { [ -d "$IMPEC_REPO/.git" ] || git clone --quiet https://github.com/pbakaus/impeccable.git "$IMPEC_REPO" 2>/dev/null; }
  for agent in "${AGENTS[@]}"; do
    skill_installed "impeccable" "$agent" && { ok "impeccable → $agent (ya existe)"; continue; }
    SRC="$(agent_skills_dir "claude")/impeccable"; [ -d "$SRC" ] || SRC="$IMPEC_REPO"
    [ -d "$SRC" ] && { DEST="$(agent_skills_dir "$agent")/impeccable"; rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "impeccable → $agent"; }
  done
else skip "impeccable"; fi

# B5: anthropics/frontend-design
step "B5 · anthropics/frontend-design  ${DIM}(Anthropic Oficial)${RESET}"
FD_SKIP=true
for agent in "${AGENTS[@]}"; do skill_installed "frontend-design" "$agent" || { FD_SKIP=false; break; }; done
if [ "$FD_SKIP" = false ]; then
  ANTHROPIC_REPO="$PRIMARY_DIR/_anthropic-skills-repo"
  npx --yes skills add anthropics/skills --skill frontend-design 2>/dev/null && ok "frontend-design via npx" || \
    { [ -d "$ANTHROPIC_REPO/.git" ] || git clone --quiet https://github.com/anthropics/skills.git "$ANTHROPIC_REPO" 2>/dev/null; }
  for agent in "${AGENTS[@]}"; do
    skill_installed "frontend-design" "$agent" && { ok "frontend-design → $agent (ya existe)"; continue; }
    SRC="$(agent_skills_dir "claude")/frontend-design"; [ -d "$SRC" ] || SRC="$ANTHROPIC_REPO/frontend-design"
    [ -d "$SRC" ] && { DEST="$(agent_skills_dir "$agent")/frontend-design"; rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "frontend-design → $agent"; }
  done
else skip "frontend-design"; fi

# B6: antigravity (bundle web-wizard)
step "B6 · antigravity-awesome-skills  ${DIM}(1,465+ skills — bundle web-wizard)${RESET}"
for agent in "${AGENTS[@]}"; do
  skill_installed "antigravity" "$agent" && { ok "antigravity → $agent (ya existe)"; continue; }
  case "$agent" in
    claude) FLAG="--claude";; cursor) FLAG="--cursor";; windsurf) FLAG="--windsurf";;
    codex)  FLAG="--codex";;  gemini) FLAG="--gemini";; *) FLAG="--claude";;
  esac
  npx --yes antigravity-awesome-skills $FLAG --bundle web-wizard 2>/dev/null \
    && ok "antigravity → $agent (web-wizard)" \
    || npx --yes antigravity-awesome-skills $FLAG --category frontend,design 2>/dev/null \
    && ok "antigravity → $agent (frontend+design)" \
    || warn "antigravity requirió confirmación para $agent → ejecutá: npx antigravity-awesome-skills $FLAG"
done

# B7: vercel-labs/web-design-guidelines  ← NUEVO
step "B7 · vercel-labs/web-design-guidelines  ${DIM}(auditor de UI contra Web Interface Guidelines)${RESET}"
echo -e "  ${DIM}Revisa archivos de código UI contra las Web Interface Guidelines de Vercel. Detecta anti-patrones de accesibilidad, contraste y estructura.${RESET}"
for agent in "${AGENTS[@]}"; do
  skill_installed "web-design-guidelines" "$agent" && { ok "web-design-guidelines → $agent (ya existe)"; continue; }
  npx --yes skills add vercel-labs/agent-skills --skill web-design-guidelines 2>/dev/null \
    && ok "web-design-guidelines → $agent" \
    || {
      WDG_REPO="$PRIMARY_DIR/_vercel-agent-skills-repo"
      [ -d "$WDG_REPO/.git" ] || git clone --quiet https://github.com/vercel-labs/agent-skills.git "$WDG_REPO" 2>/dev/null
      SRC="$WDG_REPO/skills/web-design-guidelines"
      if [ -d "$SRC" ]; then
        DEST="$(agent_skills_dir "$agent")/web-design-guidelines"
        rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "web-design-guidelines → $agent"
      else warn "web-design-guidelines no encontrado"; fi
    }
done

# B8: huashu-design  ← NUEVO
step "B8 · huashu-design  ${DIM}(花叔 — 7 capabilities · 20 filosofías · sin quemar créditos)${RESET}"
echo -e "  ${DIM}Genera prototipos, slides, animaciones en la terminal. Brand Asset Protocol + 20 vocabulario de diseño. Compatible: Claude Code · Cursor · Codex · Gemini CLI.${RESET}"
for agent in "${AGENTS[@]}"; do
  skill_installed "huashu-design" "$agent" && { ok "huashu-design → $agent (ya existe)"; continue; }
  # Instalación via npx (comando oficial del skill)
  npx --yes huashu install 2>/dev/null && ok "huashu-design instalado via npx" \
    || {
      # Fallback: clonar repo
      HUASHU_REPO="$PRIMARY_DIR/_huashu-design-repo"
      [ -d "$HUASHU_REPO/.git" ] \
        || git clone --quiet https://github.com/iamhuashu/huashu-design.git "$HUASHU_REPO" 2>/dev/null \
        || git clone --quiet https://github.com/花叔/huashu-design.git "$HUASHU_REPO" 2>/dev/null \
        || { warn "huashu-design: repo no encontrado — buscalo en GitHub como 'huashu-design skill'"; continue; }
      SRC="$HUASHU_REPO"; DEST="$(agent_skills_dir "$agent")/huashu-design"
      [ -d "$SRC" ] && { rm -rf "$DEST"; cp -r "$SRC" "$DEST" && ok "huashu-design → $agent"; }
    }
done

# B9: nexu-io/open-design skills (skills extraídos)  ← NUEVO
step "B9 · nexu-io/open-design skills  ${DIM}(19 skills — alternativa open source a Claude Design)${RESET}"
echo -e "  ${DIM}71 design systems (Stripe, Vercel, Linear, Apple…) · prototipos web/mobile/slides/video · compatible todos los agentes.${RESET}"
OPEN_DESIGN_REPO="$PRIMARY_DIR/_open-design-repo"
OD_SKIP=true
for agent in "${AGENTS[@]}"; do skill_installed "open-design-skills" "$agent" || { OD_SKIP=false; break; }; done
if [ "$OD_SKIP" = false ]; then
  if [ -d "$OPEN_DESIGN_REPO/.git" ]; then git -C "$OPEN_DESIGN_REPO" pull --quiet
  else
    git clone --quiet --depth 1 https://github.com/nexu-io/open-design.git "$OPEN_DESIGN_REPO" 2>/dev/null \
      && ok "open-design repo clonado" || warn "No se pudo clonar nexu-io/open-design"
  fi
  SKILLS_SRC="$OPEN_DESIGN_REPO/skills"
  if [ -d "$SKILLS_SRC" ]; then
    for agent in "${AGENTS[@]}"; do
      skill_installed "open-design-skills" "$agent" && { ok "open-design-skills → $agent (ya existe)"; continue; }
      DEST="$(agent_skills_dir "$agent")/open-design-skills"
      rm -rf "$DEST"; cp -r "$SKILLS_SRC" "$DEST" && ok "open-design-skills → $agent"
    done
  else warn "Directorio skills/ no encontrado en open-design"; fi
else skip "open-design-skills"; fi

# ════════════════════════════════════════════════════════════════════
# TIER C — PROYECTOS Y HERRAMIENTAS
# ════════════════════════════════════════════════════════════════════
section "TIER C — Proyectos y herramientas"
echo ""
echo -e "  ${DIM}No son skills — son proyectos completos. Se instalan según necesidad.${RESET}"; echo ""

# C1: LightRAG
step "C1 · LightRAG  ${DIM}(HKUDS — RAG con grafos · 33K★)${RESET}"
python3 -c "import lightrag" 2>/dev/null && skip "lightrag-hku ya instalado" || {
  read -rp "  ¿Instalar LightRAG? [s/N]: " r; r="${r:-N}"
  if [[ "$r" =~ ^[Ss] ]]; then
    command -v uv &>/dev/null && uv tool install "lightrag-hku[api]" 2>/dev/null && ok "LightRAG via uv" \
      || { $PIP_CMD install "lightrag-hku[api]" 2>/dev/null && ok "LightRAG via pip"; } \
      || warn "Error instalando LightRAG"
  else note "Manual: pip install lightrag-hku[api]"; fi
}

# C2: cult/ui registry
step "C2 · cult/ui  ${DIM}(nolly-studio — componentes premium para Design Engineers · shadcn registry)${RESET}"
echo -e "  ${DIM}Componentes accesibles y customizables para shadcn + Tailwind + Framer Motion."
echo -e "  Dynamic Island · Shift Card · Family Button · Direction Aware Tabs · Texture Card.${RESET}"
CULT_DIR="$HOME/projects/cult-ui"
if [ -d "$CULT_DIR/.git" ]; then skip "cult-ui ya clonado"
else
  read -rp "  ¿Clonar cult/ui en ~/projects/? [s/N]: " r; r="${r:-N}"
  if [[ "$r" =~ ^[Ss] ]]; then
    mkdir -p "$HOME/projects"
    git clone --quiet https://github.com/nolly-studio/cult-ui.git "$CULT_DIR" 2>/dev/null \
      && ok "cult/ui clonado en $CULT_DIR" \
      && note "Para usar en tu proyecto: agregar registry en components.json → npx shadcn@beta add @cult-ui/[component]" \
      || warn "No se pudo clonar cult-ui"
  else info "Referencia: cult-ui.com | github.com/nolly-studio/cult-ui"; fi
fi

# C3: agent-browser
step "C3 · agent-browser  ${DIM}(vercel-labs — CLI Rust para automatización de browser · 377K★ skills)${RESET}"
echo -e "  ${DIM}Browser automation nativo para agentes IA. Instala Chrome for Testing automáticamente.${RESET}"
if command -v agent-browser &>/dev/null; then skip "agent-browser ya instalado"
else
  read -rp "  ¿Instalar agent-browser? [s/N]: " r; r="${r:-N}"
  if [[ "$r" =~ ^[Ss] ]]; then
    case "$OS" in
      macos)
        brew install agent-browser 2>/dev/null && ok "agent-browser via Homebrew" \
          || { npm install -g agent-browser 2>/dev/null && ok "agent-browser via npm"; } \
          || warn "Error instalando agent-browser"
        ;;
      *)
        npm install -g agent-browser 2>/dev/null && ok "agent-browser via npm" \
          || warn "Error instalando agent-browser"
        ;;
    esac
    command -v agent-browser &>/dev/null && {
      info "Descargando Chrome for Testing..."
      agent-browser install 2>/dev/null && ok "Chrome for Testing descargado" || warn "agent-browser install falló"
    }
  else
    note "Manual (macOS): brew install agent-browser && agent-browser install"
    note "Manual (npm):   npm install -g agent-browser && agent-browser install"
  fi
fi

# C4: WhatsApp AgentKit
step "C4 · WhatsApp AgentKit  ${DIM}(agente WhatsApp con Claude Code · < 30 min)${RESET}"
WA_DIR="$HOME/projects/whatsapp-agentkit"
if [ -d "$WA_DIR/.git" ]; then skip "whatsapp-agentkit ya clonado"
else
  read -rp "  ¿Clonar WhatsApp AgentKit? [s/N]: " r; r="${r:-N}"
  [[ "$r" =~ ^[Ss] ]] && {
    mkdir -p "$HOME/projects"
    git clone --quiet https://github.com/Hainrixz/whatsapp-agentkit.git "$WA_DIR" 2>/dev/null \
      && ok "whatsapp-agentkit en $WA_DIR" && note "Para usar: cd ~/projects/whatsapp-agentkit && claude → /build-agent" \
      || warn "No se pudo clonar"
  } || info "github.com/Hainrixz/whatsapp-agentkit"
fi

# C5: nexu-io/open-design (app completa)
step "C5 · nexu-io/open-design  ${DIM}(app completa — alternativa open source a Claude Design · 47K★)${RESET}"
echo -e "  ${DIM}71 design systems · 19 skills · prototipos HTML/PDF/PPTX/MP4 · todos los agentes.${RESET}"
OD_APP_DIR="$HOME/projects/open-design"
if [ -d "$OD_APP_DIR/.git" ]; then skip "open-design ya clonado"
else
  read -rp "  ¿Clonar open-design (app completa)? [s/N]: " r; r="${r:-N}"
  [[ "$r" =~ ^[Ss] ]] && {
    mkdir -p "$HOME/projects"
    git clone --quiet https://github.com/nexu-io/open-design.git "$OD_APP_DIR" 2>/dev/null \
      && ok "open-design clonado en $OD_APP_DIR" \
      && note "Para usar: cd ~/projects/open-design && pnpm install && pnpm dev:all" \
      || warn "No se pudo clonar open-design"
  } || info "github.com/nexu-io/open-design"
fi

# C6: Claude Web Builder
step "C6 · Claude Web Builder  ${DIM}(landing pages sin código · README en español)${RESET}"
WEB_DIR="$HOME/projects/claude-web-builder"
if [ -d "$WEB_DIR/.git" ]; then skip "claude-web-builder ya clonado"
else
  read -rp "  ¿Clonar Claude Web Builder? [s/N]: " r; r="${r:-N}"
  [[ "$r" =~ ^[Ss] ]] && {
    mkdir -p "$HOME/projects"
    git clone --quiet https://github.com/anthropics/claude-web-builder.git "$WEB_DIR" 2>/dev/null \
      && ok "claude-web-builder clonado" \
      || warn "Buscá 'Claude Web Builder' en GitHub"
  } || info "Buscar en GitHub: Claude Web Builder"
fi

# C7: Claude Code Ultimate Guide (referencia)
step "C7 · Claude Code Ultimate Guide  ${DIM}(referencia — v3.38.12 · sin instalación)${RESET}"
note "Recurso web — guardá el link: buscar en GitHub 'Claude Code Ultimate Guide'"

# ════════════════════════════════════════════════════════════════════
# TIER D — MCP SERVERS ESPECÍFICOS DE DISEÑO  ← NUEVO TIER
# ════════════════════════════════════════════════════════════════════
section "TIER D — MCP Servers de diseño  ${DIM}(Claude Code · Gemini CLI · compatibles MCP)${RESET}"
echo ""
echo -e "  ${DIM}Servidores MCP que amplían capacidades específicas de diseño e imagen.${RESET}"; echo ""

# D1: nano-banana-mcp
step "D1 · nano-banana-mcp  ${DIM}(zhongweili — generación de imágenes Gemini Flash 2.5)${RESET}"
echo -e "  ${DIM}Genera imágenes, iconos, diagramas, storyboards con Gemini. Requiere GEMINI_API_KEY.${RESET}"
if [ "$CLAUDE_CLI" = true ] && claude mcp list 2>/dev/null | grep -q "nano-banana"; then
  skip "nano-banana-mcp ya configurado"
else
  read -rp "  ¿Configurar nano-banana-mcp? (requiere GEMINI_API_KEY) [s/N]: " r; r="${r:-N}"
  if [[ "$r" =~ ^[Ss] ]]; then
    read -rp "  GEMINI_API_KEY: " GEMINI_KEY
    if [ -n "$GEMINI_KEY" ]; then
      if [ "$CLAUDE_CLI" = true ]; then
        claude mcp add nano-banana \
          -e GEMINI_API_KEY="$GEMINI_KEY" \
          -- npx -y -p @lyalindotcom/nano-banana-mcp nano-banana-server 2>/dev/null \
          && ok "nano-banana-mcp configurado en Claude Code" \
          || warn "Error configurando nano-banana-mcp"
      fi
      if [ "$GEMINI_CLI" = true ]; then
        info "Para Gemini CLI, agregar al settings.json de gemini:"
        note '{"mcpServers":{"nano-banana":{"command":"npx","args":["-y","-p","@lyalindotcom/nano-banana-mcp","nano-banana-server"],"env":{"GEMINI_API_KEY":"'$GEMINI_KEY'"}}}}'
      fi
    else warn "API key vacía — omitiendo nano-banana-mcp"; fi
  else
    info "Manual — agregar a .mcp.json o settings.json:"
    info '{"nano-banana":{"command":"npx","args":["-y","-p","@lyalindotcom/nano-banana-mcp","nano-banana-server"],"env":{"GEMINI_API_KEY":"TU_KEY"}}}'
  fi
fi

# D2: stitch-skills (Google Labs)
step "D2 · google-labs-code/stitch-skills  ${DIM}(Google Stitch MCP — design-md · shadcn · remotion)${RESET}"
echo -e "  ${DIM}Skills para Google Stitch: design-md · enhance-prompt · react-components · shadcn-ui · stitch-loop · remotion. Compatible con Claude Code, Gemini CLI, Cursor, Antigravity.${RESET}"
STITCH_REPO="$PRIMARY_DIR/_stitch-skills-repo"
STITCH_SKIP=true
for agent in "${AGENTS[@]}"; do skill_installed "stitch-skills" "$agent" || { STITCH_SKIP=false; break; }; done
if [ "$STITCH_SKIP" = true ]; then skip "stitch-skills"
else
  if [ -d "$STITCH_REPO/.git" ]; then git -C "$STITCH_REPO" pull --quiet
  else git clone --quiet --depth 1 https://github.com/google-labs-code/stitch-skills.git "$STITCH_REPO" 2>/dev/null \
    && ok "stitch-skills clonado" || { warn "No se pudo clonar stitch-skills"; STITCH_REPO=""; }; fi
  if [ -n "$STITCH_REPO" ] && [ -d "$STITCH_REPO/skills" ]; then
    for agent in "${AGENTS[@]}"; do
      skill_installed "stitch-skills" "$agent" && { ok "stitch-skills → $agent (ya existe)"; continue; }
      DEST="$(agent_skills_dir "$agent")/stitch-skills"
      rm -rf "$DEST"; cp -r "$STITCH_REPO/skills" "$DEST" && ok "stitch-skills → $agent"
    done
  fi
fi

# D3: find-skills + mcp-builder (antigravity)
step "D3 · find-skills + mcp-builder  ${DIM}(antigravity — descubrir skills · construir MCP servers)${RESET}"
echo -e "  ${DIM}find-skills: activa cuando el usuario pide 'find a skill for X'. mcp-builder: guía creación de MCP servers en Python/FastMCP o Node/TypeScript.${RESET}"
for skill_name in "find-skills" "mcp-builder"; do
  FS_SKIP=true
  for agent in "${AGENTS[@]}"; do skill_installed "$skill_name" "$agent" || { FS_SKIP=false; break; }; done
  if [ "$FS_SKIP" = true ]; then skip "$skill_name"; continue; fi
  for agent in "${AGENTS[@]}"; do
    skill_installed "$skill_name" "$agent" && { ok "$skill_name → $agent (ya existe)"; continue; }
    case "$agent" in
      claude) FLAG="--claude";; cursor) FLAG="--cursor";; windsurf) FLAG="--windsurf";;
      codex)  FLAG="--codex";; gemini) FLAG="--gemini";; *) FLAG="--claude";;
    esac
    npx --yes antigravity-awesome-skills $FLAG --skill "$skill_name" 2>/dev/null \
      && ok "$skill_name → $agent" \
      || warn "$skill_name: ejecutá npx antigravity-awesome-skills $FLAG --skill $skill_name"
  done
done

# ════════════════════════════════════════════════════════════════════
# GEMINI CLI: SETUP ESPECÍFICO
# ════════════════════════════════════════════════════════════════════
if [[ " ${AGENTS[*]} " =~ " gemini " ]]; then
  section "Gemini CLI — Configuración específica"
  echo ""
  GEMINI_SKILLS_DIR=$(agent_skills_dir "gemini")
  echo -e "  ${DIM}Directorio de skills: $GEMINI_SKILLS_DIR${RESET}"; echo ""

  if [ "$GEMINI_CLI" = false ]; then
    warn "Gemini CLI no instalado. Para instalar:"
    echo ""
    echo -e "  ${CYAN}npm install -g @google/gemini-cli${RESET}"
    echo -e "  ${DIM}Luego autenticarse: gemini (sigue el wizard con tu cuenta Google)${RESET}"
    echo -e "  ${DIM}Gratis: 60 req/min · 1,000 req/día · contexto 1M tokens${RESET}"
  else
    ok "Gemini CLI detectado — skills instalados en $GEMINI_SKILLS_DIR"
    echo ""
    note "Para activar skills en Gemini CLI, mencionalos en el prompt:"
    info "  gemini → 'Using web-design-guidelines, review my components/'"
    info "  gemini → 'With huashu-design skill, generate a SaaS landing page'"
    echo ""
    note "Para conectar nano-banana-mcp con Gemini CLI:"
    info "  gemini → configurar MCP en ~/.config/gemini/settings.json"
    echo ""
    note "Para stitch-skills con Gemini CLI:"
    info "  gemini extensions install --auto-update [stitch-extension-url]"
  fi
fi

# ════════════════════════════════════════════════════════════════════
# RESUMEN FINAL
# ════════════════════════════════════════════════════════════════════
echo ""; hr; echo ""
step "Resumen de instalación"; echo ""

# Tier A
echo -e "  ${BLUE}${BOLD}TIER A — Plugins Claude Code${RESET}"; echo ""
for item in \
  "superpowers:$HOME/.claude/plugins/marketplaces/obra:/plugin install superpowers@claude-plugins-official" \
  "claude-mem:$HOME/.claude/plugins/marketplaces/thedotmack:/install thedotmack/claude-mem" \
  "security-guidance:$HOME/.claude/plugins/marketplaces/anthropics/security-guidance:/install anthropics/security-guidance" \
  "gstack:$HOME/.claude/skills/gstack:cd ~/.claude/skills/gstack && ./setup" \
  "everything-claude-code:$HOME/.claude/skills/ecc:npx ecc-install --profile minimal" \
  "n8n-mcp:MCP:claude mcp add n8n-mcp -- npx n8n-mcp"
do
  name="${item%%:*}"; rest="${item#*:}"; dir="${rest%%:*}"; cmd="${rest#*:}"
  if [ "$name" = "n8n-mcp" ]; then
    { [ "$CLAUDE_CLI" = true ] && claude mcp list 2>/dev/null | grep -q "n8n-mcp" \
      && echo -e "    ${GREEN}✓${RESET}  $name" \
      || echo -e "    ${YELLOW}○${RESET}  $name  ${DIM}→ $cmd${RESET}"; }
  elif [ -d "$dir" ]; then echo -e "    ${GREEN}✓${RESET}  $name"
  elif [ "$CLAUDE_CLI" = false ]; then echo -e "    ${RED}—${RESET}  $name  ${DIM}(requiere Claude Code CLI)${RESET}"
  else echo -e "    ${YELLOW}○${RESET}  $name  ${DIM}→ en Claude Code: $cmd${RESET}"; fi
done
echo ""

# Tier B
TIER_B_SKILLS=("emil-design-eng" "ui-ux-pro-max" "high-end-visual-design" "design-taste-frontend"
  "full-output-enforcement" "industrial-brutalist-ui" "impeccable" "frontend-design"
  "antigravity" "web-design-guidelines" "huashu-design" "open-design-skills")
echo -e "  ${BLUE}${BOLD}TIER B — Skills universales${RESET}"; echo ""
TOTAL_OK=0; TOTAL_PENDING=0
for agent in "${AGENTS[@]}"; do
  BASE=$(agent_skills_dir "$agent")
  echo -e "  ${CYAN}${BOLD}$agent${RESET}  ${DIM}$BASE${RESET}"
  for skill in "${TIER_B_SKILLS[@]}"; do
    if [ -d "$BASE/$skill" ]; then echo -e "    ${GREEN}✓${RESET}  $skill"; TOTAL_OK=$((TOTAL_OK+1))
    else echo -e "    ${YELLOW}○${RESET}  $skill  ${DIM}(pendiente)${RESET}"; TOTAL_PENDING=$((TOTAL_PENDING+1)); fi
  done; echo ""
done

# Tier C
echo -e "  ${BLUE}${BOLD}TIER C — Proyectos${RESET}"; echo ""
for item in \
  "LightRAG:python3 -c 'import lightrag' 2>/dev/null" \
  "cult/ui:[ -d $HOME/projects/cult-ui ]" \
  "agent-browser:command -v agent-browser &>/dev/null" \
  "whatsapp-agentkit:[ -d $HOME/projects/whatsapp-agentkit ]" \
  "open-design app:[ -d $HOME/projects/open-design ]" \
  "claude-web-builder:[ -d $HOME/projects/claude-web-builder ]"
do
  name="${item%%:*}"; check="${item#*:}"
  if eval "$check" 2>/dev/null; then echo -e "    ${GREEN}✓${RESET}  $name"
  else echo -e "    ${YELLOW}○${RESET}  $name  ${DIM}(opcional)${RESET}"; fi
done
echo -e "    ${BLUE}★${RESET}  Claude Code Ultimate Guide  ${DIM}(referencia web)${RESET}"
echo ""

# Tier D
echo -e "  ${BLUE}${BOLD}TIER D — MCP Servers de diseño${RESET}"; echo ""
NB_CHECK=false
[ "$CLAUDE_CLI" = true ] && claude mcp list 2>/dev/null | grep -q "nano-banana" && NB_CHECK=true
$NB_CHECK && echo -e "    ${GREEN}✓${RESET}  nano-banana-mcp" || echo -e "    ${YELLOW}○${RESET}  nano-banana-mcp  ${DIM}(requiere GEMINI_API_KEY)${RESET}"
for skill_d in "stitch-skills" "find-skills" "mcp-builder"; do
  for agent in "${AGENTS[@]}"; do
    [ -d "$(agent_skills_dir "$agent")/$skill_d" ] \
      && { echo -e "    ${GREEN}✓${RESET}  $skill_d  ${DIM}($agent)${RESET}"; break; } \
      || echo -e "    ${YELLOW}○${RESET}  $skill_d  ${DIM}(pendiente)${RESET}"
  done
done
echo ""

hr; echo ""
echo -e "  ${BOLD}Próximos pasos:${RESET}"; echo ""
echo -e "  ${CYAN}1.${RESET}  Verificar: ${DIM}ls ~/.claude/skills/ && claude /plugin list && claude mcp list${RESET}"
echo -e "  ${CYAN}2.${RESET}  Explorar componentes: ${DIM}https://www.cult-ui.com · https://www.21st.dev${RESET}"
echo -e "  ${CYAN}3.${RESET}  Primer prompt: ${DIM}\"Before any code, generate a complete design system for my app.\"${RESET}"
echo -e "  ${CYAN}4.${RESET}  Comandos clave:"
echo -e "     ${DIM}impeccable:     /polish  /audit  /critique  /typeset  /motion  /a11y${RESET}"
echo -e "     ${DIM}gstack:         /plan-design-review  /review  /qa  /ship${RESET}"
echo -e "     ${DIM}nano-banana:    \"generate an icon for...\"  \"create a dashboard screenshot\"${RESET}"
echo -e "     ${DIM}stitch-skills:  \"create design-md\"  \"convert to React components\"${RESET}"
echo -e "     ${DIM}huashu-design:  \"design a SaaS landing page\" (sin salir de la terminal)${RESET}"
if [ "$GEMINI_CLI" = true ]; then
  echo -e "     ${DIM}gemini:         gemini → mencionar skill por nombre en el prompt${RESET}"
fi
echo ""
hr; echo ""
echo -e "  ${GREEN}${BOLD}✓  Tier B: $TOTAL_OK skills instalados${RESET}"
[ "$TOTAL_PENDING" -gt 0 ] && echo -e "  ${YELLOW}○  $TOTAL_PENDING skills Tier B pendientes${RESET}"
[ "$CLAUDE_CLI" = true ] && echo -e "  ${GREEN}★  Tier A: plugins Claude Code procesados${RESET}"
[ "$GEMINI_CLI" = true ] && echo -e "  ${GREEN}★  Gemini CLI: skills instalados en $(agent_skills_dir gemini)${RESET}"
echo ""
echo -e "  ${DIM}Framework UI/UX con IA  —  v4.0  —  Mayo 2026${RESET}"; echo ""
