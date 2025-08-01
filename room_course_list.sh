#!/bin/bash#!/bin/sh

grep ",$1$" timetable.csv | cut -d',' -f3 | sort | uniq

