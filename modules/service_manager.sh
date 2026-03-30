#!/bin/bash

# ==============================
# USCS PRO - SERVICE MANAGER
# ==============================

SERVICE_DIR="$BASE_DIR/services"
LOG_DIR="$BASE_DIR/logs"

mkdir -p "$SERVICE_DIR"
mkdir -p "$LOG_DIR"

# ---------- START SERVICE ----------
start_service() {
    read -p "Service name: " name
    read -p "Command to run: " cmd

    nohup bash -c "$cmd" > "$LOG_DIR/$name.log" 2>&1 &
    echo $! > "$SERVICE_DIR/$name.pid"

    echo "Service '$name' started!"
}

# ---------- STOP SERVICE ----------
stop_service() {
    ls "$SERVICE_DIR"
    read -p "Service name: " name

    if [ -f "$SERVICE_DIR/$name.pid" ]; then
        kill -9 $(cat "$SERVICE_DIR/$name.pid")
        rm "$SERVICE_DIR/$name.pid"
        echo "Service '$name' stopped!"
    else
        echo "Service not found!"
    fi
}

# ---------- STATUS ----------
service_status() {
    echo "Running Services:"
    for file in "$SERVICE_DIR"/*.pid; do
        [ -e "$file" ] || continue
        name=$(basename "$file" .pid)
        echo "- $name (PID: $(cat $file))"
    done
    pause
}

# ---------- VIEW LOG ----------
view_logs() {
    ls "$LOG_DIR"
    read -p "Service name: " name

    if [ -f "$LOG_DIR/$name.log" ]; then
        tail -f "$LOG_DIR/$name.log"
    else
        echo "Log not found!"
        pause
    fi
}

# ---------- MENU ----------
service_manager_menu() {
    while true; do
        clear
        echo -e "${CYAN}==== SERVICE MANAGER ====${NC}"
        echo "1. Start Service"
        echo "2. Stop Service"
        echo "3. Status"
        echo "4. View Logs"
        echo "5. Back"

        read -p "Choice: " ch

        case $ch in
            1) start_service ;;
            2) stop_service ;;
            3) service_status ;;
            4) view_logs ;;
            5) return ;;
            *) echo "Invalid"; sleep 1 ;;
        esac
    done
}

# Register module
register_module "service_manager"
