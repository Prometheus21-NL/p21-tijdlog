# command-center

Het Prometheus21 Command Center in Claude Code (ADR-0064 in de command-center-repo).

- **MCP-server `cc`**: de change-borden, de delivery-borden en de daily lezen en
  bijwerken, als jezelf en met jouw rechten.
- **Skill `/kaart <nummer>`**: een user story van een bord uitvoeren. De skill leest
  de kaart, legt een plan voor, bouwt in de huidige repository, opent een PR en
  werkt de kaart bij. Hij zet een kaart nooit zelf op klaar.

## Installeren

```
/plugin marketplace add Prometheus21-NL/p21-tijdlog
/plugin install command-center@p21
```

Daarna `/mcp`, kies `cc` en log in met je Google-werkaccount. Je krijgt een
scherm van het Command Center dat vraagt of je de koppeling wilt maken. De
koppeling staat daarna onder Mijn beveiliging > Ingelogde apparaten. Daar trek je
hem ook in.

Je hebt het recht `mcp.use` nodig (en `mcp.schrijven` om te schrijven). Die
staan per rol in het Rollen-scherm.

## Aanbevolen instelling

Lezen mag zonder te vragen, schrijven vraagt elke keer om je akkoord. Zet in je
`~/.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["mcp__plugin_command-center_cc__bekijk_*"]
  }
}
```

Die regel dekt de bord- en daily-leestools (`bekijk_*`). De leestools uit
Charmander (`query_crm`, `get_change_overview` enzovoort) vragen nog wel om
akkoord; voeg ze los toe als je dat wilt.

## Getest en nog niet getest

- `claude plugin validate` op de marketplace en de plugin: groen.
- Nog niet in het echt: inloggen met OAuth via `/mcp` voor een server uit een
  plugin. Doe dat één keer na de inrichting van de poort.

## In claude.ai of Claude Desktop

Een Owner voegt één keer een custom connector toe met de URL
`https://mcp.command-center.prometheus21.nl/mcp`. Daarna logt iedereen zelf in
via Settings > Connectors.
