#!/bin/bash

while true; do
    selected=$(ls "$sys/launchers" | sed 's/\.[^.]*$//' | fzf)
    if [ -z "$selected" ]; then
        # If no selection is made in fzf, exit the loop
        echo "Exiting..."
        break
    fi
    sys "$selected"
done
