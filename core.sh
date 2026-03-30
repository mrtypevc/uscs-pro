#!/bin/bash

# ==============================
# USCS PRO CORE (FINAL FIX)
# ==============================

# IMPORTANT: correct base dir
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

MODULES=()

# ---------- REGISTER ----------
register_module() {
    MODULES+=("$1")
}

# ---------- LOAD MODULES ----------
load_modules() {
    if [ -d "$BASE_DIR/modules" ]; then
        for file in "$BASE_DIR/modules/"*.sh; do
            if [ -f "$file" ]; then
                source "$file"
            fi
        done
    fi
}

# ---------- LOAD PLUGINS ----------
load_plugins() {
    if [ -d "$BASE_DIR/plugins" ]; then
        for file in "$BASE_DIR/plugins/"*.sh; do
            if [ -f "$file" ]; then
                source "$file"
            fi
        done
    fi
}

# ---------- INIT ----------
init_core() {
    load_modules
    load_plugins
}

# ---------- SHOW MODULES ----------
show_modules() {
    echo "Loaded Modules:"
    for m in "${MODULES[@]}"; do
        echo "- $m"
    done
    read -p "Press Enter..."
}
