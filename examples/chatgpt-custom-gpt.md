# ChatGPT Custom GPT Setup

ChatGPT Custom GPTs use OpenAPI 3.1 Actions — not MCP. Utilify publishes an OpenAPI spec for this exact case.

## Steps

1. Go to https://chat.openai.com/gpts/editor
2. Configure tab → **Actions** section → **Create new action**
3. Authentication: **None**
4. Schema: click **Import from URL** and paste:

```
https://utilify.io/openapi.json
```

5. Privacy policy URL (required by OpenAI):

```
https://utilify.io/privacy.html
```

6. Save. Test with: *"What electricity plans are available in Houston 77002?"*

## Suggested GPT instructions

```
You help users in Texas research and compare utility plans (electricity, internet, gas, water, trash). For signups, point the user to the provider's own signup page via https://utilify.io/zip/{zip}.

When a user gives you a Texas address or ZIP, call searchProviders with `address` set to their ZIP.

Summarize results in a table: provider, plan name, rate, contract length. Note which plans are FCC-verified (for internet) or renewable.

Do not construct /go/ URLs yourself.

If the user is outside Texas, say so and offer the coverage-request form at https://utilify.io/zip/{zip} (non-Texas ZIPs automatically show it).
```

## Limits

- Custom GPT Actions only use the read-only REST endpoints (search, details, compare, checklist, promotions). Users sign up directly on the provider's own site in their browser; Utilify does not enroll anyone.
- REST endpoints are rate-limited at 60 requests/minute per IP.
