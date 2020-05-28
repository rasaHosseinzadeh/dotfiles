#!/bin/sh
player_status=$(playerctl status 2> /dev/null)
[ "$player_status" = "Playing" ] && player_status=""
[ "$player_status" = "Paused" ] && player_status=""
[ "$player_status" != "Stopped" ] &&  echo "{\"text\": \"$(playerctl metadata title) - $(playerctl metadata artist) $player_status\"}" || echo "\{\"text\":\"\"}"
