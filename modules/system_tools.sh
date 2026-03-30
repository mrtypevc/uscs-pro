#!/bin/bash

# ==============================
# USCS PRO - SYSTEM TOOLS MODULE
# ==============================

system_tools_menu() {
    while true; do
        clear
        echo -e "${CYAN}==== SYSTEM TOOLS ====${NC}"
        echo "1. System Info"
        echo "2. Disk Usage"
        echo "3. RAM Usage"
        echo "4. Back"

        read -p "Select option: " choice

        case $choice in
            1) sys_info ;;
            2) disk_usage ;;
            3) ram_usage ;;
            4) return ;;
            *) echo "Invalid option"; sleep 1 ;;
        esac
    done
}

# ---------- SYSTEM INFO ----------
sys_info() {
    clear
    echo -e "${GREEN}--- SYSTEM INFO ---${NC}"
    uname -a
    echo ""
    echo "User: $(whoami)"
    echo "Uptime:"
    uptime
    pause
}

# ---------- DISK ----------
disk_usage() {
    clear
    echo -e "${YELLOW}--- DISK USAGE ---${NC}"
    df -h
    pause
}

# ---------- RAM ----------
ram_usage() {
    clear
    echo -e "${CYAN}--- RAM USAGE ---${NC}"
    free -h
    pause
}

# Register module (important)
register_module "system_tools"
