# Fedora Spicetify Manager

**Fedora Spicetify Manager** is a simple terminal helper for using **Spicetify** with **Spotify Flatpak** on Fedora, RHEL and CentOS based systems.

It provides a modern terminal menu, direct commands, Flatpak path handling, Spicetify configuration, update handling, autostart support and an intelligent backup/apply workflow.

This project is only meant as a convenience tool for Linux users.

## Features

- Modern terminal menu
- Arrow key navigation
- Spotify Flatpak start, stop and restart
- Spicetify fix for Spotify Flatpak
- Automatic `prefs_path` and `spotify_path` configuration
- Intelligent backup/apply handling
- Visible Flatpak update output
- Autostart mode without sudo prompts
- Status overview
- Designed for Fedora, RHEL and CentOS based systems

## Supported systems

Tested mainly on:

- Fedora Workstation
- Spotify Flatpak
- GNOME Terminal / zsh / bash

Should also work on:

- RHEL based systems
- CentOS based systems
- Other Flatpak based Linux setups

## Requirements

- Linux
- Flatpak
- Spotify installed as Flatpak
- Spicetify CLI
- bash
- curl

Install Spotify Flatpak:

```bash
flatpak install flathub com.spotify.Client
