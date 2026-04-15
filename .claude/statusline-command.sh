#!/usr/bin/env bash

input=$(cat)

# ── helpers ──────────────────────────────────────────────────────────────────

make_bar() {
  local pct="$1" width=8
  local filled=$(echo "$pct $width" | awk '{printf "%d", ($1/100)*$2 + 0.5}')
  local empty=$((width - filled))
  local bar=""
  for i in $(seq 1 $filled); do bar="${bar}█"; done
  for i in $(seq 1 $empty); do bar="${bar}░"; done
  printf "%s" "$bar"
}

bar_color() {
  local pct="$1"   # remaining %
  if   [ "$pct" -ge 60 ]; then printf "\033[32m"   # green
  elif [ "$pct" -ge 30 ]; then printf "\033[33m"   # yellow
  else                          printf "\033[31m"   # red
  fi
}

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
CYAN="\033[36m"
MAGENTA="\033[35m"
BLUE="\033[34m"
WHITE="\033[37m"
YELLOW="\033[33m"
GREEN="\033[32m"

# ── extract fields ────────────────────────────────────────────────────────────

model=$(echo "$input"        | jq -r '.model.display_name // "unknown"')
cwd=$(echo "$input"          | jq -r '.workspace.current_dir // .cwd // "?"')
version=$(echo "$input"      | jq -r '.version // ""')
session_name=$(echo "$input" | jq -r '.session_name // empty')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')
vim_mode=$(echo "$input"     | jq -r '.vim.mode // empty')
agent_name=$(echo "$input"   | jq -r '.agent.name // empty')
worktree=$(echo "$input"     | jq -r '.worktree.name // empty')
git_wt=$(echo "$input"       | jq -r '.workspace.git_worktree // empty')

ctx_used=$(echo "$input"     | jq -r '.context_window.used_percentage // empty')
ctx_rem=$(echo "$input"      | jq -r '.context_window.remaining_percentage // empty')

five_pct=$(echo "$input"     | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input"     | jq -r '.rate_limits.seven_day.used_percentage // empty')

# ── git info (best-effort) ────────────────────────────────────────────────────

git_branch=""
git_dirty=""
if command -v git >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
               || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$git_branch" ]; then
    dirty=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    [ -n "$dirty" ] && git_dirty=" ✏️"
  fi
fi

# ── assemble line ─────────────────────────────────────────────────────────────

SEP="${DIM}│${RESET}"

# 1. model
line="  🤖 ${BOLD}${CYAN}${model}${RESET}"
[ -n "$version" ] && line="${line} ${DIM}v${version}${RESET}"

# 2. session name
if [ -n "$session_name" ]; then
  line="${line}  ${SEP}  💬 ${MAGENTA}${session_name}${RESET}"
fi

# 3. output style (only show when not default)
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  line="${line}  ${SEP}  🎨 ${YELLOW}${output_style}${RESET}"
fi

# 4. vim mode
if [ -n "$vim_mode" ]; then
  if [ "$vim_mode" = "INSERT" ]; then
    line="${line}  ${SEP}  ✍️  ${GREEN}INSERT${RESET}"
  else
    line="${line}  ${SEP}  🔷 ${BLUE}NORMAL${RESET}"
  fi
fi

# 5. agent
if [ -n "$agent_name" ]; then
  line="${line}  ${SEP}  🕵️  ${YELLOW}${agent_name}${RESET}"
fi

# 6. working directory (shortened)
short_cwd=$(echo "$cwd" | sed "s|$HOME|~|")
line="${line}  ${SEP}  📁 ${WHITE}${short_cwd}${RESET}"

# 7. git branch / worktree
branch_display="${git_branch:-${worktree:-${git_wt}}}"
if [ -n "$branch_display" ]; then
  line="${line}  ${SEP}  🌿 ${GREEN}${branch_display}${git_dirty}${RESET}"
fi

# 8. context window
if [ -n "$ctx_rem" ]; then
  ctx_rem_int=$(printf "%.0f" "$ctx_rem")
  ctx_color=$(bar_color "$ctx_rem_int")
  ctx_bar=$(make_bar "$ctx_rem_int")
  line="${line}  ${SEP}  🧠 ${ctx_color}${ctx_bar} ${ctx_rem_int}%${RESET}"
fi

# 9. rate limits
if [ -n "$five_pct" ]; then
  five_left=$(echo "$five_pct" | awk '{printf "%.0f", 100 - $1}')
  col=$(bar_color "$five_left")
  bar=$(make_bar "$five_left")
  line="${line}  ${SEP}  ⏱️  ${col}${bar} ${five_left}%${RESET}"
fi

if [ -n "$week_pct" ]; then
  week_left=$(echo "$week_pct" | awk '{printf "%.0f", 100 - $1}')
  col=$(bar_color "$week_left")
  bar=$(make_bar "$week_left")
  line="${line}  ${SEP}  📅 ${col}${bar} ${week_left}%${RESET}"
fi

printf "%b\n" "$line"
