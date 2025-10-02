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
    echo "-----------------------------------------------"
    echo "   use this script with router-status command  "
    echo "==============================================="
    echo "----------------------------------"
    echo "1. Display Full Router Status     "
    echo "2. Display Full Router Network    "
    echo "3. Update Packages                "
    echo "4. Update router-status Package   "
    echo "5. Uninstall router-status Package"
    echo "6. Exit                           "
    echo "----------------------------------"
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
            echo "Updating script..."
            SCRIPT_DIR="/root/example-openwrt"
            if [ -d "$SCRIPT_DIR/.git" ]; then
                cd "$SCRIPT_DIR" || { echo "Error: cannot access $SCRIPT_DIR"; break; }
                git pull
                echo "Script updated successfully."
            else
                echo "Git repository not found in $SCRIPT_DIR."
                echo "Please clone the repository first."
            fi
                read -p "Press Enter to return to the menu..."
            ;;
        5)
            echo "Uninstalling script..."
            SCRIPT_DIR="/root/example-openwrt"
            if [ -f "$SCRIPT_DIR/uninstall.sh" ]; then
                read -p "Are you sure? This will remove the script. [y/N] " confirm
                if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                    cd "$SCRIPT_DIR" || { echo "Error: cannot access $SCRIPT_DIR"; break; }
                    sh uninstall.sh
                    echo "Script uninstalled successfully."
                    exit 0
                else
                    echo "Uninstall cancelled."
                    read -p "Press Enter to return to the menu..."
                fi
            else
                echo "Uninstall script not found in $SCRIPT_DIR."
                read -p "Press Enter to return to the menu..."
            fi
            ;;
        6)
            echo "Exiting."
            exit 0
            ;;
        *)
            read -p "Invalid option. Press Enter to try again..."
            ;;
    esac
done
