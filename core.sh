#!/bin/bash

# ==============================
# USCS PRO CORE (FINAL WORKING)
# ==============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

MODULES=()

register_module() {
    MODULES+=("$1")
}

# ---------- LOAD ALL MODULES (SAFE) ----------
load_modules() {
    if [ -d "$BASE_DIR/modules" ]; then
        
        # Pehle service manager load karo (dependency)
        if [ -f "$BASE_DIR/modules/service_manager.sh" ]; then
            source "$BASE_DIR/modules/service_manager.sh"
        fi

        # Baaki modules load karo
        for file in "$BASE_DIR/modules/"*.sh; do
            # skip service_manager (already loaded)
            if [[ "$file" != *"service_manager.sh" ]]; then
                [ -f "$file" ] && source "$file"
            fi
        done
    fi
}

# ---------- INIT ----------
init_core() {
    load_modules
}

# ---------- SHOW ----------
show_modules() {
    echo "Loaded Modules:"
    for m in "${MODULES[@]}"; do
        echo "- $m"
    done
    read -p "Press Enter..."
}
