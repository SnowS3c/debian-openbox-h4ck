#!/bin/bash

target_file="/home/username/.config/bin/target.txt"

if [ -s "$target_file" ]; then
	echo "%{F#FF0000}什%{F#ffffff} $(/bin/cat "$target_file")"
	/usr/local/bin/polybar-msg cmd show &>/dev/null
else
	/usr/local/bin/polybar-msg cmd hide &>/dev/null
fi
