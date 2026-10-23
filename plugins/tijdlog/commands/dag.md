---
description: Sluit je werkdag af en maak de samenvatting voor Rinse (Klantwerk, Intern werk, Acquisitie + duur)
---
Je helpt de gebruiker om de werkdag af te sluiten voor het P21 tijdonderzoek. Meet alleen twee dingen: voor welk soort werk is er gewerkt (Klantwerk, Intern werk of Acquisitie) en hoe lang. Vraag NOOIT naar de naam van een klant of project en noteer die ook niet. Lees NOOIT gesprekken of bestandsinhoud. Werk in gewoon Nederlands, kort, en stel alles in zo min mogelijk berichten.

Stappen:
1. Lees `~/P21-tijdlog/<datum van vandaag>.jsonl` (regels met `t`, `e` = start/vraag/klaar/einde, `map`). Een vraag loopt tot de eerstvolgende `klaar` (+5 min). Stukken met dezelfde map die minder dan 15 minuten uit elkaar liggen horen bij elkaar. Maak per blok: map, van, tot.
1b. Wie is de gebruiker? Het Claude-account is gedeeld, dus gebruik NOOIT de accountnaam, het e-mailadres of een gok. Lees `~/P21-tijdlog/naam.txt`. Bestaat die niet, vraag dan als eerste (samen met de andere vragen in stap 3) "Wat is je voornaam?" en sla het antwoord op in `~/P21-tijdlog/naam.txt`. Die naam is bij elke volgende keer vast.
2. Lees `~/P21-tijdlog/koppeling.json` (map -> {soort}) als dat bestaat. Gebruik die keuzes voor bekende mappen.
3. Vraag in één bericht, als genummerde lijst, alleen wat ontbreekt:
   - per onbekende map: Klantwerk (voor een klant), Intern werk (Prometheus21 zelf) of Acquisitie (nieuwe klanten werven). Geen namen. Sla het antwoord op in `koppeling.json`.
   - de rest van de werkdag (standaard 08:30 tot 17:00, lunch 12:00 tot 13:00 is al pauze): wat er buiten Claude is gedaan, met tijden en per stuk Klantwerk, Intern werk of Acquisitie, eventueel één zin zonder klantnamen. Heeft de gebruiker een Google Agenda-koppeling beschikbaar, haal dan de meetings van vandaag op (alleen tijden en of er mensen buiten @prometheus21.nl bij zitten: dan standaard Klantwerk, anders Intern werk; lees de titel alleen om te beoordelen of het een kennismaking, offerte-, demo- of salesgesprek met een nieuwe klant lijkt, dan Acquisitie; geef je voorstel in de lijst zodat de gebruiker het kan corrigeren. Schrijf de titel nooit in de samenvatting of in bestanden) en vraag alleen naar de gaten.
   Is een agent door de lunch heen doorgelopen, dan telt die tijd als Claude-tijd.
4. Reken uit: elke minuut telt één keer (meeting gaat voor Claude, Claude voor zelf ingevuld, pauze als laatste). Maak totalen per soort.
5. Schrijf `~/P21-tijdlog/samenvatting-<datum>.txt` en toon precies dit blok, zodat de gebruiker het kan kopiëren:

```
P21 tijdlog <datum> <inhoud van naam.txt>
Klantwerk: <u m>
Intern werk: <u m>
Acquisitie: <u m>
Pauze: <u m>
Niet verklaard: <u m>
```
6. Zeg dat het blok in een mail of Teams-bericht naar rinse.nieboer@prometheus21.nl kan. Heeft de gebruiker een Gmail-koppeling, bied dan aan een concept te maken (niet versturen zonder ja).

Voeg nooit inhoud van gesprekken toe. Verander niets aan het logbestand.
