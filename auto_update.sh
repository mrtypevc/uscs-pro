#!/bin/bash

# ==============================
# USCS PRO AUTO UPDATE SYSTEM
# ==============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
UPDATE_INTERVAL=25   # 300 sec = 5 min

AUTO_UPDATE_LOOP() {
    while true; do
        if [ -d "$BASE_DIR/.git" ]; then
            
            LOCAL=$(git rev-parse HEAD)
            git fetch origin > /dev/null 2>&1
            REMOTE=$(git rev-parse origin/main)

            if [ "$LOCAL" != "$REMOTE" ]; then
                echo "[AUTO-UPDATE] New update found! Updating..."
                git pull
                echo "[AUTO-UPDATE] Updated successfully!"
            fi
        fi

        sleep $UPDATE_INTERVAL
    done
}

# Run in background
AUTO_UPDATE_LOOP &
