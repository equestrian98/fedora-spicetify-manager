# Fedora Spicetify Manager

![Platform](https://img.shields.io/badge/platform-Fedora%20%7C%20RHEL%20%7C%20CentOS-blue)
![Shell](https://img.shields.io/badge/shell-bash-green)
![Spotify](https://img.shields.io/badge/spotify-flatpak-1DB954)
![Spicetify](https://img.shields.io/badge/spicetify-supported-purple)
![License](https://img.shields.io/badge/license-CC%20BY--NC%204.0-orange)

**Fedora Spicetify Manager** is a small modern terminal helper for using **Spicetify** with **Spotify Flatpak** on Fedora, RHEL and CentOS based Linux systems.

It was created to make the common Spotify Flatpak + Spicetify setup easier, especially when Spicetify settings are lost after Spotify or Flatpak updates.

The tool provides an interactive terminal menu, direct commands, automatic path configuration, Flatpak permission handling, update helpers, status checks and an autostart mode.

---

## Preview

[url=https://ibb.co/39M2YGkc][img]https://i.ibb.co/dwLFJ17D/spice.gif[/img][/url]

```text
╭────────────────────────────────────────────────────╮
│              Fedora Spicetify Manager              │
│              Spotify Flatpak + Spicetify           │
│                                                    │
│             Projekt GitHub @equestrian98           │
╰────────────────────────────────────────────────────╯

Menü
Mit ↑/↓ auswählen, Enter bestätigen, q beendet.

  > Spicetify reparieren
    Spotify starten
    Spotify beenden
    Spotify neu starten
    Spotify + Spicetify updaten
    Spicetify apply
    Backup / Apply intelligent
    Status anzeigen
    Autostart-Fix testen
    Hilfe
    Beenden
```

---

## Features

- Modern interactive terminal menu
- Arrow key navigation
- Direct CLI commands
- Spotify Flatpak start, stop and restart
- Spicetify repair/fix command
- Automatic Spotify Flatpak path configuration
- Automatic Spicetify `prefs_path` configuration
- Intelligent backup/apply handling
- Visible Flatpak update output
- GNOME autostart mode without sudo prompts
- Status overview
- Designed for Fedora, RHEL and CentOS based systems

---

## Supported systems

Tested mainly on:

- Fedora Workstation
- Spotify Flatpak
- GNOME Terminal
- zsh
- bash

Should also work on:

- RHEL based systems
- CentOS based systems
- other Linux systems using Spotify Flatpak

---

## Requirements

You need:

- Linux
- Flatpak
- Spotify installed as Flatpak
- Spicetify CLI
- bash
- curl

---

## Install Spotify Flatpak

Install Spotify from Flathub:

```bash
flatpak install flathub com.spotify.Client
```

Start Spotify once so the preferences file is created:

```bash
flatpak run com.spotify.Client
```

Then close Spotify.

---

## Install Spicetify

Install Spicetify CLI:

```bash
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
```

During installation you can also install the Spicetify Marketplace if asked.

After installation, make sure Spicetify is available:

```bash
spicetify -v
```

If the command is not found, open a new terminal or add Spicetify to your PATH:

```bash
export PATH="$HOME/.spicetify:$PATH"
```

---

## Quick install

Install Fedora Spicetify Manager with:

```bash
curl -fsSL https://raw.githubusercontent.com/equestrian98/fedora-spicetify-manager/main/install.sh | bash
```

After installation, open a new terminal or run:

```bash
source ~/.zshrc
```

For bash users:

```bash
source ~/.bashrc
```

Then start the manager:

```bash
spice
```

---

## Manual installation

Clone the repository:

```bash
git clone https://github.com/equestrian98/fedora-spicetify-manager.git
cd fedora-spicetify-manager
```

Make the installer executable:

```bash
chmod +x install.sh
```

Run the installer:

```bash
./install.sh
```

After installation, open a new terminal or run:

```bash
source ~/.zshrc
```

or:

```bash
source ~/.bashrc
```

Start the manager:

```bash
spice
```

---

## Usage

Open the interactive menu:

```bash
spice
```

You can navigate the menu with the arrow keys and confirm with Enter.

Press `q` to quit the menu.

---

## Direct commands

You can also use direct commands without opening the menu:

```bash
spice fix
spice start
spice stop
spice restart
spice update
spice apply
spice backup
spice status
spice autostart
spice help
```

---

## Command overview

| Command | Description |
|---|---|
| `spice` | Opens the interactive terminal menu |
| `spice fix` | Repairs and reapplies Spicetify for Spotify Flatpak |
| `spice start` | Starts Spotify Flatpak |
| `spice stop` | Stops Spotify |
| `spice restart` | Restarts Spotify |
| `spice update` | Updates Spotify Flatpak and reapplies Spicetify |
| `spice apply` | Runs `spicetify apply` |
| `spice backup` | Runs intelligent backup/apply handling |
| `spice status` | Shows Spotify, Spicetify and path status |
| `spice autostart` | Applies Spicetify without sudo for GNOME autostart |
| `spice help` | Shows help information |

---

## First run

After installing everything, run:

```bash
spice fix
```

This will:

- check if Spotify Flatpak exists
- check if the Spotify prefs file exists
- set the correct Spicetify `prefs_path`
- set the correct Spotify Flatpak `spotify_path`
- enable CSS injection
- enable color replacement
- enable the Marketplace custom app
- set the Marketplace theme
- set Flatpak app permissions
- run `spicetify apply`

You may be asked for your sudo password because Spotify Flatpak app files are stored system-wide under `/var/lib/flatpak`.

---

## Autostart

The installer creates a GNOME autostart file:

```text
~/.config/autostart/spicetify-fix.desktop
```

It runs:

```bash
spice autostart
```

The autostart mode does not use sudo.

This is important because sudo password prompts should not appear invisibly during login.

---

## Default paths

Spotify Flatpak preferences file:

```text
~/.var/app/com.spotify.Client/config/spotify/prefs
```

Spotify Flatpak application path:

```text
/var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
```

Spicetify binary path:

```text
~/.spicetify/spicetify
```

Installed manager command:

```text
~/.local/bin/spice
```

Autostart file:

```text
~/.config/autostart/spicetify-fix.desktop
```

---

## Why is this needed?

Spotify installed through Flatpak stores its files and preferences in different locations than traditional native package installations.

Spicetify sometimes cannot automatically detect these paths.

Also, Spotify or Flatpak updates can overwrite Spicetify changes.

This tool helps by setting the correct paths and reapplying Spicetify quickly.

---

## Troubleshooting

### `spice: command not found`

Make sure `~/.local/bin` is in your PATH:

```bash
export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"
```

To make it permanent for zsh:

```bash
echo 'export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

For bash:

```bash
echo 'export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

### Spotify prefs file not found

Start Spotify once:

```bash
flatpak run com.spotify.Client
```

Then close Spotify and run:

```bash
spice fix
```

---

### Spicetify settings are gone after update

Run:

```bash
spice fix
```

or:

```bash
spice update
```

---

### Permission denied while applying Spicetify

Run:

```bash
spice fix
```

The fix command sets the required permissions for the Spotify Flatpak application path.

---

### Backup already exists

This can happen with:

```bash
spicetify backup apply
```

Fedora Spicetify Manager handles this with:

```bash
spice backup
```

If a backup already exists, it will use `spicetify apply` instead.

---

### Update seems to hang

The update command shows Flatpak output directly.

Use:

```bash
spice update
```

If Flatpak is waiting for something, you should see the output in the terminal.

---

## Uninstall

Remove the manager command:

```bash
rm -f ~/.local/bin/spice
```

Remove the autostart file:

```bash
rm -f ~/.config/autostart/spicetify-fix.desktop
```

Optional: remove this PATH line from `~/.zshrc` or `~/.bashrc`:

```bash
export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"
```

---

## Repository structure

```text
fedora-spicetify-manager/
├── README.md
├── install.sh
├── spice
├── LICENSE
└── .gitignore
```

---

## Disclaimer

This project is not affiliated with Spotify, Spicetify, Fedora, Red Hat, CentOS, Flatpak, GNOME or Spotify AB.

This is only a convenience helper script.

Use at your own risk.

---

## License

This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International License**.

You may use, share and modify this project for non-commercial purposes.

Commercial use is not permitted.

See the `LICENSE` file for details.
