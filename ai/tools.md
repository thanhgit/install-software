# Tools for AI agent

#### MCP gateway
```bash
docker run -d --name mcpgateway \
  -p 4444:4444 \
  -e HOST=0.0.0.0 \
  -e MCPGATEWAY_UI_AIRGAPPED=true \
  -e MCPGATEWAY_UI_ENABLED=true \
  -e MCPGATEWAY_ADMIN_API_ENABLED=true \
  -e PLUGINS_ENABLED=true \
  -e JWT_SECRET_KEY=my-password-test-key \
  -e JWT_AUDIENCE=mcpgateway-api \
  -e JWT_ISSUER=mcpgateway \
  -e AUTH_REQUIRED=true \
  -e PLATFORM_ADMIN_EMAIL=admin@util4dev.tech \
  -e PLATFORM_ADMIN_PASSWORD=admin \
  -e PLATFORM_ADMIN_FULL_NAME="Platform Administrator" \
  -e DATABASE_URL=sqlite:///./mcp.db \
  ghcr.io/ibm/mcp-context-forge:1.0.0-BETA-1
```
