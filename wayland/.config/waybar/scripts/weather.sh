#!/usr/bin/env bash

where=${1:-"Paris+FRANCE"}

weather="$(curl --silent wttr.in/${where}?0TpQA)"

echo "$weather" | sed -n '2,3p' | cut -c19- | tr "\n" " " | xargs

echo "$where" | sed 's;+;, ;'

echo "custom-weather"

# EOF
