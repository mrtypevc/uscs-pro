#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODULES=()

register_module() {
    MODULES+=("$1")
}

load_modules() {
    MODULE_PATH="$BASE_DIR/modules"

    if [ -d "$MODULE_PATH" ]; then
        for file in "$MODULE_PATH"/*.sh; do
            [ -f "$file" ] && source "$file"
        done
    fi
}

load_plugins() {
    PLUGIN_PATH="$BASE_DIR/plugins"

    if [ -d "$PLUGIN_PATH" ]; then
        for file in "$PLUGIN_PATH"/*.sh; do
            [ -f "$file" ] && source "$file"
        done
    fi
}

init_core() {
    load_modules
    load_plugins
}

show_modules() {
    echo "Loaded Modules:"
    for m in "${MODULES[@]}"; do
        echo "- $m"
    done
    read -p "Press Enter..."
}
