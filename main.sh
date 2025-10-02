#!/bin/sh

STATUS_SCRIPT="./modules/status.sh"
NETWORK_SCRIPT="./modules/network.sh"

if [ ! -f "$STATUS_SCRIPT" ]; then
    echo "Error: Status script not found."
    exit 1
fi

if [ ! -f "$NETWORK_SCRIPT" ]; then
    echo "Error: Network script not found."
    exit 1
fi

. "$STATUS_SCRIPT"
. "$NETWORK_SCRIPT"

show_menu() {
    clear
    draw_banner
    echo "==============================================="
    echo "   Main Management Script For Openwrt Router   "
    echo "==============================================="
    echo "   use this script with router-status command  "
    echo "==============================================="
    echo "1. Display Full Router Status"
    echo "2. Display Full Router Network"
    echo "3. Update Packages"
    echo "4. Exit"
    echo "-------------------------"
}

while true; do
    show_menu
    read -p "Please select an option: " choice

    case $choice in
        1)
            clear_terminal
            script_status
            read -p "Press Enter to return to the menu..."
            clear_terminal
            ;;
        2)
            clear_terminal
            script_network
            read -p "Press Enter to return to the menu..."
            clear_terminal
            ;;
        3)
            echo "Updating packages..."
            opkg update
            read -p "Update finished. Press Enter to return to the menu..."
            ;;
        4)
            echo "Exiting."
            exit 0
            ;;
        *)
            read -p "Invalid option. Press Enter to try again..."
            ;;
    esac
done
