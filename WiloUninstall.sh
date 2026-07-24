#!/usr/bin/env bash
# ============================
# WiloUnistall-Setup
# Versão: 1.1.0
# Autor: UmWilo 
# Copyright (c) 2026 UmWilo
# ============================


WiloIF() {
    local mensagem="$1"
    local status="$2"

    if [[ "$status" -eq 0 ]]; then
        echo "✔ $mensagem"
    else
        echo "✖ $mensagem"
    fi
}

Wiloading() {
    local tempo="${1:-1}"
    local delay=0.1
    local spin='|/-\'
    local i=0
    local fim

    fim=$(awk -v t="$tempo" 'BEGIN { print systime() + t }')

    while awk -v now="$(date +%s.%N)" -v end="$fim" 'BEGIN { exit !(now < end) }'; do
        printf '\r[%c] Carregando...' "${spin:$i:1}"
        sleep "$delay"
        i=$(( (i + 1) % ${#spin} ))
    done

    printf '\r\033[K'
}
WiloRun() {
    local mensagem="$1"
    shift

    echo "▶ $mensagem"
    "$@"
    local status=$?

    WiloIF "$mensagem" $status
    return $status
}

WiloText() {
    local mensagem="$1"
    local tempo="${2:-1}"

    echo "$mensagem"
    sleep "$tempo"
}

echo "esta é a tela de desinstalação do WiloOS, deseja prosseguir? (s/n)"

read resposta

if [[ "$resposta" != "s" ]]; then
    echo "Desinstalação cancelada."
    exit 0
fi

echo "Porque deseja desinstalar o WiloOS? (escreva sua resposta)"
read resposta1

if [[ -z "$resposta1" ]]; then
    echo "Ja que não respondeu bora continuar, seu sem educação >:("
else
    echo "Meh, não li nada do que voçê escreveu, bora continuar entâo"
fi

WiloText "Adquirindo permissões de superusuário..." 1

if sudo -v; then
    echo "✔ Permissões concedidas."
else
    echo "✖ Não foi possível obter permissões."
    exit 1
fi

echo "Iniciando a desinstalação do WiloOS"

Wiloading 2

echo "Deseja remover os pacotes DNF instalados pelo WiloOS? (s/n)"
read resposta3

if [[ "$resposta3" == "s" ]]; then
    WiloRun "Removendo pacotes DNF" sudo dnf remove -y \
        git \
        zsh \
        fastfetch \
        btop \
    vlc \
    obs-studio \
    easyeffects \
    steam \
    gimp \
    krita \
    kdenlive \
    code
fi

echo "Deseja remover o flathub e os pacotes Flatpak instalados? (s/n)"

read resposta2

if [[ "$resposta2" == "s" ]]; then
    WiloRun "Removendo repositório Flathub" sudo flatpak remote-delete flathub

    WiloRun "Removendo pacotes Flatpak" flatpak uninstall -y flathub \
	com.spotify.Client \
    io.github.Soundux \
    com.discordapp.Discord \
    org.vinegarhq.Sober \
    net.davidotek.pupgui2 \
    com.brave.Browser \
    com.github.ztefn.haguichi
fi

echo "Deseja remover as ferramentas de customização KDE instaladas? (s/n)"
read resposta4

if [[ "$resposta4" == "s" ]]; then
    WiloRun "Removendo ferramentas de customização KDE" sudo dnf remove -y \
    kvantum \
    qt5ct \
    qt6ct \
    papirus-icon-theme \
    sassc
fi

echo "Deseja remover os temas Tela Circle Icons, Nordic KDE e retornar as configurações do KDE para padrão? (s/n)"
read resposta5

if [[ "$resposta5" == "s" ]]; then
	WiloRun "Removendo Tela Circle Icons" sudo rm -rf /usr/share/icons/Tela-circle*
    WiloRun "Removendo Nordic KDE" bash -c 'sudo rm -rf /usr/share/themes/Nordic* /usr/share/plasma/look-and-feel/Nordic* "$HOME/.local/share/plasma/look-and-feel/Nordic*"'
    WiloRun "Restaurando configurações padrão do KDE" bash -c 'lookandfeeltool -a org.kde.breeze.desktop && kwriteconfig6 --file kdeglobals --group Icons --key Theme breeze && kwriteconfig6 --group KDE --key SingleClick true'
fi

	echo "Reiniciando Plasma"
	WiloText "Aguarde" 1
	systemctl --user restart plasma-plasmashell

echo "Desinstalação do WiloOS concluída com sucesso!"

echo 'Eu ate diria "fastfetch", mas como você desinstalou ele, não posso :('