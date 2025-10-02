#!/bin/sh

# Load common functions
. "$(dirname "$0")/../utils/main.sh"

display_network_info() {
    echo "Network"
    echo "-----------------------------------------------------"

    # لیست اینترفیس‌ها
    ifconfig | awk '/^(br-lan|eth|wlan)/ {print $1}' | while read iface; do
        echo "Interface: $iface"

        # IPv4
        ipv4=$(ifconfig $iface 2>/dev/null | awk '/inet / {print $2}' | cut -d: -f2)
        [ -n "$ipv4" ] && echo "  IPv4: $ipv4" || echo "  IPv4: N/A"

        # IPv6
        ipv6=$(ifconfig $iface 2>/dev/null | awk '/inet6 / && /Global/ {print $2}')
        [ -n "$ipv6" ] && echo "  IPv6: $ipv6" || echo "  IPv6: N/A"

        # MAC
        mac=$(ifconfig $iface 2>/dev/null | awk '/(HWaddr|ether)/ {print $NF}')
        [ -n "$mac" ] && echo "  MAC:  $mac" || echo "  MAC:  N/A"

        echo ""
    done
}

display_wireless_usage() {
    echo "Wireless"
    echo "-----------------------------------------------------"

    if command -v iwinfo >/dev/null 2>&1; then
        iwinfo
    elif command -v iwconfig >/dev/null 2>&1; then
        iwconfig 2>/dev/null | grep -v 'no wireless extensions'
    else
        echo "Wireless tools not available."
    fi
}

script_network() {
    draw_banner
    display_network_info
    display_wireless_usage
}
