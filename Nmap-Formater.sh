#!/bin/bash

set -euo pipefail

if [ $# -eq 0 ]; then
echo "<Usage> : $0 <nmap_output_file>"
echo "Example: $0 nmap.txt"
exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
echo "Error: file '$INPUT_FILE' not found" >&2
exit 1
fi

echo "Open Ports found in $INPUT_FILE:"
echo "-------------------------------------------------------------------"
printf "%-12s %-16s %-35s\n" "PORT" "STATE" "SERVICE / VERSION"
printf "%-12s %-16s %-35s\n" "----" "-----" "-----------------"

count=0

while read -r port state service; do 
printf "%-12s %-16s %-35s\n" "$port" "$state" "$service"
((++count))
done < <(grep -E '^[0-9]+/(tcp|udp)[[:space:]]+(open\|filtered|open|filtered)' "$INPUT_FILE" || true)

echo "----------------------------------------------------------------"
echo "Total open/filtered ports: $count"





