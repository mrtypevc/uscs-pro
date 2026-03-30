#!/bin/bash

# ==============================
# USCS PRO CORE ENGINE (STEP 2)
# ==============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---------- MODULE STORAGE ----------
MODULES=()

# ---------- REGISTER MODULE ----------
register_module() {
    MODULES+=("$1")
}

# ---------- LOAD MODULES ----------
load_modules() {
    if [ -d "$BASE_DIR/modules" ]; then
        for file in "$BASE_DIR/modules"/*.sh; do
            if [ -f "$file" ]; then
                source "$file"
                register_module "$(basename "$file")"
            fi
        done
    fi
}

# ---------- LOAD PLUGINS ----------
load_plugins() {
    if [ -d "$BASE_DIR/plugins" ]; then
        for file in "$BASE_DIR/plugins"/*.sh; do
            if [ -f "$file" ]; then
                source "$file"
                register_module "plugin:$(basename "$file")"
            fi
        done
    fi
}

# ---------- INIT CORE ----------
init_core() {
    load_modules
    load_plugins
}

# ---------- SHOW LOADED MODULES ----------
show_modules() {
    echo "Loaded Modules:"
    for m in "${MODULES[@]}"; do
        echo "- $m"
    done
    read -p "Press Enter..."
}
