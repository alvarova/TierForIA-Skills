#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════════════╗
# ║   FRAMEWORK UI/UX — INSTALADOR COMPLETO DE SKILLS               ║
# ║   Claude Code  +  Codex CLI  —  Global  —  Sin prompts          ║
# ║   v2.0 — Mayo 2026                                               ║
# ╚══════════════════════════════════════════════════════════════════╝
#
#  SKILLS QUE INSTALA (todos los de la conversación):
#
#  TIER B — SKILL.md universales
#  ├── emilkowalski/skill          (animaciones, motion, Sonner/Vaul)
#  ├── ui-ux-pro-max               (motor design system — colores, tipografía, spacing)
#  ├── high-end-visual-design      (core — estética premium, evita defaults)
#  ├── design-taste-frontend       (criterio de diseño en código)
#  ├── full-output-enforcement     (componentes completos, sin fragmentos)
#  ├── industrial-brutalist-ui     (estilo editorial/distintivo)
#  ├── impeccable                  (audita y refina — /polish /audit /critique)
#  ├── anthropics/frontend-design  (oficial Anthropic — production-grade)
#  ├── antigravity web-wizard      (1465+ skills, bundle frontend+design+lint)
#  ├── web-design-guidelines       (Vercel — auditor UI vs. Interface Guidelines)
#  ├── huashu-design               (花叔 — prototipos, slides, animaciones)
#  ├── open-design-skills          (nexu-io — 19 skills + 71 design systems)
#  ├── stitch-skills               (Google Labs — design-md, shadcn, react)
#  ├── find-skills                 (antigravity — descubrimiento de skills)
#  └── mcp-builder                 (antigravity — construir MCP servers)
#
#  TIER A — Solo Claude Code (plugins nativos)
#  ├── garrytan/gstack             (/review /qa /ship /plan-*)
#  ├── everything-claude-code ECC  (142 skills, 36 agentes, hooks TDD)
#  └── nano-banana-mcp             (MCP — imágenes Gemini Flash)
#
# ══════════════════════════════════════════════════════════════════
set -euo pipefail

RESET="\033[0m"; BOLD="\033[1m"; DIM="\033[2m"
CYAN="\033[36m"; GREEN="\033[32m"; YELLOW="\033[33m"
RED="\033[31m";  BLUE="\033[34m"; MAGENTA="\033[35m"

ok()   { echo -e "  ${GREEN}✓${RESET}  $1"; }
skip() { echo -e "  ${DIM}–${RESET}  $1 ${DIM}(ya instalado)${RESET}"; }
warn() { echo -e "  ${YELLOW}⚠${RESET}  $1"; }
err()  { echo -e "  ${RED}✗${RESET}  $1"; }
info() { echo -e "  ${DIM}  $1${RESET}"; }
note() { echo -e "  ${MAGENTA}★${RESET}  $1"; }
step() { echo -e "\n${CYAN}${BOLD}▶  $1${RESET}"; }
hr()   { echo -e "  ${DIM}────────────────────────────────────────────────────${RESET}"; }

clear; echo ""
echo -e "${CYAN}${BOLD}  ╔═══════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}  ║   FRAMEWORK UI/UX — INSTALADOR COMPLETO          ║${RESET}"
echo -e "${CYAN}${BOLD}  ║   Claude Code  +  Codex CLI  —  Global  v2.0     ║${RESET}"
echo -e "${CYAN}${BOLD}  ╚═══════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${DIM}15 skills · 3 plugins nativos · Automático · Sin selección manual${RESET}"
hr; echo ""

# ── Destinos ───────────────────────────────────────────────────────
CLAUDE_DIR="$HOME/.claude/skills"
CODEX_DIR="$HOME/.codex/skills"
CACHE="$HOME/.cache/uiux-skills"
mkdir -p "$CLAUDE_DIR" "$CODEX_DIR" "$CACHE"

# Detectar Claude Code CLI
CLAUDE_CLI=false
command -v claude &>/dev/null && CLAUDE_CLI=true

# ── Helpers ────────────────────────────────────────────────────────

# Instalar skill desde git repo → claude + codex
# Uso: from_git <skill-name> <repo-url> [subdir]
from_git() {
  local name="$1" url="$2" subdir="${3:-}"
  local repo="$CACHE/$(echo "$name" | tr '/+' '--')-repo"
  [ -d "$CLAUDE_DIR/$name" ] && [ -d "$CODEX_DIR/$name" ] && { skip "$name"; return 0; }
  if [ -d "$repo/.git" ]; then
    git -C "$repo" pull --quiet 2>/dev/null || true
  else
    git clone --quiet --depth 1 "$url" "$repo" 2>/dev/null \
      || { err "$name — clone falló: $url"; return 1; }
  fi
  local src="$repo"; [ -n "$subdir" ] && src="$repo/$subdir"
  [ -d "$src" ] || { err "$name — subdir '$subdir' no encontrado"; return 1; }
  [ -d "$CLAUDE_DIR/$name" ] || { rm -rf "$CLAUDE_DIR/$name"; cp -r "$src" "$CLAUDE_DIR/$name"; }
  [ -d "$CODEX_DIR/$name"  ] || { rm -rf "$CODEX_DIR/$name";  cp -r "$src" "$CODEX_DIR/$name"; }
  ok "$name → claude + codex"
}

# Instalar via npx skills add → claude, luego copiar a codex
from_npx() {
  local name="$1"; shift
  [ -d "$CLAUDE_DIR/$name" ] && [ -d "$CODEX_DIR/$name" ] && { skip "$name"; return 0; }
  if npx --yes skills add "$@" 2>/dev/null; then
    [ -d "$CLAUDE_DIR/$name" ] && {
      [ -d "$CODEX_DIR/$name" ] || { rm -rf "$CODEX_DIR/$name"; cp -r "$CLAUDE_DIR/$name" "$CODEX_DIR/$name"; }
    }
    ok "$name → claude + codex"
  else
    return 1
  fi
}

# Instalar via antigravity --claude + copiar a codex
from_antigravity() {
  local name="$1"; shift
  [ -d "$CLAUDE_DIR/$name" ] && [ -d "$CODEX_DIR/$name" ] && { skip "$name"; return 0; }
  npx --yes antigravity-awesome-skills --claude "$@" 2>/dev/null \
    || npx --yes antigravity-awesome-skills --codex "$@" 2>/dev/null \
    || { warn "$name — antigravity no disponible ahora"; return 1; }
  [ -d "$CLAUDE_DIR/$name" ] && {
    [ -d "$CODEX_DIR/$name" ] || { rm -rf "$CODEX_DIR/$name"; cp -r "$CLAUDE_DIR/$name" "$CODEX_DIR/$name"; }
  }
  ok "$name → claude + codex"
}

# ════════════════════════════════════════════════════════════════════
# TIER B — SKILL.md UNIVERSALES
# ════════════════════════════════════════════════════════════════════
echo -e "  ${BLUE}${BOLD}══ TIER B — Skills universales SKILL.md ══${RESET}"; echo ""

# ── Grupo 1: taste-skill (4 skills del mismo repo) ────────────────
step "taste-skill (×4)  ${DIM}high-end-visual-design · design-taste-frontend · full-output-enforcement · industrial-brutalist-ui${RESET}"

TASTE_REPO="$CACHE/taste-skill-repo"
if [ -d "$TASTE_REPO/.git" ]; then
  git -C "$TASTE_REPO" pull --quiet 2>/dev/null || true
else
  git clone --quiet https://github.com/Leonxlnx/taste-skill.git "$TASTE_REPO" 2>/dev/null \
    && ok "taste-skill repo clonado" \
    || { err "No se pudo clonar taste-skill"; }
fi

for skill in \
  "high-end-visual-design" \
  "design-taste-frontend" \
  "full-output-enforcement" \
  "industrial-brutalist-ui"
do
  SRC="$TASTE_REPO/$skill"
  [ -d "$SRC" ] || { warn "$skill no encontrado en repo"; continue; }
  [ -d "$CLAUDE_DIR/$skill" ] && [ -d "$CODEX_DIR/$skill" ] && { skip "$skill"; continue; }
  [ -d "$CLAUDE_DIR/$skill" ] || { rm -rf "$CLAUDE_DIR/$skill"; cp -r "$SRC" "$CLAUDE_DIR/$skill"; }
  [ -d "$CODEX_DIR/$skill"  ] || { rm -rf "$CODEX_DIR/$skill";  cp -r "$SRC" "$CODEX_DIR/$skill"; }
  ok "$skill → claude + codex"
done

# ── B1: emilkowalski/skill ────────────────────────────────────────
step "emilkowalski/skill  ${DIM}(animaciones, motion, Sonner/Vaul)${RESET}"
from_npx "emil-design-eng" emilkowalski/skill \
  || from_git "emil-design-eng" "https://github.com/emilkowalski/skill.git"

# ── B2: ui-ux-pro-max ─────────────────────────────────────────────
step "ui-ux-pro-max  ${DIM}(motor design system — colores, tipografía, spacing)${RESET}"
if [ -d "$CLAUDE_DIR/ui-ux-pro-max" ] && [ -d "$CODEX_DIR/ui-ux-pro-max" ]; then
  skip "ui-ux-pro-max"
else
  npm install -g uipro-cli 2>&1 | grep -v "^npm warn" | grep -v "^added" | grep -v "^$" | head -2 || true
  uipro init --ai claude --global 2>/dev/null && ok "ui-ux-pro-max → claude" || warn "uipro init claude falló"
  uipro init --ai codex  --global 2>/dev/null && ok "ui-ux-pro-max → codex"  || warn "uipro init codex falló"
fi

# ── B3: impeccable ────────────────────────────────────────────────
step "impeccable  ${DIM}(audita y refina — /polish /audit /critique /typeset)${RESET}"
from_npx "impeccable" pbakaus/impeccable \
  || from_git "impeccable" "https://github.com/pbakaus/impeccable.git"

# ── B4: anthropics/frontend-design ───────────────────────────────
step "frontend-design  ${DIM}(Anthropic Oficial — production-grade UI)${RESET}"
from_npx "frontend-design" anthropics/skills --skill frontend-design \
  || from_git "frontend-design" "https://github.com/anthropics/skills.git" "frontend-design"

# ── B5: antigravity web-wizard bundle ────────────────────────────
step "antigravity  ${DIM}(1,465+ skills — bundle web-wizard: frontend + design + lint)${RESET}"
if [ -d "$CLAUDE_DIR/antigravity" ] && [ -d "$CODEX_DIR/antigravity" ]; then
  skip "antigravity"
else
  npx --yes antigravity-awesome-skills --claude --bundle web-wizard 2>/dev/null \
    || npx --yes antigravity-awesome-skills --claude --category frontend,design 2>/dev/null \
    || warn "antigravity: ejecutá manualmente: npx antigravity-awesome-skills --claude"
  [ -d "$CLAUDE_DIR/antigravity" ] && {
    [ -d "$CODEX_DIR/antigravity" ] || { rm -rf "$CODEX_DIR/antigravity"; cp -r "$CLAUDE_DIR/antigravity" "$CODEX_DIR/antigravity"; }
    ok "antigravity → claude + codex"
  }
  npx --yes antigravity-awesome-skills --codex --bundle web-wizard 2>/dev/null || true
fi

# ── B6: vercel-labs/web-design-guidelines ────────────────────────
step "web-design-guidelines  ${DIM}(Vercel — auditor UI vs. Web Interface Guidelines)${RESET}"
from_npx "web-design-guidelines" vercel-labs/agent-skills --skill web-design-guidelines \
  || from_git "web-design-guidelines" "https://github.com/vercel-labs/agent-skills.git" "skills/web-design-guidelines"

# ── B7: huashu-design ─────────────────────────────────────────────
step "huashu-design  ${DIM}(花叔 — 7 capacidades · 20 vocabularios · Brand Asset Protocol)${RESET}"
if [ -d "$CLAUDE_DIR/huashu-design" ] && [ -d "$CODEX_DIR/huashu-design" ]; then
  skip "huashu-design"
else
  npx --yes huashu install 2>/dev/null && {
    [ -d "$CLAUDE_DIR/huashu-design" ] && {
      [ -d "$CODEX_DIR/huashu-design" ] || cp -r "$CLAUDE_DIR/huashu-design" "$CODEX_DIR/huashu-design"
    }
    ok "huashu-design → claude + codex"
  } || from_git "huashu-design" "https://github.com/iamhuashu/huashu-design.git"
fi

# ── B8: nexu-io/open-design skills ───────────────────────────────
step "open-design-skills  ${DIM}(nexu-io — 19 skills + 71 design systems: Stripe, Vercel, Linear…)${RESET}"
from_git "open-design-skills" "https://github.com/nexu-io/open-design.git" "skills"

# ── B9: stitch-skills ─────────────────────────────────────────────
step "stitch-skills  ${DIM}(Google Labs — design-md · shadcn-ui · react-components · stitch-loop)${RESET}"
from_git "stitch-skills" "https://github.com/google-labs-code/stitch-skills.git" "skills"

# ── B10: find-skills ──────────────────────────────────────────────
step "find-skills  ${DIM}(antigravity — descubrimiento de skills)${RESET}"
from_antigravity "find-skills" --skill find-skills \
  || from_git "find-skills" "https://github.com/sickn33/antigravity-awesome-skills.git" "skills/find-skills"

# ── B11: mcp-builder ──────────────────────────────────────────────
step "mcp-builder  ${DIM}(antigravity — guía para construir MCP servers)${RESET}"
from_antigravity "mcp-builder" --skill mcp-builder \
  || from_git "mcp-builder" "https://github.com/sickn33/antigravity-awesome-skills.git" "skills/mcp-builder"

# ════════════════════════════════════════════════════════════════════
# TIER A — PLUGINS NATIVOS CLAUDE CODE
# ════════════════════════════════════════════════════════════════════
echo ""
echo -e "  ${BLUE}${BOLD}══ TIER A — Plugins nativos Claude Code ══${RESET}"; echo ""

if [ "$CLAUDE_CLI" = true ]; then

  # garrytan/gstack
  step "garrytan/gstack  ${DIM}(/review /qa /ship /plan-ceo-review /plan-design-review)${RESET}"
  GSTACK_DIR="$HOME/.claude/skills/gstack"
  if [ -d "$GSTACK_DIR/.git" ]; then
    git -C "$GSTACK_DIR" pull --quiet 2>/dev/null || true
    ok "gstack actualizado"
  else
    git clone --single-branch --depth 1 \
      https://github.com/garrytan/gstack.git "$GSTACK_DIR" --quiet 2>/dev/null \
      && ok "gstack clonado" || warn "gstack — clone falló"
    [ -f "$GSTACK_DIR/setup" ] && {
      cd "$GSTACK_DIR"
      bash ./setup 2>/dev/null \
        && ok "gstack configurado" \
        || note "setup requiere input: cd ~/.claude/skills/gstack && ./setup"
      cd - &>/dev/null
    }
  fi

  # everything-claude-code (ECC)
  step "everything-claude-code  ${DIM}(affaan-m — 142 skills · 36 agentes · hooks TDD · security scan)${RESET}"
  if [ -d "$HOME/.claude/plugins/marketplaces/affaan-m" ] || [ -d "$HOME/.claude/skills/ecc" ]; then
    skip "everything-claude-code"
  else
    npx --yes ecc-install --profile minimal --target claude 2>/dev/null \
      && ok "everything-claude-code (minimal)" \
      || {
        warn "ecc-install no disponible — comandos manuales:"
        note "npm install -g @affaan-m/ecc"
        note "npx ecc-install --profile minimal --target claude"
        note "O en Claude Code: /plugin install everything-claude-code@claude-plugins-official"
      }
  fi

  # nano-banana-mcp
  step "nano-banana-mcp  ${DIM}(imágenes con Gemini Flash 2.5 — requiere GEMINI_API_KEY)${RESET}"
  if claude mcp list 2>/dev/null | grep -q "nano-banana"; then
    skip "nano-banana-mcp"
  else
    GEMINI_KEY="${GEMINI_API_KEY:-}"
    if [ -n "$GEMINI_KEY" ]; then
      claude mcp add nano-banana \
        -e GEMINI_API_KEY="$GEMINI_KEY" \
        -- npx -y -p @lyalindotcom/nano-banana-mcp nano-banana-server 2>/dev/null \
        && ok "nano-banana-mcp configurado" \
        || warn "nano-banana-mcp — error al agregar MCP"
    else
      warn "nano-banana-mcp requiere GEMINI_API_KEY"
      note "Para activar, exportá la variable y volvé a ejecutar:"
      info "  export GEMINI_API_KEY=tu_api_key && ./install-new-skills.sh"
      note "O manualmente en terminal:"
      info "  claude mcp add nano-banana \\"
      info "    -e GEMINI_API_KEY=TU_KEY \\"
      info "    -- npx -y -p @lyalindotcom/nano-banana-mcp nano-banana-server"
    fi
  fi

else
  warn "Claude Code CLI no detectado — Tier A omitido"
  echo ""
  note "Instalá Claude Code: npm install -g @anthropic-ai/claude-code"
  echo ""
  echo -e "  ${DIM}Comandos manuales Tier A:${RESET}"
  info "git clone --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack"
  info "cd ~/.claude/skills/gstack && ./setup"
  info "npx ecc-install --profile minimal --target claude"
  info "claude mcp add nano-banana -e GEMINI_API_KEY=TU_KEY -- npx -y -p @lyalindotcom/nano-banana-mcp nano-banana-server"
fi

# ════════════════════════════════════════════════════════════════════
# REFERENCIA: herramientas que NO se instalan globalmente
# ════════════════════════════════════════════════════════════════════
echo ""
echo -e "  ${BLUE}${BOLD}══ Referencias — por proyecto ══${RESET}"; echo ""

echo -e "  ${DIM}21st.dev${RESET}           → ${CYAN}https://www.21st.dev${RESET}  ${DIM}(referencia visual de componentes)${RESET}"
echo -e "  ${DIM}cult/ui${RESET}            → ${CYAN}npx shadcn@beta add @cult-ui/[component]${RESET}"
echo -e "  ${DIM}agent-browser${RESET}      → ${CYAN}npm install -g agent-browser && agent-browser install${RESET}"
echo -e "  ${DIM}open-design app${RESET}    → ${CYAN}git clone nexu-io/open-design && pnpm dev:all${RESET}"
echo -e "  ${DIM}WhatsApp AgentKit${RESET}  → ${CYAN}git clone Hainrixz/whatsapp-agentkit${RESET}"

# ════════════════════════════════════════════════════════════════════
# RESUMEN FINAL
# ════════════════════════════════════════════════════════════════════
echo ""; hr; echo ""
echo -e "  ${BOLD}Estado de instalación:${RESET}"; echo ""

ALL_SKILLS=(
  "high-end-visual-design"
  "design-taste-frontend"
  "full-output-enforcement"
  "industrial-brutalist-ui"
  "emil-design-eng"
  "ui-ux-pro-max"
  "impeccable"
  "frontend-design"
  "antigravity"
  "web-design-guidelines"
  "huashu-design"
  "open-design-skills"
  "stitch-skills"
  "find-skills"
  "mcp-builder"
)

OK=0; PENDING=0

echo -e "  ${CYAN}${BOLD}Skill${RESET}                          ${CYAN}${BOLD}Claude${RESET}   ${CYAN}${BOLD}Codex${RESET}"
hr
for skill in "${ALL_SKILLS[@]}"; do
  C="○"; D="○"
  [ -d "$CLAUDE_DIR/$skill" ] && C="✓"
  [ -d "$CODEX_DIR/$skill"  ] && D="✓"
  C_COLOR="${YELLOW}"; D_COLOR="${YELLOW}"
  [ "$C" = "✓" ] && C_COLOR="${GREEN}"
  [ "$D" = "✓" ] && D_COLOR="${GREEN}"
  printf "  %-32s ${C_COLOR}%s${RESET}      ${D_COLOR}%s${RESET}\n" "$skill" "$C" "$D"
  { [ "$C" = "✓" ] || [ "$D" = "✓" ]; } && OK=$((OK+1)) || PENDING=$((PENDING+1))
done

echo ""
# gstack
[ -d "$HOME/.claude/skills/gstack" ] \
  && printf "  %-32s ${GREEN}✓${RESET}      ${DIM}claude-only${RESET}\n" "gstack" \
  || printf "  %-32s ${YELLOW}○${RESET}      ${DIM}pendiente${RESET}\n" "gstack"

# ECC
{ [ -d "$HOME/.claude/plugins/marketplaces/affaan-m" ] \
  || [ -d "$HOME/.claude/skills/ecc" ]; } \
  && printf "  %-32s ${GREEN}✓${RESET}      ${DIM}claude-only${RESET}\n" "everything-claude-code" \
  || printf "  %-32s ${YELLOW}○${RESET}      ${DIM}pendiente${RESET}\n" "everything-claude-code"

# nano-banana
{ [ "$CLAUDE_CLI" = true ] && claude mcp list 2>/dev/null | grep -q "nano-banana"; } \
  && printf "  %-32s ${GREEN}✓${RESET}      ${DIM}MCP claude${RESET}\n" "nano-banana-mcp" \
  || printf "  %-32s ${YELLOW}○${RESET}      ${DIM}requiere GEMINI_API_KEY${RESET}\n" "nano-banana-mcp"

echo ""; hr; echo ""
echo -e "  ${GREEN}${BOLD}✓  $OK skills instalados${RESET}"
[ "$PENDING" -gt 0 ] && echo -e "  ${YELLOW}○  $PENDING pendientes${RESET}"
echo ""
echo -e "  ${BOLD}Comandos clave:${RESET}"
echo -e "  ${DIM}impeccable:   /polish  /audit  /critique  /typeset  /a11y${RESET}"
echo -e "  ${DIM}gstack:       /review  /qa  /ship  /plan-design-review${RESET}"
echo -e "  ${DIM}huashu:       \"design a SaaS landing page, save as landing.html\"${RESET}"
echo -e "  ${DIM}find-skills:  \"find a skill for X\"${RESET}"
echo ""
hr
echo -e "  ${DIM}Framework UI/UX  —  v2.0  —  Mayo 2026${RESET}"
echo ""
