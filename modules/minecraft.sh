#!/bin/bash

# ==============================
# USCS PRO - MINECRAFT MANAGER (ADVANCED)
# ==============================

MC_DIR="$BASE_DIR/minecraft"
mkdir -p "$MC_DIR"

# ---------- JAVA CHECK ----------
check_java() {
    if ! command -v java &> /dev/null; then
        echo "Java not found! Installing OpenJDK 17..."
        pkg install openjdk-17 -y
    else
        echo "Java already installed!"
    fi
    sleep 1
}

# ---------- SELECT VERSION ----------
select_version() {
    echo "Select Minecraft Version:"
    echo "1. Latest (auto)"
    echo "2. 1.20.1 (stable)"
    echo "3. Custom version"

    read -p "Choice: " vch

    case $vch in
        1)
            VERSION="1.20.1"
            BUILD="latest"
            ;;
        2)
            VERSION="1.20.1"
            BUILD="100"
            ;;
        3)
            read -p "Enter version (e.g. 1.20.1): " VERSION
            read -p "Enter build number: " BUILD
            ;;
        *)
            echo "Invalid, using default"
            VERSION="1.20.1"
            BUILD="100"
            ;;
    esac
}

# ---------- CREATE SERVER ----------
create_mc_server() {
    read -p "Server name: " name
    DIR="$MC_DIR/$name"

    mkdir -p "$DIR"
    cd "$DIR"

    check_java
    select_version

    echo "Downloading PaperMC..."

    if [ "$BUILD" = "latest" ]; then
        curl -s https://api.papermc.io/v2/projects/paper/versions/$VERSION \
        | grep -o '"builds":[^]]*' | grep -o '[0-9]\+' | tail -1 > build.txt
        BUILD=$(cat build.txt)
    fi

    DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar"

    curl -L -o server.jar "$DOWNLOAD_URL"

    echo "eula=true" > eula.txt

    echo "Server '$name' created with version $VERSION build $BUILD!"
    pause
}

# ---------- START ----------
start_mc_server() {
    ls "$MC_DIR"
    read -p "Server name: " name

    DIR="$MC_DIR/$name"

    if [ -d "$DIR" ]; then
        check_java
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
