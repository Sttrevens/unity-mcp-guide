# Unity MCP + Claude Code Setup Guide

> Let Claude Code control your Unity Editor directly via MCP

## Prerequisites

- macOS (Apple Silicon)
- Unity 2022.3+ project
- Claude Code CLI (running `claude` in terminal should launch it)
- Homebrew (optional, for installing .NET)

---

## Step 1: Install the Unity MCP Plugin

1. Open your Unity project
2. Menu bar → **Window** → **Package Manager**
3. Click **+** (top left) → **Add package from git URL...**
4. Enter:
   ```
   https://github.com/IvanMurzak/Unity-MCP.git
   ```
5. Wait for installation and compilation to finish (no red errors in Console = OK)

---

## Step 2: Configure the MCP Connection in Unity

1. After installation, a new **AI Game Developer** window appears (find it under the Window menu)
2. Open the **AI Game Developer** window and configure:

| Setting | Value |
|---|---|
| Connection | **Custom** |
| Transport | **stdio** |
| Authorization Token | **none** |
| AI agent | **Claude Code** |

3. Click **Connect** (green status = connected)

> **Note**: In stdio mode, the MCP server doesn't need to be started manually — Claude Code launches the server instance automatically.

---

## Step 3: Generate Configuration Files

At the bottom of the AI Game Developer window:

1. Click **Enable Skills** — generates the `.claude/skills/` directory
2. Click **Configure** (next to the MCP section) — generates the `.mcp.json` config file

The generated `.mcp.json` looks roughly like this:

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
      "command": "<your-project-path>/Library/mcp-server/osx-arm64/unity-mcp-server"
    }
  }
}
```

---

## Step 4: Connect Claude Code to Unity

1. Open Terminal
2. `cd` to your Unity project root:
   ```bash
   cd /path/to/your/unity-project
   ```
3. Launch Claude Code:
   ```bash
   claude
   ```
4. Claude Code will automatically read `.mcp.json`, start the MCP server, and connect to Unity

---

## Verify the Connection

Try these commands in Claude Code:

- "Take a screenshot of the Scene View"
- "List all GameObjects in the current scene"
- "Create an empty GameObject called TestObject"

If it responds correctly, the connection is working.

---

## Available Tools (58 total)

Once connected, Claude Code can use these capabilities:

### Asset Management
- `assets-find` — Search project assets
- `assets-create-folder` — Create folders
- `assets-copy` / `assets-move` / `assets-delete` — Copy/move/delete assets
- `assets-material-create` — Create materials
- `assets-prefab-create` / `assets-prefab-instantiate` — Create/instantiate Prefabs

### GameObject Operations
- `gameobject-create` / `gameobject-destroy` / `gameobject-duplicate`
- `gameobject-find` — Find GameObjects
- `gameobject-modify` — Modify Transform and other properties
- `gameobject-component-add` / `gameobject-component-get` / `gameobject-component-modify`

### Scene Management
- `scene-open` / `scene-save` / `scene-create`
- `scene-list-opened` — List opened scenes

### Scripts & Code
- `script-read` / `script-update-or-create` / `script-delete`
- `script-execute` — Execute C# code directly

### Screenshots & Debugging
- `screenshot-scene-view` / `screenshot-game-view` / `screenshot-camera`
- `console-get-logs` / `console-clear-logs`

### Package Management
- `package-list` / `package-add` / `package-remove` / `package-search`

### Testing
- `tests-run` — Run unit tests

---

## Troubleshooting

### Q: HTTP mode shows "Connection refused"
**A**: Switch to **stdio** mode. Custom connection → Transport → select stdio.

### Q: Compilation errors / installation failed
**A**: Make sure Unity version >= 2022.3 and your project uses .NET Standard 2.1 or higher.

### Q: Claude Code doesn't detect MCP after launch
**A**: Confirm `.mcp.json` exists in the project root directory, and the `command` path points to an existing `unity-mcp-server` binary.

### Q: How to handle multiple Unity projects?
**A**: Each project needs its own plugin installation and `.mcp.json` generated via Configure. Claude Code connects to whichever project directory it's launched from.

---

## Plugin Info

- Plugin: [IvanMurzak/Unity-MCP](https://github.com/IvanMurzak/Unity-MCP)
- Version: 0.60.0
- Protocol: MCP (Model Context Protocol)
