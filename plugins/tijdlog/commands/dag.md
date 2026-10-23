---
description: Sluit je werkdag af en maak de samenvatting voor Rinse (Klant, Bedrijf, Project + duur)
---
Je helpt de gebruiker om de werkdag af te sluiten voor het P21 tijdonderzoek. Meet alleen twee dingen: voor wie of wat is er gewerkt (Klant, Bedrijf of Project, met de naam van de klant of het project) en hoe lang. Lees NOOIT gesprekken of bestandsinhoud. Werk in gewoon Nederlands, kort, en stel alles in zo min mogelijk berichten.

Stappen:
1. Lees `~/P21-tijdlog/<datum van vandaag>.jsonl` (regels met `t`, `e` = start/vraag/klaar/einde, `map`). Een vraag loopt tot de eerstvolgende `klaar` (+5 min). Stukken met dezelfde map die minder dan 15 minuten uit elkaar liggen horen bij elkaar. Maak per blok: map, van, tot.
1b. Wie is de gebruiker? Het Claude-account is gedeeld, dus gebruik NOOIT de accountnaam, het e-mailadres of een gok. Lees `~/P21-tijdlog/naam.txt`. Bestaat die niet, vraag dan als eerste (samen met de andere vragen in stap 3) "Wat is je voornaam?" en sla het antwoord op in `~/P21-tijdlog/naam.txt`. Die naam is bij elke volgende keer vast.
2. Lees `~/P21-tijdlog/koppeling.json` (map -> {soort, naam}) als dat bestaat. Gebruik die keuzes voor bekende mappen.
3. Vraag in één bericht, als genummerde lijst, alleen wat ontbreekt:
   - per onbekende map: Klant, Bedrijf (Prometheus21 zelf) of Project, en de naam (bv. RLG, Anti-AI-slop). Sla het antwoord op in `koppeling.json`.
   - de rest van de werkdag (standaard 08:30 tot 17:00, lunch 12:00 tot 13:00 is al pauze): wat er buiten Claude is gedaan, met tijden en per stuk Klant, Bedrijf of Project + naam, eventueel één zin. Heeft de gebruiker een Google Agenda-koppeling beschikbaar, haal dan de meetings van vandaag op (alleen tijden en of er mensen buiten @prometheus21.nl bij zitten: dan Klant, anders Bedrijf) en vraag alleen naar de gaten.
   Is een agent door de lunch heen doorgelopen, dan telt die tijd als Claude-tijd.
4. Reken uit: elke minuut telt één keer (meeting gaat voor Claude, Claude voor zelf ingevuld, pauze als laatste). Maak totalen per soort en per naam.
5. Schrijf `~/P21-tijdlog/samenvatting-<datum>.txt` en toon precies dit blok, zodat de gebruiker het kan kopiëren:

```
P21 tijdlog <datum> <inhoud van naam.txt>
Klant: <u m>
Bedrijf: <u m>
Project: <u m>
Pauze: <u m>
Niet verklaard: <u m>
Per klant of project:
- <soort> · <naam>: <u m>
```
6. Zeg dat het blok in een mail of Teams-bericht naar rinse.nieboer@prometheus21.nl kan. Heeft de gebruiker een Gmail-koppeling, bied dan aan een concept te maken (niet versturen zonder ja).

Voeg nooit inhoud van gesprekken toe. Verander niets aan het logbestand.
