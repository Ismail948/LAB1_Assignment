#!/bin/bash
instructor="$1"

count=$(( $(grep -i ",$instructor," timetable.csv | wc -l) - 1 ))

echo "$instructor is teaching $count course(s)."
