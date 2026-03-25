# Unity MCP + Claude Code Setup Guide

> 让 Claude Code 通过 MCP 直接操控你的 Unity Editor

## 前置要求

- macOS (Apple Silicon)
- Unity 2022.3+ 项目
- Claude Code CLI（终端运行 `claude` 能启动）
- Homebrew（可选，用于安装 .NET）

---

## 第一步：安装 Unity MCP 插件

1. 打开你的 Unity 项目
2. 菜单栏 → **Window** → **Package Manager**
3. 点左上角 **+** → **Add package from git URL...**
4. 输入：
   ```
   https://github.com/IvanMurzak/Unity-MCP.git
   ```
5. 等待安装和编译完成（Console 里没有红色报错就 OK）

---

## 第二步：配置 Unity 侧的 MCP 连接

1. 安装完成后，Unity 菜单栏会多出一个 **AI Game Developer** 窗口（或者在 Window 菜单里找）
2. 打开 **AI Game Developer** 窗口，设置如下：

| 设置项 | 值 |
|---|---|
| Connection | **Custom** |
| Transport | **stdio** |
| Authorization Token | **none** |
| AI agent | **Claude Code** |

3. 点 **Connect**（Unity 状态变绿 = 连接成功）

> **注意**：stdio 模式下 MCP server 不需要手动 Start，Claude Code 会自动启动 server 实例。

---

## 第三步：生成配置文件

在 AI Game Developer 窗口底部：

1. 点 **Enable Skills** — 生成 `.claude/skills/` 目录
2. 点 **Configure**（MCP 区域旁边）— 生成 `.mcp.json` 配置文件

生成的 `.mcp.json` 大概长这样：

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
      "command": "<你的项目路径>/Library/mcp-server/osx-arm64/unity-mcp-server"
    }
  }
}
```

---

## 第四步：用 Claude Code 连接 Unity

1. 打开终端
2. `cd` 到你的 Unity 项目根目录：
   ```bash
   cd /path/to/your/unity-project
   ```
3. 启动 Claude Code：
   ```bash
   claude
   ```
4. Claude Code 会自动读取 `.mcp.json`，启动 MCP server 并连接到 Unity

---

## 验证连接

在 Claude Code 里试试这些命令：

- "帮我截一张 Scene View 的截图"
- "列出当前场景中所有 GameObject"
- "创建一个新的空 GameObject 叫 TestObject"

如果能正常响应，说明连接成功。

---

## 可用工具（共 58 个）

连接成功后 Claude Code 可以操作的功能：

### 资源管理
- `assets-find` — 搜索项目资源
- `assets-create-folder` — 创建文件夹
- `assets-copy` / `assets-move` / `assets-delete` — 复制/移动/删除资源
- `assets-material-create` — 创建材质
- `assets-prefab-create` / `assets-prefab-instantiate` — 创建/实例化 Prefab

### GameObject 操作
- `gameobject-create` / `gameobject-destroy` / `gameobject-duplicate`
- `gameobject-find` — 查找 GameObject
- `gameobject-modify` — 修改 Transform 等属性
- `gameobject-component-add` / `gameobject-component-get` / `gameobject-component-modify`

### 场景管理
- `scene-open` / `scene-save` / `scene-create`
- `scene-list-opened` — 列出已打开的场景

### 脚本与代码
- `script-read` / `script-update-or-create` / `script-delete`
- `script-execute` — 直接执行 C# 代码

### 截图与调试
- `screenshot-scene-view` / `screenshot-game-view` / `screenshot-camera`
- `console-get-logs` / `console-clear-logs`

### 包管理
- `package-list` / `package-add` / `package-remove` / `package-search`

### 测试
- `tests-run` — 运行单元测试

---

## 常见问题

### Q: http 模式连接报 "Connection refused"
**A**: 切换到 **stdio** 模式。Custom 连接 → Transport 选 stdio。

### Q: 编译报错 / 安装失败
**A**: 确保 Unity 版本 >= 2022.3，并且项目使用了 .NET Standard 2.1 或更高。

### Q: Claude Code 启动后没识别到 MCP
**A**: 确认 `.mcp.json` 文件在项目根目录下，且 `command` 路径指向的 `unity-mcp-server` 文件存在。

### Q: 多个 Unity 项目怎么办？
**A**: 每个项目都需要单独安装插件、Configure 生成 `.mcp.json`。Claude Code 在哪个项目目录启动，就连接哪个项目。

---

## 插件信息

- 插件：[IvanMurzak/Unity-MCP](https://github.com/IvanMurzak/Unity-MCP)
- 版本：0.60.0
- 协议：MCP (Model Context Protocol)
