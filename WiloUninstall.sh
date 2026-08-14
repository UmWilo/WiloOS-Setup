#!/usr/bin/env bash
# ============================
# WiloUninstall-Setup
# Versão: 1.1.0
# Autor: UmWilo 
# Copyright (c) 2026 UmWilo
# ============================

source ./WiloFunctions.sh

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
WiloFunctionAleatoriaParaPegarPermissaoDeSuperUsuarioQueEDesnecessariaPorqueSoUso1VezPorArquivoMasColoqueiPorqueEuQueroEPossoPorqueEuQueFizEsseCodigoAPrincipio()



echo "para continuar, digite seus credenciais bancarios:"
read RecomendoNãoDigitarRealmenteSeusCredenciaisBancarios
if [[ -z "$RecomendoNãoDigitarRealmenteSeusCredenciaisBancarios" ]]; then
    echo "Ja que não respondeu bora continuar, seu sem educação >:("
else
    echo "Meh eu confesso, não sei ler"
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
    com.github.ztefn.haguichi\
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

echo "Deseja remover a pasta de wallpapers instalada? (s/n)"
read wilochat6

if [[ "$wilochat6" =~ ^[sS]$ ]]; then
    WiloRun "Removendo pasta de wallpapers" rm -rf ~/wallpapers
    else
    echo "Pasta de wallpapers não será removida."
fi

WiloDeteccaoDeDesktop
echo "ATENÇÂO: Deseja remover a interface gráfica $desktop? (s/n)"
read wilochat7

if [[ "$wilochat7" =~ ^[sS]$ ]]; then
    case "$desktop" in
        "kde")
            WiloRun "Removendo KDE Plasma" sudo dnf remove -y \
                plasma-desktop \
                plasma-workspace \
                kde-plasma-desktop \
                kde-standard \
                kde-full
            ;;
       "hyprland")
            WiloRun "Removendo HYPRLAND" sudo dnf remove -y HYPRLAND
            ;;
        "xfce")
            WiloRun "Removendo XFCE" sudo dnf remove -y xfce4 xfce4-session lightdm
            ;;
        *)
            echo "Interface gráfica não reconhecida. Nenhuma ação será tomada."
            ;;
    esac
 else
    echo "Interface gráfica não será removida."
fi
	echo "Reiniciando Plasma"
	WiloText "Aguarde" 1
	systemctl --user restart plasma-plasmashell

echo "Desinstalação do WiloOS concluída com sucesso!"

echo  'Eu ate diria "fastfetch", mas como você desinstalou ele porque você é malvado, não posso :('