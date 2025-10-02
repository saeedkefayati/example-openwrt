#!/bin/sh

# Draw Banner
draw_banner() {
    clear
    echo '  _______                     ________        __'
    echo ' |       |.-----.-----.-----.|  |  |  |.----.|  |_'
    echo ' |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|'
    echo ' |_______||   __|_____|__|__||________||__|  |____|'
    echo '          |__| W I R E L E S S   F R E E D O M'
    echo ''
}

# Progress Bar
draw_progress_bar() {
    local label=$1 used=$2 total=$3 used_hr=$4 total_hr=$5
    local percentage=0
    [ "$total" -ne 0 ] && percentage=$(( (100 * used) / total ))
    [ "$percentage" -gt 100 ] && percentage=100

    local color reset="\033[0m"
    if   [ "$percentage" -lt 70 ]; then color="\033[0;32m"
    elif [ "$percentage" -lt 90 ]; then color="\033[1;33m"
    else color="\033[0;31m"; fi

    local filled=$(( (percentage * 20) / 100 ))
    local empty=$(( 20 - filled ))

    local bar
    bar="$(printf "%${filled}s" | tr ' ' '█')"
    bar+=$(printf "%${empty}s" | tr ' ' '░')

    printf "%-12s [${color}%s${reset}] %3d%% (%s / %s)\n" \
        "$label" "$bar" "$percentage" "$used_hr" "$total_hr"
}
