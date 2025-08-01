#!/bin/bash

tail -n +2 timetable.csv | cut -d',' -f1,5 | sort | uniq -c | while read count day room; do
    echo "$day, $room: $count classes"
done