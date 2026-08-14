#!/usr/bin/env bash

# ============================
# WiloOS-Setup
# Versão: 1.1.0
# Autor: UmWilo 
# Copyright (c) 2026 UmWilo
# ============================
# Ao rodar este .sh, ele irá detectar os componentes da sua máquina
# e reescrever o próprio código, adicionando apenas as informações
# dos componentes (sistema, CPU, GPU e RAM).
# ============================

source ./WiloFunctions.sh



echo "Iniciando a instalação do WiloOS"

wiloText "Adquirindo permissões de superusuário..." 2
WiloFunctionAleatoriaParaPegarPermissãoDeSuperUsuarioQueÉDesnecessariaPorqueSoUso1VezPorArquivoMasColoqueiPorqueEuQueroEPossoPorqueEuQueFizEsseCodigoAPrincipio()

WiloCheat

Wiloading 5

# Easter egg
if (( RANDOM % 100 == 0 )); then
    echo "============================="
    echo -e "=          \e[1;31mERROR:\e[0m           ="
    echo "============================="
    echo "ocorreu um bug inesperado durante a inicialização do WiloOS"
    read -p "Deseja iniciar o WiloOS SHN? [Y/N]: " resposta

    if [[ "$resposta" =~ ^[Yy]$ ]]; then
        echo "Inicializando WiloOS SHN"
        WiloText "Inicializando WiloOS SHN" 3
        echo "ERRO: Um erro fatal ocorreu."
        echo "Processando"
        Wiloading 1
        echo "Destruindo hardware"
        Wiloading 1
        echo "0%"
        Wiloading 2
        echo "12%"
        Wiloading 3
        echo "34%"
        Wiloading 1
        echo "56%"
        Wiloading 2.5
        echo "67%"
        Wiloading 1
        echo "69%"
        Wiloading 1
        echo "78%"
        Wiloading 2
        echo "88%"
        Wiloading 1
        echo "90%"
        Wiloading 3
        echo "93%"
        Wiloading 1
        echo "95%"
        Wiloading 1
        echo "97%"
        Wiloading 1
        echo "99%"
        Wiloading 9
        echo "ERROR: Seu computador é uma bomba nuclear, fiquei com pena ;)"
        echo "Retomando a instalação do WiloOS"
        Wiloading 2
    else
        echo "Retomando a instalação do WiloOS"
        Wiloading 1
    fi
fi

WiloGerenciadores

Wiloading 2

WiloRun "Atualizando sistema" WiloSistemaUP

WiloRun "Instalando pacotes base" WiloPacotes \
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
    code \
    flatpak

echo "Garantindo que o Flathub esteja adicionado"
WiloRun "Adicionando repositório Flathub" sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Deseja instalar qual interface gráfica: KDE, Hyprland, XFCE (N para nenhuma):"
read resposta2

INTERFACE_ESCOLHIDA=""

case "$resposta2" in
    [Kk]de)
        case "$GERENCIADOR" in
            dnf)    WiloRun "Instalando KDE Plasma" WiloPacotes @kde-desktop-environment sddm konsole dolphin ;;
            pacman) WiloRun "Instalando KDE Plasma" WiloPacotes plasma-meta sddm konsole dolphin ;;
            apt)    WiloRun "Instalando KDE Plasma" WiloPacotes kde-plasma-desktop sddm konsole dolphin ;;
        esac
        sudo systemctl enable sddm
        INTERFACE_ESCOLHIDA="kde"
        ;;
    [Hh]yprland)
        if [[ "$GERENCIADOR" == "apt" ]]; then
            echo "✖ Hyprland não está nos repositórios oficiais do apt — precisa de instalação manual :(."
        else
            WiloRun "Instalando Hyprland" WiloPacotes hyprland waybar kitty sddm
            sudo systemctl enable sddm
            INTERFACE_ESCOLHIDA="hyprland"
        fi
        ;;
    [Xx]fce)
        case "$GERENCIADOR" in
            dnf)    WiloRun "Instalando XFCE" WiloPacotes @xfce-desktop-environment sddm ;;
            pacman) WiloRun "Instalando XFCE" WiloPacotes xfce4 xfce4-goodies sddm ;;
            apt)    WiloRun "Instalando XFCE" WiloPacotes xfce4 sddm ;;
        esac
        sudo systemctl enable sddm
        INTERFACE_ESCOLHIDA="xfce"
        ;;
    [Nn])
        echo "Nenhuma interface gráfica será instalada."
        ;;
    *)
        echo "Opção inválida. Considerando nenhuma interface gráfica."
        ;;
esac

echo "Escolha qual navegador instalar (N para nenhum):"
read resposta1

case "$resposta1" in
    [Bb]rave)
        WiloRun "Instalando Brave" flatpak install -y flathub com.brave.Browser
        ;;
    [Ff]irefox)
        WiloRun "Instalando Firefox" flatpak install -y flathub org.mozilla.firefox
        ;;
    [Gg]oogle|[Cc]hrome)
        WiloRun "Instalando Google Chrome" flatpak install -y flathub com.google.Chrome
        ;;
    [Zz]en)
        WiloRun "Instalando Zen Browser" flatpak install -y flathub app.zen_browser.zen
        ;;
    [Nn])
        echo "Nenhum navegador será instalado."
        ;;
    *)
        echo "Opção inválida. Considerando nenhum navegador."
        ;;
esac

WiloRun "Instalando ferramentas de customização KDE" WiloPacotes \
    kvantum \
    qt5ct \
    qt6ct \
    papirus-icon-theme \
    sassc

echo "Deseja instalar uma pasta de 1gb de wallpapers do repositório makccr/wallpapers?(s/n)"

read resposta3

if [[ "$resposta3" =~ ^[Ss]$ ]]; then
    WiloRun "Instalando wallpapers" bash -c 'cd /tmp && git clone https://github.com/makccr/wallpapers.git && cd wallpapers && ./install.sh'
    else
    echo "Pasta de wallpapers não será instalada."
fi

WiloRun "Instalando Tela Circle Icons" bash -c 'cd /tmp && rm -rf Tela-circle-icon-theme && git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git && cd Tela-circle-icon-theme && ./install.sh -a'


if [[ "$INTERFACE_ESCOLHIDA" == "kde" ]]; then

    WiloRun "Instalando Nordic KDE" bash -c 'cd /tmp && rm -rf Nordic && git clone https://github.com/EliverLara/Nordic.git && cd Nordic/kde && ./install.sh'

    WiloRun "Aplicando configurações KDE" bash -c \
    'lookandfeeltool -a Nordic && \
    kwriteconfig6 --file kdeglobals --group Icons --key Theme Tela-circle-dark && \
    kwriteconfig6 --group KDE --key SingleClick false'

else
    echo "Interface não é KDE. Pulando configurações específicas do Plasma."
    echo "E eu não tenho experiências com Hyprland e XFCE, e por isso não sei ao certo as melhores configurações de personalização para ambas as interfaces. Porém, caso eu venha a ter experiências com elas, posso atualizar ;)"fi


echo "Reiniciando Plasma"
WiloText "Aguarde" 1
systemctl --user restart plasma-plasmashell

echo
echo "=================================="
echo " Update concluído com sucesso!    "
echo " Reinicie o PC para garantir tudo."
echo "=================================="

echo ""
echo "Créditos:"
echo "A coleção de wallpapers utilizada pelo WiloOS vem do repositório makccr/wallpapers"
echo "https://github.com/makccr/wallpapers"
echo "Atribuições completas: https://github.com/makccr/wallpapers/wiki"


WiloText "Iniciando fastfetch" 3 
fastfetch
