#!/bin/bash

id="NOT"

nohup playerctl -F metadata --format "{{ status }}/////{{ artist }}/////{{ title }}/////{{ mpris:artUrl }}" 2>/dev/null | while read line; do
  if [[ ${line} =~ ^Playing/////.+/////.+/////.+$ ]]; then
    if [[ $id == "NOT" ]];then
      id=$(echo ${line} | awk -F///// '{system("notify-send -p -u low -i "$4" \""$3"\" \""$2"\"")}')
    else
      id=$(echo ${line} | awk -v id="$id" -F///// '{system("notify-send -p -r "id" -u low -i "$4" \""$3"\" \""$2"\"")}')
    fi
  fi
done >/dev/null 2>&1 &
