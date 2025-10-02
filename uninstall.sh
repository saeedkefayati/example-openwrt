#!/bin/sh


REPO_DIR="/root/example-openwrt"
SHORTCUT="/usr/bin/router-status"


EXTRA_FILES=(
    # "/usr/bin/other-shortcut"
    # "/root/example-openwrt-extra"
)


if [ -d "$REPO_DIR" ]; then
    echo "Removing repository: $REPO_DIR ..."
    rm -rf "$REPO_DIR"
else
    echo "Repository not found: $REPO_DIR"
fi


if [ -f "$SHORTCUT" ]; then
    echo "Removing shortcut command: $SHORTCUT ..."
    rm -f "$SHORTCUT"
else
    echo "Shortcut command not found: $SHORTCUT"
fi


for f in "${EXTRA_FILES[@]}"; do
    if [ -e "$f" ]; then
        echo "Removing extra file: $f ..."
        rm -rf "$f"
    else
        echo "Extra file not found: $f"
    fi
done

echo ""
echo "Uninstall complete. All traces removed."
