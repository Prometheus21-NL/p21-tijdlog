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

De tijdlog leest nooit wat je typt. Het bestand blijft op je computer. Er wordt niets automatisch verstuurd.
In het invulscherm kies je zelf per map: Klant, Bedrijf of Project, en voor welke klant of welk project. Het scherm onthoudt dat per map.

## Installeren (1 regel)

Plak in de terminal:

```
claude plugin marketplace add https://github.com/Prometheus21-NL/p21-tijdlog.git && claude plugin install tijdlog@p21
```

Start Claude Code daarna opnieuw (VS Code: Claude-paneel sluiten en openen).

## Aan het eind van de dag (2 minuten)

Om 16:45 krijg je een melding op je scherm en Claude herinnert je er in je volgende gesprek aan (één keer per dag, en alleen als je de dag nog niet hebt afgesloten). Typ in Claude Code: `/tijdlog:dag`. Beantwoord de lijst met vragen en mail het blok dat je terugkrijgt naar Rinse.

## Handige opdrachten

| Opdracht | Wat het doet |
|---|---|
| `/tijdlog:dag` | sluit je dag af en maakt de samenvatting voor Rinse |
| `/tijdlog:vandaag` | laat zien wat er vandaag genoteerd is |
| `/tijdlog:pauze` | even niets bijhouden |
| `/tijdlog:hervat` | weer bijhouden |

## Verwijderen

```
/plugin uninstall tijdlog@p21
```

De map `P21-tijdlog` in je thuismap kun je daarna gewoon weggooien.
