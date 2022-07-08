#!/bin/bash

target_file="/home/username/.config/bin/target.txt"
/usr/bin/cat "$target_file" | /usr/bin/xclip -sel clip
