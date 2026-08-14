#!/usr/bin/env bash

#============================
# WiloConfigArch (Pro Max)
# Versão: 1.0.0
# Autor: UmWilo
# Copyright (c) 2026 UmWilo
#============================

echo "=== WiloConfigArch (Pro Max) ==="


sudo pacman -Syu --noconfirm

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Sy --noconfirm

sudo pacman -S --needed --noconfirm base-devel git flatpak networkmanager

sudo systemctl enable --now NetworkManager

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    makepkg -si --noconfirm
    cd - || exit
fi

echo "Configuração básica concluída!"