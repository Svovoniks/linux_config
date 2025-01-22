#!/bin/bash
num=$(i3-msg -t get_workspaces \
    | jq '.[] | select(.focused==true).name' \
    | cut -d"\"" -f2)

echo $num
i3-msg "workspace 10"
nohup vlc /home/svovoniks/Music/Lofi\ Study\ 2024 &
sleep 0.5
i3-msg "workspace ${num}"
