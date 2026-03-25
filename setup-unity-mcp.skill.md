---
name: setup-unity-mcp
description: |-
  Setup Unity MCP (IvanMurzak/Unity-MCP) integration for a Unity project so that
  Claude Code can control Unity Editor via MCP. Handles package installation,
  CLI setup, MCP configuration, and skills generation. Use when the user says
  "帮我配置 Unity MCP", "setup unity mcp", or wants to connect Claude Code to Unity.
---

# Setup Unity MCP — Automated Workflow

This skill sets up the IvanMurzak/Unity-MCP plugin for a Unity project so Claude Code
can operate Unity Editor through MCP (Model Context Protocol).

---

## Prerequisites Check

Before starting, verify these are installed:

```bash
# Node.js (required for unity-mcp-cli)
node --version   # needs ^20.19.0 || >=22.12.0

# npm
npm --version
```

If Node.js is missing, install it:
```bash
brew install node@22
```

---

## Step 1: Install unity-mcp-cli

```bash
npm install -g unity-mcp-cli
```

Verify:
```bash
unity-mcp-cli --version
```

---

## Step 2: Install the Unity-MCP Plugin into the Project

```bash
unity-mcp-cli install-plugin /path/to/unity/project
```

This adds the `com.ivanmurzak.unity.mcp` package to the Unity project's manifest.

After running this, the user must open (or reopen) the Unity project so Unity compiles the package.

---

## Step 3: Configure MCP Connection

### Option A: Using unity-mcp-cli (Recommended)

```bash
# Enable all tools
unity-mcp-cli configure /path/to/unity/project \
  --enable-all-tools \
  --enable-all-prompts \
  --enable-all-resources

# Setup MCP config for Claude Code
unity-mcp-cli setup-mcp claude-code /path/to/unity/project

# Generate skill files (Unity Editor must be running)
unity-mcp-cli setup-skills claude-code /path/to/unity/project
```

### Option B: Using Unity Editor UI (Manual Fallback)

If the CLI approach has issues, guide the user through the Unity UI:

1. Open **AI Game Developer** window in Unity
2. Set Connection: **Custom**
3. Set Transport: **stdio**
4. Set Authorization Token: **none**
5. Set AI agent: **Claude Code**
6. Click **Connect**
7. Click **Enable Skills** (generates `.claude/skills/`)
8. Click **Configure** (generates `.mcp.json`)

---

## Step 4: Verify Connection

After setup, verify the `.mcp.json` exists in the project root:

```bash
cat /path/to/unity/project/.mcp.json
```

Expected structure:
```json
{
  "mcpServers": {
    "ai-game-developer": {
      "args": [
        "port=22398",
        "plugin-timeout=10000",
        "client-transport=stdio",
        "authorization=none"
      ],
      "command": "<project>/Library/mcp-server/osx-arm64/unity-mcp-server"
    }
  }
}
```

Also verify the MCP server binary exists:
```bash
ls <project>/Library/mcp-server/osx-arm64/unity-mcp-server
```

---

## Step 5: Launch Claude Code

```bash
cd /path/to/unity/project
claude
```

Claude Code will auto-detect `.mcp.json` and connect to Unity.

Test with: "列出当前场景中所有 GameObject" or "截一张 Scene View 截图"

---

## Troubleshooting

| Problem | Solution |
|---|---|
| http mode "Connection refused" | Switch Transport to **stdio** |
| MCP server binary not found | Open project in Unity first, wait for compile |
| unity-mcp-cli not found | `npm install -g unity-mcp-cli` |
| Node.js version too old | `brew install node@22` |
| Skills not generated | Unity Editor must be running with plugin connected |
| Multiple projects | Each project needs its own setup; `cd` to the project dir before running `claude` |

---

## Available Tools After Setup (58 total)

- **Assets**: find, create-folder, copy, move, delete, material-create, prefab operations
- **GameObject**: create, destroy, duplicate, find, modify, component operations
- **Scene**: open, save, create, list-opened
- **Script**: read, create/update, delete, execute C# code
- **Screenshot**: scene-view, game-view, camera
- **Console**: get-logs, clear-logs
- **Package**: list, add, remove, search
- **Tests**: run unit tests
