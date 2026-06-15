#!/usr/bin/env bash

set -e

APP_NAME="Fedora Spicetify Manager"
REPO_URL="https://github.com/equestrian98/fedora-spicetify-manager"
RAW_URL="https://raw.githubusercontent.com/equestrian98/fedora-spicetify-manager/main"

INSTALL_DIR="$HOME/.local/bin"
SPICE_BIN="$INSTALL_DIR/spice"

AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/spicetify-fix.desktop"

ZSHRC="$HOME/.zshrc"
BASHRC="$HOME/.bashrc"

GREEN="$(tput setaf 2 2>/dev/null || true)"
YELLOW="$(tput setaf 3 2>/dev/null || true)"
CYAN="$(tput setaf 6 2>/dev/null || true)"
RED="$(tput setaf 1 2>/dev/null || true)"
BOLD="$(tput bold 2>/dev/null || true)"
RESET="$(tput sgr0 2>/dev/null || true)"

print_header() {
    echo
    echo "${CYAN}${BOLD}Fedora Spicetify Manager Installer${RESET}"
    echo "${CYAN}Spotify Flatpak + Spicetify helper${RESET}"
    echo
}

info() {
    echo "${CYAN}[ INFO ]${RESET} $1"
}

ok() {
    echo "${GREEN}[ OK ]${RESET} $1"
}

warn() {
    echo "${YELLOW}[ WARN ]${RESET} $1"
}

err() {
    echo "${RED}[ ERROR ]${RESET} $1"
}

need_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        err "$1 wurde nicht gefunden."
        return 1
    fi
}

add_path_line() {
    local file="$1"
    local line='export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"'

    if [ -f "$file" ]; then
        if grep -Fxq "$line" "$file"; then
            ok "PATH ist bereits in $file gesetzt."
        else
            echo "" >> "$file"
            echo "# Fedora Spicetify Manager" >> "$file"
            echo "$line" >> "$file"
            ok "PATH wurde zu $file hinzugefügt."
        fi
    fi
}

download_spice() {
    info "Lade spice Script herunter..."

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$RAW_URL/spice" -o "$SPICE_BIN"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$RAW_URL/spice" -O "$SPICE_BIN"
    else
        err "Weder curl noch wget wurde gefunden."
        echo
        echo "Installiere curl mit:"
        echo "  sudo dnf install curl"
        exit 1
    fi

    chmod +x "$SPICE_BIN"
    ok "spice wurde nach $SPICE_BIN installiert."
}

install_spicetify_if_missing() {
    if command -v spicetify >/dev/null 2>&1 || [ -x "$HOME/.spicetify/spicetify" ]; then
        ok "Spicetify ist bereits installiert."
        return
    fi

    warn "Spicetify wurde nicht gefunden."
    info "Installiere Spicetify CLI ohne Marketplace-Abfrage..."

    if command -v curl >/dev/null 2>&1; then
        echo "n" | curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
    elif command -v wget >/dev/null 2>&1; then
        echo "n" | sh -c "$(wget -qO- https://raw.githubusercontent.com/spicetify/cli/main/install.sh)"
    else
        err "Kann Spicetify nicht installieren, weil curl/wget fehlt."
        exit 1
    fi

    ok "Spicetify CLI wurde installiert."
}

create_autostart() {
    info "Erstelle GNOME Autostart-Eintrag..."

    mkdir -p "$AUTOSTART_DIR"

    cat > "$AUTOSTART_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=Spicetify Autostart Fix
Comment=Applies Spicetify after login without sudo
Exec=$SPICE_BIN autostart
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

    ok "Autostart wurde erstellt: $AUTOSTART_FILE"
}

print_done() {
    echo
    ok "$APP_NAME wurde erfolgreich installiert."
    echo
    echo "${BOLD}Nächste Schritte:${RESET}"
    echo
    echo "1. Neues Terminal öffnen oder ausführen:"
    echo
    echo "   source ~/.zshrc"
    echo
    echo "   oder bei bash:"
    echo
    echo "   source ~/.bashrc"
    echo
    echo "2. Spotify einmal starten, falls noch nie gestartet:"
    echo
    echo "   flatpak run com.spotify.Client"
    echo
    echo "3. Danach Manager starten:"
    echo
    echo "   spice"
    echo
    echo "4. Beim ersten Mal ausführen:"
    echo
    echo "   spice fix"
    echo
    echo "${YELLOW}Hinweis:${RESET} spice fix kann nach deinem sudo-Passwort fragen, weil Spotify Flatpak-Dateien unter /var/lib/flatpak liegen."
    echo
    echo "GitHub: $REPO_URL"
    echo
}

print_header

mkdir -p "$INSTALL_DIR"

info "Prüfe benötigte Programme..."

if need_command flatpak; then
    ok "Flatpak gefunden."
else
    echo
    echo "Installiere Flatpak mit:"
    echo "  sudo dnf install flatpak"
    exit 1
fi

if command -v curl >/dev/null 2>&1; then
    ok "curl gefunden."
elif command -v wget >/dev/null 2>&1; then
    ok "wget gefunden."
else
    warn "curl/wget fehlt."
    echo
    echo "Installiere curl mit:"
    echo "  sudo dnf install curl"
    exit 1
fi

if flatpak info com.spotify.Client >/dev/null 2>&1; then
    ok "Spotify Flatpak ist installiert."
else
    warn "Spotify Flatpak ist nicht installiert."
    echo
    echo "Installiere Spotify mit:"
    echo "  flatpak install flathub com.spotify.Client"
    echo
fi

install_spicetify_if_missing
download_spice
create_autostart

add_path_line "$ZSHRC"
add_path_line "$BASHRC"

print_done
