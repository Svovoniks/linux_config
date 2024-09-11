#!/bin/bash

GNOME_TERMINAL_SCREEN=""

echo 'cd "${1}" exec bash'o
i3-sensible-terminal -e 'cd "${1}" exec bash' &

disown
