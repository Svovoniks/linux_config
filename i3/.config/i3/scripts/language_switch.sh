#!/bin/bash

LANGUAGE=$(setxkbmap -query | grep layout | cut -d ':' -f 2 | xargs)

if  [[ "LANGUAGE" == "" ]]; then
    exit 0
fi

if  [[ "$LANGUAGE" == "us" ]]; then
    setxkbmap -layout ru
else
    setxkbmap -layout us
fi


