#!/bin/bash
# modules/cloudflare_tunnel.sh
# USCS PRO – Cloudflare Tunnel Module for Minecraft

start_cloudflare_tunnel() {
    read -p "Enter server name: " name
    DIR="$BASE_DIR/minecraft/$name"
    if [ ! -d "$DIR" ]; then
        echo "Server '$name' not found!"
        pause
        return
    fi

    read -p "Enter subdomain (optional, leave blank for random): " subdomain

    # Check cloudflared
    if ! command -v cloudflared >/dev/null 2>&1; then
        echo "Installing cloudflared..."
        pkg install cloudflared -y
    fi

    echo "Starting Cloudflare Tunnel..."
    LOG_DIR="$BASE_DIR/logs"
    mkdir -p "$LOG_DIR"

    if [ -z "$subdomain" ]; then
        nohup cloudflared tunnel --url "tcp://localhost:25565" > "$LOG_DIR/${name}_tunnel.log" 2>&1 &
    else
        nohup cloudflared tunnel --url "tcp://localhost:25565" --hostname "$subdomain" > "$LOG_DIR/${name}_tunnel.log" 2>&1 &
    fi

    echo "Tunnel started! Check logs/${name}_tunnel.log for public URL."
    pause
}

show_cloudflare_menu() {
    while true; do
        clear
        echo "==== CLOUD FLARE TUNNEL MANAGER ===="
        echo "1. Start Tunnel for Minecraft"
        echo "2. Back"
        read -p "Choice: " choice
        case $choice in
            1) start_cloudflare_tunnel ;;
            2) break ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}
