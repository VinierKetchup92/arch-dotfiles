#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Do NOT run as root. Run as your normal user (with sudo)."
  exit 1
fi

echo "[1/4] Sync time (important for pacman keys)"
sudo timedatectl set-ntp true || true

echo "[2/4] System update"
sudo pacman -Syu --noconfirm

echo "[3/4] Base tools"
sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  networkmanager \
  sudo

echo "[4/4] Enable NetworkManager"
sudo systemctl enable --now NetworkManager

echo
echo "Base setup complete."
echo "Next: we'll add pkgs lists + NVIDIA + Hyprland in separate phases."
