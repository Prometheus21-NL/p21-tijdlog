#!/bin/sh
# P21 Tijdlog
# Schrijft per moment één regel naar ~/P21-tijdlog/<datum>.jsonl met ALLEEN:
#   - het tijdstip
#   - wat er gebeurde (sessie start, vraag gesteld, Claude klaar, sessie dicht)
#   - het sessienummer van Claude Code (een willekeurig id), zodat meerdere tabs
#     door elkaar kunnen lopen en elke minuut toch maar één keer telt
# Wat je typt wordt nooit gelezen en er wordt geen mapnaam bewaard: de invoer
# wordt alleen gebruikt voor het soort moment en het sessienummer. Het bestand
# blijft op je computer.
# Chat uitsluiten: leg een leeg bestand .geen-tijdlog in de map (zie README).
# Pauzeren: maak een bestand ~/P21-tijdlog/PAUZE aan (of gebruik /tijdlog:pauze).

dir="$HOME/P21-tijdlog"
[ -f "$dir/PAUZE" ] && exit 0

# Alleen ingebouwde shell-functies, geen sed/head/tr/cut/dirname. Elk los programma kost op
# Windows (Git Bash) en op trage laptops tijd, en een hook die te lang duurt wordt afgebroken.
IFS= read -r input || :

# Haalt de waarde van een tekstveld uit de JSON-invoer in $v (leeg als het veld ontbreekt).
val() {
  v=${input#*\"$1\"}
  if [ "$v" = "$input" ]; then v=; return; fi
  v=${v#*:}; v=${v#*\"}; v=${v%%\"*}
}

# Uitzondering voor wie geen werknemer is: staat er een leeg bestand .geen-tijdlog in de map
# van de chat (of een map erboven), dan wordt voor die chat niets genoteerd. De map zelf wordt
# alleen gecontroleerd en nergens bewaard.
# Stuurt nieuwe regels van het logbestand naar Supabase, zodat je dag in het invulscherm klaarstaat.
# Verstuurd wordt alleen: je voornaam, tijdstip, soort handeling (start, vraag, klaar, einde, soort) en het
# sessienummer. Nooit wat je typt. Zonder voornaam of zonder internet gebeurt er niets.
sync() {
  [ -f "$dir/naam.txt" ] || return 0
  command -v curl >/dev/null 2>&1 || return 0
  IFS= read -r nm < "$dir/naam.txt" || :
  case $nm in ''|*[!A-Za-z]*) return 0 ;; esac
  . "$(dirname "$0")/config.sh" 2>/dev/null || return 0
  for f in "$dir"/*.jsonl; do
    [ -f "$f" ] || continue
    b=${f##*/}; b=${b%.jsonl}; m="$dir/.verzonden-$b"
    if [ -f "$m" ]; then
      [ "$f" -nt "$m" ] || continue
      IFS= read -r klaar < "$m" || klaar=0
    else klaar=0; fi
    case $klaar in ''|*[!0-9]*) klaar=0 ;; esac
    i=0; batch=
    while IFS= read -r regel || [ -n "$regel" ]; do
      i=$((i + 1)); [ "$i" -le "$klaar" ] && continue
      case $regel in '{'*'}') batch="${batch:+$batch,}$regel" ;; esac
      [ $((i - klaar)) -ge 400 ] && break
    done < "$f"
    [ "$i" -gt "$klaar" ] || continue
    ( r=$(curl -s -m 8 -X POST "$P21_URL" -H "apikey: $P21_KEY" -H "Authorization: Bearer $P21_KEY" -H "Content-Type: application/json" -d "{\"p_naam\":\"$nm\",\"p_events\":[$batch]}" 2>/dev/null)
      case $r in ''|-*|*[!0-9]*) ;; *) printf '%s' "$i" > "$m" ;; esac ) >/dev/null 2>&1 &
  done
}

val cwd; d=$v; n=0
while [ -n "$d" ] && [ "$d" != "/" ] && [ "$d" != "." ] && [ "$n" -lt 40 ]; do
  [ -f "$d/.geen-tijdlog" ] && exit 0
  case $d in */*) d=${d%/*}; [ -z "$d" ] && d=/ ;; *) d=. ;; esac
  n=$((n + 1))
done

val hook_event_name
case "$v" in
  SessionStart) e=start ;;
  UserPromptSubmit) e=vraag ;;
  Stop) e=klaar ;;
  SessionEnd) e=einde ;;
  *) exit 0 ;;
esac

val session_id; sid=$v
case $sid in *[!A-Za-z0-9-]*) sid=$(printf '%s' "$sid" | tr -cd 'A-Za-z0-9-') ;; esac
[ "${#sid}" -gt 40 ] && sid=$(printf '%s' "$sid" | cut -c 1-40)

[ -d "$dir" ] || mkdir -p "$dir" 2>/dev/null || exit 0
t=$(date +%Y-%m-%dT%H:%M:%S%z)
dag=${t%%T*}
printf '{"t":"%s","e":"%s","s":"%s"}\n' "$t" "$e" "$sid" >> "$dir/$dag.jsonl" 2>/dev/null
sync

# Eerste vraag van een chat: Claude vraagt waarvoor de chat is (één keer per sessie).
# Het antwoord wordt via soort.sh vastgelegd; alleen klant, intern, acquisitie of persoonlijk.
if [ "$e" = vraag ] && [ -n "$sid" ] && [ ! -f "$dir/gevraagd-$sid" ]; then
  : > "$dir/gevraagd-$sid" 2>/dev/null
  skripts="$(cd "$(dirname "$0")" && pwd)"
  naamvraag=""
  if [ ! -f "$dir/naam.txt" ]; then
    naamvraag=" Vraag in hetzelfde bericht ook: Wat is je voornaam? (Rinse, Joost, Pascal, Babeth, Hidde of Daan). Voer daarna uit: sh $skripts/naam.sh <voornaam>. Dat hoeft maar één keer."
  fi
  printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"P21 tijdlog: dit is de eerste vraag van deze chat. Begin je antwoord met één korte vraag: Waarvoor is deze chat: Klantwerk, Intern werk, Acquisitie of Persoonlijk? Vraag niet naar namen van klanten of projecten.%s Geef daarna meteen antwoord op de vraag van de gebruiker. Zodra de gebruiker kiest, voer je uit: sh %s/soort.sh %s klant (of intern, acquisitie of persoonlijk). Kiest de gebruiker niets, doe dan niets."}}' "$naamvraag" "$skripts" "$sid"
  exit 0
fi

# Herinnering om 16:45: één keer per dag, alleen als de dag nog niet is afgesloten.
# Het scherm krijgt een melding en Claude krijgt de opdracht om dit te noemen. Er wordt niets gelezen.
tt=${t#*T}; r=${tt#*:}; nu=${P21_NU:-${tt%%:*}${r%%:*}}
if [ "$e" != einde ] && [ "$nu" -ge 1645 ] && [ ! -f "$dir/herinnerd-$dag" ] && [ ! -f "$dir/samenvatting-$dag.txt" ]; then
  : > "$dir/herinnerd-$dag" 2>/dev/null
  if command -v osascript >/dev/null 2>&1; then
    osascript -e 'display notification "Typ /tijdlog:dag in Claude Code. Duurt 2 minuten." with title "P21 Tijdlog"' >/dev/null 2>&1 &
  fi
  if [ "$e" = vraag ]; then
    printf '%s' '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"P21 tijdlog: het is na 16:45 en de gebruiker heeft de werkdag nog niet afgesloten. Beantwoord eerst de vraag en wijs er daarna in één zin op dat het invullen 2 minuten kost. Het scherm staat in de herinneringsmail en in de agenda-afspraak van 16:45 Lees niets uit het logbestand."}}'
  fi
fi
exit 0
