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

input=$(cat)

# Uitzondering voor wie geen werknemer is: staat er een leeg bestand .geen-tijdlog in de map
# van de chat (of een map erboven), dan wordt voor die chat niets genoteerd. De map zelf wordt
# alleen gecontroleerd en nergens bewaard.
d=$(printf '%s' "$input" | sed -n 's/.*"cwd"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
while [ -n "$d" ] && [ "$d" != "/" ] && [ "$d" != "." ]; do
  [ -f "$d/.geen-tijdlog" ] && exit 0
  d=$(dirname "$d")
done

event=$(printf '%s' "$input" | sed -n 's/.*"hook_event_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
case "$event" in
  SessionStart) e=start ;;
  UserPromptSubmit) e=vraag ;;
  Stop) e=klaar ;;
  SessionEnd) e=einde ;;
  *) exit 0 ;;
esac

sid=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1 | tr -cd 'A-Za-z0-9-' | cut -c 1-40)

mkdir -p "$dir" 2>/dev/null || exit 0
t=$(date +%Y-%m-%dT%H:%M:%S%z)
printf '{"t":"%s","e":"%s","s":"%s"}\n' "$t" "$e" "$sid" >> "$dir/$(date +%Y-%m-%d).jsonl" 2>/dev/null

# Eerste vraag van een chat: Claude vraagt waarvoor de chat is (één keer per sessie).
# Het antwoord wordt via soort.sh vastgelegd; alleen klant, intern of acquisitie.
if [ "$e" = vraag ] && [ -n "$sid" ] && [ ! -f "$dir/gevraagd-$sid" ]; then
  : > "$dir/gevraagd-$sid" 2>/dev/null
  soort="$(cd "$(dirname "$0")" && pwd)/soort.sh"
  printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"P21 tijdlog: dit is de eerste vraag van deze chat. Begin je antwoord met één korte vraag: Waarvoor is deze chat: Klantwerk, Intern werk of Acquisitie? Vraag niet naar namen. Geef daarna meteen antwoord op de vraag van de gebruiker. Zodra de gebruiker kiest, voer je uit: sh %s %s klant (of intern, of acquisitie). Kiest de gebruiker niets, doe dan niets."}}' "$soort" "$sid"
  exit 0
fi

# Herinnering om 16:45: één keer per dag, alleen als de dag nog niet is afgesloten.
# Het scherm krijgt een melding en Claude krijgt de opdracht om dit te noemen. Er wordt niets gelezen.
dag=$(date +%Y-%m-%d)
nu=${P21_NU:-$(date +%H%M)}
if [ "$e" != einde ] && [ "$nu" -ge 1645 ] && [ ! -f "$dir/herinnerd-$dag" ] && [ ! -f "$dir/samenvatting-$dag.txt" ]; then
  : > "$dir/herinnerd-$dag" 2>/dev/null
  if command -v osascript >/dev/null 2>&1; then
    osascript -e 'display notification "Typ /tijdlog:dag in Claude Code. Duurt 2 minuten." with title "P21 Tijdlog"' >/dev/null 2>&1
  fi
  if [ "$e" = vraag ]; then
    printf '%s' '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"P21 tijdlog: het is na 16:45 en de gebruiker heeft de werkdag nog niet afgesloten. Beantwoord eerst de vraag en wijs er daarna in één zin op dat /tijdlog:dag typen 2 minuten kost. Lees niets uit het logbestand."}}'
  fi
fi
exit 0
