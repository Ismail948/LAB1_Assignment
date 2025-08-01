#!/bin/bash

day=$(date +%A)

head -n 1 timetable.csv

grep "$day" timetable.csv
