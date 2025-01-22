#!/bin/bash

if [ -z "$1" ]; then
  exit 0
fi

i3-msg exec "i3-sensible-terminal -e zsh -c '${1}'" >& /dev/null &
