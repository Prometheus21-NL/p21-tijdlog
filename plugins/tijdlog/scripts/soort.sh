#!/bin/sh
# P21 Tijdlog: legt vast voor welk soort werk een chat is.
# Gebruik: soort.sh <sessienummer> <klant|intern|acquisitie|persoonlijk>
# Alleen die vier woorden worden bewaard, nooit vrije tekst.

dir="$HOME/P21-tijdlog"
[ -f "$dir/PAUZE" ] && exit 0

sid=$(printf '%s' "$1" | tr -cd 'A-Za-z0-9-' | cut -c 1-40)
case "$2" in
  klant|intern|acquisitie|persoonlijk) v="$2" ;;
  *) exit 0 ;;
esac

mkdir -p "$dir" 2>/dev/null || exit 0
printf '{"t":"%s","e":"soort","v":"%s","s":"%s"}\n' "$(date +%Y-%m-%dT%H:%M:%S%z)" "$v" "$sid" >> "$dir/$(date +%Y-%m-%d).jsonl" 2>/dev/null
exit 0
