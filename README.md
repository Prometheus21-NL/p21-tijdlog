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
In het invulscherm kies je zelf per map: Klantwerk, Intern werk of Acquisitie. Namen van klanten of projecten worden niet gevraagd. Het scherm onthoudt je keuze per map.

## Installeren (1 regel)

Plak in de terminal:

```
claude plugin marketplace add https://github.com/Prometheus21-NL/p21-tijdlog.git && claude plugin install tijdlog@p21
```

Start Claude Code daarna opnieuw (VS Code: Claude-paneel sluiten en openen).

## Wie ben jij? (gedeeld Claude-account)

Jullie delen één Claude-account, dus Claude kan jullie daar niet aan herkennen. De tijdlog staat op **jouw eigen computer** (`~/P21-tijdlog`), dus elke computer heeft zijn eigen log. De eerste keer dat je `/tijdlog:dag` typt, vraagt Claude om je voornaam en bewaart die op je computer (`~/P21-tijdlog/naam.txt`). Die naam staat daarna boven elk blok dat je naar Rinse mailt. Verkeerde naam? Pas dat bestand aan.
Werk je met meerdere mensen op dezelfde computer en dezelfde inlog van het besturingssysteem? Dan loopt alles door elkaar; geef elk een eigen gebruiker op die computer.

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
