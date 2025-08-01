#!/bin/bash
room="$1"

all_slots=$(tail -n +2 timetable.csv | cut -d',' -f1,2 | sort | uniq)
used_slots=$(grep "$room" timetable.csv | cut -d',' -f1,2 | sort | uniq)

echo "Free slots for $room:"
while IFS= read -r slot; do
    if ! echo "$used_slots" | grep -Fxq "$slot"; then
        echo "$slot"
    fi
done <<< "$all_slots"
