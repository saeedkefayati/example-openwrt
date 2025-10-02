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
    local label=$1
    local used=$2
    local total=$3
    local used_hr=$4
    local total_hr=$5

    local percentage=0
    [ "$total" -ne 0 ] && percentage=$(( (100 * used) / total ))
    [ "$percentage" -gt 100 ] && percentage=100

    local color reset="\033[0m"
    if [ "$percentage" -lt 70 ]; then
        color="\033[0;32m"
    elif [ "$percentage" -lt 90 ]; then
        color="\033[1;33m"
    else
        color="\033[0;31m"
    fi

    local filled=$(( (percentage * 20) / 100 ))
    local empty=$(( 20 - filled ))

    local bar_filled bar_empty
    bar_filled=$(printf "%${filled}s" | tr ' ' '#')
    bar_empty=$(printf "%${empty}s" | tr ' ' '-')
    local bar="${bar_filled}${bar_empty}"

    printf "%-12s [${color}%s${reset}] %3d%% (%s / %s)\n" \
        "$label" "$bar" "$percentage" "$used_hr" "$total_hr"
}

# Terminal
clear_terminal() {
    if command -v printf >/dev/null 2>&1; then
        printf "\033c"
    elif command -v clear >/dev/null 2>&1; then
        clear
    elif command -v reset >/dev/null 2>&1; then
        reset
    else
        echo "No method to clear terminal available"
    fi
}