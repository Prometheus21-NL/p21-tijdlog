# P21 Tijdlog

Een kleine uitbreiding voor Claude Code die bijhoudt **hoe lang** je met Claude werkt en **ongeveer aan wat**.
Voor het stage-onderzoek van Rinse (oktober–november 2026).

## Wat wordt bijgehouden

Per moment één regel in een bestand op je eigen computer (`~/P21-tijdlog/<datum>.jsonl`). Sinds versie 1.10.0 stuurt de plugin diezelfde regels ook zelf, samen met je voornaam, naar de eigen Supabase-database van Prometheus21, zodat je dag in het invulscherm klaarstaat:

| Wel | Niet |
|---|---|
| tijdstip (bv. 10:14) | wat je typt |
| wat er gebeurde: sessie gestart, vraag gesteld, Claude klaar, sessie dicht | wat Claude antwoordt |
| je antwoord op de beginvraag: klant, intern, acquisitie of persoonlijk (alleen die vier woorden) | |
| een willekeurig sessienummer per tab (geen mapnaam, geen namen van klanten of projecten) | inhoud van bestanden, mails of documenten |

De tijdlog leest nooit wat je typt. Het bestand blijft op je computer en een kopie van deze regels gaat naar de database. Wat je typt, wat Claude antwoordt en wat er in bestanden of mails staat, gaat nooit mee.
Bij de eerste vraag van elke chat vraagt Claude waarvoor de chat is. Dat antwoord vult het invulscherm vooraf in. In het invulscherm kun je het altijd aanpassen en kies je zelf per blok: Klantwerk, Intern werk, Acquisitie of Persoonlijk / nvt. Namen van klanten of projecten worden niet gevraagd. Uit je agenda komen alleen de begin- en eindtijden van je afspraken in het invulscherm (afgesproken met het team), nooit de titels of deelnemers. Er is ook een keuze Persoonlijk / nvt voor wat niet voor Prometheus21 was.

## Installeren (1 regel)

Plak in de terminal:

```
claude plugin marketplace add https://github.com/Prometheus21-NL/p21-tijdlog.git && claude plugin install tijdlog@p21
```

Start Claude Code daarna opnieuw (VS Code: Claude-paneel sluiten en openen).

## Meerdere tabs en tabs die open blijven staan

Een open tab telt niet mee. Er wordt alleen tijd geteld van het moment dat je een vraag stelt tot Claude klaar is (plus 5 minuten). Een tab die klaar is en open blijft staan kost dus geen tijd.

Werk je in meerdere tabs tegelijk, dan krijgt elke tab zijn eigen blok (tab 1, tab 2, ...) en kies je per tab wat het was. Twee tabs naast elkaar mogen dus Klantwerk en Intern werk zijn. Lopen er op hetzelfde moment meerdere tabs, dan wordt die minuut gelijk over de tabs verdeeld, zodat je totaal gelijk blijft aan je echte werktijd. Het logbestand bewaart daarvoor per regel een willekeurig sessienummer, geen inhoud.

Staat een blok te lang, bijvoorbeeld omdat Claude op jouw antwoord wachtte terwijl je weg was? Sleep in het invulscherm de boven- of onderkant van het blok naar de goede tijd, of pas de tijd aan in het paneel. De tijd die vrijkomt, vul je daarna zelf in.

## Wie ben jij? (gedeeld Claude-account)

Jullie delen één Claude-account, dus Claude kan jullie daar niet aan herkennen. De tijdlog staat op **jouw eigen computer** (`~/P21-tijdlog`), dus elke computer heeft zijn eigen log. De eerste keer dat je `/tijdlog:dag` typt, vraagt Claude om je voornaam en bewaart die op je computer (`~/P21-tijdlog/naam.txt`). Die naam staat daarna boven elk blok dat je naar Rinse mailt. Verkeerde naam? Pas dat bestand aan.
Werk je met meerdere mensen op dezelfde computer en dezelfde inlog van het besturingssysteem? Dan loopt alles door elkaar; geef elk een eigen gebruiker op die computer.

## Aan het eind van de dag (2 minuten)

Om 16:45 staat er een agenda-afspraak en komt er een herinneringsmail, allebei met de link naar het invulscherm. Open de link, kies rechtsboven je naam (eenmalig), kijk of je dag klopt en klik op de grote knop "Dag opslaan". Je hoeft geen bestanden te zoeken: de plugin heeft je Claude-tijd al klaargezet. De dagenbalk bovenaan laat zien welke dagen nog open staan, zodat je ook eerdere dagen kunt invullen.

Liever in de chat? Zeg dat tegen Claude, dan stelt hij de vragen en krijg je een blokje dat je naar Rinse mailt.

## Handige opdrachten

| Opdracht | Wat het doet |
|---|---|
| `/tijdlog:dag` | laat het invulscherm zien en wat je moet doen (of vult in de chat in) |
| `/tijdlog:vandaag` | laat zien wat er vandaag genoteerd is |
| `/tijdlog:pauze` | even niets bijhouden |
| `/tijdlog:hervat` | weer bijhouden |

## Een chat of map uitsluiten (alleen voor wie geen werknemer is)

Hoort bepaald werk niet in de tijdlog thuis, bijvoorbeeld schoolwerk van een stagiair? (Chats in zo'n map worden ook niet naar de database gestuurd.) Leg dan een leeg bestand met de naam `.geen-tijdlog` in de map waarin je die chats opent (`touch .geen-tijdlog`). Chats in die map, of een map eronder, worden dan niet bijgehouden en Claude stelt er ook de beginvraag niet. De plugin kijkt alleen of het bestand bestaat; de map wordt nergens bewaard. Verwijder het bestand om weer mee te tellen. Wie dit niet aanmaakt, merkt er niets van.

## Verwijderen

```
/plugin uninstall tijdlog@p21
```

De map `P21-tijdlog` in je thuismap kun je daarna gewoon weggooien.
