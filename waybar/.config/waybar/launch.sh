#!/usr/bin/env bash

killall -q waybar

echo "---" | tee -a /tmp/waybar.log
waybar 2>&1 | tee -a /tmp/waybar.log & disown

