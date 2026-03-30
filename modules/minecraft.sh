#!/bin/bash

# ==============================
# USCS PRO - MINECRAFT MANAGER
# ==============================

MC_DIR="$BASE_DIR/minecraft"
mkdir -p "$MC_DIR"

# ---------- CREATE SERVER ----------
create_mc_server() {
    read -p "Server name: " name
    DIR="$MC_DIR/$name"

    mkdir -p "$DIR"
    cd "$DIR"

    echo "Downloading PaperMC..."
    curl -L -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/100/downloads/paper-1.20.1-100.jar

    echo "eula=true" > eula.txt

    echo "Server '$name' created!"
    pause
}

# ---------- START ----------
start_mc_server() {
    ls "$MC_DIR"
    read -p "Server name: " name

    DIR="$MC_DIR/$name"

    if [ -d "$DIR" ]; then
        start_service "$name" "cd $DIR && java -Xmx1G -Xms512M -jar server.jar nogui"
    else
        echo "Server not found!"
    fi

    pause
}

# ---------- STOP ----------
stop_mc_server() {
    ls "$MC_DIR"
    read -p "Server name: " name

    stop_service "$name"
    pause
}

# ---------- MENU ----------
minecraft_menu() {
    while true; do
        clear
        echo -e "${CYAN}==== MINECRAFT MANAGER ====${NC}"
        echo "1. Create Server"
        echo "2. Start Server"
        echo "3. Stop Server"
        echo "4. Back"

        read -p "Choice: " ch

        case $ch in
            1) create_mc_server ;;
            2) start_mc_server ;;
            3) stop_mc_server ;;
            4) return ;;
            *) echo "Invalid"; sleep 1 ;;
        esac
    done
}

# Register module
register_module "minecraft"
