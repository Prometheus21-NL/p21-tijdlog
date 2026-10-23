---
description: Sluit je werkdag af en maak de samenvatting voor Rinse (Klantwerk, Intern werk, Acquisitie + duur)
---
Je helpt de gebruiker om de werkdag af te sluiten voor het P21 tijdonderzoek. Meet alleen twee dingen: voor welk soort werk is er gewerkt (Klantwerk, Intern werk of Acquisitie) en hoe lang. Vraag NOOIT naar de naam van een klant of project en noteer die ook niet. Lees NOOIT gesprekken of bestandsinhoud. Werk in gewoon Nederlands, kort, en stel alles in zo min mogelijk berichten.

Stappen:
1. Lees `~/P21-tijdlog/<datum van vandaag>.jsonl` (regels met `t`, `e` = start/vraag/klaar/einde en `s` = sessienummer van een tab). Bekijk per sessie: een vraag loopt tot de eerstvolgende `klaar` of `einde` van dezelfde sessie (+5 min), zonder `klaar` hooguit 45 minuten. Tabs die open staan zonder vraag tellen niet mee. Voeg daarna stukken van alle sessies samen die overlappen of minder dan 15 minuten uit elkaar liggen, zodat elke minuut maar één keer telt. Maak per blok: van, tot.
1b. Wie is de gebruiker? Het Claude-account is gedeeld, dus gebruik NOOIT de accountnaam, het e-mailadres of een gok. Lees `~/P21-tijdlog/naam.txt`. Bestaat die niet, vraag dan als eerste (samen met de andere vragen in stap 3) "Wat is je voornaam?" en sla het antwoord op in `~/P21-tijdlog/naam.txt`. Die naam is bij elke volgende keer vast.
3. Vraag in één bericht, als genummerde lijst, alleen wat ontbreekt:
   - per blok met Claude: Klantwerk (voor een klant), Intern werk (Prometheus21 zelf) of Acquisitie (nieuwe klanten werven). Geen namen.
   - per gat in de werkdag (standaard 08:30 tot 17:00; lunch 12:00 tot 13:00 is al pauze; gaten zijn tijd zonder Claude): vraag per heel gat welk soort werk het was (Klantwerk, Intern werk, Acquisitie of Pauze). Vraag niet naar tijden. Zegt de gebruiker dat een gat uit meer dan één soort werk bestond, vraag dan pas hoe laat het wisselde en splits het gat daar. Lees geen agenda en geen afspraaktitels.
   Is een agent door de lunch heen doorgelopen, dan telt die tijd als Claude-tijd.
4. Reken uit: elke minuut telt één keer (Claude gaat voor zelf ingevuld, pauze als laatste). Maak totalen per soort.
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
