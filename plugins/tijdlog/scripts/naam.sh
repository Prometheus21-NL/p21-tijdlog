#!/bin/sh
# P21 Tijdlog: bewaart je voornaam, zodat je tijden in jouw eigen scherm verschijnen.
# Gebruik: naam.sh <voornaam>
dir="$HOME/P21-tijdlog"
n=$(printf '%s' "$1" | tr -cd 'A-Za-z' | cut -c 1-20)
[ -n "$n" ] || exit 0
mkdir -p "$dir" 2>/dev/null || exit 0
printf '%s\n' "$n" > "$dir/naam.txt" 2>/dev/null
exit 0
