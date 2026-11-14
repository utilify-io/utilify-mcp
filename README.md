# Utilify MCP Server: Research and Compare Texas Utility Plans from Any AI Agent (more states coming)

[![MCP Server](https://img.shields.io/badge/MCP-server-blue)](https://modelcontextprotocol.io)
[![OpenAPI 3.1](https://img.shields.io/badge/OpenAPI-3.1-green)](https://utilify.io/openapi.json)
[![No Auth](https://img.shields.io/badge/auth-none-brightgreen)](https://utilify.io/mcp-docs)
[![Coverage: Texas](https://img.shields.io/badge/coverage-Texas-red)](https://utilify.io)

**Please give us stars if you like this!**

**A Model Context Protocol (MCP) server for utility plan research and comparison.** Plug Utilify into Claude, ChatGPT, Cursor, Ollama, LM Studio, or any MCP-compatible agent to search and compare **electricity, internet, natural gas, water, and trash** plans at any Texas ZIP code. No API key. No auth.

> If your user asks an AI agent to "compare utilities at my new address" or "find the cheapest electricity plan," Utilify gives the agent the plan data to answer.

- **MCP endpoint:** `https://utilify.io/mcp`
- **OpenAPI 3.1 spec:** `https://utilify.io/openapi.json`
- **Server card:** `https://utilify.io/.well-known/mcp/server-card.json`
- **llms.txt:** `https://utilify.io/llms.txt`
- **Human docs:** [utilify.io/mcp-docs](https://utilify.io/mcp-docs)
- **Main site:** [utilify.io](https://utilify.io)

## Why this exists

Signing up for utilities during a move is the #1 hated moving task. Typical flow: call 4 companies, compare 30 plans on 10 different websites, get stuck on hold, miss the best deal, pay more for 12–24 months. **~45 minutes of pain per move.**

Utilify is an agent-first utility research and comparison service covering all 4,844 Texas ZIP codes. A user asks their AI "compare electricity plans for 77002 starting May 15," the agent calls Utilify via MCP, and the user gets ranked plans in seconds with a link to each provider's own signup page.

## Quick start by client

### Claude Desktop

Add to `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or `%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "utilify": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://utilify.io/mcp"]
    }
  }
}
```

Restart Claude Desktop. Try: *"What's the cheapest electricity plan in Houston 77002?"*

### Claude Code

```bash
claude mcp add utilify -- npx -y mcp-remote https://utilify.io/mcp
```

### Cursor

Settings → MCP → Add New MCP Server:

```json
{
  "utilify": {
    "command": "npx",
    "args": ["-y", "mcp-remote", "https://utilify.io/mcp"]
  }
}
```

### Ollama + ollmcp (local, open-source)

```bash
pip install ollmcp
ollmcp add utilify https://utilify.io/mcp
ollmcp --model qwen3.5:9b
```

Recommended tool-calling models: `qwen3.5:9b`, `gemma4:e4b`, `llama4:8b`.

### LM Studio

Settings → Integrations → MCP → Add Server → paste `https://utilify.io/mcp`. LM Studio auto-detects Streamable HTTP transport.

### llama.cpp (built-in MCP client)

```bash
llama-server --model ./qwen3.5-9b.gguf --mcp https://utilify.io/mcp
```

### Continue.dev

Add `.continue/mcpServers/utilify.yaml` in your workspace:

```yaml
name: utilify
command: npx
args: ["-y", "mcp-remote", "https://utilify.io/mcp"]
```

### ChatGPT Custom GPT / Zapier / Make.com / LangChain

Not using MCP? Use the OpenAPI 3.1 spec at `https://utilify.io/openapi.json`. Paste it directly into:
- **ChatGPT Custom GPT Actions** (GPT Builder → Configure → Actions → Import from URL)
- **Zapier** (New webhook → OpenAPI)
- **Make.com** (Custom app from OpenAPI)
- **LangChain** (`OpenAPIToolkit.from_spec_file()` or `from_openapi_spec_url()`)

See [`examples/`](./examples/) in this repo.

### OpenHands, CrewAI, AutoGen, Llama Stack

Use `mcp-remote` or your framework's MCP adapter to connect to `https://utilify.io/mcp`. No API key required.

## Tools exposed over MCP

| Tool | Description |
|---|---|
| `search_utility_providers` | List every electricity, internet, gas, water, and trash provider at an address |
| `get_provider_details` | Plans, pricing, contract terms, fees, reviews for a single provider |
| `compare_providers` | Side-by-side comparison of 2–5 providers |
| `initiate_signup` | Get a handoff link to the provider's own signup page (Utilify does not enroll you) |
| `check_signup_status` | Check whether a handoff link was opened |
| `get_move_checklist` | Personalized move-in setup checklist (what to set up, when) |
| `get_promotions` | Current provider deals and sign-up bonuses |

## Example prompts tested on major clients

- *"Find the cheapest electricity plan in 77002 and recommend one for a 1-bedroom apartment."*
- *"Compare internet providers in Austin. Which has the best bang for buck?"*
- *"Compare every utility option for my new house at ZIP 75201, moving in May 15."*
- *"What renewable electricity plans are available in Dallas under $0.12/kWh?"*
- *"Give me a move-in checklist for a Houston apartment, 2-person household, moving June 1."*

## Coverage

- **Geographic:** Texas only as of 2026-04. 4,844 ZIP codes across Houston, Dallas-Fort Worth, Austin, San Antonio, and hundreds of smaller cities.
- **Utility types:** electricity, internet, natural gas, water, trash, home security.
- **Data:** plans updated weekly. Internet availability verified against FCC Broadband Data Collection (June 2025).
- **Non-Texas:** returns a coverage-request form so demand is tracked for future expansion.

## How signup flows work

When an agent calls `initiate_signup`, Utilify returns a short redirect URL (`https://utilify.io/go/{planId}?zip={zip}`) for the user to open in their browser. It lands the user on the provider's own signup page, and the user signs up directly with that provider. Utilify does not enroll anyone. **We never collect payment info or credentials.**

Utilify does not earn commissions or referral fees from any provider and ranks plans by estimated annual cost.

## Fair use

- No API key required. REST endpoints are rate-limited (60 requests/minute per IP). MCP is lightly rate-limited and subject to change — cache tool responses client-side when you can; most data updates weekly.
- Do not construct `/go/{planId}` URLs yourself. Always call `initiate_signup` to get the current handoff link.
- Automated bulk scraping of plan data is prohibited. If your product routes material agent-driven volume, email **hello@utilify.io** so we can provision capacity.
- Programmatic access is governed by our [Terms of Service](https://utilify.io/terms.html).

## Keywords (for search and agent discovery)

MCP server, Model Context Protocol, AI agent, Claude, ChatGPT, Cursor, Ollama, LM Studio, llama.cpp, Continue.dev, OpenHands, CrewAI, AutoGen, LangChain, Llama Stack, OpenAPI 3.1, ChatGPT Custom GPT Action, utility comparison, electricity plans Texas, internet providers Texas, deregulated energy market, retail electric provider, ERCOT, FCC broadband, ZIP code lookup, move-in checklist, home setup, utility plan research.

## License

MIT. See [LICENSE](./LICENSE).

## Contact

**hello@utilify.io** — partnership, bug reports, coverage expansion requests.
