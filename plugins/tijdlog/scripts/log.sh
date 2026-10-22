#!/bin/sh
# P21 Tijdlog
# Schrijft per moment één regel naar ~/P21-tijdlog/<datum>.jsonl met ALLEEN:
#   - het tijdstip
#   - wat er gebeurde (sessie start, vraag gesteld, Claude klaar, sessie dicht)
#   - de naam van de map waarin je werkt
# Wat je typt wordt nooit gelezen: de invoer wordt alleen gebruikt voor het
# event en de mapnaam. Het bestand blijft op je computer.
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

mkdir -p "$dir" 2>/dev/null || exit 0
t=$(date +%Y-%m-%dT%H:%M:%S%z)
printf '{"t":"%s","e":"%s","map":"%s"}\n' "$t" "$e" "$map" >> "$dir/$(date +%Y-%m-%d).jsonl" 2>/dev/null
exit 0
