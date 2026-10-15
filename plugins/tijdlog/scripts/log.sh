#!/bin/sh
# P21 Tijdlog
# Schrijft per moment één regel naar ~/P21-tijdlog/<datum>.jsonl met ALLEEN:
#   - het tijdstip
#   - wat er gebeurde (sessie start, vraag gesteld, Claude klaar, sessie dicht)
#   - de naam van de map waarin je werkt
#   - een grove soort werk (bv. "Document"), afgeleid van een paar trefwoorden
# Wat je typt wordt alleen hier in het geheugen gelezen om die soort te kiezen,
# en daarna weggegooid. Het komt nooit in het bestand en gaat nergens heen.
# Pauzeren: maak een bestand ~/P21-tijdlog/PAUZE aan (of gebruik /tijdlog:pauze).

dir="$HOME/P21-tijdlog"
[ -f "$dir/PAUZE" ] && exit 0

input=$(cat)

event=$(printf '%s' "$input" | sed -n 's/.*"hook_event_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
case "$event" in
  SessionStart) e=start ;;
  UserPromptSubmit) e=vraag ;;
  Stop) e=klaar ;;
  SessionEnd) e=einde ;;
  *) exit 0 ;;
esac

cwd=$(printf '%s' "$input" | sed -n 's/.*"cwd"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
map=$(printf '%s' "$cwd" | sed 's/\\\\/\//g; s/\/*$//')
map=${map##*/}
map=$(printf '%s' "$map" | tr -d '"\\' | cut -c 1-60)

soort=""
if [ "$e" = vraag ]; then
  # Alleen de tekst na "prompt" bekijken, zodat mapnamen als "Documents" niet meetellen.
  tekst=$(printf '%s' "$input" | sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"//p' | tr '[:upper:]' '[:lower:]')
  if printf '%s' "$tekst" | grep -Eq 'presentatie|slides|slide|pptx|powerpoint|keynote|deck'; then soort="Presentatie"
  elif printf '%s' "$tekst" | grep -Eq 'linkedin|social|instagram|blog|website|campagne|video|afbeelding|beeld|marketing'; then soort="Content en marketing"
  elif printf '%s' "$tekst" | grep -Eq 'document|rapport|offerte|verslag|docx|pdf|word|contract|notitie|handleiding|voorstel'; then soort="Document"
  elif printf '%s' "$tekst" | grep -Eq 'e-mail|mail|bericht|antwoord aan|reageer'; then soort="Mail en berichten"
  elif printf '%s' "$tekst" | grep -Eq 'excel|xlsx|csv|analyse|cijfers|dashboard|rapportage|data'; then soort="Data en analyse"
  elif printf '%s' "$tekst" | grep -Eq 'bug|fix|code|pull request|deploy|test|feature|branch|merge|api|component|script|commit|build|n8n|workflow'; then soort="Bouwen"
  else soort="Overig"
  fi
  tekst=""
fi

mkdir -p "$dir" 2>/dev/null || exit 0
t=$(date +%Y-%m-%dT%H:%M:%S%z)
printf '{"t":"%s","e":"%s","map":"%s","soort":"%s"}\n' "$t" "$e" "$map" "$soort" >> "$dir/$(date +%Y-%m-%d).jsonl" 2>/dev/null
exit 0
