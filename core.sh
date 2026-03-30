#!/bin/bash

# ==============================
# USCS PRO CORE (FINAL FIX 2)
# ==============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

MODULES=()

register_module() {
    MODULES+=("$1")
}

# ---------- FORCE LOAD SERVICE MANAGER FIRST ----------
load_core_modules() {
    # sabse pehle service manager load karo (important)
    if [ -f "$BASE_DIR/modules/service_manager.sh" ]; then
        source "$BASE_DIR/modules/service_manager.sh"
    fi
}

# ---------- LOAD ALL MODULES ----------
load_modules() {
    if [ -d "$BASE_DIR/modules" ]; then
        for file in "$BASE_DIR/modules/"*.sh; do
            [ -f "$file" ] && source "$file"
        done
    fi
}

# ---------- LOAD PLUGINS ----------
load_plugins() {
    if [ -d "$BASE_DIR/plugins" ]; then
        for file in "$BASE_DIR/plugins/"*.sh; do
            [ -f "$file" ] && source "$file"
        done
    fi
}

# ---------- INIT ----------
init_core() {
    load_core_modules   # 👈 FIRST
    load_modules        # 👈 THEN others
    load_plugins
}

# ---------- SHOW ----------
show_modules() {
    echo "Loaded Modules:"
    for m in "${MODULES[@]}"; do
        echo "- $m"
    done
    read -p "Press Enter..."
}
