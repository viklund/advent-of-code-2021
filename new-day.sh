#!/usr/bin/env bash

day=$(date +%d)
day_unpadded=$(echo $day | sed 's/^0//')

echo "<$day> <$day_unpadded>"

if [ ! -d $day ]; then
    mkdir $day
    cp TEMPLATE/* $day
fi

curl \
    -H "Cookie: $(cat cookie)" \
    "https://adventofcode.com/2021/day/${day_unpadded}/input" \
    > $day/input

