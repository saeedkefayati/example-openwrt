#!/bin/sh

. "$(dirname "$0")/../utils/main.sh"

display_system_info() {
    echo "System"
    echo "-----------------------------------------------------"

    HOSTNAME=$(uci get system.@system[0].hostname 2>/dev/null || cat /proc/sys/kernel/hostname)
    printf "%-20s %s\n" "Hostname" "$HOSTNAME"

    MODEL=$(cat /tmp/sysinfo/model 2>/dev/null || echo "Unknown")
    printf "%-20s %s\n" "Model" "$MODEL"

    ARCH_INFO=$(opkg print-architecture 2>/dev/null | grep -v 'all' | grep -v 'noarch' | head -n 1 | awk '{print $2}')
    [ -z "$ARCH_INFO" ] && ARCH_INFO="Unknown"
    printf "%-20s %s\n" "Architecture" "$ARCH_INFO"

    PLATFORM=$(cat /tmp/sysinfo/board_name 2>/dev/null || echo "Unknown")
    printf "%-20s %s\n" "Target Platform" "$PLATFORM"

    FIRMWARE=$(grep 'DISTRIB_DESCRIPTION' /etc/openwrt_release 2>/dev/null | cut -d"'" -f2)
    [ -z "$FIRMWARE" ] && FIRMWARE="Unknown"
    printf "%-20s %s\n" "Firmware Version" "$FIRMWARE"

    printf "%-20s %s\n" "Kernel Version" "$(uname -r)"

    if [ -r /proc/uptime ]; then
        UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
        UPTIME_FMT=$(printf "%d days, %02d:%02d:%02d" \
            $((UPTIME_SEC/86400)) $((UPTIME_SEC/3600%24)) $((UPTIME_SEC/60%60)) $((UPTIME_SEC%60)))
        printf "%-20s %s\n" "Uptime" "$UPTIME_FMT"
    else
        printf "%-20s %s\n" "Uptime" "Unavailable"
    fi

    if [ -r /proc/loadavg ]; then
        LOAD_VAL=$(awk '{print $1", "$2", "$3}' /proc/loadavg)
        printf "%-20s %s\n" "Load Average" "$LOAD_VAL"
    else
        printf "%-20s %s\n" "Load Average" "Unavailable"
    fi

    echo ""
}

display_memory_usage() {
    echo "Memory"
    echo "-----------------------------------------------------"

    MEM_INFO=$(free | awk 'NR==2{print $2, $3}')
    TOTAL_MEM=$(echo "$MEM_INFO" | cut -d' ' -f1)
    USED_MEM=$(echo "$MEM_INFO" | cut -d' ' -f2)

    MEM_HR_INFO=$(free -h | awk 'NR==2{print $2, $3}')
    TOTAL_MEM_HR=$(echo "$MEM_HR_INFO" | cut -d' ' -f1)
    USED_MEM_HR=$(echo "$MEM_HR_INFO" | cut -d' ' -f2)

    draw_progress_bar "RAM" "$USED_MEM" "$TOTAL_MEM" "$USED_MEM_HR" "$TOTAL_MEM_HR"
}

display_storage_usage() {
    echo "Storage"
    echo "-----------------------------------------------------"

    DF_RAW=$(df)
    DF_HR=$(df -h)

    if echo "$DF_RAW" | grep -q '/$'; then
        TOTAL_DISK=$(echo "$DF_RAW" | grep -m1 '/$' | awk '{print $2}')
        USED_DISK=$(echo  "$DF_RAW" | grep -m1 '/$' | awk '{print $3}')
        TOTAL_DISK_HR=$(echo "$DF_HR" | grep -m1 '/$' | awk '{print $2}')
        USED_DISK_HR=$(echo  "$DF_HR" | grep -m1 '/$' | awk '{print $3}')
        draw_progress_bar "Disk space" "$USED_DISK" "$TOTAL_DISK" "$USED_DISK_HR" "$TOTAL_DISK_HR"
    else
        echo "Disk space info not available."
    fi

    if echo "$DF_RAW" | grep -q '/tmp$'; then
        TOTAL_TMP=$(echo "$DF_RAW" | grep -m1 '/tmp$' | awk '{print $2}')
        USED_TMP=$(echo  "$DF_RAW" | grep -m1 '/tmp$' | awk '{print $3}')
        TOTAL_TMP_HR=$(echo "$DF_HR" | grep -m1 '/tmp$' | awk '{print $2}')
        USED_TMP_HR=$(echo  "$DF_HR" | grep -m1 '/tmp$' | awk '{print $3}')
        draw_progress_bar "Temp space" "$USED_TMP" "$TOTAL_TMP" "$USED_TMP_HR" "$TOTAL_TMP_HR"
    else
        echo "Temp space info not available."
    fi
}

script_status() {
    draw_banner
    display_system_info
    display_memory_usage
    display_storage_usage
}
