#!/usr/bin/env bash
set -euo pipefail

echo "=== NVIDIA setup (RTX / Wayland-ready) ==="

echo "[1/5] Installing NVIDIA packages"
sudo pacman -S --needed --noconfirm \
  nvidia \
  nvidia-utils \
  lib32-nvidia-utils \
  egl-wayland \
  xorg-xwayland

echo "[2/5] Enable DRM modeset"
sudo sed -i 's/^GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1 /' /etc/default/grub

echo "[3/5] Ensure NVIDIA modules in mkinitcpio"
sudo sed -i \
  's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' \
  /etc/mkinitcpio.conf

echo "[4/5] Regenerate initramfs"
sudo mkinitcpio -P

echo "[5/5] Update GRUB"
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo
echo "NVIDIA setup complete."
echo "REBOOT REQUIRED before proceeding."
