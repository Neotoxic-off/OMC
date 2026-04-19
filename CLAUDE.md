# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

OMC ("Oh My Claude") — a statusline script for Claude Code. Single file: `.claude/statusline-command.sh`.

## How it works

Claude Code pipes a JSON blob to the script via stdin. The script extracts fields with `jq`, builds a colored ANSI status line, and prints it. Claude Code renders it as the statusline.

Key JSON fields consumed:
- `model.display_name`, `version`
- `session_name`, `output_style.name`, `vim.mode`, `agent.name`
- `workspace.current_dir`, `workspace.git_worktree`, `worktree.name`
- `context_window.used_percentage` / `remaining_percentage`
- `rate_limits.five_hour.used_percentage`, `rate_limits.seven_day.used_percentage`

## Setup

Add to `~/.claude/settings.json`:
```json
"statusLine": {
  "type": "command",
  "command": "bash ~/.claude/statusline-command.sh",
  "refreshInterval": 30
}
```

## Dependencies

- `bash`
- `jq` (JSON parsing)
- `git` (optional, for branch display)
- `awk`, `sed`, `seq` (standard POSIX tools)

## Testing the script

```bash
echo '{"model":{"display_name":"claude-sonnet-4-6"},"context_window":{"remaining_percentage":75},"workspace":{"current_dir":"/home/user/project"}}' | bash .claude/statusline-command.sh
```
