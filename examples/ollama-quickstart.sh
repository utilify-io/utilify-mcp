#!/usr/bin/env bash
# Quickstart: local Ollama + Utilify MCP via ollmcp (terminal TUI bridge).
# Runs fully on your machine — no data leaves except the API call to utilify.io.
set -euo pipefail

# 1. Install ollmcp (assumes Python 3.10+ and pip).
pip install --upgrade ollmcp

# 2. Pull a tool-calling-capable model from Ollama.
#    As of 2026, these are the strongest open models for MCP tool use:
ollama pull qwen3.5:9b
# alternatives: gemma4:e4b, llama4:8b

# 3. Register the Utilify MCP server with ollmcp.
ollmcp add utilify https://utilify.io/mcp

# 4. Start an interactive session.
ollmcp --model qwen3.5:9b
# then ask: "find cheap electricity in 77002 for a 1-bedroom apartment"
