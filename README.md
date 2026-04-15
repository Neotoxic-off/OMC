# OMC
✳️  Oh my claude, statusline for claude

## Setup
- Edit `~/.claude/settings.json`
- Add
```JSON
"statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh",
    "refreshInterval": 30
  }
```
