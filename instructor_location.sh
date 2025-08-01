#!/bin/sh

instructor="$1"
test_day="Monday"
test_time="08:15"

h=${test_time%:*}
m=${test_time#*:}
current_minutes=$((10#$h * 60 + 10#$m))

f="/tmp/instructor_found_$$.tmp"
echo "false" > "$f"

tail -n +2 timetable.csv | while IFS=',' read day time course instr room; do
  d=$(echo "$day" | tr A-Z a-z)
  i=$(echo "$instr" | tr A-Z a-z)
  td=$(echo "$test_day" | tr A-Z a-z)
  iname=$(echo "$instructor" | tr A-Z a-z)

  if [ "$d" = "$td" ] && [ "$i" = "$iname" ]; then
    start=${time%-*}
    end=${time#*-}
    sh=${start%:*}
    sm=${start#*:}
    eh=${end%:*}
    em=${end#*:}
    s=$((10#$sh * 60 + 10#$sm))
    e=$((10#$eh * 60 + 10#$em))

    if [ "$current_minutes" -ge "$s" ] && [ "$current_minutes" -lt "$e" ]; then
      echo "$instructor is currently in $room (Day: $test_day, Time: $time)"
      echo "true" > "$f"
      break
    fi
  fi
done

[ "$(cat "$f")" = "false" ] && echo "$instructor is in office (no class at this time)"

rm -f "$f"
