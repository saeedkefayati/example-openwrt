#!/bin/sh


REPO_DIR="/root/example-openwrt"
SHORTCUT="/usr/bin/router-status"


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

echo ""
echo "Uninstall complete. All traces removed."
