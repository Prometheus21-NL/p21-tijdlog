# P21 Tijdlog

Een kleine uitbreiding voor Claude Code die bijhoudt **hoe lang** je met Claude werkt en **ongeveer aan wat**.
Voor het stage-onderzoek van Rinse (oktober–november 2026).

## Wat wordt bijgehouden

Per moment één regel in een bestand op je eigen computer (`~/P21-tijdlog/<datum>.jsonl`):

| Wel | Niet |
|---|---|
| tijdstip (bv. 10:14) | wat je typt |
| wat er gebeurde: sessie gestart, vraag gesteld, Claude klaar, sessie dicht | wat Claude antwoordt |
| de naam van de map waarin je werkt | inhoud van bestanden, mails of documenten |
| een grove soort werk, bv. "Document" of "Bouwen" | |

De soort werk wordt gekozen op basis van een paar trefwoorden. De tekst zelf wordt daarna meteen weggegooid en komt nooit in het bestand.
Het bestand blijft op je computer. Er wordt niets automatisch verstuurd.

## Installeren (2 minuten)

Typ in Claude Code (terminal of VS Code):

```
/plugin marketplace add Prometheus21-NL/p21-tijdlog
/plugin install tijdlog@p21
```

Sluit Claude Code daarna één keer af en start opnieuw.

## Handige opdrachten

| Opdracht | Wat het doet |
|---|---|
| `/tijdlog:vandaag` | laat zien wat er vandaag genoteerd is |
| `/tijdlog:pauze` | even niets bijhouden |
| `/tijdlog:hervat` | weer bijhouden |

## Aan het eind van de dag (2 minuten)

1. Open het invulscherm: https://claude.ai/artifact/UsiVti9hAxUtu6LJK9Be4j
2. Klik bij "Claude-tijdlog" op **Bestand kiezen** en kies het bestand van vandaag uit de map `P21-tijdlog` in je thuismap.
3. Klik bij "Google Agenda" op **Ophalen**.
4. Klik op de gestippelde vakken en kies wat je in die tijd deed.
5. Klik op **Dag opslaan**. Alleen Rinse ziet de opgeslagen dagen; in het verslag komen alleen totalen.

## Verwijderen

```
/plugin uninstall tijdlog@p21
```

De map `P21-tijdlog` in je thuismap kun je daarna gewoon weggooien.
