#!/usr/bin/env bash

day=$(date +%d)
day_unpadded=$(echo $day | sed 's/^0//')

level=$1
ans=$2

if [ -z $ans ]; then
    echo "Usage: $0 [12] <answer>"
    exit 1
fi

ANS=$( curl \
    -s \
    -H "Cookie: $(cat cookie)" \
    -X POST \
    -d "level=${level}" \
    -d "answer=${ans}" \
    "https://adventofcode.com/2021/day/${day_unpadded}/answer" \
    | grep '<article>' )

if echo $ANS | grep "You gave an answer too recently" >/dev/null; then
    LEFT=$( echo $ANS | perl -pe 's/^.*\. You have (.*?) left.*$/$1/g' )
    echo "Timeout ($LEFT)"
    exit
fi

if echo $ANS | grep "That's not the right answer" >/dev/null; then
    echo "Wrong"
    echo $ANS
    exit;
fi

if echo $ANS | grep "That's the right answer" >/dev/null; then
    echo "Success"
    exit;
fi

if echo $ANS | grep "You don't seem to be solving the right level." >/dev/null; then
    echo "Wrong level"
    exit;
fi

echo "ERROR??"
echo $ANS
