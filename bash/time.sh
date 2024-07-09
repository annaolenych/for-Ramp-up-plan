#!/bin/bash

usage() {
  echo "Usage: $0 -d 'date and time' -f from_timezone -t to_timezone"
  echo "Example: $0 -d '2024-07-09 14:00:00' -f UTC -t America/New_York"
  exit 1
}

while getopts ":d:f:t:" opt; do
  case $opt in
    d) datetime="$OPTARG"
    ;;
    f) from_tz="$OPTARG"
    ;;
    t) to_tz="$OPTARG"
    ;;
    *) usage
    ;;
  esac
done

if [ -z "$datetime" ] || [ -z "$from_tz" ] || [ -z "$to_tz" ]; then
  usage
fi

converted_datetime=$(TZ=$from_tz date -j -f "%Y-%m-%d %H:%M:%S" "$datetime" "+%Y-%m-%d %H:%M:%S $from_tz" | TZ=$to_tz date +"%Y-%m-%d %H:%M:%S $to_tz")

echo "Original datetime: $datetime $from_tz"
echo "Converted datetime: $converted_datetime"
