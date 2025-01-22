#!/bin/bash

STATE=$(xinput list | grep -i touchpad | cut -d '[' -f 2 | cut -d ']' -f 1)

if  [[ "$STATE" == "" ]]; then
    exit 0
fi

if  [[ "$STATE" == "floating slave" ]]; then
   xinput --enable $(xinput list | grep -i touchpad | cut -d '=' -f 2 | cut -f 1)
else
   xinput --disable $(xinput list | grep -i touchpad | cut -d '=' -f 2 | cut -f 1)
fi


