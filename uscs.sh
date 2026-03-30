#!/bin/bash

# ==============================
# USCS PRO - BASE SYSTEM (STEP 1)
# ==============================

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$BASE_DIR/system.log"
source "$BASE_DIR/core.sh"

# ---------- COLORS ----------
RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
NC="\033[0m"

# ---------- LOGGER ----------
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
    echo "$(date) [INFO] $1" >> "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    echo "$(date) [ERROR] $1" >> "$LOG_FILE"
}

# ---------- UTILS ----------
pause() {
    read -p "Press Enter to continue..."
}

# ---------- SYSTEM INFO ----------
system_info() {
    echo -e "${CYAN}System Information:${NC}"
    uname -a
    echo ""
    echo "User: $(whoami)"
    echo "Directory: $BASE_DIR"
    pause
}

# ---------- BASIC FILE SYSTEM ----------
file_manager() {
    clear
    echo -e "${CYAN}File Manager${NC}"
    echo "1. List Files"
    echo "2. Create File"
    echo "3. Delete File"
    echo "4. Back"

    read -p "Choice: " ch

    case $ch in
        1) ls; pause ;;
        2) read -p "File name: " f; touch "$f"; log_info "Created $f"; pause ;;
        3) read -p "File name: " f; rm -rf "$f"; log_info "Deleted $f"; pause ;;
        4) return ;;
        *) echo "Invalid"; sleep 1 ;;
    esac
}

# ---------- AUTO UPDATE ----------
update_system() {
    if [ -d ".git" ]; then
        git pull
        log_info "System updated"
    else
        log_error "Not a git repo"
    fi
    pause
}

# ---------- MAIN MENU ----------
main_menu() {
    while true; do
        clear
        echo -e "${CYAN}==== USCS PRO CONTROL PANEL ====${NC}"
        echo "1. System Info"
        echo "2. File Manager"
        echo "3. System Tools (PRO)"
        echo "4. Service Manager"
        echo "5. Show Modules"
        echo "6. Update System"
        echo "7. Exit"

        read -p "Select option: " choice

        case $choice in
            1) system_info ;;
            2) file_manager ;;
            3) system_tools_menu ;;
            4) service_manager_menu ;;
            5) show_modules ;;
            6) update_system ;;
            7) exit ;;
            *) echo "Invalid option"; sleep 1 ;;
        esac
    done
}

# ---------- INIT ----------
init() {
    log_info "USCS PRO Started"
    init_core
}

# ---------- START ----------
init
main_menu
